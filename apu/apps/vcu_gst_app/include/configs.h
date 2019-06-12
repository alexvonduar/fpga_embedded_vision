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


#ifndef INCLUDE_CONFIGS_H_
#define INCLUDE_CONFIGS_H_

/* Common configurations */
#define CMN_CONFIG           "Common Configuration"
#define NUM_SRC              "Num Of Input"
#define OUTPUT               "Output"
#define DP_OUT               "DP"
#define HDMI_OUT             "HDMI"
#define HDMI_TX_OUT          "HDMI_Tx"
#define SDI_OUT              "SDI"
#define SDI_TX_OUT           "SDI_Tx"
#define I2S_OUT              "I2S"
#define I2S_TX_OUT           "I2S_Tx"
#define OUTPUT_TYPE          "Out Type"
#define RECORD_FILE_OUT      "Record"
#define STREAM_OUT           "Stream"
#define DISPLAY_OUT          "Display"
#define SPLIT_SCREEN_OUT     "Split_Screen"
#define FRAME_RATE           "Frame Rate"
#define TRUE_VAL             "TRUE"
#define FALSE_VAL            "FALSE"

/* Input configurations */
#define INPUT_CONFIG         "Input Configuration"
#define INPUT_NUM            "Input Num"
#define ACCELERATOR_FILTER   "Accelerator Filter"
#define ENABLE_SCD           "Enable SCD"
#define INPUT_TYPE           "Input Type"
#define TPG_INPUT            "TPG"
#define TPG_2_INPUT          "TPG_2"
#define HDMI_INPUT           "HDMI"
#define HDMI_RX_INPUT        "HDMI_Rx"
#define HDMI_2_INPUT         "HDMI_2"
#define HDMI_RX_2_INPUT      "HDMI_Rx_2"
#define HDMI_3_INPUT         "HDMI_3"
#define HDMI_RX_3_INPUT      "HDMI_Rx_3"
#define HDMI_4_INPUT         "HDMI_4"
#define HDMI_RX_4_INPUT      "HDMI_Rx_4"
#define HDMI_5_INPUT         "HDMI_5"
#define HDMI_RX_5_INPUT      "HDMI_Rx_5"
#define HDMI_6_INPUT         "HDMI_6"
#define HDMI_RX_6_INPUT      "HDMI_Rx_6"
#define HDMI_7_INPUT         "HDMI_7"
#define HDMI_RX_7_INPUT      "HDMI_Rx_7"
#define MIPI_INPUT           "MIPI"
#define CSI_INPUT            "CSI"
#define MIPI_CSI_INPUT       "MIPI_CSI"
#define SDI_INPUT            "SDI"
#define SDI_RX_INPUT         "SDI_Rx"
#define I2S_INPUT            "I2S"
#define I2S_RX_INPUT         "I2S_Rx"
#define FILE_INPUT           "File"
#define STREAMING_INPUT      "Stream"
#define NV12_FORMAT          "NV12"
#define NV16_FORMAT          "NV16"
#define XV15_FORMAT          "XV15"
#define XV20_FORMAT          "XV20"

#define URI                  "Uri"
#define FORMAT               "Format"
#define RAW                  "Raw"
#define WIDTH                "Width"
#define HEIGHT               "Height"

/* Encoder configurations */
#define ENCODER_CONFIG       "Encoder Configuration"
#define ENCODER_NUM          "Encoder Num"
#define PRESET               "Preset"
#define HEVC_HIGH            "HEVC_High"
#define HEVC_MEDIUM          "HEVC_Medium"
#define HEVC_LOW             "HEVC_Low"
#define AVC_HIGH             "AVC_High"
#define AVC_MEDIUM           "AVC_Medium"
#define AVC_LOW              "AVC_Low"
#define CUSTOM               "Custom"

#define ENCODER_NAME         "Encoder Name"
#define H264_ENC_NAME        "H264"
#define AVC_ENC_NAME         "AVC"
#define H265_ENC_NAME        "H265"
#define HEVC_ENC_NAME        "HEVC"


#define PROFILE              "Profile"
#define BASE_PROF            "Baseline"
#define MAIN_PROF            "Main"
#define HIGH_PROF            "High"

#define QP_VALUE             "QP"
#define UNIFORM_QP           "Uniform"
#define AUTO_QP              "Auto"

#define RATE_CONTRL          "Rate Control"
#define CBR_RC               "CBR"
#define VBR_RC               "VBR"
#define LOWLATENCY_RC        "Low_Latency"

#define BITRATE              "Bitrate"
#define LATENCY_MODE         "Latency Mode"
#define NORMAL               "Normal"
#define SUB_FRAME            "Sub_Frame"

#define FILLER_DATA          "Filler Data"
#define LOW_BANDWIDTH        "Low Bandwidth"
#define GOP_MODE             "Gop Mode"
#define BASIC_GOP            "Basic"
#define LOW_DELAY_P_GOP      "Low_Delay_P"
#define LOW_DELAY_B_GOP      "Low_Delay_B"

#define B_FRAMES             "B Frames"
#define SLICE                "Slice"
#define GOP_LENGTH           "GoP Length"
#define L2_CACHE             "L2 Cache"

/* Record configurations */
#define RECORD_CONFIG        "Record Configuration"
#define RECORD_NUM           "Record Num"
#define OUT_FILE_NAME        "Out File Name"
#define DURATION             "Duration"    // value will be in minute

/* Streaming configurations */
#define STREAMING_CONFIG     "Streaming Configuration"
#define STREAMING_NUM        "Streaming Num"
#define HOST_IP              "Host IP"
#define PORT                 "Port"

/* Audio configurations */
#define AUDIO_CONFIG         "Audio Configuration"
#define AUDIO_NUM            "Audio Num"
#define AUDIO_ENABLE         "Audio Enable"
#define AUDIO_FORMAT         "Audio Format"
#define SAMPLING_RATE        "Sampling Rate"
#define NUM_CHANNEL          "Num Of Channel"
#define VOLUME               "Volume"
#define SOURCE               "Source"
#define RENDERER             "Renderer"


/* Streaming configurations */
#define TRACE_CONFIG         "Trace Configuration"
#define FPS_INFO             "FPS Info"
#define APM_INFO             "APM Info"
#define PIPELINE_INFO        "Pipeline Info"
#define LOOP_PLAYBACK        "Loop Playback"
#define LOOP_INTERVAL        "Loop Interval"

#define EXIT                 "Exit"

#endif /* INCLUDE_CONFIGS_H_ */
