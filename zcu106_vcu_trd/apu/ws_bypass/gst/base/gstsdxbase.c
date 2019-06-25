/*
 * Copyright (C) 2017 – 2019 Xilinx, Inc.  All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Use of the Software is limited solely to applications: (a) running on a
 * Xilinx device, or (b) that interact with a Xilinx device through a bus or
 * interconnect.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * XILINX BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * Except as contained in this notice, the name of the Xilinx shall not be used
 * in advertising or otherwise to promote the sale, use or other dealings in
 * this Software without prior written authorization from Xilinx.
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <string.h>
#include <errno.h>
#include <gst/allocators/gstdmabuf.h>
#include <gst/allocators/gstsdxallocator.h>
#include <sds_lib.h>

#include "gstsdxbase.h"

GST_DEBUG_CATEGORY_STATIC (sdx_base_debug);
#define GST_CAT_DEFAULT sdx_base_debug

#define GST_SDX_BASE_GET_PRIVATE(obj)  \
    (G_TYPE_INSTANCE_GET_PRIVATE ((obj), GST_TYPE_SDX_BASE, \
        GstSdxBasePrivate))

struct _GstSdxBasePrivate
{
  gint64 min_latency;
  gint64 max_latency;

  GList *pending_events;

  GstBufferPool *input_pool;
};

enum
{
  PROP_0,
  PROP_FILTER_MODE,
  PROP_NEED_CMA_INPUT,
};

#define DEFAULT_INPUTS_PER_OUTPUT    1
#define DEFAULT_FILTER_MODE         GST_SDX_BASE_FILTER_MODE_HW
#define DEFAULT_NEED_CMA_INPUT      TRUE

GType gst_sdx_base_filter_mode_get_type (void)
{
  static GType filter_mode = 0;

  if (!filter_mode) {
    static const GEnumValue filter_modes[] = {
      {GST_SDX_BASE_FILTER_MODE_SW, "GST_SDX_BASE_FILTER_MODE_SW", "SW"},
      {GST_SDX_BASE_FILTER_MODE_HW, "GST_SDX_BASE_FILTER_MODE_HW", "HW"},
      {0, NULL, NULL}
    };
    filter_mode = g_enum_register_static ("GstSdxBaseFilterMode", filter_modes);
  }
  return filter_mode;
}

#define parent_class gst_sdx_base_parent_class
G_DEFINE_ABSTRACT_TYPE (GstSdxBase, gst_sdx_base, GST_TYPE_BASE_TRANSFORM);

static void gst_sdx_base_set_property (GObject * object, guint prop_id,
    const GValue * value, GParamSpec * pspec);
static void gst_sdx_base_get_property (GObject * object, guint prop_id,
    GValue * value, GParamSpec * pspec);
static void gst_sdx_base_push_pending_events (GstSdxBase * self);
static GstSdxFrame * gst_sdx_base_new_frame (GstSdxBase * self, GstBuffer * buf,
   GstClockTime pts, GstClockTime duration, gboolean is_input);
static void gst_sdx_base_release_input_frame_all (GstSdxBase * self);

static void
gst_sdx_base_reset (GstSdxBase * self)
{
  GstSdxBasePrivate *priv = self->priv;

  if (self->n_input_frames) {
    GST_OBJECT_LOCK (self);
    gst_sdx_base_release_input_frame_all (self);
    GST_OBJECT_UNLOCK (self);
  }

  if (priv->pending_events) {
    g_list_foreach (priv->pending_events, (GFunc) gst_event_unref, NULL);
    g_list_free (priv->pending_events);
    priv->pending_events = NULL;
  }
}

static gboolean
gst_sdx_base_decide_allocation (GstBaseTransform * trans, GstQuery * query)
{
  GstSdxBase *self = GST_SDX_BASE (trans);
  GstAllocator *allocator = NULL;
  GstAllocationParams params;
  GstBufferPool *pool = NULL;
  guint size, min, max;
  GstCaps *outcaps;
  gboolean update_allocator;
  gboolean update_pool;

  gst_query_parse_allocation (query, &outcaps, NULL);

  /* we got configuration from our peer or the decide_allocation method,
   * parse them */
  if (gst_query_get_n_allocation_params (query) > 0) {
    /* try the allocator */
    gst_query_parse_nth_allocation_param (query, 0, &allocator, &params);
    update_allocator = TRUE;
  } else {
    allocator = NULL;
    update_allocator = FALSE;
    gst_allocation_params_init (&params);
  }

  if (gst_query_get_n_allocation_pools (query) > 0) {
    gst_query_parse_nth_allocation_pool (query, 0, &pool, &size, &min, &max);
    update_pool = TRUE;
  } else {
    GstVideoInfo info;

    if (!gst_video_info_from_caps (&info, outcaps))
      goto invalid_caps;

    pool = NULL;
    min = 2;
    max = 0;
    size = info.size;

    update_pool = FALSE;
  }

  if (self->filter_mode != GST_SDX_BASE_FILTER_MODE_HW)
    goto next;

  if (pool) {
    GstStructure *config = gst_buffer_pool_get_config (pool);

    if (gst_buffer_pool_config_has_option (config,
        "GstBufferPoolOptionKMSPrimeExport")) {
      gst_structure_free (config);
      goto next;
    }

    gst_structure_free (config);
    gst_object_unref (pool);
    pool = NULL;
    GST_DEBUG_OBJECT (self,
        "pool deos not have the KMSPrimeExport option, \
        unref the pool and create sdx allocator");
  }

  if (allocator && !GST_IS_SDX_ALLOCATOR (allocator)) {
    GST_DEBUG_OBJECT (self, "replace %" GST_PTR_FORMAT " to sdx allocator",
        allocator);
    gst_object_unref (allocator);
    gst_allocation_params_init (&params);
    allocator = NULL;
  }

  if (!allocator) {
    /* making sdx allocator for the HW mode without dmabuf */
    allocator = gst_sdx_allocator_new ();
    params.flags = GST_MEMORY_FLAG_PHYSICALLY_CONTIGUOUS;
  }

