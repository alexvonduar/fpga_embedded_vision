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


#ifndef INCLUDE_VCU_GST_APP_H_
#define INCLUDE_VCU_GST_APP_H_

#include <math.h>
#include <string.h>
#include <vgst_lib.h>
#include <video.h>
#include <perfapm.h>
#include <stdlib.h>
#include <stdio.h>

#define DEFAULT_GOP_LEN       60
#define DEFAULT_B_FRAME       0
#define LOW_BITRATE           10000
#define MEDIUM_BITRATE        30000
#define HIGH_BITRATE          60000

#define DEFAULT_DISPLAY_RATE  60
#define DEFAULT_NUM_SLICE     8
#define DEFAULT_PORT_NUM      5004
#define BYTE_TO_GBIT          (8 / 1000000000.0)
#define BIT_TO_MBIT(value)    (value/1000000.0)
#define BIT_TO_KBIT(value)    (value/1000.0)
#define MAX_NUM_SOURCES       8
#define MIN_NUM_SOURCES       1
#define MAX_WIDTH             3840
#define MAX_HEIGHT            2160
#define MIN_RECORD_DUR        1
#define MAX_RECORD_DUR        3
#define DEFAULT_INFO_INTERVAL 1

typedef struct _App {
  FILE *file;
  gchar line[512];
  GMainLoop *loop;
  gboolean fps_info, apm_info, pipeline_info, update_bitrate[MAX_NUM_SOURCES], loop_playback;
  guint fps[2];
  gint64 position;
  guint loop_interval;
  vgst_enc_params encParam[MAX_NUM_SOURCES];
  vgst_ip_params  ipParam [MAX_NUM_SOURCES];
  vgst_op_params  opParam [MAX_NUM_SOURCES];
  vgst_cmn_params cmnParam;
  vgst_aud_params audParam[MAX_NUM_SOURCES];
}App;

#endif /* INCLUDE_VCU_GST_APP_H_ */
