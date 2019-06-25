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

#ifndef __GST_SDX_BASE_H__
#define __GST_SDX_BASE_H__

#include <gst/gst.h>
#include <gst/base/gstbasetransform.h>
#include <gst/video/video.h>

G_BEGIN_DECLS

#define GST_TYPE_SDX_BASE \
  (gst_sdx_base_get_type())
#define GST_SDX_BASE(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST ((obj), GST_TYPE_SDX_BASE, GstSdxBase))
#define GST_SDX_BASE_CLASS(klass) \
  (G_TYPE_CHECK_CLASS_CAST ((klass), GST_TYPE_SDX_BASE, GstSdxBaseClass))
#define GST_IS_SDX_BASE(obj) \
  (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GST_TYPE_SDX_BASE))
#define GST_IS_SDX_BASE_CLASS(klass) \
  (G_TYPE_CHECK_CLASS_TYPE ((klass), GST_TYPE_SDX_BASE))
#define GST_SDX_BASE_GET_CLASS(obj) \
  (G_TYPE_INSTANCE_GET_CLASS ((obj), GST_TYPE_SDX_BASE, GstSdxBaseClass))
#define GST_SDX_BASE_CAST(obj)  ((GstSdxBase *)(obj))

#define GST_TYPE_SDX_BASE_FILTER_MODE (gst_sdx_base_filter_mode_get_type ())
GType gst_sdx_base_filter_mode_get_type (void);

#define GST_SDX_BASE_SRC_PAD(obj)         (GST_BASE_TRSANSFORM_SINK_PAD (obj))
#define GST_SDX_BASE_SINK_PAD(obj)        (GST_BASE_TRSANSFORM_SRC_PAD (obj))

typedef enum
{
  GST_SDX_BASE_FILTER_MODE_SW,
  GST_SDX_BASE_FILTER_MODE_HW
} GstSdxBaseFilterMode;

typedef struct _GstSdxBase GstSdxBase;
typedef struct _GstSdxBasePrivate GstSdxBasePrivate;
typedef struct _GstSdxBaseClass GstSdxBaseClass;

typedef struct _GstSdxFrame GstSdxFrame;

struct _GstSdxFrame {
  GstVideoFrame vframe;
  GstVideoInfo info;
  GstBuffer *buffer;

  GstClockTime pts;
  GstClockTime duration;

  gboolean registered;
  gint dma_fd;

  gboolean is_input;
};

struct _GstSdxBase {
  GstBaseTransform parent;

  GstSdxFrame **input_frames;
  gint n_input_frames;

  gint inputs_per_output;
  GstSdxBaseFilterMode filter_mode;
  gboolean need_cma_input;

  GstSdxBasePrivate *priv;
};

struct _GstSdxBaseClass {
  GstBaseTransformClass parent_class;

  GstFlowReturn (*process_frames)      (GstSdxBase *base,
                                        GstSdxFrame **in_frames,
                                        GstSdxFrame *out_frame);
};

GType    gst_sdx_base_get_type (void);

void     gst_sdx_base_set_inputs_per_output (GstSdxBase * base,
                                            gint inputs_per_output);

GstSdxBaseFilterMode gst_sdx_base_get_filter_mode (GstSdxBase * base);

void     gst_sdx_base_set_filter_mode (GstSdxBase * base,
                                       GstSdxBaseFilterMode mode);

G_END_DECLS

#endif /* __GST_SDX_BASE_H__ */