next:

  if (update_allocator)
    gst_query_set_nth_allocation_param (query, 0, allocator, &params);
  else
    gst_query_add_allocation_param (query, allocator, &params);

  if (allocator)
    gst_object_unref (allocator);

  if (pool == NULL) {
    GST_DEBUG_OBJECT (self, "no pool, making new pool");
    pool = gst_video_buffer_pool_new ();
  }

  if (update_pool)
    gst_query_set_nth_allocation_pool (query, 0, pool, size, min, max);
  else
    gst_query_add_allocation_pool (query, pool, size, min, max);
  gst_object_unref (pool);

  return GST_BASE_TRANSFORM_CLASS (parent_class)->decide_allocation (trans,
      query);

invalid_caps:
  GST_ERROR_OBJECT (trans, "Invalid video caps %" GST_PTR_FORMAT, outcaps);

  if (allocator)
    gst_object_unref (allocator);
  if (pool)
    gst_object_unref (pool);

  return FALSE;
}

static gboolean
gst_sdx_base_propose_allocation (GstBaseTransform * trans,
    GstQuery * decide_query, GstQuery * query)
{
  GstSdxBase * self = GST_SDX_BASE (trans);
  GstCaps *caps;
  GstVideoInfo info;
  GstBufferPool *pool;
  guint size;

  if (!GST_BASE_TRANSFORM_CLASS (parent_class)->propose_allocation (trans,
        decide_query, query))
    return FALSE;

  gst_query_parse_allocation (query, &caps, NULL);

  if (caps == NULL)
    return FALSE;

  if (!gst_video_info_from_caps (&info, caps))
    return FALSE;

  size = GST_VIDEO_INFO_SIZE (&info);

  if (gst_query_get_n_allocation_pools (query) == 0) {
    GstStructure *structure;
    GstAllocator *allocator = NULL;
    GstAllocationParams params = { GST_MEMORY_FLAG_PHYSICALLY_CONTIGUOUS, 0, 0,
        0 };

    if (gst_query_get_n_allocation_params (query) > 0)
      gst_query_parse_nth_allocation_param (query, 0, &allocator, &params);
    else
      gst_query_add_allocation_param (query, allocator, &params);

    pool = gst_video_buffer_pool_new ();

    structure = gst_buffer_pool_get_config (pool);
    gst_buffer_pool_config_set_params (structure, caps, size, 0, 0);
    gst_buffer_pool_config_set_allocator (structure, allocator, &params);

    if (allocator)
      gst_object_unref (allocator);

    if (!gst_buffer_pool_set_config (pool, structure))
      goto config_failed;

    GST_OBJECT_LOCK (self);
    gst_query_add_allocation_pool (query, pool, size, self->inputs_per_output,
        0);
    GST_OBJECT_UNLOCK (self);

    gst_object_unref (pool);
    gst_query_add_allocation_meta (query, GST_VIDEO_META_API_TYPE, NULL);
  }

  if (self->priv->input_pool) {
    gst_buffer_pool_set_active (self->priv->input_pool, FALSE);
    g_clear_object (&self->priv->input_pool);
  }

  return TRUE;

  /* ERRORS */
config_failed:
  {
    GST_ERROR_OBJECT (self, "failed to set config");
    gst_object_unref (pool);
    return FALSE;
  }
}

