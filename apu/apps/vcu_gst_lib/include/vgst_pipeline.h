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

#ifndef INCLUDE_VGST_PIPELINE_H_
#define INCLUDE_VGST_PIPELINE_H_

#include "vgst_utils.h"

#ifdef __cplusplus
extern "C"
{
#endif

/* This API is to create all the elements required for single/multi-stream pipeline */
VGST_ERROR_LOG create_pipeline (vgst_ip_params *ip_param, vgst_enc_params *enc_param, vgst_playback *play_ptr, guint sink_type, gchar *uri, vgst_aud_params *aud_param);

/* This API is to parse the tag and get the bitrate value from file */
void fetch_tag (const GstTagList * list, const gchar * tag, gpointer user_data);

/* This API is to measure the current fps value */
void on_fps_measurement (GstElement *fps, gdouble fps_num, gdouble drop_rate, gdouble avg_rate, gpointer data);

/* This API is to set all the required property to start playback/capture pipeline */
void set_property (vgst_application *app, gint index);

/* This API is to link all the elements required for playback/capture pipeline */
VGST_ERROR_LOG link_elements (vgst_ip_params *ip_param, vgst_playback *play_ptr, gint sink_type, vgst_aud_params *aud_param, gchar *uri);

/* This API is to link all the elements required for audio-video pipeline */
VGST_ERROR_LOG link_audio_pipeline (vgst_ip_params *ip_param, vgst_playback *play_ptr, gint sink_type);

/* This API is to get the proper coordinates for multi-stream */
void get_coordinates (guint *x, guint *y, guint cnt, guint num_src);

#ifdef __cplusplus
}
#endif

#endif /* INCLUDE_VGST_PIPELINE_H_ */
