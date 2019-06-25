/******************************************************************************
 * (c) Copyright 2019 Xilinx, Inc. All rights reserved.
 *
 * This file contains confidential and proprietary information of Xilinx, Inc.
 * and is protected under U.S. and international copyright and other
 * intellectual property laws.
 *
 * DISCLAIMER
 * This disclaimer is not a license and does not grant any rights to the
 * materials distributed herewith. Except as otherwise provided in a valid
 * license issued to you by Xilinx, and to the maximum extent permitted by
 * applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
 * FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
 * IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
 * MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
 * and (2) Xilinx shall not be liable (whether in contract or tort, including
 * negligence, or under any other theory of liability) for any loss or damage
 * of any kind or nature related to, arising under or in connection with these
 * materials, including for any direct, or any indirect, special, incidental,
 * or consequential loss or damage (including loss of data, profits, goodwill,
 * or any type of loss or damage suffered as a result of any action brought by
 * a third party) even if such damage or loss was reasonably foreseeable or
 * Xilinx had been advised of the possibility of the same.
 *
 * CRITICAL APPLICATIONS
 * Xilinx products are not designed or intended to be fail-safe, or for use in
 * any application requiring fail-safe performance, such as life-support or
 * safety devices or systems, Class III medical devices, nuclear facilities,
 * applications related to the deployment of airbags, or any other applications
 * that could lead to death, personal injury, or severe property or
 * environmental damage (individually and collectively, "Critical
 * Applications"). Customer assumes the sole risk and liability of any use of
 * Xilinx products in Critical Applications, subject only to applicable laws
 * and regulations governing limitations on product liability.
 *
 * THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
 * AT ALL TIMES.
 *******************************************************************************/

#include <pcie_src.h>
GST_DEBUG_CATEGORY_EXTERN (pciesrc_sink_debug);
#define GST_CAT_DEFAULT pciesrc_sink_debug

gboolean feed_data (GstElement * pciesrc, guint size, App * app) {
    GstBuffer *buffer;
    guint64 len;
    GstFlowReturn ret;

    g_mutex_lock (&app->mutex);
    if (app->read_offset >= app->length) {
      /* we are EOS, send end-of-stream */
      if (!app->eos_flag) {
        GST_DEBUG ("Emitting eos");
        g_signal_emit_by_name (app->pciesrc, "end-of-stream", &ret);
      }
      g_mutex_unlock (&app->mutex);
      return TRUE;
    }

    /* read any amount of data, we are allowed to return less if we are EOS */
    buffer = gst_buffer_new ();

    len = CHUNK_SIZE;
    if (app->read_offset + len > app->length)
      len = app->length - app->read_offset;

    if (app->total_len < ONE_GB_SIZE) {
      pcie_read(app->fd, len, app->read_offset, app->data + app->read_offset);

      gst_buffer_append_memory (buffer,
            gst_memory_new_wrapped (GST_MEMORY_FLAG_READONLY,
            app->data, app->total_len, app->read_offset, len, NULL, NULL));
    } else {
      if (app->intOffset + len >  app->total_len)
        app->intOffset = 0;
      pcie_read(app->fd, len, app->read_offset, app->data + app->intOffset);

      gst_buffer_append_memory (buffer,
            gst_memory_new_wrapped (GST_MEMORY_FLAG_READONLY,
            app->data, app->total_len, app->intOffset, len, NULL, NULL));
      app->intOffset += len;
    }
    GST_DEBUG ("Feed buffer %p, offset %" G_GUINT64_FORMAT "-%lu", buffer, app->read_offset, len);
    g_signal_emit_by_name (app->pciesrc, "push-buffer", buffer, &ret);
    gst_buffer_unref (buffer);
    app->read_offset += len;
    g_mutex_unlock (&app->mutex);
    return TRUE;
}

void start_feed (GstElement *source, guint size, App *data) {
    if (data->sourceid == 0) {
      data->sourceid = g_idle_add ((GSourceFunc) feed_data, data);
    }
}

void stop_feed (GstElement *source, App *data) {
    if (data->sourceid != 0) {
      g_source_remove (data->sourceid);
      data->sourceid = 0;
    }
}

gboolean seek_data (GstElement * pciesrc, guint64 position, App * app) {
    g_mutex_lock (&app->mutex);
    GST_DEBUG ("Seek to offset %" G_GUINT64_FORMAT, position);
    app->read_offset = position;
    g_mutex_unlock (&app->mutex);
    return TRUE;
}