static gboolean
gst_sdx_base_sink_event (GstBaseTransform * trans, GstEvent * event)
{
  GstSdxBase *self = GST_SDX_BASE (trans);
  gboolean ret = FALSE;

  switch (GST_EVENT_TYPE (event)) {
    case GST_EVENT_CAPS:
    case GST_EVENT_SEGMENT:
    case GST_EVENT_EOS:
    {
      gst_sdx_base_push_pending_events (self);

      if (self->n_input_frames > 0) {
        GST_OBJECT_LOCK (self);
        gst_sdx_base_release_input_frame_all (self);
        GST_OBJECT_UNLOCK (self);
      }
      break;
    }
    case GST_EVENT_FLUSH_STOP:{
      gst_sdx_base_reset (self);
      break;
    }
    default:
      break;
  }

  /* Forward non-serialized events and EOS/FLUSH_STOP immediately.
   * For EOS this is required because no buffer or serialized event
   * will come after EOS.
   * If the subclass handles sending of EOS manually it can simply
   * not chain up to the parent class' event handler
   *
   * For FLUSH_STOP this is required because it is expected
   * to be forwarded immediately and no buffers are queued anyway.
   */
  if (event) {
    if (!GST_EVENT_IS_SERIALIZED (event)
        || GST_EVENT_TYPE (event) == GST_EVENT_EOS
        || GST_EVENT_TYPE (event) == GST_EVENT_FLUSH_STOP
        || GST_EVENT_TYPE (event) == GST_EVENT_CAPS
        || GST_EVENT_TYPE (event) == GST_EVENT_SEGMENT) {
      ret = GST_BASE_TRANSFORM_CLASS (parent_class)->sink_event (trans, event);
    } else {
      GST_DEBUG_OBJECT (self, "Queueing serialized event: %" GST_PTR_FORMAT, event);
      self->priv->pending_events =
          g_list_prepend (self->priv->pending_events, event);
      ret = TRUE;
    }
  }

  return ret;
}

static gboolean
gst_sdx_base_query (GstBaseTransform * trans, GstPadDirection direction,
  GstQuery * query)
{
  GstSdxBase *self = GST_SDX_BASE (trans);
  GstSdxBasePrivate *priv;
  gboolean res;

  priv = self->priv;

  GST_LOG_OBJECT (self, "handling query: %" GST_PTR_FORMAT, query);

  switch (GST_QUERY_TYPE (query)) {
    case GST_QUERY_LATENCY:
    {
      gboolean live;
      GstClockTime min_latency, max_latency;

      if (direction != GST_PAD_SRC) {
        GST_WARNING_OBJECT (self, "wrong direction for latency query");
        return FALSE;
      }

      res = gst_pad_peer_query (GST_BASE_TRANSFORM_SINK_PAD (self), query);
      if (res) {
        gst_query_parse_latency (query, &live, &min_latency, &max_latency);
        GST_DEBUG_OBJECT (self, "Peer latency: live %d, min %"
            GST_TIME_FORMAT " max %" GST_TIME_FORMAT, live,
            GST_TIME_ARGS (min_latency), GST_TIME_ARGS (max_latency));

        GST_OBJECT_LOCK (self);
        min_latency += priv->min_latency;
        if (max_latency == GST_CLOCK_TIME_NONE
            || self->priv->max_latency == GST_CLOCK_TIME_NONE)
          max_latency = GST_CLOCK_TIME_NONE;
        else
          max_latency += self->priv->max_latency;
        GST_OBJECT_UNLOCK (self);

        gst_query_set_latency (query, live, min_latency, max_latency);
      }
      break;
    }
    default:
      res = GST_BASE_TRANSFORM_CLASS (parent_class)->query (trans, direction, query);
  }

  return res;
}

static GstFlowReturn
gst_sdx_base_create_output_frame (GstSdxBase * self, GstSdxFrame ** out_frame,
    GstSdxFrame *ref_frame)
{
  GstBaseTransform *trans = GST_BASE_TRANSFORM (self);
  GstBuffer *outbuf;
  GstFlowReturn ret;

  ret = GST_BASE_TRANSFORM_CLASS (parent_class)->prepare_output_buffer (trans,
      ref_frame->buffer, &outbuf);
  if (ret != GST_FLOW_OK)
    return ret;

  GST_BUFFER_PTS(outbuf) = ref_frame->pts;
  GST_BUFFER_DURATION(outbuf) = ref_frame->duration;

  *out_frame = gst_sdx_base_new_frame (self, outbuf, ref_frame->pts,
      ref_frame->duration, FALSE);

  if (*out_frame == NULL) {
    gst_buffer_unref (outbuf);
    return GST_FLOW_ERROR;
  }

  return GST_FLOW_OK;
}

