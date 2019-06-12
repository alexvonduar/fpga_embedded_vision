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


#ifndef INCLUDE_VGST_LIB_H_
#define INCLUDE_VGST_LIB_H_

#include <sys/stat.h>
#include <string.h>
#include "vgst_err.h"
#include <gst/gst.h>

#ifdef __cplusplus
extern "C"
{
#endif

typedef struct
_vgst_enc_params {
    gboolean   enable_l2Cache;
    gboolean   low_bandwidth;
    gboolean   filler_data;
    guint      bitrate;
    guint      gop_len;
    guint      b_frame;
    guint      slice;
    guint      qp_mode;
    guint      rc_mode;
    guint      profile;
    guint      enc_type;
    guint      gop_mode;
    guint      latency_mode;
} vgst_enc_params;

typedef struct
_vgst_aud_params {
    gchar      *format;
    gboolean   enable_audio;
    guint      sampling_rate;
    guint      channel;
    gdouble    volume;
    guint      audio_in;
    guint      audio_out;
} vgst_aud_params;

typedef struct
_vgst_input_param {
    gchar      *uri;
    gboolean   raw;
    guint      width;
    guint      height;
    guint      src_type;
    guint      device_type;
    guint      format;
    gboolean   accelerator;
    gboolean   enable_scd;
} vgst_ip_params;

typedef struct
_vgst_output_param {
    gchar      *file_out;
    gchar      *host_ip;
    guint      duration;
    guint      port_num;
} vgst_op_params;

typedef struct
_vgst_cmn_param {
    guint      num_src;
    guint      sink_type;
    guint      driver_type;
    guint      plane_id;
    guint      frame_rate;
} vgst_cmn_params;

typedef enum {
    STREAM,
    RECORD,
    DISPLAY,
    SPLIT_SCREEN,
} VGST_SINK_TYPE;

typedef enum {
    UNIFORM,
    ROI,
    AUTO,
} VGST_QP_MODE;

typedef enum {
    CONST_QP,
    VBR,
    CBR,
    LOW_LATENCY = 0x7F000001,
} VGST_RC_MODE;

typedef enum {
    BASIC,
    LOW_DELAY_P = 3,
    LOW_DELAY_B,
} VGST_GOP_MODE;

typedef enum {
    BASELINE_PROFILE,
    MAIN_PROFILE,
    HIGH_PROFILE,
} VGST_PROFILE_MODE;

typedef enum {
    LIVE_SRC,
    FILE_SRC,
    STREAMING_SRC,
} VGST_SRC_TYPE;

typedef enum {
    AVC =1,
    HEVC,
} VGST_CODEC_TYPE;

typedef enum {
    AUDIO_HDMI_IN,
    AUDIO_SDI_IN,
    AUDIO_I2S_IN,
} VGST_AUDIO_SRC_TYPE;

typedef enum {
    AUDIO_HDMI_OUT,
    AUDIO_SDI_OUT,
    AUDIO_I2S_OUT,
    AUDIO_DP_OUT,
} VGST_AUDIO_RENDER_TYPE;

typedef enum {
    NORMAL_LATENCY,
    SUB_FRAME_LATENCY,
} VGST_LOW_LATENCY_MODE;

typedef enum {
    EVENT_NONE,
    EVENT_EOS,
    EVENT_ERROR,
} VGST_EVENT_TYPE;

/* This API is to initialize the library */
gint vgst_init(void);

/* This API is to initialize the options to initiate the pipeline */
gint vgst_config_options (vgst_enc_params *enc_param, vgst_ip_params *ip_param, vgst_op_params *op_param, vgst_cmn_params *cmn_param, vgst_aud_params *aud_param);

/* This API is to start the pipeline */
gint vgst_start_pipeline (void);

/* This API is interface to stop the single/multi-stream pipeline */
gint vgst_stop_pipeline (void);

/* This API is to convert error number to string */
const gchar * vgst_error_to_string (VGST_ERROR_LOG error_code, gint index);

/* This API is to get fps of the pipeline */
void vgst_get_fps (guint index, guint *fps);

/* This API is to get bitrate for file/stream-in playback */
guint vgst_get_bitrate (int index);

/* This API is to get video type for file/stream-in playback */
guint vgst_get_video_type (int index);

/* This API is to poll events */
gint vgst_poll_event (int *arg, int index);

/* This API is to un-initialize the library */
gint vgst_uninit(void);

/* This API is to get current position of the pipeline */
void vgst_get_position (guint index, gint64 *pos);

/* This API is to get duration of the file */
void vgst_get_duration (guint index, gint64 *duration);

#ifdef __cplusplus
}
#endif

#endif /* INCLUDE_VGST_LIB_H_ */
