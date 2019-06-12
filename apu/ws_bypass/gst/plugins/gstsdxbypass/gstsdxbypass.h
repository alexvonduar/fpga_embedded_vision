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

#ifndef __GST_SDXBYPASS_H__
#define __GST_SDXBYPASS_H__

#include <gst/base/gstsdxbase.h>

G_BEGIN_DECLS

#define GST_TYPE_SDX_BYPASS \
  (gst_sdx_bypass_get_type())
#define GST_SDX_BYPASS(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj),GST_TYPE_SDX_BYPASS,GstSdxBypass))
#define GST_SDX_BYPASS_CLASS(klass) \
  (G_TYPE_CHECK_CLASS_CAST((klass),GST_TYPE_SDX_BYPASS,GstSdxBypassClass))
#define GST_IS_SDX_BYPASS(obj) \
  (G_TYPE_CHECK_INSTANCE_TYPE((obj),GST_TYPE_SDX_BYPASS))
#define GST_IS_SDX_BYPASS_CLASS(klass) \
  (G_TYPE_CHECK_CLASS_TYPE((klass),GST_TYPE_SDX_BYPASS}))

typedef struct
{
  GstSdxBase parent;
  gboolean raw;
  void *data;
} GstSdxBypass;

typedef struct
{
  GstSdxBaseClass parent_class;
} GstSdxBypassClass;

G_END_DECLS

#endif /* __GST_SDXBYPASS_H__ */