static gboolean
gst_sdx_base_register_frame (GstSdxBase * self, GstSdxFrame * frame)
{
  GstMemory *mem;

  if (self->filter_mode != GST_SDX_BASE_FILTER_MODE_HW)
    return TRUE;

  mem = gst_buffer_get_memory (frame->buffer, 0);
  if (!gst_is_dmabuf_memory (mem)) {
    gst_memory_unref (mem);
    return TRUE;
  }

  if ((frame->dma_fd = gst_dmabuf_memory_get_fd (mem)) == -1) {
    GST_ERROR_OBJECT (self, "failed to get DMABUF FD");
    gst_memory_unref (mem);
    return FALSE;
  }
  gst_memory_unref (mem);

  if (sds_register_dmabuf (GST_VIDEO_FRAME_PLANE_DATA (&frame->vframe, 0),
      frame->dma_fd) != 0) {
    GST_ERROR_OBJECT (self, "%s: sds_register_dmabuf() failed",
        strerror(errno));
    sds_unregister_dmabuf (GST_VIDEO_FRAME_PLANE_DATA (&frame->vframe, 0), frame->dma_fd);
    return FALSE;
  }
  GST_DEBUG_OBJECT (self, "sds register dmabuf %p", frame->buffer);
  frame->registered = TRUE;

  return TRUE;
}

static gboolean
gst_sdx_base_unregister_frame (GstSdxBase * self, GstSdxFrame * frame)
{
  if (self->filter_mode != GST_SDX_BASE_FILTER_MODE_HW || !frame->registered)
    return TRUE;

  sds_unregister_dmabuf (GST_VIDEO_FRAME_PLANE_DATA (&frame->vframe, 0), frame->dma_fd);
  frame->registered = FALSE;
  GST_DEBUG_OBJECT (self, "sds unregister dmabuf");

  return TRUE;
}

static GstBuffer *
gst_sdx_base_copy_to_sdx_buf (GstSdxBase * self, GstBuffer * buf)
{
  GstBuffer *copy;
  GstMapInfo read, write;
  gsize len;
  GstVideoMeta *meta;

  len = gst_buffer_get_size (buf);

  if (G_UNLIKELY (!self->priv->input_pool)) {
    GstStructure *config;
    GstPad *pad;
    GstCaps *caps;
    GstAllocator *allocator;
    GstAllocationParams params;

    GST_DEBUG_OBJECT (self, "create input copy pool");

    pad = GST_BASE_TRANSFORM_SINK_PAD (self);
    g_assert (pad);
    caps = gst_pad_get_current_caps (pad);
    g_assert (caps);

    self->priv->input_pool = gst_buffer_pool_new ();
    config = gst_buffer_pool_get_config (self->priv->input_pool);

    gst_buffer_pool_config_set_params (config, caps, len, 0, 0);

    allocator = gst_sdx_allocator_new ();
    gst_allocation_params_init (&params);
    params.flags = GST_MEMORY_FLAG_PHYSICALLY_CONTIGUOUS;
    gst_buffer_pool_config_set_allocator (config, allocator, &params);

    if (!gst_buffer_pool_set_config (self->priv->input_pool, config)) {
      GST_WARNING_OBJECT (self, "failed to configure the pool");
      g_clear_object (&self->priv->input_pool);
      return NULL;
    }

    if (!gst_buffer_pool_set_active (self->priv->input_pool, TRUE)) {
      GST_WARNING_OBJECT (self, "failed to activate the pool");
      g_clear_object (&self->priv->input_pool);
      return NULL;
    }
  }

  if (gst_buffer_pool_acquire_buffer (self->priv->input_pool, &copy,
          GST_BUFFER_POOL_ACQUIRE_FLAG_NONE) != GST_FLOW_OK) {
    GST_WARNING_OBJECT (self, "failed to acquire buffer");
    return NULL;
  }

  /* gst_buffer_copy_into() would create new memories if we'd ask it to deep
   * copy so doing it ourself. */
  g_assert (gst_buffer_map (buf, &read, GST_MAP_READ));
  g_assert (gst_buffer_map (copy, &write, GST_MAP_WRITE));
  memcpy (write.data, read.data, len);
  gst_buffer_unmap (buf, &read);
  gst_buffer_unmap (copy, &write);

  if (!gst_buffer_copy_into (copy, buf, GST_BUFFER_COPY_METADATA, 0, -1)) {
    gst_buffer_unref (copy);
    return NULL;
  }

  /* gst_buffer_copy_into() didn't copy the meta as we didn't copy the memory
   * so do it manually. */
  meta = gst_buffer_get_video_meta (buf);
  if (meta)
    gst_buffer_add_video_meta_full (copy, meta->flags, meta->format,
        meta->width, meta->height, meta->n_planes, meta->offset, meta->stride);

  return copy;
}

