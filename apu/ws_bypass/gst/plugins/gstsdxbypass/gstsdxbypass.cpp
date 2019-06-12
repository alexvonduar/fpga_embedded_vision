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

/**
 * SECTION:sdxbypass
 *
 * This is an example SDX accelerated bypass.
 *
 * <refsect2>
 * <title>Example launch line</title>
 * |[
 * gst-launch -v videotestsrc ! sdxbypass ! kmssink
 * ]|
 * </refsect2>
 */

#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif
#include <stdio.h>
#include <string.h>

#include <bypass_sds.h>

#include "gstsdxbypass.h"

GST_DEBUG_CATEGORY_STATIC (gst_sdx_bypass_debug);
#define GST_CAT_DEFAULT gst_sdx_bypass_debug

#define SDX_BYPASS_INPUT_PER_OUTPUT      1

enum
{
  PROP_0,
  PROP_RAW,
};

typedef enum
{
  RESOLUTION_1080P,
  RESOLUTION_4K,
}RESOLUTION_TYPE;

#define SDX_BYPASS_CAPS \
    "video/x-raw, " \
    "format = (string) {NV12}, " \
    "width = (int) [ 1, 2147483647 ], " \
    "height = (int) [ 1, 2147483647 ], " \
    "framerate = " GST_VIDEO_FPS_RANGE

static GstStaticPadTemplate src_template = GST_STATIC_PAD_TEMPLATE ("src",
    GST_PAD_SRC,
    GST_PAD_ALWAYS,
    GST_STATIC_CAPS (SDX_BYPASS_CAPS)
    );

static GstStaticPadTemplate sink_template = GST_STATIC_PAD_TEMPLATE ("sink",
    GST_PAD_SINK,
    GST_PAD_ALWAYS,
    GST_STATIC_CAPS (SDX_BYPASS_CAPS)
    );

#define gst_sdx_bypass_parent_class parent_class
G_DEFINE_TYPE (GstSdxBypass, gst_sdx_bypass, GST_TYPE_SDX_BASE);

static gboolean
gst_sdx_bypass_set_caps (GstBaseTransform * trans, GstCaps * in_caps,
    GstCaps * out_caps)
{
  GstSdxBypass *bypass = GST_SDX_BYPASS (trans);


  GstVideoInfo info;

  /* Caps is just used to initialize optical flow without modification */

  GST_DEBUG_OBJECT (bypass, "in caps : %" GST_PTR_FORMAT, in_caps);
  g_print  ("in caps : %" GST_PTR_FORMAT, in_caps);

  if (!gst_video_info_from_caps (&info, in_caps)) {
    GST_WARNING_OBJECT (bypass, "failed to get video info from caps");
    return FALSE;
  }
  return TRUE;
}

static GstFlowReturn
gst_sdx_bypass_process_frames (GstSdxBase * base, GstSdxFrame ** in_frames,
    GstSdxFrame * out_frame)
{
  GstVideoFrame *in_vframe, *out_vframe;
  GstSdxBypass *bypass = GST_SDX_BYPASS (base);
  GstSdxFrame *in_frame;
  GstVideoInfo *out_info;
  gulong *in_data, *out_data;
  guint resolution;

  g_return_val_if_fail (out_frame != NULL && in_frames != NULL, GST_FLOW_ERROR);

  in_frame = in_frames[0];
  if (in_frame == NULL) {
    GST_WARNING_OBJECT (base, "input frame is invalid");
    return GST_FLOW_ERROR;
  }

  in_vframe = &in_frame->vframe;
  out_vframe = &out_frame->vframe;
  out_info = &out_frame->info;
  in_data = (gulong *) GST_VIDEO_FRAME_PLANE_DATA (in_vframe, 0);
  out_data = (gulong *) GST_VIDEO_FRAME_PLANE_DATA (out_vframe, 0);
  resolution = GST_VIDEO_INFO_HEIGHT (out_info)*GST_VIDEO_INFO_WIDTH (out_info);
  if (gst_sdx_base_get_filter_mode (base) == GST_SDX_BASE_FILTER_MODE_HW) {
	if (GST_VIDEO_INFO_WIDTH (out_info) == 1920 && GST_VIDEO_INFO_HEIGHT (out_info) == 1080) {
	  bypass_sds (in_data, out_data, (GST_VIDEO_INFO_HEIGHT (out_info) * GST_VIDEO_INFO_WIDTH (out_info) * 1.5), bypass->raw, RESOLUTION_1080P);
	} else if (GST_VIDEO_INFO_WIDTH (out_info) == 3840 && GST_VIDEO_INFO_HEIGHT (out_info) == 2160) {
	  bypass_sds (in_data, out_data, (GST_VIDEO_INFO_HEIGHT (out_info) * GST_VIDEO_INFO_WIDTH (out_info) * 1.5), bypass->raw, RESOLUTION_4K);
	}
  } else {
	gint i, stride = 2048;
	if (bypass->raw) {
	  memcpy (out_data, in_data, (resolution*1.5));
	} else {
	  if (GST_VIDEO_INFO_WIDTH (out_info) == 1920 && GST_VIDEO_INFO_HEIGHT (out_info) == 1080) {
	    for (i =0; i < GST_VIDEO_INFO_HEIGHT (out_info); i++)
	      memcpy (out_data+(GST_VIDEO_INFO_WIDTH (out_info)*i)/8, in_data+(stride*i)/8, GST_VIDEO_INFO_WIDTH (out_info));

	    for (i =0; i < GST_VIDEO_INFO_HEIGHT (out_info)/2; i++)
		  memcpy (out_data+(resolution+(GST_VIDEO_INFO_WIDTH (out_info)*i))/8, in_data+(2228224+(stride*i))/8, GST_VIDEO_INFO_WIDTH (out_info));
	  } else if (GST_VIDEO_INFO_WIDTH (out_info) == 3840 && GST_VIDEO_INFO_HEIGHT (out_info) == 2160) {
		memcpy (out_data, in_data, resolution);
		memcpy (out_data+resolution/8, in_data+((resolution+61440)/8), 2160*GST_VIDEO_INFO_WIDTH (out_info)/2);
	  }
	}
  }

  GST_DEBUG_OBJECT (base, "input frames processed");
  return GST_FLOW_OK;
}

