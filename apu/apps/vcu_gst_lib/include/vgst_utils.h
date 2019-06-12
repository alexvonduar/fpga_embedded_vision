/******************************************************************************
 * (c) Copyright 2017-2019 Xilinx, Inc. All rights reserved.
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



#ifndef INCLUDE_VGST_UTILS_H_
#define INCLUDE_VGST_UTILS_H_

#include "vgst_config.h"
#include "vgst_lib.h"
#include "video.h"
#include <gst/video/videooverlay.h>


#ifdef __cplusplus
extern "C"
{
#endif

#define MP4_MUX_TYPE        "mp4"
#define MKV_MUX_TYPE        "mkv"
#define TS_MUX_TYPE         "ts"

typedef struct
_vgst_playback {
    GstElement       *pipeline, *ip_src, *rtppay, *demux, *mux, *tee;
    GstElement       *queue, *enc_queue, *audqueue;
    GstElement       *audcapsfilter, *audcapsfilter2, *srccapsfilter, *enccapsfilter;
    GstElement       *videoparser, *videoenc, *videodec,  *videosink, *videosink2;
    GstElement       *fpsdisplaysink, *fpsdisplaysink2;
    GstElement       *audconvert, *audresample, *audconvert2, *audresample2;
    GstElement       *alsasrc, *alsasink, *volume, *audioenc, *audiodec;
    GstElement       *bypass, *xilinxscd;
    GstVideoOverlay  *overlay, *overlay2;
    GstPad           *pad, *pad2;
    GstPad           *vidpad, *audpad;
    GMainLoop        *loop;
    gboolean         eos_flag, err_flag, stop_flag;
    gchar            *err_msg;
    guint            fps_num[MAX_SPLIT_SCREEN], file_br, video_type;
    GstClockTime     eos_time;
} vgst_playback;

typedef struct
_vgst_application {
    vgst_playback      playback[MAX_SRC_NUM];
    vgst_enc_params    *enc_params;
    vgst_ip_params     *ip_params;
    vgst_op_params     *op_params;
    vgst_cmn_params    *cmn_params;
    vgst_aud_params    *aud_params;
} vgst_application;

/* This API is interface for creating single/mult-stream pipeline */
VGST_ERROR_LOG vgst_create_pipeline ();

/* This API is to print all the parameters coming from application */
void vgst_print_params (guint index);

/* This API is to capture messages from pipeline */
gboolean bus_callback (GstBus *bus, GstMessage *msg, gpointer data);

/* This API is to initialize pipeline structure */
void init_struct_params (vgst_enc_params *enc_param, vgst_ip_params *ip_param, vgst_op_params *op_param, vgst_cmn_params *cmn_param, vgst_aud_params *aud_param);

/* This API is required for linking src pad of decoder to sink element */
void on_pad_added (GstElement *element, GstPad *pad, gpointer data);

/* This API is to stop the single/multi-stream pipeline */
gint stop_pipeline (void);

/* This API is to run the single/multi-stream pipeline */
VGST_ERROR_LOG vgst_run_pipeline ();

/* This API is to convert error number to string */
const gchar * error_to_string (VGST_ERROR_LOG error_code, gint index);

/* This API is to get bitrate for file/stream-in playback */
guint get_bitrate (int index);

/* This API is to get video type for file/stream-in playback */
guint get_video_type (int index);

/* This API is to poll events */
gint poll_event (int *arg, int index);

/* This API is to get fps of the pipeline */
void get_fps (guint index, guint *fps);

/* This API is to get current position of the pipeline */
void get_position (guint index, gint64 *position);

/* This API is to get duration of the file */
void get_duration (guint index, gint64 *duration);

#ifdef __cplusplus
}
#endif

#endif /* INCLUDE_VGST_UTILS_H_ */