static GstSdxFrame *
gst_sdx_base_new_frame (GstSdxBase * self, GstBuffer * buf, GstClockTime pts,
    GstClockTime duration, gboolean is_input)
{
  GstCaps *caps;
  GstSdxFrame *frame;
  GstMapFlags flag;
  gboolean try_register = TRUE;

  frame = g_slice_new0 (GstSdxFrame);

  frame->buffer = buf;
  frame->pts = pts;
  frame->duration = duration;

  /* HACK: hardware mode requires contiguous memory; assume not dmabuf memories
   * aren't so copy. */
  if (is_input && self->filter_mode == GST_SDX_BASE_FILTER_MODE_HW
      && self->need_cma_input) {
    GstMemory *mem;

    mem = gst_buffer_get_memory (buf, 0);
    if (!gst_is_dmabuf_memory (mem)) {
      GST_LOG_OBJECT (self, "not dmabuf input in hardware mode, copy");

      frame->buffer = gst_sdx_base_copy_to_sdx_buf (self, buf);
      if (!frame->buffer) {
        GST_WARNING_OBJECT (self, "Failed to copy input buffer");
        gst_memory_unref (mem);
        return NULL;
      }

      try_register = FALSE;
      gst_buffer_unref (buf);
    }
    gst_memory_unref (mem);
  }

  if (is_input) {
    flag = GST_MAP_READ;
    caps  = gst_pad_get_current_caps (GST_BASE_TRANSFORM_SINK_PAD (self));
  } else {
    flag = GST_MAP_WRITE;
    caps  = gst_pad_get_current_caps (GST_BASE_TRANSFORM_SRC_PAD (self));
  }

  if (!gst_video_info_from_caps (&frame->info, caps)) {
    GST_WARNING_OBJECT (self, "failed to get video info from caps");
    gst_caps_unref (caps);
    return NULL;
  }

  gst_caps_unref (caps);

retry:
  if (!gst_video_frame_map (&frame->vframe, &frame->info, frame->buffer, flag)) {
    GST_WARNING_OBJECT (self, "failed to map buffer");
    return NULL;
  }

  if (try_register && !gst_sdx_base_register_frame (self, frame)) {
    gst_video_frame_unmap (&frame->vframe);
    if (is_input && self->filter_mode == GST_SDX_BASE_FILTER_MODE_HW
        && self->need_cma_input) {
      GST_LOG_OBJECT (self,
          "failed to register input frame in hardware mode, copy");
      frame->buffer = gst_sdx_base_copy_to_sdx_buf (self, buf);
      if (!frame->buffer) {
        GST_WARNING_OBJECT (self, "Failed to copy input buffer");
        g_slice_free (GstSdxFrame, frame);
        return NULL;
      }
      try_register = FALSE;
      gst_buffer_unref (buf);
      goto retry;
    } else {
      GST_ERROR_OBJECT (self, "failed to register frame");
      g_slice_free (GstSdxFrame, frame);
      return NULL;
    }
  }

  return frame;
}


static void
gst_sdx_base_frame_release (GstSdxBase * self, GstSdxFrame * frame)
{
  gst_sdx_base_unregister_frame (self, frame);
  gst_video_frame_unmap (&frame->vframe);
  gst_buffer_unref (frame->buffer);
  g_slice_free (GstSdxFrame, frame);
}


static void
gst_sdx_base_release_oldest_frame (GstSdxBase * self)
{
  gint i;

  if (self->n_input_frames == 0)
    return;

  gst_sdx_base_frame_release (self, self->input_frames[0]);

  for (i = 1; i < self->n_input_frames; i++) {
    self->input_frames[i - 1] = self->input_frames[i];
    self->input_frames[i] = NULL;
  }

  self->n_input_frames--;
}


static void
gst_sdx_base_release_input_frame_all (GstSdxBase * self)
{
  while (self->n_input_frames > 0) {
    GstSdxFrame *frame = self->input_frames[self->n_input_frames - 1];
    gst_sdx_base_frame_release (self, frame);
    frame = NULL;
    self->n_input_frames--;
  }
}

static void
gst_sdx_base_push_pending_events (GstSdxBase * self)
{
  GST_DEBUG_OBJECT (self, "Pushing pending events.");

  if (self->priv->pending_events) {
    GList *l;

    for (l = g_list_last (self->priv->pending_events); l;
        l = g_list_previous (l)) {
      GstEvent *event = GST_EVENT (l->data);
      gst_pad_push_event (GST_BASE_TRANSFORM_SRC_PAD (self), event);
    }

    g_list_free (self->priv->pending_events);
    self->priv->pending_events = NULL;
  }
}