static void
gst_sdx_bypass_set_property (GObject * object, guint prop_id,
    const GValue * value, GParamSpec * pspec)
{
  GstSdxBypass *bypass = GST_SDX_BYPASS (object);

  switch (prop_id) {
    case PROP_RAW:
    	bypass->raw = g_value_get_boolean (value);
      break;
    default:
      G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
      break;
  }
}

static void
gst_sdx_bypass_get_property (GObject * object, guint prop_id,
    GValue * value, GParamSpec * pspec)
{
	GstSdxBypass *bypass = GST_SDX_BYPASS (object);

  switch (prop_id) {
    case PROP_RAW:
      g_value_set_boolean (value, bypass->raw);
      break;
    default:
      G_OBJECT_WARN_INVALID_PROPERTY_ID (object, prop_id, pspec);
      break;
  }
}

static void
gst_sdx_bypass_finalize (GObject * object)
{
  G_OBJECT_CLASS (parent_class)->finalize (object);
}

static void
gst_sdx_bypass_init (GstSdxBypass * bypass)
{
  GstSdxBase *base = GST_SDX_BASE (bypass);
  bypass->raw = TRUE;
  gst_sdx_base_set_inputs_per_output (base, SDX_BYPASS_INPUT_PER_OUTPUT);
}

static void
gst_sdx_bypass_class_init (GstSdxBypassClass * klass)
{
  GObjectClass *gobject_class;
  GstElementClass *element_class;
  GstSdxBaseClass *sdxbase_class;
  GstBaseTransformClass *transform_class;

  gobject_class = G_OBJECT_CLASS (klass);
  element_class = GST_ELEMENT_CLASS (klass);
  transform_class = GST_BASE_TRANSFORM_CLASS (klass);
  sdxbase_class = GST_SDX_BASE_CLASS (klass);

  gst_element_class_add_static_pad_template (element_class, &sink_template);
  gst_element_class_add_static_pad_template (element_class, &src_template);

  gobject_class->set_property = gst_sdx_bypass_set_property;
  gobject_class->get_property = gst_sdx_bypass_get_property;
  gobject_class->finalize = gst_sdx_bypass_finalize;

  transform_class->set_caps = GST_DEBUG_FUNCPTR (gst_sdx_bypass_set_caps);
  sdxbase_class->process_frames =
      GST_DEBUG_FUNCPTR (gst_sdx_bypass_process_frames);

  g_object_class_install_property (gobject_class, PROP_RAW,
      g_param_spec_boolean ("raw", "Raw",
          "To check whether plugin used after VCU", TRUE,
		  (GParamFlags) (G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS)));


  gst_element_class_set_static_metadata (element_class,
      "SDx Bypass",
      "Filter/Effect/Video",
      "SDx Bypass", "Saket Bafna <saketb@xilinx.com>");
}

static gboolean
plugin_init (GstPlugin * plugin)
{
  GST_DEBUG_CATEGORY_INIT (gst_sdx_bypass_debug, "sdxbypass", 0,
      "SDx Bypass");

  return gst_element_register (plugin, "sdxbypass", GST_RANK_NONE,
      GST_TYPE_SDX_BYPASS);
}

/* PACKAGE: this is usually set by autotools depending on some _INIT macro
 * in configure.ac and then written into and defined in config.h, but we can
 * just set it ourselves here in case someone doesn't use autotools to
 * compile this code. GST_PLUGIN_DEFINE needs PACKAGE to be defined.
 */
#ifndef PACKAGE
#define PACKAGE "sdxbypass"
#endif

GST_PLUGIN_DEFINE (GST_VERSION_MAJOR,
    GST_VERSION_MINOR,
    sdxbypass,
    "SDx Bypass plugin",
    plugin_init,
    "0.1",
    "LGPL",
    "GStreamer SDX",
    "http://xilinx.com/")
