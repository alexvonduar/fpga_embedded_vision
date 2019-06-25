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
 * and regulatio#include <pcie_src.h>ns governing limitations on product liability.
 *
 * THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
 * AT ALL TIMES.
 *******************************************************************************/

#ifndef INCLUDE_PCIE_MAIN_H_
#define INCLUDE_PCIE_MAIN_H_

#include <stdio.h>
#include <gst/app/gstappsrc.h>
#include <gst/gst.h>
#include <pcie_abstract.h>

#define CHUNK_SIZE      (32 * 1024 * 1024)
#define WRITE_BUF_SIZE  (32 * 1024 * 1024)
#define ONE_GB_SIZE     (1024 * 1024 * 1024)
typedef struct _App App;

struct _App {
    GstElement *audioconvert, *audioresample, *videoparser;
    GstElement *audioqueue, *audioenc, *mux, *videoenc, *videoqueue;
    GstElement *pipeline, *pciesrc, *pciesink;
    GstElement *decodebin;
    GMainLoop *loop;
    GMutex mutex;
    guint64 read_offset, write_offset;
    guint sourceid;         /* To control the GSource */
    gint  fd;
    guint64 length, total_len, intOffset;
    gboolean eos_flag;
    gchar *data, *path;
    enc_params enc_param;
    gchar buf[WRITE_BUF_SIZE];
};

typedef enum {
    CONST_QP,
    VBR,
    CBR,
} VGST_RC_MODE;

typedef enum {
    AVC,
    HEVC,
} VGST_CODEC_TYPE;


/* This API is required for linking src pad of decoder to ts mux element */
void on_pad_added (GstElement *element, GstPad *pad, gpointer   data);

/* This API is required for user interactions to quit the app */
gboolean handle_keyboard (GIOChannel *source, GIOCondition cond, App *data);

/* This API is to capture messages from pipeline */
gboolean bus_message (GstBus * bus, GstMessage * message, App * app);

/* The appsink has received a buffer */
GstFlowReturn new_sample (GstElement *sink, App *data);

#endif /* INCLUDE_PCIE_MAIN_H_ */