static GstFlowReturn
gst_sdx_base_submit_input_buffer (GstBaseTransform * trans, gboolean is_discont,
    GstBuffer * inbuf)

{
  GstSdxBase *self;
  GstClockTime pts, duration;
  GstClockTime start, stop, cstart, cstop;
  GstFlowReturn ret = GST_FLOW_OK;
  GstSdxFrame *in_frame;
  gsize size;

  self = GST_SDX_BASE (trans);

  ret = GST_BASE_TRANSFORM_CLASS (parent_class)->submit_input_buffer (trans,
      is_discont, inbuf);
  if (ret != GST_FLOW_OK)
    goto done;

  /* keep input buffer ownership */
  trans->queued_buf = NULL;

  pts = GST_BUFFER_PTS (inbuf);
  duration = GST_BUFFER_DURATION (inbuf);
  size = gst_buffer_get_size (inbuf);

  GST_LOG_OBJECT (self,
      "received buffer of size %" G_GSIZE_FORMAT " with PTS %" GST_TIME_FORMAT
      ", DTS %" GST_TIME_FORMAT ", duration %" GST_TIME_FORMAT,
      size, GST_TIME_ARGS (pts),
      GST_TIME_ARGS (GST_BUFFER_DTS (inbuf)), GST_TIME_ARGS (duration));

  start = pts;
  if (GST_CLOCK_TIME_IS_VALID (duration))
    stop = start + duration;
  else
    stop = GST_CLOCK_TIME_NONE;

  /* Drop buffers outside of segment */
  if (!gst_segment_clip (&trans->segment,
          GST_FORMAT_TIME, start, stop, &cstart, &cstop)) {
    GST_DEBUG_OBJECT (self, "clipping to segment dropped frame");
    gst_buffer_unref (inbuf);
    ret = GST_BASE_TRANSFORM_FLOW_DROPPED;
    goto done;
  }

  if (GST_CLOCK_TIME_IS_VALID (cstop))
    duration = cstop - cstart;
  else
    duration = GST_CLOCK_TIME_NONE;

  if (!(in_frame = gst_sdx_base_new_frame (self, inbuf, cstart, duration, TRUE)))
    goto register_failed;

  GST_OBJECT_LOCK (self);
  self->input_frames[self->n_input_frames] = in_frame;
  self->n_input_frames++;
  GST_OBJECT_UNLOCK (self);

done:
  return ret;

register_failed:
  {
    gst_buffer_unref (inbuf);
    GST_ELEMENT_ERROR (self, RESOURCE, FAILED, (NULL),
        ("failed to register buffer"));
    return GST_FLOW_ERROR;
  }
}

static GstFlowReturn
gst_sdx_base_generate_output (GstBaseTransform * trans,
    GstBuffer **outbuf)
{
  GstSdxBase *self;
  GstSdxBaseClass *klass;
  GstSdxFrame *out_frame, *ref_frame;
  GstFlowReturn ret = GST_FLOW_OK;

  self = GST_SDX_BASE (trans);
  klass = GST_SDX_BASE_GET_CLASS (self);

  g_return_val_if_fail (klass->process_frames != NULL, GST_FLOW_ERROR);

  GST_OBJECT_LOCK (self);
  if (self->n_input_frames < self->inputs_per_output) {
    GST_OBJECT_UNLOCK (self);
    goto done;
  }
  ref_frame = self->input_frames[self->n_input_frames - 1];
  GST_OBJECT_UNLOCK (self);

  if (gst_sdx_base_create_output_frame (self, &out_frame, ref_frame)
      != GST_FLOW_OK)
    goto no_output;

  GST_DEBUG_OBJECT (self, "process frames (input per output: %d)",
      self->inputs_per_output);

  ret = klass->process_frames (self, self->input_frames, out_frame);

  if (ret != GST_FLOW_OK)
    goto process_failed;

  /* ref to the buffer which is going to be pushed */
  *outbuf = gst_buffer_ref (out_frame->buffer);
  gst_sdx_base_frame_release (self, out_frame);

  GST_OBJECT_LOCK (self);
  gst_sdx_base_release_oldest_frame (self);
  GST_OBJECT_UNLOCK (self);

  gst_sdx_base_push_pending_events (self);

done:
  return ret;

no_output:
  {
    GST_OBJECT_LOCK (self);
    gst_sdx_base_release_input_frame_all (self);
    GST_OBJECT_UNLOCK (self);
    GST_ELEMENT_ERROR (self, RESOURCE, FAILED, (NULL),
        ("failed to create output buffer"));
    return GST_FLOW_ERROR;
  }
process_failed:
  {
    gst_sdx_base_frame_release (self, out_frame);
    GST_OBJECT_LOCK (self);
    gst_sdx_base_release_input_frame_all (self);
    GST_OBJECT_UNLOCK (self);
    GST_ELEMENT_ERROR (self, STREAM, FAILED, (NULL),
        ("failed to process frames in sub-class"));
    return GST_FLOW_ERROR;
  }
}

