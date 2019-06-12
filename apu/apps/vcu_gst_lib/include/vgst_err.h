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

#ifndef INCLUDE_VGST_ERR_H_
#define INCLUDE_VGST_ERR_H_

typedef enum {
    VGST_SUCCESS,
    VGST_ERROR_FILE_IO = -1,
    VGST_ERROR_GOP_NOT_SUPPORTED = -2,
    VGST_ERROR_GOP_LENGTH_RANGE_MISMATCH = -3,
    VGST_ERROR_B_FRAME_RANGE_MISMATCH = -4,
    VGST_ERROR_PIPELINE_CREATE_FAIL = -5,
    VGST_ERROR_PIPELINE_LINKING_FAIL = -6,
    VGST_ERROR_STATE_CHANGE_FAIL = -7,
    VGST_ERROR_ENCODER_TYPE_NOT_SUPPORTED = -8,
    VGST_ERROR_SRC_TYPE_NOT_SUPPORTED = -9,
    VGST_ERROR_FORMAT_NOT_SUPPORTED = -10,
    VGST_ERROR_SRC_COUNT_INVALID = -11,
    VGST_ERROR_RESOLUTION_NOT_SUPPORTED = -12,
    VGST_ERROR_DEVICE_TYPE_INVALID = -13,
    VGST_ERROR_PIPELINE_NOT_INITIALIZED = -14,
    VGST_ERROR_SET_ENC_BUF_ENV_FAILED = -15,
    VGST_ERROR_RUN_TIME_PIPELINE_FAILED = -16,
    VGST_ERROR_SLICE_RANGE_MISMATCH = -17,
    VGST_ERROR_BITRATE_NOT_SUPPORTED = -18,
    VGST_ERROR_QPMODE_NOT_SUPPORTED = -19,
    VGST_ERROR_PROFILE_NOT_SUPPORTED = -20,
    VGST_ERROR_RCMODE_NOT_SUPPORTED = -21,
    VGST_ERROR_PORT_NUM_RANGE_MISMATCH = -22,
    VGST_ERROR_DRIVER_TYPE_MISMATCH = -23,
    VGST_ERROR_OVERLAY_CREATION_FAIL = -24,
    VGST_ERROR_MULTI_STREAM_FAIL = -25,
    VGST_ERROR_SPLIT_SCREEN_FAIL = -26,
    VGST_ERROR_APP_PTR_NULL = -27,
    VGST_ERROR_GOP_MODE_NOT_SUPPORTED = -28,
    VGST_ERROR_B_FRAME_LOW_LATENCY_MODE_NOT_SUPPORTED = -29,
    VGST_ERROR_INPUT_OPTIONS_INVALID = -30,
    VGST_ERROR_LATENCY_MODE_NOT_SUPPORTED = -31,
    VGST_ERROR_4KP60_PARAM_NOT_SUPPORTED = -32,
    VGST_ERROR_2_4KP30_PARAM_NOT_SUPPORTED = -33,
    VGST_ERROR_4_1080P60_PARAM_NOT_SUPPORTED = -34,
    VGST_ERROR_TPG_IN_1080P30_NOT_SUPPORTED = -35,
    VGST_ERROR_FILE_IN_MULTISTREAM_NOT_SUPPORTED = -36,
    VGST_ERROR_CBR_VBR_SUB_FRAME_LATENCY_NOT_SUPPORTED = -37,
    VGST_ERROR_VBR_IN_STREAMING_NOT_SUPPORTED = -38,
    VGST_ERROR_AUDIO_CHANNEL_NOT_SUPPORTED = -39,
    VGST_ERROR_AUDIO_VOLUME_NOT_SUPPORTED = -40,
    VGST_ERROR_AUDIO_IN_TYPE_NOT_SUPPORTED = -41,
    VGST_ERROR_AUDIO_OUT_TYPE_NOT_SUPPORTED = -42,
    VGST_ERROR_8_1080P30_PARAM_NOT_SUPPORTED = -43,
    VGST_ERROR_SPLIT_SCREEN_NOT_SUPPORTED = -44,
    VGST_ERROR_PROFILE_FORMAT_NOT_SUPPORTED = -45,
    /* Error range -50 to -70 is assigned for VLIB */
    VGST_ERROR_OTHER = -99,
} VGST_ERROR_LOG;

#endif /* INCLUDE_VGST_ERR_H_ */
