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

#include <sds_lib.h>
#include "gstsdxallocator.h"

#define GST_CAT_DEFAULT sdxallocator_debug
GST_DEBUG_CATEGORY_STATIC (GST_CAT_DEFAULT);

#define GST_SDX_MEMORY_TYPE "SDXMemory"

#define parent_class gst_sdx_allocator_parent_class
G_DEFINE_TYPE_WITH_CODE (GstSdxAllocator, gst_sdx_allocator, GST_TYPE_ALLOCATOR,
    GST_DEBUG_CATEGORY_INIT (GST_CAT_DEFAULT, "sdxallocator", 0,
        "SDX allocator"));

gboolean
gst_is_sdx_memory (GstMemory * mem)
{
  return gst_memory_is_type (mem, GST_SDX_MEMORY_TYPE);
}

static gpointer
gst_sdx_memory_map (GstMemory * mem, gsize maxsize, GstMapFlags flags)
{
  GstSdxMemory *sdxmem = (GstSdxMemory *) mem;
  return sdxmem->data;
}

static void
gst_sdx_memory_unmap (GstMemory * mem)
{
  return;
}

static GstMemory *
gst_sdx_allocator_alloc (GstAllocator * allocator, gsize size,
    GstAllocationParams * params)
{
  GstSdxAllocator *alloc = GST_SDX_ALLOCATOR (allocator);
  GstSdxMemory *sdxmem;

  sdxmem = g_slice_new0 (GstSdxMemory);
  gst_memory_init (GST_MEMORY_CAST (sdxmem), params->flags,
      GST_ALLOCATOR_CAST (alloc), NULL, size, params->align, params->prefix,
      size);

  sdxmem->data = sds_alloc_non_cacheable (size);
  if (!sdxmem->data) {
    GST_ERROR_OBJECT (alloc, "failed to alloc new sds memory");
    return NULL;
  }

  return (GstMemory *) sdxmem;
}

static void
gst_sdx_allocator_free (GstAllocator * allocator, GstMemory * mem)
{
  GstSdxMemory *sdxmem = (GstSdxMemory *) mem;
  sds_free (sdxmem->data);
  g_slice_free (GstSdxMemory, sdxmem);
}

static void
gst_sdx_allocator_class_init (GstSdxAllocatorClass * klass)
{
  GstAllocatorClass *allocator_class;

  allocator_class = GST_ALLOCATOR_CLASS (klass);

  allocator_class->free = gst_sdx_allocator_free;
  allocator_class->alloc = gst_sdx_allocator_alloc;
}


static void
gst_sdx_allocator_init (GstSdxAllocator * allocator)
{
  GstAllocator *alloc;

  alloc = GST_ALLOCATOR_CAST (allocator);

  alloc->mem_type = GST_SDX_MEMORY_TYPE;
  alloc->mem_map = gst_sdx_memory_map;
  alloc->mem_unmap = gst_sdx_memory_unmap;

  GST_OBJECT_FLAG_SET (allocator, GST_ALLOCATOR_FLAG_CUSTOM_ALLOC);
}

GstAllocator *
gst_sdx_allocator_new ()
{
  GstAllocator *alloc = NULL;

  alloc = g_object_new (GST_TYPE_SDX_ALLOCATOR, "name",
      "SDXMemory::allocator", NULL);
  gst_object_ref_sink (alloc);
  return alloc;
}