static gboolean
gst_sdx_base_transform_size (GstBaseTransform * trans,
    GstPadDirection direction, GstCaps * caps, gsize size,
    GstCaps * othercaps, gsize * othersize)
{
  GstVideoInfo info;

  if (!gst_video_info_from_caps (&info, othercaps))
    return FALSE;

  *othersize = info.size;

  GST_WARNING_OBJECT (trans, "Run-time memory allocation detected.");

  return TRUE;
}

static GstFlowReturn
gst_sdx_base_transform (GstBaseTransform * trans, GstBuffer * inbuf,
    GstBuffer * outbuf)
{
  /* There is nothing to be done here, this stub is just to signal the base
   * class that we support non-inplace transforms */
  return GST_FLOW_OK;
}

static void
gst_sdx_base_set_property (GObject * object, guint prop_id, const GValue * value,
    GParamSpec * pspec)
{
  GstSdxBase * self = GST_SDX_BASE (object);

  switch (prop_id) {
    case PROP_FILTER_MODE:
      self->filter_mode = g_value_get_enum (value);
      break;
    case PROP_NEED_CMA_INPUT:
      self->need_cma_input = g_value_get_boolean (value);
      break;
    default:
      G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
      break;
  }
}

static void
gst_sdx_base_get_property (GObject * object, guint prop_id, GValue * value,
    GParamSpec * pspec)
{
  GstSdxBase * self = GST_SDX_BASE (object);

  switch (prop_id) {
    case PROP_FILTER_MODE:
      g_value_set_enum (value, self->filter_mode);
      break;
    case PROP_NEED_CMA_INPUT:
      g_value_set_boolean (value, self->need_cma_input);
      break;
    default:
      G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
      break;
  }
}

static GstStateChangeReturn
gst_sdx_base_change_state (GstElement * element, GstStateChange transition)
{
  GstSdxBase *self;
  GstStateChangeReturn ret;

  self = GST_SDX_BASE (element);

  switch (transition) {
    case GST_STATE_CHANGE_READY_TO_PAUSED:
      gst_sdx_base_reset (self);
      break;
    default:
      break;
  }

  ret = GST_ELEMENT_CLASS (parent_class)->change_state (element, transition);

  switch (transition) {
    case GST_STATE_CHANGE_PAUSED_TO_READY:{
      gst_sdx_base_reset (self);
      break;
    }
    default:
      break;
  }

  return ret;
}

static void
gst_sdx_base_dispose (GObject * object)
{
  GstSdxBase * self = GST_SDX_BASE (object);

  g_clear_object (&self->priv->input_pool);

  G_OBJECT_CLASS (gst_sdx_base_parent_class)->dispose (object);
}

static void
gst_sdx_base_finalize (GObject * object)
{
  GstSdxBase * self = GST_SDX_BASE (object);

  g_slice_free (GstSdxFrame *, self->input_frames);

  G_OBJECT_CLASS (gst_sdx_base_parent_class)->finalize (object);
}

static gboolean
gst_sdx_base_stop (GstBaseTransform * base)
{
  GstSdxBase * self = GST_SDX_BASE (base);

  if (self->priv->input_pool) {
    gst_buffer_pool_set_active (self->priv->input_pool, FALSE);
    g_clear_object (&self->priv->input_pool);
  }

  return TRUE;
}

static void
gst_sdx_base_class_init (GstSdxBaseClass * klass)
{
  GObjectClass *gobject_class;
  GstElementClass *element_class;
  GstBaseTransformClass *transform_class;

  gobject_class = G_OBJECT_CLASS (klass);
  element_class = GST_ELEMENT_CLASS (klass);
  transform_class = GST_BASE_TRANSFORM_CLASS (klass);

  GST_DEBUG_CATEGORY_INIT (sdx_base_debug, "sdxbase", 0, "Sdx base class");

  g_type_class_add_private (klass, sizeof (GstSdxBasePrivate));

  gobject_class->set_property = gst_sdx_base_set_property;
  gobject_class->get_property = gst_sdx_base_get_property;
  gobject_class->dispose = gst_sdx_base_dispose;
  gobject_class->finalize = gst_sdx_base_finalize;

  element_class->change_state = GST_DEBUG_FUNCPTR (gst_sdx_base_change_state);

  transform_class->sink_event = gst_sdx_base_sink_event;
  transform_class->query = gst_sdx_base_query;
  transform_class->decide_allocation = gst_sdx_base_decide_allocation;
  transform_class->propose_allocation = gst_sdx_base_propose_allocation;
  transform_class->submit_input_buffer = gst_sdx_base_submit_input_buffer;
  transform_class->generate_output = gst_sdx_base_generate_output;
  transform_class->transform_size = gst_sdx_base_transform_size;
  transform_class->transform = gst_sdx_base_transform;
  transform_class->stop = gst_sdx_base_stop;

  g_object_class_install_property (gobject_class, PROP_FILTER_MODE,
    g_param_spec_enum ("filter-mode", "filter mode", "filter mode",
        GST_TYPE_SDX_BASE_FILTER_MODE, DEFAULT_FILTER_MODE,
        G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS));

  g_object_class_install_property (gobject_class, PROP_NEED_CMA_INPUT,
      g_param_spec_boolean ("need-cma-input", "Need CMA input",
          "Ensure that the accelerator receives contiguous memory, copying if needed",
          DEFAULT_NEED_CMA_INPUT, G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS));
}

