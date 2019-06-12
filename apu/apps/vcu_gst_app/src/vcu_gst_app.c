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

#include "configs.h"
#include "vcu_gst_app.h"

App app_data;

void
usage () {
    g_print ("minimum 2 arguments are required.\n"
             "./vcu_gst_app ./input.cfg\n");
}

static gchar*
skip_whitespace(gchar* cursor) {
    gchar *new = NULL;
    if (!cursor)
        return NULL;
    if (*cursor == '\0')
        return NULL;
    while (*cursor == '\t' || *cursor == '\r' || *cursor == ' ' || *cursor == ':') {
        ++(cursor);
    }
    new = strtok (cursor, "\n");
    return new;
}

gboolean
meet_exit_criterion () {
    gchar *ptr = app_data.line;
    if (ptr) {
        ptr = skip_whitespace (ptr);
        if ((ptr && !strncasecmp(ptr, EXIT, strlen (EXIT))) || feof(app_data.file)) {
            return TRUE;
        }
    }
    return FALSE;
}

static gchar*
get_value (gchar *ptr, const gchar *key) {
    ptr += strlen(key);
    ptr = skip_whitespace (ptr);
    return ptr;
}

void
get_cmn_config () {
    gint temp =0;
    gchar *ptr = NULL;
    while (!meet_exit_criterion ()) {
        fgets (app_data.line, sizeof (app_data.line), app_data.file);
        if ((ptr = strstr (app_data.line, NUM_SRC)) != NULL) {
            ptr = get_value (ptr, NUM_SRC);
            temp = atoi (ptr);
            if (temp >= MIN_NUM_SOURCES && temp <= MAX_NUM_SOURCES) {
                app_data.cmnParam.num_src = temp;
            } else {
                g_print ("Warning!! Num of Input value is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, OUTPUT)) != NULL) {
            ptr = get_value (ptr, OUTPUT);
            if (ptr ) {
                if (!strncasecmp (ptr, DP_OUT, strlen (DP_OUT))) {
                    app_data.cmnParam.driver_type = DP;
                } else if (!strncasecmp (ptr, HDMI_OUT, strlen (HDMI_OUT)) || !strncasecmp (ptr, HDMI_TX_OUT, strlen (HDMI_TX_OUT))) {
                    app_data.cmnParam.driver_type = HDMI_Tx;
                } else if (!strncasecmp (ptr, SDI_OUT, strlen (SDI_OUT)) || !strncasecmp (ptr, SDI_TX_OUT, strlen (SDI_TX_OUT))) {
                    app_data.cmnParam.driver_type = SDI_Tx;
                } else {
                    g_print ("Warning!! output destination value is incorrect taking default\n");
                }
            } else {
                g_print ("Warning!! Output destination value is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, OUTPUT_TYPE)) != NULL) {
            ptr = get_value (ptr, OUTPUT_TYPE);
            if (ptr) {
                if (!strncasecmp (ptr, RECORD_FILE_OUT, strlen (RECORD_FILE_OUT))) {
                    app_data.cmnParam.sink_type = RECORD;
                } else if (!strncasecmp (ptr, STREAM_OUT, strlen (STREAM_OUT))) {
                    app_data.cmnParam.sink_type = STREAM;
                } else if (!strncasecmp (ptr, DISPLAY_OUT, strlen (DISPLAY_OUT))) {
                    app_data.cmnParam.sink_type = DISPLAY;
                } else if (!strncasecmp (ptr, SPLIT_SCREEN_OUT, strlen (SPLIT_SCREEN_OUT))) {
                    app_data.cmnParam.sink_type = SPLIT_SCREEN;
                } else {
                    g_print ("Warning!! Output type value is incorrect taking default\n");
                }
            } else {
                g_print ("Warning!! Output type value is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, FRAME_RATE)) != NULL) {
            ptr = get_value (ptr, FRAME_RATE);
            ptr = skip_whitespace (ptr);
            if (ptr) {
                app_data.cmnParam.frame_rate = atoi (ptr);
            } else {
                g_print ("Warning!! Frame rate is incorrect taking default\n");
            }
        }
    }
}

void
get_input_config () {
    gchar *ptr = NULL;
    guint tmp, cnt =1;
    while (!meet_exit_criterion ()) {
        fgets (app_data.line, sizeof (app_data.line), app_data.file);
        if ((ptr = strstr (app_data.line, INPUT_NUM)) != NULL) {
            ptr = get_value (ptr, INPUT_NUM);
            tmp = atoi (ptr);
            if (tmp >= MIN_NUM_SOURCES && tmp <= MAX_NUM_SOURCES) {
                cnt = tmp;
            } else {
                cnt = 1;
                g_print ("Warning!! Input Num value is incorrect taking default =%d\n", cnt);
            }
        } else if ((ptr = strstr (app_data.line, ACCELERATOR_FILTER)) != NULL) {
            ptr = get_value (ptr, ACCELERATOR_FILTER);
            if (ptr) {
                if (!strncasecmp (ptr, TRUE_VAL, strlen (TRUE_VAL))) {
                    app_data.ipParam[cnt-1].accelerator = TRUE;
                } else if (!strncasecmp (ptr, FALSE_VAL, strlen (FALSE_VAL ))) {
                    app_data.ipParam[cnt-1].accelerator = FALSE;
                } else {
                    g_print ("Warning!! accelerator flag is incorrect taking default\n");
                }
            } else {
                g_print ("Warning!! accelerator flag is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, ENABLE_SCD)) != NULL) {
            ptr = get_value (ptr, ENABLE_SCD);
            if (ptr) {
                if (!strncasecmp (ptr, TRUE_VAL, strlen (TRUE_VAL))) {
                    app_data.ipParam[cnt-1].enable_scd = TRUE;
                } else if (!strncasecmp (ptr, FALSE_VAL, strlen (FALSE_VAL ))) {
                    app_data.ipParam[cnt-1].enable_scd = FALSE;
                } else {
                    g_print ("Warning!! enable_scd flag is incorrect taking default\n");
                }
            } else {
                g_print ("Warning!! enable_scd flag is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, INPUT_TYPE)) != NULL) {
            ptr = get_value (ptr, INPUT_TYPE);
            if (ptr) {
                if (!strncasecmp (ptr, HDMI_2_INPUT, strlen (HDMI_2_INPUT)) || !strncasecmp (ptr, HDMI_RX_2_INPUT, strlen(HDMI_RX_2_INPUT))) {
                    app_data.ipParam[cnt-1].device_type = HDMI_2;
                    app_data.ipParam[cnt-1].src_type = LIVE_SRC;
                } else if (!strncasecmp (ptr, HDMI_3_INPUT, strlen (HDMI_3_INPUT)) || !strncasecmp (ptr, HDMI_RX_3_INPUT, strlen(HDMI_RX_3_INPUT))) {
                    app_data.ipParam[cnt-1].device_type = HDMI_3;
                    app_data.ipParam[cnt-1].src_type = LIVE_SRC;
                } else if (!strncasecmp (ptr, HDMI_4_INPUT, strlen (HDMI_4_INPUT)) || !strncasecmp (ptr, HDMI_RX_4_INPUT, strlen(HDMI_RX_4_INPUT))) {
                    app_data.ipParam[cnt-1].device_type = HDMI_4;
                    app_data.ipParam[cnt-1].src_type = LIVE_SRC;
                } else if (!strncasecmp (ptr, HDMI_5_INPUT, strlen (HDMI_5_INPUT)) || !strncasecmp (ptr, HDMI_RX_5_INPUT, strlen(HDMI_RX_5_INPUT))) {
                    app_data.ipParam[cnt-1].device_type = HDMI_5;
                    app_data.ipParam[cnt-1].src_type = LIVE_SRC;
                } else if (!strncasecmp (ptr, HDMI_6_INPUT, strlen (HDMI_6_INPUT)) || !strncasecmp (ptr, HDMI_RX_6_INPUT, strlen(HDMI_RX_6_INPUT))) {
                    app_data.ipParam[cnt-1].device_type = HDMI_6;
                    app_data.ipParam[cnt-1].src_type = LIVE_SRC;
                } else if (!strncasecmp (ptr, HDMI_7_INPUT, strlen (HDMI_7_INPUT)) || !strncasecmp (ptr, HDMI_RX_7_INPUT, strlen(HDMI_RX_7_INPUT))) {
                    app_data.ipParam[cnt-1].device_type = HDMI_7;
                    app_data.ipParam[cnt-1].src_type = LIVE_SRC;
                } else if (!strncasecmp (ptr, TPG_2_INPUT, strlen (TPG_2_INPUT))) {
                    app_data.ipParam[cnt-1].device_type = TPG_2;
                    app_data.ipParam[cnt-1].src_type = LIVE_SRC;
                } else if (!strncasecmp (ptr, TPG_INPUT, strlen (TPG_INPUT))) {
                    app_data.ipParam[cnt-1].device_type = TPG_1;
                    app_data.ipParam[cnt-1].src_type = LIVE_SRC;
                } else if (!strncasecmp (ptr, HDMI_INPUT, strlen (HDMI_INPUT)) || !strncasecmp (ptr, HDMI_RX_INPUT, strlen (HDMI_RX_INPUT))) {
                    app_data.ipParam[cnt-1].device_type = HDMI_1;
                    app_data.ipParam[cnt-1].src_type = LIVE_SRC;
                } else if (!strncasecmp (ptr, MIPI_INPUT, strlen (MIPI_INPUT)) || !strncasecmp (ptr, CSI_INPUT, strlen (CSI_INPUT)) ||\
                           !strncasecmp (ptr, MIPI_CSI_INPUT, strlen (MIPI_CSI_INPUT))) {
                    app_data.ipParam[cnt-1].device_type = CSI;
                    app_data.ipParam[cnt-1].src_type = LIVE_SRC;
                } else if (!strncasecmp (ptr, SDI_INPUT, strlen (SDI_INPUT)) || !strncasecmp (ptr, SDI_RX_INPUT, strlen (SDI_RX_INPUT))) {
                    app_data.ipParam[cnt-1].device_type = SDI;
                    app_data.ipParam[cnt-1].src_type = LIVE_SRC;
                } else if (!strncasecmp (ptr, FILE_INPUT, strlen (FILE_INPUT))) {
                    app_data.ipParam[cnt-1].src_type = FILE_SRC;
                } else if (!strncasecmp (ptr, STREAMING_INPUT, strlen (STREAMING_INPUT))) {
                    app_data.ipParam[cnt-1].src_type = STREAMING_SRC;
                } else {
                    g_print ("Warning!! input type value is incorrect taking default\n");
                }
            } else {
                g_print ("Warning!! input type value is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, URI)) != NULL) {
            ptr = get_value (ptr, URI);
            if (ptr) {
                app_data.ipParam[cnt-1].uri = g_strdup (ptr);
            } else {
                g_print ("Warning!! file Uri is null\n");
            }
        } else if ((ptr = strstr (app_data.line, FORMAT)) != NULL) {
            ptr = get_value (ptr, FORMAT);
            if (ptr) {
                if (!strncasecmp (ptr, NV12_FORMAT, strlen (NV12_FORMAT))) {
                    app_data.ipParam[cnt-1].format = NV12;
                } else if (!strncasecmp (ptr, NV16_FORMAT, strlen (NV16_FORMAT))) {
                    app_data.ipParam[cnt-1].format = NV16;
                } else if (!strncasecmp (ptr, XV15_FORMAT, strlen (XV15_FORMAT))) {
                    app_data.ipParam[cnt-1].format = XV15;
                } else if (!strncasecmp (ptr, XV20_FORMAT, strlen (XV20_FORMAT))) {
                    app_data.ipParam[cnt-1].format = XV20;
                } else {
                    g_print ("Warning!! Format value is incorrect taking default\n");
                }
            } else {
                g_print ("Warning!! Format value is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, RAW)) != NULL) {
            ptr = get_value (ptr, RAW);
            if (ptr ) {
                if (!strncasecmp (ptr, TRUE_VAL, strlen (TRUE_VAL))) {
                    app_data.ipParam[cnt-1].raw = TRUE;
                } else if (!strncasecmp (ptr, FALSE_VAL, strlen (FALSE_VAL ))) {
                    app_data.ipParam[cnt-1].raw = FALSE;
                } else {
                    g_print ("Warning!! Raw flag value is incorrect taking default\n");
                }
            } else {
                g_print ("Warning!! Raw flag value is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, WIDTH)) != NULL) {
            ptr = get_value (ptr, WIDTH);
            if (ptr) {
                app_data.ipParam[cnt-1].width = atoi (ptr);
            } else {
                g_print ("Warning!! Width value is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, HEIGHT)) != NULL) {
            ptr = get_value (ptr, HEIGHT);
            if (ptr) {
                app_data.ipParam[cnt-1].height = atoi (ptr);
            } else {
                g_print ("Warning!! Height value is incorrect taking default\n");
            }
        }
    }
}

gboolean
set_preset_config (gchar *ptr, guint index) {
    vgst_enc_params *encParam = &app_data.encParam[index-1];
    if (!strncasecmp (ptr, HEVC_HIGH, strlen (HEVC_HIGH))) {
        encParam->bitrate = HIGH_BITRATE;
        encParam->enc_type = HEVC;
    } else if (!strncasecmp (ptr, HEVC_MEDIUM, strlen (HEVC_MEDIUM))) {
        encParam->bitrate = MEDIUM_BITRATE;
        encParam->enc_type = HEVC;
    } else if (!strncasecmp (ptr, HEVC_LOW, strlen (HEVC_LOW))) {
        encParam->bitrate = LOW_BITRATE;
        encParam->enc_type = HEVC;
    } else if (!strncasecmp (ptr, AVC_HIGH, strlen (AVC_HIGH))) {
        encParam->bitrate = HIGH_BITRATE;
        encParam->enc_type = AVC;
    } else if (!strncasecmp (ptr, AVC_MEDIUM, strlen (AVC_MEDIUM))) {
        encParam->bitrate = MEDIUM_BITRATE;
        encParam->enc_type = AVC;
    } else if (!strncasecmp (ptr, AVC_LOW, strlen (AVC_LOW))) {
        encParam->bitrate = LOW_BITRATE;
        encParam->enc_type = AVC;
    } else {
        return FALSE;
    }
    encParam->b_frame = DEFAULT_B_FRAME;
    encParam->enable_l2Cache = TRUE;
    encParam->gop_len = DEFAULT_GOP_LEN;
    if (encParam->enc_type == HEVC)
        encParam->profile = MAIN_PROFILE;
    else
        encParam->profile = HIGH_PROFILE;
    encParam->qp_mode = AUTO;
    encParam->rc_mode = CBR;
    encParam->slice = DEFAULT_NUM_SLICE;
    encParam->gop_mode = BASIC;
    encParam->filler_data = TRUE;
    encParam->low_bandwidth = FALSE;
    encParam->latency_mode = NORMAL_LATENCY;
    return TRUE;
}

void
get_encoder_config () {
    gchar *ptr = NULL;
    guint tmp, cnt;
    while (!meet_exit_criterion ()) {
        fgets (app_data.line, sizeof (app_data.line), app_data.file);
        if ((ptr = strstr (app_data.line, ENCODER_NUM)) != NULL) {
            ptr = get_value (ptr, ENCODER_NUM);
            tmp = atoi (ptr);
            if (tmp >= MIN_NUM_SOURCES && tmp <= MAX_NUM_SOURCES) {
                cnt = tmp;
            } else {
                cnt = MIN_NUM_SOURCES;
                g_print ("Warning!! Encoder Num value is incorrect taking default =%d\n", cnt);
            }
        } else if ((ptr = strstr (app_data.line, PRESET)) != NULL) {
            ptr = get_value (ptr, PRESET);
            if (ptr) {
                if (strncasecmp (ptr, CUSTOM, strlen (CUSTOM))) {
                    if (!set_preset_config (ptr, cnt)) {
                        g_print ("Warning!! Preset value is incorrect taking custom as default\n");
                    }
                }
            } else {
                g_print ("Warning!! Preset value is incorrect taking custom as default\n");
            }
        } else if ((ptr = strstr (app_data.line, ENCODER_NAME)) != NULL) {
            ptr = get_value (ptr, ENCODER_NAME);
            if (ptr) {
                if (!strncasecmp (ptr, H264_ENC_NAME, strlen (H264_ENC_NAME)) || !strncasecmp (ptr, AVC_ENC_NAME, strlen (AVC_ENC_NAME))) {
                    app_data.encParam[cnt-1].enc_type = AVC;
                } else if (!strncasecmp (ptr, H265_ENC_NAME, strlen (H265_ENC_NAME)) || !strncasecmp (ptr, HEVC_ENC_NAME, strlen (HEVC_ENC_NAME))) {
                    app_data.encParam[cnt-1].enc_type = HEVC;
                } else {
                    g_print ("Warning!! Encoder Name is incorrect taking default\n");
                }
            } else {
                g_print ("Warning!! Encoder Name is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, PROFILE)) != NULL) {
            ptr = get_value (ptr, PROFILE);
            if (ptr) {
                if (!strncasecmp (ptr, BASE_PROF, strlen (BASE_PROF))) {
                    app_data.encParam[cnt-1].profile = BASELINE_PROFILE;
                } else if (!strncasecmp (ptr, MAIN_PROF, strlen (MAIN_PROF))) {
                    app_data.encParam[cnt-1].profile = MAIN_PROFILE;
                } else if (!strncasecmp (ptr, HIGH_PROF, strlen (HIGH_PROF))) {
                    app_data.encParam[cnt-1].profile = HIGH_PROFILE;
                } else {
                    g_print ("Warning!! profile value is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! profile value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, QP_VALUE)) != NULL) {
            ptr = get_value (ptr, QP_VALUE);
            if (ptr) {
                if (!strncasecmp (ptr, UNIFORM_QP, strlen (UNIFORM_QP))) {
                    app_data.encParam[cnt-1].qp_mode = UNIFORM;
                } else if (!strncasecmp (ptr, AUTO_QP, strlen (AUTO_QP))) {
                    app_data.encParam[cnt-1].qp_mode = AUTO;
                } else {
                    g_print ("Warning!! qp_mode value is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! qp_mode value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, RATE_CONTRL)) != NULL) {
            ptr = get_value (ptr, RATE_CONTRL);
            if (ptr) {
                if (!strncasecmp (ptr, CBR_RC, strlen (CBR_RC))) {
                    app_data.encParam[cnt-1].rc_mode = CBR;
                } else if (!strncasecmp (ptr, VBR_RC, strlen (VBR_RC))) {
                    app_data.encParam[cnt-1].rc_mode = VBR;
                } else if (!strncasecmp (ptr, LOWLATENCY_RC, strlen (LOWLATENCY_RC))) {
                    app_data.encParam[cnt-1].rc_mode = LOW_LATENCY;
                } else {
                    g_print ("Warning!! rc_mode is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! rc_mode is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, BITRATE)) != NULL) {
            ptr = get_value (ptr, BITRATE);
            if (ptr) {
                app_data.encParam[cnt-1].bitrate = atoi (ptr);
            } else {
                g_print ("Warning!! bitrate is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, FILLER_DATA)) != NULL) {
            ptr = get_value (ptr, FILLER_DATA);
            if (ptr) {
                if (!strncasecmp (ptr, TRUE_VAL, strlen (TRUE_VAL))) {
                    app_data.encParam[cnt-1].filler_data = TRUE;
                } else if (!strncasecmp (ptr, FALSE_VAL, strlen (FALSE_VAL))) {
                    app_data.encParam[cnt-1].filler_data = FALSE;
                } else {
                    g_print ("Warning!! filler_data value is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! filler_data value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, LOW_BANDWIDTH)) != NULL) {
            ptr = get_value (ptr, LOW_BANDWIDTH);
            if (ptr) {
                if (!strncasecmp (ptr, TRUE_VAL, strlen (TRUE_VAL))) {
                    app_data.encParam[cnt-1].low_bandwidth = TRUE;
                } else if (!strncasecmp (ptr, FALSE_VAL, strlen (FALSE_VAL))) {
                    app_data.encParam[cnt-1].low_bandwidth = FALSE;
                } else {
                    g_print ("Warning!! low_bandwidth value is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! low_bandwidth value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, GOP_MODE)) != NULL) {
            ptr = get_value (ptr, GOP_MODE);
            if (ptr) {
                if (!strncasecmp (ptr, BASIC_GOP, strlen (BASIC_GOP))) {
                    app_data.encParam[cnt-1].gop_mode = BASIC;
                } else if (!strncasecmp (ptr, LOW_DELAY_P_GOP, strlen (LOW_DELAY_P_GOP))) {
                    app_data.encParam[cnt-1].gop_mode = LOW_DELAY_P;
                } else if (!strncasecmp (ptr, LOW_DELAY_B_GOP, strlen (LOW_DELAY_B_GOP))) {
                    app_data.encParam[cnt-1].gop_mode = LOW_DELAY_B;
                } else {
                    g_print ("Warning!! gop_mode is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! gop_mode is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, B_FRAMES)) != NULL) {
            ptr = get_value (ptr, B_FRAMES);
            if (ptr) {
                app_data.encParam[cnt-1].b_frame = atoi (ptr);
            } else {
                g_print ("Warning!! b_frame value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, LATENCY_MODE)) != NULL) {
            ptr = get_value (ptr, LATENCY_MODE);
            if (ptr) {
                if (!strncasecmp (ptr, NORMAL, strlen (NORMAL))) {
                    app_data.encParam[cnt-1].latency_mode = NORMAL_LATENCY;
                } else if (!strncasecmp (ptr, SUB_FRAME, strlen (SUB_FRAME))) {
                    app_data.encParam[cnt-1].latency_mode = SUB_FRAME_LATENCY;
                } else {
                    g_print ("Warning!! latency_mode is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! latency_mode is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, SLICE)) != NULL) {
            ptr = get_value (ptr, SLICE);
            if (ptr) {
                app_data.encParam[cnt-1].slice = atoi (ptr);
            } else {
                g_print ("Warning!! slice value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, GOP_LENGTH)) != NULL) {
            ptr = get_value (ptr, GOP_LENGTH);
            if (ptr) {
                app_data.encParam[cnt-1].gop_len = atoi (ptr);
            } else {
                g_print ("Warning!! gop_len value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, L2_CACHE)) != NULL) {
            ptr = get_value (ptr, L2_CACHE);
            if (ptr) {
                if (!strncasecmp (ptr, TRUE_VAL, strlen (TRUE_VAL))) {
                    app_data.encParam[cnt-1].enable_l2Cache = TRUE;
                } else if (!strncasecmp (ptr, FALSE_VAL, strlen (FALSE_VAL))) {
                    app_data.encParam[cnt-1].enable_l2Cache = FALSE;
                } else {
                    g_print ("Warning!! enable_l2Cache value is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! enable_l2Cache value is wrong taking default\n");
            }
        }
    }
}

void
get_record_config () {
    gchar *ptr = NULL;
    guint tmp, cnt = MIN_NUM_SOURCES;
    while (!meet_exit_criterion ()) {
        fgets (app_data.line, sizeof (app_data.line), app_data.file);
        if ((ptr = strstr (app_data.line, RECORD_NUM)) != NULL) {
            ptr = get_value (ptr, RECORD_NUM);
            if (ptr) {
                tmp = atoi (ptr);
                if (tmp >= MIN_NUM_SOURCES && tmp <= MAX_NUM_SOURCES) {
                    cnt = tmp;
                } else {
                    g_print ("Warning!! Record Num value is incorrect taking default\n");
                }
            }
        } else if ((ptr = strstr (app_data.line, OUT_FILE_NAME)) != NULL) {
            ptr = get_value (ptr, OUT_FILE_NAME);
            if (ptr) {
                app_data.opParam[cnt-1].file_out = g_strdup (ptr);
            } else {
                g_print ("Warning!! File out path is null\n");
            }
        } else if ((ptr = strstr (app_data.line, DURATION)) != NULL) {
            ptr = get_value (ptr, DURATION);
            if (ptr) {
                tmp = atoi (ptr);
                if (tmp >= MIN_RECORD_DUR && tmp <= MAX_RECORD_DUR) {
                    app_data.opParam[cnt-1].duration = tmp;
                } else {
                    g_print ("Warning!! Record duration is incorrect taking default\n");
                }
            } else {
                g_print ("Warning!! Record duration is incorrect taking default\n");
            }
        }
    }
}

void
get_stream_config () {
    gchar *ptr = NULL;
    guint tmp, cnt = MIN_NUM_SOURCES;
    while (!meet_exit_criterion ()) {
        fgets (app_data.line, sizeof (app_data.line), app_data.file);
        if ((ptr = strstr (app_data.line, STREAMING_NUM)) != NULL) {
            ptr = get_value (ptr, STREAMING_NUM);
            tmp = atoi (ptr);
            if (tmp >= MIN_NUM_SOURCES && tmp <= MAX_NUM_SOURCES) {
                cnt = tmp;
            } else {
                g_print ("Streaming Num value is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, HOST_IP)) != NULL) {
            ptr = get_value (ptr, HOST_IP);
            if (ptr) {
                app_data.opParam[cnt-1].host_ip = g_strdup (ptr);
            } else {
                g_print ("Warning!! host_ip is null\n");
            }
        } else if ((ptr = strstr (app_data.line, PORT)) != NULL) {
            ptr = get_value (ptr, PORT);
            if (ptr) {
                app_data.opParam[cnt-1].port_num = atoi (ptr);
            } else {
                g_print ("Warning!! port_num is incorrect taking default\n");
            }
        }
    }
}

void
get_audio_config () {
    gchar *ptr = NULL;
    guint tmp =0;
    guint cnt = MIN_NUM_SOURCES;
    gdouble vol;
    while (!meet_exit_criterion ()) {
        fgets (app_data.line, sizeof (app_data.line), app_data.file);
        if ((ptr = strstr (app_data.line, AUDIO_NUM)) != NULL) {
            ptr = get_value (ptr, AUDIO_NUM);
            tmp = atoi (ptr);
            if (tmp >= MIN_NUM_SOURCES && tmp <= MAX_NUM_SOURCES) {
                cnt = tmp;
            } else {
                g_print ("Audio Num value is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, AUDIO_FORMAT)) != NULL) {
            ptr = get_value (ptr, AUDIO_FORMAT);
            if (ptr) {
                app_data.audParam[cnt-1].format = g_strdup (ptr);
            } else {
                g_print ("Warning!! audio format is null taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, AUDIO_ENABLE)) != NULL) {
            ptr = get_value (ptr, AUDIO_ENABLE);
            if (ptr) {
                if (!strncasecmp (ptr, TRUE_VAL, strlen (TRUE_VAL))) {
                    app_data.audParam[cnt-1].enable_audio = TRUE;
                } else if (!strncasecmp (ptr, FALSE_VAL, strlen (FALSE_VAL))) {
                    app_data.audParam[cnt-1].enable_audio = FALSE;
                } else {
                    g_print ("Warning!! enable_audio value is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! enable_audio value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, SAMPLING_RATE)) != NULL) {
            ptr = get_value (ptr, SAMPLING_RATE);
            tmp = atoi (ptr);
            if (tmp) {
                app_data.audParam[cnt-1].sampling_rate = tmp;
            } else {
                g_print ("Warning!! sampling rate is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, NUM_CHANNEL)) != NULL) {
            ptr = get_value (ptr, NUM_CHANNEL);
            tmp = atoi (ptr);
            if (tmp) {
                app_data.audParam[cnt-1].channel = tmp;
            } else {
                g_print ("Warning!! channel is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, SOURCE)) != NULL) {
            ptr = get_value (ptr, SOURCE);
            if (ptr) {
                if (!strncasecmp (ptr, HDMI_INPUT, strlen (HDMI_INPUT))) {
                    app_data.audParam[cnt-1].audio_in = AUDIO_HDMI_IN;
                } else if (!strncasecmp (ptr, SDI_INPUT, strlen (SDI_INPUT))) {
                    app_data.audParam[cnt-1].audio_in = AUDIO_SDI_IN;
                } else if (!strncasecmp (ptr, I2S_INPUT, strlen (I2S_INPUT))) {
                    app_data.audParam[cnt-1].audio_in = AUDIO_I2S_IN;
                } else {
                    g_print ("Warning!! audio_in value is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! audio_in value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, RENDERER)) != NULL) {
            ptr = get_value (ptr, RENDERER);
            if (ptr) {
                if (!strncasecmp (ptr, HDMI_OUT, strlen (HDMI_OUT))) {
                    app_data.audParam[cnt-1].audio_out = AUDIO_HDMI_OUT;
                } else if (!strncasecmp (ptr, SDI_OUT, strlen (SDI_OUT))) {
                    app_data.audParam[cnt-1].audio_out = AUDIO_SDI_OUT;
                } else if (!strncasecmp (ptr, I2S_OUT, strlen (I2S_OUT))) {
                    app_data.audParam[cnt-1].audio_out = AUDIO_I2S_OUT;
                } else if (!strncasecmp (ptr, DP_OUT, strlen (DP_OUT))) {
                    app_data.audParam[cnt-1].audio_out = AUDIO_DP_OUT;
                } else {
                    g_print ("Warning!! audio_out value is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! audio_out value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, VOLUME)) != NULL) {
            ptr = get_value (ptr, VOLUME);
            vol = atof (ptr);
            app_data.audParam[cnt-1].volume = vol;
        }
    }
}

void
get_trace_config () {
    gchar *ptr = NULL;
    while (!meet_exit_criterion ()) {
        fgets (app_data.line, sizeof (app_data.line), app_data.file);
        if ((ptr = strstr (app_data.line, FPS_INFO)) != NULL) {
            ptr = get_value (ptr, FPS_INFO);
            if (ptr) {
                if (!strncasecmp (ptr, TRUE_VAL, strlen (TRUE_VAL))) {
                    app_data.fps_info = TRUE;
                } else if (!strncasecmp (ptr, FALSE_VAL, strlen (FALSE_VAL))) {
                    app_data.fps_info = FALSE;
                } else {
                    g_print ("Warning!! fps_info value is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! fps_info value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, APM_INFO)) != NULL) {
            ptr = get_value (ptr, APM_INFO);
            if (ptr) {
                if (!strncasecmp (ptr, TRUE_VAL, strlen (TRUE_VAL))) {
                    app_data.apm_info = TRUE;
                } else if (!strncasecmp (ptr, FALSE_VAL, strlen (FALSE_VAL))) {
                    app_data.apm_info = FALSE;
                } else {
                    g_print ("Warning!! apm_info value is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! apm_info value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, LOOP_PLAYBACK)) != NULL) {
            ptr = get_value (ptr, LOOP_PLAYBACK);
            if (ptr) {
                if (!strncasecmp (ptr, TRUE_VAL, strlen (TRUE_VAL))) {
                    app_data.loop_playback = TRUE;
                } else if (!strncasecmp (ptr, FALSE_VAL, strlen (FALSE_VAL))) {
                    app_data.loop_playback = FALSE;
                } else {
                    g_print ("Warning!! loop playback value is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! loop playback value is wrong taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, LOOP_INTERVAL)) != NULL) {
            ptr = get_value (ptr, LOOP_INTERVAL);
            if (ptr) {
                app_data.loop_interval = atoi (ptr);
            } else {
                g_print ("Warning!! loop interval in second is incorrect taking default\n");
            }
        } else if ((ptr = strstr (app_data.line, PIPELINE_INFO)) != NULL) {
            ptr = get_value (ptr, PIPELINE_INFO);
            if (ptr) {
                if (!strncasecmp (ptr, TRUE_VAL, strlen (TRUE_VAL))) {
                    app_data.pipeline_info = TRUE;
                } else if (!strncasecmp (ptr, FALSE_VAL, strlen (FALSE_VAL))) {
                    app_data.pipeline_info = FALSE;
                } else {
                    g_print ("Warning!! pipeline_info value is wrong taking default\n");
                }
            } else {
                g_print ("Warning!! pipeline_info value is wrong taking default\n");
            }
        }
    }
}

gint
parse_config_file (gchar *path) {
    gchar *ptr = NULL;
    app_data.file = fopen (path, "r");
    if (!app_data.file) {
        g_print ("Error!! Input file can't be opened\n");
        return -1;
    }
    while (fgets (app_data.line, sizeof (app_data.line), app_data.file)) {
        if ((ptr = strstr (app_data.line, CMN_CONFIG)) != NULL) {
            get_cmn_config ();
        } else if ((ptr = strstr (app_data.line, INPUT_CONFIG)) != NULL) {
            get_input_config ();
        } else if ((ptr = strstr (app_data.line, ENCODER_CONFIG)) != NULL) {
            get_encoder_config ();
        } else if ((ptr = strstr (app_data.line, RECORD_CONFIG)) != NULL) {
            get_record_config ();
        } else if ((ptr = strstr (app_data.line, STREAMING_CONFIG)) != NULL) {
            get_stream_config ();
        } else if ((ptr = strstr (app_data.line, AUDIO_CONFIG)) != NULL) {
            get_audio_config ();
        } else if ((ptr = strstr (app_data.line, TRACE_CONFIG)) != NULL) {
            get_trace_config ();
        }
    }
    if ((RECORD == app_data.cmnParam.sink_type || STREAM ==  app_data.cmnParam.sink_type) && app_data.fps_info) {
      g_print ("Warning!! fps info should be disabled for Record/streaming option\n");
      app_data.fps_info = FALSE;
    }
    fclose (app_data.file);
    return 0;
}

void
quit_pipeline (void) {
    gint err = vgst_stop_pipeline();

    if(VGST_SUCCESS == err) {
        g_print("pipeline stopped successfully \n");
    }
    else {
        g_print("ERROR: vgst_stop_pipeline() failed. \"%s\"\n", vgst_error_to_string(err, 0));
    }
}

void
free_resources (void) {
    guint i =0, ret = 0;
    for (i =0; i< MAX_NUM_SOURCES; i++) {
        if (app_data.ipParam[i].uri) {
            g_free (app_data.ipParam[i].uri);
        }
        if (app_data.opParam[i].file_out) {
            g_free (app_data.opParam[i].file_out);
        }
        if (app_data.opParam[i].host_ip) {
            g_free (app_data.opParam[i].host_ip);
        }
        if (app_data.audParam[i].format) {
            g_free (app_data.audParam[i].format);
        }
    }
    if (app_data.file) {
        fclose (app_data.file);
    }
    if (app_data.apm_info) {
        if (perf_monitor_deinit() != EXIT_SUCCESS) {
            g_print ("APM de-initialization failed\n");
        }
    }
    ret = vgst_uninit();
    if (ret !=  VGST_SUCCESS) {
        g_print("ERROR: vgst_uninit() failed error code \"%s\"\n", vgst_error_to_string(ret, 0));
    }
}

void
reset_all_params () {
    guint i =0;
    app_data.cmnParam.driver_type = HDMI_Tx;
    app_data.cmnParam.frame_rate = DEFAULT_DISPLAY_RATE;
    app_data.cmnParam.num_src = MIN_NUM_SOURCES;
    app_data.cmnParam.sink_type = DISPLAY;
    app_data.fps_info = TRUE;
    app_data.apm_info = TRUE;
    app_data.pipeline_info = TRUE;
    app_data.loop_playback = FALSE;
    app_data.loop_interval = 5;
    app_data.position = -1;

    for (i =0; i< MAX_NUM_SOURCES; i++) {
        app_data.encParam[i].b_frame = DEFAULT_B_FRAME;
        app_data.encParam[i].bitrate = LOW_BITRATE;
        app_data.encParam[i].enable_l2Cache = TRUE;
        app_data.encParam[i].enc_type = HEVC;
        app_data.encParam[i].gop_len = DEFAULT_GOP_LEN;
        if (app_data.encParam[i].enc_type == HEVC)
            app_data.encParam[i].profile = MAIN_PROFILE;
        else
            app_data.encParam[i].profile = HIGH_PROFILE;
        app_data.encParam[i].qp_mode = AUTO;
        app_data.encParam[i].rc_mode = CBR;
        app_data.encParam[i].slice = DEFAULT_NUM_SLICE;
        app_data.encParam[i].gop_mode = BASIC;
        app_data.encParam[i].filler_data = TRUE;
        app_data.encParam[i].low_bandwidth = FALSE;
        app_data.encParam[i].latency_mode = NORMAL_LATENCY;

        /* input param initialization */
        app_data.ipParam[i].device_type = TPG_1;
        app_data.ipParam[i].format = NV12;
        app_data.ipParam[i].raw = FALSE;
        app_data.ipParam[i].src_type = LIVE_SRC;
        app_data.ipParam[i].width = MAX_WIDTH;
        app_data.ipParam[i].height = MAX_HEIGHT;
        app_data.ipParam[i].accelerator = FALSE;
        app_data.ipParam[i].enable_scd = FALSE;

        /* output param initialization */
        app_data.opParam[i].duration = MIN_RECORD_DUR;
        app_data.opParam[i].port_num = DEFAULT_PORT_NUM;

        app_data.update_bitrate[i] = TRUE;
        app_data.audParam[i].format = g_strdup("S24_32LE");
        app_data.audParam[i].enable_audio = FALSE;
        app_data.audParam[i].sampling_rate = 48000;
        app_data.audParam[i].channel = 2;
        app_data.audParam[i].volume = 2.0;
        app_data.audParam[i].audio_in = AUDIO_HDMI_IN;
        app_data.audParam[i].audio_out = AUDIO_HDMI_OUT;

    }
}

void
print_pipeline_cmd () {
    guint cnt =0;
    gchar *sink;
    sink = app_data.cmnParam.sink_type == RECORD ? RECORD_FILE_OUT: app_data.cmnParam.sink_type == STREAM ? STREAM_OUT:DISPLAY_OUT;
    g_print ("/*************************Pipeline Information Start*************************/\n");
    g_print ("Pipeline Info : %s\n", app_data.pipeline_info == TRUE ? "On" : "Off");
    g_print ("Fps Info : %s\n", app_data.fps_info == TRUE ? "On" : "Off");
    g_print ("APM Info : %s\n", app_data.apm_info == TRUE ? "On" : "Off");
    g_print ("Output goes on : %s\n", app_data.cmnParam.driver_type == DP ? DP_OUT: app_data.cmnParam.driver_type == HDMI_Tx ? HDMI_OUT : SDI_OUT);
    g_print ("Frame rate : %d\n", app_data.cmnParam.frame_rate);
    g_print ("Number of Source is : %d\n", app_data.cmnParam.num_src);
    g_print ("Use case is to : %s\n", sink);
    for (cnt =0; cnt< app_data.cmnParam.num_src; cnt++) {
        if (app_data.audParam[cnt].enable_audio) {
            g_print ("Audio format is : %s\n", app_data.audParam[cnt].format);
            g_print ("Audio sampling rate is : %d\n", app_data.audParam[cnt].sampling_rate);
            g_print ("Channel is : %d\n", app_data.audParam[cnt].channel);
            g_print ("Volume level is : %f\n", app_data.audParam[cnt].volume);
            g_print ("Audio Source is : %s\n", app_data.audParam[cnt].audio_in == AUDIO_HDMI_IN ? HDMI_INPUT : app_data.audParam[cnt].audio_in == AUDIO_SDI_IN ? SDI_INPUT : I2S_INPUT);
            g_print ("Audio Renderer is : %s\n", app_data.audParam[cnt].audio_out == AUDIO_HDMI_OUT ? HDMI_OUT : app_data.audParam[cnt].audio_out == AUDIO_SDI_OUT ? SDI_OUT : \
                      app_data.audParam[cnt].audio_out == AUDIO_I2S_OUT ? I2S_OUT : DP_OUT);
        }
        if (!(app_data.ipParam[cnt].src_type == FILE_SRC || app_data.ipParam[cnt].src_type == STREAMING_SRC || app_data.ipParam[cnt].raw)) {
            g_print ("B Frames : %d\n", app_data.encParam[cnt].b_frame);
            g_print ("Bitrate : %d\n", app_data.encParam[cnt].bitrate);
            g_print ("Enable L2Cache : %s\n", app_data.encParam[cnt].enable_l2Cache == TRUE ? "True" : "False");
            g_print ("Enc Name : %s\n", app_data.encParam[cnt].enc_type == AVC ? "AVC":"HEVC");
            g_print ("Gop Len : %d\n", app_data.encParam[cnt].gop_len);
            g_print ("Profile : %s\n", app_data.encParam[cnt].profile == BASELINE_PROFILE? BASE_PROF : \
                      app_data.encParam[cnt].profile == MAIN_PROFILE ? MAIN_PROF : HIGH_PROF);
            g_print ("Qp Mode : %s\n", app_data.encParam[cnt].qp_mode == AUTO ? AUTO_QP : UNIFORM_QP);
            g_print ("Rc Mode : %s\n", app_data.encParam[cnt].rc_mode == CBR? CBR_RC:app_data.encParam[cnt].rc_mode == VBR? VBR_RC : LOWLATENCY_RC);
            g_print ("Num Slice : %d\n", app_data.encParam[cnt].slice);
            g_print ("GoP Mode : %s\n", app_data.encParam[cnt].gop_mode == BASIC ? BASIC_GOP : app_data.encParam[cnt].gop_mode == LOW_DELAY_P ? LOW_DELAY_P_GOP : \
                                        LOW_DELAY_B_GOP);
            g_print ("Filler Data : %s\n", app_data.encParam[cnt].filler_data == TRUE ? "True" : "False");
            g_print ("Low Bandwidth : %s\n", app_data.encParam[cnt].low_bandwidth == TRUE ? "True" : "False");
            g_print ("Latency Mode : %s\n", app_data.encParam[cnt].latency_mode == NORMAL_LATENCY ? NORMAL : SUB_FRAME);
        }
        g_print ("Device Type : %s\n", app_data.ipParam[cnt].device_type == TPG_1 ? TPG_INPUT : app_data.ipParam[cnt].device_type == HDMI_1 ? \
                  HDMI_INPUT: app_data.ipParam[cnt].device_type == CSI ? MIPI_INPUT : app_data.ipParam[cnt].device_type == HDMI_2 ? \
                  HDMI_2_INPUT : app_data.ipParam[cnt].device_type == HDMI_3 ? HDMI_3_INPUT : app_data.ipParam[cnt].device_type == HDMI_4 ? \
                  HDMI_4_INPUT : app_data.ipParam[cnt].device_type == HDMI_5 ? HDMI_5_INPUT : app_data.ipParam[cnt].device_type == HDMI_6 ? \
                  HDMI_6_INPUT : app_data.ipParam[cnt].device_type == HDMI_7 ? HDMI_7_INPUT : SDI_INPUT);
        g_print ("Format : %s\n", app_data.ipParam[cnt].format == NV12 ? \
                  NV12_FORMAT : app_data.ipParam[cnt].format == NV16 ? \
                  NV16_FORMAT : app_data.ipParam[cnt].format == XV15 ? XV15_FORMAT : XV20_FORMAT);
        g_print ("Width : %d\n", app_data.ipParam[cnt].width);
        g_print ("Height : %d\n", app_data.ipParam[cnt].height);
        g_print ("Raw : %s\n", app_data.ipParam[cnt].raw == TRUE ? "True" : "False");
        g_print ("Accelerator flag : %s\n", app_data.ipParam[cnt].accelerator == TRUE ? "True" : "False");
        g_print ("Enable_scd flag : %s\n", app_data.ipParam[cnt].enable_scd == TRUE ? "True" : "False");
        g_print ("Src Type : %s\n", app_data.ipParam[cnt].src_type ==LIVE_SRC ? "Live Src" : app_data.ipParam[cnt].src_type ==FILE_SRC ? "File Src" : "Streaming Src");
        if (app_data.ipParam[cnt].uri)
            g_print ("URI : %s\n", app_data.ipParam[cnt].uri);
        if (!strncasecmp (sink, RECORD_FILE_OUT, strlen (RECORD_FILE_OUT))) {
            g_print ("Duration : %d\n", app_data.opParam[cnt].duration);
            g_print ("Recording file path : %s\n", app_data.opParam[cnt].file_out);
        } else if (!strncasecmp (sink, STREAM_OUT, strlen (STREAM_OUT))) {
            g_print ("Streaming at IP : %s\n", app_data.opParam[cnt].host_ip);
            g_print ("Streaming at Port : %d\n", app_data.opParam[cnt].port_num);
        }
    }
    g_print ("/*************************Pipeline Information End*************************/\n");
}

void
signal_handler (gint sig) {
     signal(sig, SIG_IGN);
     g_print ("Hit Ctrl-C\n"
              "Quitting the app now\n");
     app_data.loop_playback = FALSE;
     if (app_data.loop && g_main_is_running (app_data.loop)) {
         g_print ("Quitting the loop \n");
         g_main_loop_quit (app_data.loop);
         g_main_loop_unref (app_data.loop);
     }
     return;
}

gboolean
loop_cb () {
    quit_pipeline ();
    if (app_data.loop_playback) {
        if (app_data.loop && g_main_is_running (app_data.loop)) {
            g_print ("Quitting the loop \n");
            g_main_loop_quit (app_data.loop);
            g_main_loop_unref (app_data.loop);
        }
    }
    return FALSE;
}

gboolean
time_cb () {
    gint arg = 0;
    guint ret = 0, cnt =0;
    guint num_src = app_data.cmnParam.num_src;
    guint bitrate =0;
    ret = vgst_poll_event(&arg, cnt);
    if (EVENT_EOS == ret) {
        if (app_data.loop && g_main_is_running (app_data.loop)) {
            g_print ("Quitting the loop \n");
            g_main_loop_quit (app_data.loop);
            g_main_loop_unref (app_data.loop);
        }
        return FALSE;
    } else {
        for (cnt = 0; cnt < num_src; cnt++) {
            ret = vgst_poll_event(&arg, cnt);
            if (EVENT_ERROR == ret) {
                g_print ("Error!! code \"%s\" to pipeline [%d]\n", vgst_error_to_string (arg, cnt), cnt+1);
            } else {
                if (app_data.apm_info) {
                    g_print ("Encoder Memory Bandwidth (%2.2f Gbps)\n", \
                            (float)((perf_monitor_get_rd_wr_cnt(E_APM0) + perf_monitor_get_rd_wr_cnt(E_APM1))* BYTE_TO_GBIT));
                    g_print ("Decoder Memory Bandwidth (%2.2f Gbps)\n", \
                            (float)((perf_monitor_get_rd_wr_cnt(E_APM2) + perf_monitor_get_rd_wr_cnt(E_APM3))* BYTE_TO_GBIT));
                }
                if (app_data.fps_info) {
                    vgst_get_fps (cnt, app_data.fps);
                    if (SPLIT_SCREEN == app_data.cmnParam.sink_type)
                        g_print ("Split screen Pipeline [%d] Fps[%d]::[%d]\n", cnt+1, app_data.fps[0], app_data.fps[1]);
                    else
                        g_print ("Pipeline [%d] Fps[%d]\n", cnt+1, app_data.fps[0]);
                }
                if (RECORD == app_data.cmnParam.sink_type) {
                    vgst_get_position (cnt, &app_data.position);
                }
                if ((app_data.ipParam[cnt].src_type == FILE_SRC || app_data.ipParam[cnt].src_type == STREAMING_SRC) && app_data.update_bitrate[cnt]) {
                    bitrate = vgst_get_bitrate (cnt);
                    if (bitrate) {
                        if (round(BIT_TO_MBIT(bitrate)) <= 0.0){
                            g_print ("pipeline [%d] file/streaming Bitrate : [%f]Kbps\n", cnt+1, round(BIT_TO_KBIT(bitrate)));
                        } else {
                            g_print ("pipeline [%d] file/streaming Bitrate : [%f]Mbps\n", cnt+1, round(BIT_TO_MBIT(bitrate)));
                        }
                        app_data.update_bitrate[cnt] = FALSE;
                    }
                }
            }
        }
    }
    return TRUE;
}

gint
main (gint argc, gchar *argv[]) {
    gint ret =0;
    if (argc < 2) {
        g_print ("Error!! Less arguments see the usage note :\n");
        usage ();
        return -1;
    }
    int count = 0;
    reset_all_params ();
    if (parse_config_file (argv[1]) < 0) {
        g_print ("Error!! parsing file failed\n");
        return -1;
    }
    signal(SIGINT, signal_handler);

    ret = vgst_init ();
    if (ret !=  VGST_SUCCESS) {
        g_print("ERROR: vgst_init() failed error code %d :: \"%s\"\n", ret, vgst_error_to_string(ret, 0));
        if (ret ==  VLIB_NO_MEDIA_SRC) {
            g_print("Get \"%s\" error in Tx only design, can be ignored!!!\n",  vgst_error_to_string(ret, 0));
        } else {
            g_print("Error condition : CleanUp\n");
            goto CLEANUP;
        }
    }
    if (app_data.apm_info) {
        if (perf_monitor_init() != EXIT_SUCCESS ) {
            g_print ("APM initialization failed. Disabling APM logs\n");
            app_data.apm_info = FALSE;
        }
    }
    if (app_data.pipeline_info)
        print_pipeline_cmd ();
    g_timeout_add_seconds (DEFAULT_INFO_INTERVAL, (GSourceFunc)time_cb, NULL);
    do {
        ret = vgst_config_options(&app_data.encParam[0], &app_data.ipParam[0], &app_data.opParam[0], &app_data.cmnParam, &app_data.audParam[0]);

        if(VGST_SUCCESS == ret) {
            ret = vgst_start_pipeline();
            if(VGST_SUCCESS != ret) {
                g_print("ERROR: vgst_start_pipeline() failed error code \"%s\"\n", vgst_error_to_string(ret, 0));
                goto QUIT;
            }
        } else {
            g_print("ERROR: vgst_config_options() failed, error code \"%s\"\n", vgst_error_to_string(ret, 0));
            goto CLEANUP;
        }
        if (app_data.loop_playback)
            g_timeout_add_seconds (app_data.loop_interval, (GSourceFunc)loop_cb, NULL);
        app_data.loop = g_main_loop_new (NULL, FALSE);
        g_main_loop_run (app_data.loop);
        g_print ("playback count %d\n", ++count);
    } while (app_data.loop_playback);

QUIT :
    quit_pipeline ();
CLEANUP :
    free_resources ();
    return 0;
}
