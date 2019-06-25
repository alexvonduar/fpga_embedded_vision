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

#ifndef __GST_SDX_ALLOCATOR_H__
#define __GST_SDX_ALLOCATOR_H__

#include <gst/gst.h>
#include <gst/video/video.h>

G_BEGIN_DECLS

#define GST_TYPE_SDX_ALLOCATOR  \
   (gst_sdx_allocator_get_type())
#define GST_IS_SDX_ALLOCATOR(obj)       \
   (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GST_TYPE_SDX_ALLOCATOR))
#define GST_IS_SDX_ALLOCATOR_CLASS(klass)     \
   (G_TYPE_CHECK_CLASS_TYPE ((klass), GST_TYPE_SDX_ALLOCATOR))
#define GST_SDX_ALLOCATOR_GET_CLASS(obj)      \
   (G_TYPE_INSTANCE_GET_CLASS ((obj), GST_TYPE_SDX_ALLOCATOR, GstSdxAllocatorClass))
#define GST_SDX_ALLOCATOR(obj)        \
   (G_TYPE_CHECK_INSTANCE_CAST ((obj), GST_TYPE_SDX_ALLOCATOR, GstSdxAllocator))
#define GST_SDX_ALLOCATOR_CLASS(klass)      \
   (G_TYPE_CHECK_CLASS_CAST ((klass), GST_TYPE_SDX_ALLOCATOR, GstSdxAllocatorClass))

typedef struct _GstSdxAllocator GstSdxAllocator;
typedef struct _GstSdxAllocatorClass GstSdxAllocatorClass;
typedef struct _GstSdxMemory GstSdxMemory;

struct _GstSdxMemory
{
  GstMemory parent;
  gpointer data;
};

struct _GstSdxAllocator
{
  GstAllocator parent;
};

struct _GstSdxAllocatorClass {
  GstAllocatorClass parent_class;
};

GType gst_sdx_allocator_get_type (void) G_GNUC_CONST;

GstAllocator* gst_sdx_allocator_new ();

G_END_DECLS


#endif /* __GST_SDX_ALLOCATOR_H__ */