static void
gst_sdx_base_init (GstSdxBase * self)
{
  self->priv = GST_SDX_BASE_GET_PRIVATE (self);

  /* Inputs_per_output represents that N inputs are going to be a single output
   * e.g. the optical flow plugin combine two input buffers and create a new
   * output buffer.
   */
  self->inputs_per_output = DEFAULT_INPUTS_PER_OUTPUT;
  self->filter_mode = DEFAULT_FILTER_MODE;

  self->priv->min_latency = 0;
  self->priv->max_latency = 0;

  self->input_frames =
      g_slice_alloc0 (sizeof (GstSdxFrame) * self->inputs_per_output);
  self->n_input_frames = 0;

  self->need_cma_input = DEFAULT_NEED_CMA_INPUT;

  gst_sdx_base_reset (self);
}

/**
 * gst_sdx_base_set_inputs_per_output:
 * @self A #GstSdxBase object
 * @inputs_per_output: The number of input needed before we start
 *
 * This setters controls the size of the internal FIFO. As an example, if this
 * is set to 2, the process_frames() will be called as soon as two buffers
 * have arrived. It will then evict the older buffer, and call
 * process_frames() again with the second and the third buffer.
 */
void
gst_sdx_base_set_inputs_per_output (GstSdxBase * self, gint inputs_per_output)
{
  GST_OBJECT_LOCK (self);
  if (self->inputs_per_output != inputs_per_output) {
    self->inputs_per_output = inputs_per_output;

    if (self->n_input_frames > 0)
      gst_sdx_base_release_input_frame_all (self);

    g_slice_free (GstSdxFrame *, self->input_frames);
    self->input_frames =
        g_slice_alloc0 (sizeof (GstSdxFrame *) * inputs_per_output);
  }
  GST_OBJECT_UNLOCK (self);
}

GstSdxBaseFilterMode
gst_sdx_base_get_filter_mode (GstSdxBase * self)
{
  return self->filter_mode;
}

void
gst_sdx_base_set_filter_mode (GstSdxBase * self, GstSdxBaseFilterMode mode)
{
  self->filter_mode = mode;
}

/**
 * gst_sdx_base_set_latency:
 * @self: a #GstSdxBase
 * @min_latency: minimum latency
 * @max_latency: maximum latency
 *
 * Informs baseclass of processing latency.
 */
void
gst_sdx_base_set_latency (GstSdxBase * self, GstClockTime min_latency,
    GstClockTime max_latency)
{
  g_return_if_fail (GST_CLOCK_TIME_IS_VALID (min_latency));
  g_return_if_fail (max_latency >= min_latency);

  GST_OBJECT_LOCK (self);
  self->priv->min_latency = min_latency;
  self->priv->max_latency = max_latency;
  GST_OBJECT_UNLOCK (self);

  gst_element_post_message (GST_ELEMENT_CAST (self),
      gst_message_new_latency (GST_OBJECT_CAST (self)));
}

/**
 * gst_sdx_base_get_latency:
 * @self: a #GstSdxBase
 * @min_latency: (out) (allow-none): address of variable in which to store the
 *     configured minimum latency, or %NULL
 * @max_latency: (out) (allow-none): address of variable in which to store the
 *     configured maximum latency, or %NULL
 *
 * Query the configured processing latency. Results will be returned via
 * @min_latency and @max_latency.
 */
void
gst_sdx_base_get_latency (GstSdxBase * self, GstClockTime * min_latency,
    GstClockTime * max_latency)
{
  GST_OBJECT_LOCK (self);
  if (min_latency)
    *min_latency = self->priv->min_latency;
  if (max_latency)
    *max_latency = self->priv->max_latency;
  GST_OBJECT_UNLOCK (self);
}
