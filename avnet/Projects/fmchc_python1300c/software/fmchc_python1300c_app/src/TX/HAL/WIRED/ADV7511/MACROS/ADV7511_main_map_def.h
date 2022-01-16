/**********************************************************************************************
*																						      *
* Copyright (c) 2008 - 2012 Analog Devices, Inc.  All Rights Reserved.                        *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/
/*******************************************************************************
*                                                                              *

* This software is intended for use with the ADV7511 part only.                *
*                                                                              *
*******************************************************************************/

/*******************************************************************************
*                                                                              *
* FILE AUTOMATICALLY GENERATED.                                                *
* DATE: 4 Nov 2009 18:16:18                                                    *
*                                                                              *
*******************************************************************************/


#ifndef ADV7511_MAIN_MAP_DEF_H
#define ADV7511_MAIN_MAP_DEF_H

#define HTX_REG_MAIN_00H_DEF                                0x10
#define HTX_FIELD_CHIPREVISION_DEF                          0x10
#define HTX_FIELD_CHIPREVISION_BIT_SIZE                     8

#define HTX_FIELD_N_HIGH_BYTE_DEF                           0x0
#define HTX_FIELD_N_HIGH_BYTE_BIT_SIZE                      4

#define HTX_REG_MAIN_02H_DEF                                0x00
#define HTX_FIELD_N_MID_BYTE_DEF                            0x0
#define HTX_FIELD_N_MID_BYTE_BIT_SIZE                       8

#define HTX_REG_MAIN_03H_DEF                                0x00
#define HTX_FIELD_N_LOW_BYTE_DEF                            0x0
#define HTX_FIELD_N_LOW_BYTE_BIT_SIZE                       8

#define HTX_REG_MAIN_04H_DEF                                0x00
#define HTX_FIELD_SPDIF_SF_DEF                              0x0
#define HTX_FIELD_SPDIF_SF_BIT_SIZE                         4

#define HTX_FIELD_INT_CTS_HIGH_BYTE_DEF                     0x0
#define HTX_FIELD_INT_CTS_HIGH_BYTE_BIT_SIZE                4

#define HTX_REG_MAIN_05H_DEF                                0x00
#define HTX_FIELD_INT_CTS_MID_BYTE_DEF                      0x0
#define HTX_FIELD_INT_CTS_MID_BYTE_BIT_SIZE                 8

#define HTX_REG_MAIN_06H_DEF                                0x00
#define HTX_FIELD_INT_CTS_LOW_BYTE_DEF                      0x0
#define HTX_FIELD_INT_CTS_LOW_BYTE_BIT_SIZE                 8

#define HTX_REG_MAIN_07H_DEF                                0x00
#define HTX_FIELD_EXT_CTS_HIGH_BYTE_DEF                     0x0
#define HTX_FIELD_EXT_CTS_HIGH_BYTE_BIT_SIZE                4

#define HTX_REG_MAIN_08H_DEF                                0x00
#define HTX_FIELD_EXT_CTS_MID_BYTE_DEF                      0x0
#define HTX_FIELD_EXT_CTS_MID_BYTE_BIT_SIZE                 8

#define HTX_REG_MAIN_09H_DEF                                0x00
#define HTX_FIELD_EXT_CTS_LOW_BYTE_DEF                      0x0
#define HTX_FIELD_EXT_CTS_LOW_BYTE_BIT_SIZE                 8

#define HTX_REG_MAIN_0AH_DEF                                0x01
#define HTX_FIELD_CTS_SEL_DEF                               0x0
#define HTX_FIELD_CTS_SEL_BIT_SIZE                          1

#define HTX_FIELD_AUDIO_SEL_DEF                             0x0
#define HTX_FIELD_AUDIO_SEL_BIT_SIZE                        3

#define HTX_FIELD_AUDIO_MODE_DEF                            0x0
#define HTX_FIELD_AUDIO_MODE_BIT_SIZE                       2

#define HTX_FIELD_MCLK_RATIO_DEF                            0x1
#define HTX_FIELD_MCLK_RATIO_BIT_SIZE                       2

#define HTX_REG_MAIN_0BH_DEF                                0x0E
#define HTX_FIELD_SPDIF_EN_DEF                              0x0
#define HTX_FIELD_SPDIF_EN_BIT_SIZE                         1

#define HTX_FIELD_MCLK_POL_DEF                              0x0
#define HTX_FIELD_MCLK_POL_BIT_SIZE                         1

#define HTX_FIELD_MCLK_EN_DEF                               0x0
#define HTX_FIELD_MCLK_EN_BIT_SIZE                          1

#define HTX_REG_MAIN_0CH_DEF                                0xBC
#define HTX_FIELD_EXT_AUDIOSF_SEL_DEF                       0x1
#define HTX_FIELD_EXT_AUDIOSF_SEL_BIT_SIZE                  1

#define HTX_FIELD_CS_BIT_OVERRIDE_DEF                       0x0
#define HTX_FIELD_CS_BIT_OVERRIDE_BIT_SIZE                  1

#define HTX_FIELD_I2SENABLE_DEF                             0xf
#define HTX_FIELD_I2SENABLE_BIT_SIZE                        4

#define HTX_FIELD_I2SFORMAT_DEF                             0x0
#define HTX_FIELD_I2SFORMAT_BIT_SIZE                        2

#define HTX_REG_MAIN_0DH_DEF                                0x18
#define HTX_FIELD_I2S_BIT_WODTH_DEF                         0x18
#define HTX_FIELD_I2S_BIT_WODTH_BIT_SIZE                    5

#define HTX_REG_MAIN_0EH_DEF                                0x01
#define HTX_FIELD_SUBPKT0_L_SRC_DEF                         0x0
#define HTX_FIELD_SUBPKT0_L_SRC_BIT_SIZE                    3

#define HTX_FIELD_SUBPKT0_R_SRC_DEF                         0x1
#define HTX_FIELD_SUBPKT0_R_SRC_BIT_SIZE                    3

#define HTX_REG_MAIN_0FH_DEF                                0x13
#define HTX_FIELD_SUBPKT1_L_SRC_DEF                         0x2
#define HTX_FIELD_SUBPKT1_L_SRC_BIT_SIZE                    3

#define HTX_FIELD_SUBPKT1_R_SRC_DEF                         0x3
#define HTX_FIELD_SUBPKT1_R_SRC_BIT_SIZE                    3

#define HTX_REG_MAIN_10H_DEF                                0x25
#define HTX_FIELD_SUBPKT2_L_SRC_DEF                         0x4
#define HTX_FIELD_SUBPKT2_L_SRC_BIT_SIZE                    3

#define HTX_FIELD_SUBPKT2_R_SRC_DEF                         0x5
#define HTX_FIELD_SUBPKT2_R_SRC_BIT_SIZE                    3

#define HTX_REG_MAIN_11H_DEF                                0x37
#define HTX_FIELD_SUBPKT3_L_SRC_DEF                         0x6
#define HTX_FIELD_SUBPKT3_L_SRC_BIT_SIZE                    3

#define HTX_FIELD_SUBPKT3_R_SRC_DEF                         0x7
#define HTX_FIELD_SUBPKT3_R_SRC_BIT_SIZE                    3

#define HTX_REG_MAIN_12H_DEF                                0x00
#define HTX_FIELD_CS_BIT_1_0_DEF                            0x0
#define HTX_FIELD_CS_BIT_1_0_BIT_SIZE                       2

#define HTX_FIELD_CR_BIT_DEF                                0x0
#define HTX_FIELD_CR_BIT_BIT_SIZE                           1

#define HTX_FIELD_A_INFO_DEF                                0x0
#define HTX_FIELD_A_INFO_BIT_SIZE                           3

#define HTX_FIELD_CLK_ACC_DEF                               0x0
#define HTX_FIELD_CLK_ACC_BIT_SIZE                          2

#define HTX_REG_MAIN_13H_DEF                                0x00
#define HTX_FIELD_CATEGORY_CODE_DEF                         0x0
#define HTX_FIELD_CATEGORY_CODE_BIT_SIZE                    8

#define HTX_REG_MAIN_14H_DEF                                0x00
#define HTX_FIELD_SOURCENUMBER_DEF                          0x0
#define HTX_FIELD_SOURCENUMBER_BIT_SIZE                     4

#define HTX_FIELD_WORDLENGTH_DEF                            0x0
#define HTX_FIELD_WORDLENGTH_BIT_SIZE                       4

#define HTX_REG_MAIN_15H_DEF                                0x00
#define HTX_FIELD_I2S_SF_DEF                                0x0
#define HTX_FIELD_I2S_SF_BIT_SIZE                           4

#define HTX_FIELD_VFE_INPUT_ID_DEF                          0x0
#define HTX_FIELD_VFE_INPUT_ID_BIT_SIZE                     4

#define HTX_REG_MAIN_16H_DEF                                0x00
#define HTX_FIELD_VFE_OUT_FMT_DEF                           0x0
#define HTX_FIELD_VFE_OUT_FMT_BIT_SIZE                      2

#define HTX_FIELD_VFE_422_WIDTH_DEF                         0x0
#define HTX_FIELD_VFE_422_WIDTH_BIT_SIZE                    2

#define HTX_FIELD_VFE_INPUT_STYLE_DEF                       0x0
#define HTX_FIELD_VFE_INPUT_STYLE_BIT_SIZE                  2

#define HTX_FIELD_VFE_INPUT_EDGE_DEF                        0x0
#define HTX_FIELD_VFE_INPUT_EDGE_BIT_SIZE                   1

#define HTX_FIELD_VFE_INPUT_CS_DEF                          0x0
#define HTX_FIELD_VFE_INPUT_CS_BIT_SIZE                     1

#define HTX_REG_MAIN_17H_DEF                                0x00
#define HTX_FIELD_ITU_VSYNC_POL_DEF                         0x0
#define HTX_FIELD_ITU_VSYNC_POL_BIT_SIZE                    1

#define HTX_FIELD_ITU_HSYNC_POL_DEF                         0x0
#define HTX_FIELD_ITU_HSYNC_POL_BIT_SIZE                    1

#define HTX_FIELD_NC_CEC_MODE_DEF                           0x0
#define HTX_FIELD_NC_CEC_MODE_BIT_SIZE                      2

#define HTX_FIELD_GEN_444_EN_DEF                            0x0
#define HTX_FIELD_GEN_444_EN_BIT_SIZE                       1

#define HTX_FIELD_ASP_RATIO_DEF                             0x0
#define HTX_FIELD_ASP_RATIO_BIT_SIZE                        1

#define HTX_FIELD_DEGEN_EN_DEF                              0x0
#define HTX_FIELD_DEGEN_EN_BIT_SIZE                         1

#define HTX_REG_MAIN_18H_DEF                                0x46
#define HTX_FIELD_CSC_EN_DEF                                0x0
#define HTX_FIELD_CSC_EN_BIT_SIZE                           1

#define HTX_FIELD_CSC_MODE_DEF                              0x2
#define HTX_FIELD_CSC_MODE_BIT_SIZE                         2

#define HTX_FIELD_CSC_A1_MSB_DEF                            0x6
#define HTX_FIELD_CSC_A1_MSB_BIT_SIZE                       5

#define HTX_REG_MAIN_19H_DEF                                0x62
#define HTX_FIELD_CSC_A1_DEF                                0x62
#define HTX_FIELD_CSC_A1_BIT_SIZE                           8

#define HTX_REG_MAIN_1AH_DEF                                0x04
#define HTX_FIELD_COEFFI_UPDATE_DEF                         0x0
#define HTX_FIELD_COEFFI_UPDATE_BIT_SIZE                    1

#define HTX_FIELD_CSC_A2_MSB_DEF                            0x4
#define HTX_FIELD_CSC_A2_MSB_BIT_SIZE                       5

#define HTX_REG_MAIN_1BH_DEF                                0xA8
#define HTX_FIELD_CSC_A2_DEF                                0xa8
#define HTX_FIELD_CSC_A2_BIT_SIZE                           8

#define HTX_REG_MAIN_1CH_DEF                                0x00
#define HTX_FIELD_CSC_A3_MSB_DEF                            0x0
#define HTX_FIELD_CSC_A3_MSB_BIT_SIZE                       5

#define HTX_REG_MAIN_1DH_DEF                                0x00
#define HTX_FIELD_CSC_A3_DEF                                0x0
#define HTX_FIELD_CSC_A3_BIT_SIZE                           8

#define HTX_REG_MAIN_1EH_DEF                                0x1C
#define HTX_FIELD_CSC_A4_MSB_DEF                            0x1c
#define HTX_FIELD_CSC_A4_MSB_BIT_SIZE                       5

#define HTX_REG_MAIN_1FH_DEF                                0x84
#define HTX_FIELD_CSC_A4_DEF                                0x84
#define HTX_FIELD_CSC_A4_BIT_SIZE                           8

#define HTX_REG_MAIN_20H_DEF                                0x1C
#define HTX_FIELD_CSC_B1_MSB_DEF                            0x1c
#define HTX_FIELD_CSC_B1_MSB_BIT_SIZE                       5

#define HTX_REG_MAIN_21H_DEF                                0xBF
#define HTX_FIELD_CSC_B1_DEF                                0xbf
#define HTX_FIELD_CSC_B1_BIT_SIZE                           8

#define HTX_REG_MAIN_22H_DEF                                0x04
#define HTX_FIELD_CSC_B2_MSB_DEF                            0x4
#define HTX_FIELD_CSC_B2_MSB_BIT_SIZE                       5

#define HTX_REG_MAIN_23H_DEF                                0xA8
#define HTX_FIELD_CSC_B2_DEF                                0xa8
#define HTX_FIELD_CSC_B2_BIT_SIZE                           8

#define HTX_REG_MAIN_24H_DEF                                0x1E
#define HTX_FIELD_CSC_B3_MSB_DEF                            0x1e
#define HTX_FIELD_CSC_B3_MSB_BIT_SIZE                       5

#define HTX_REG_MAIN_25H_DEF                                0x70
#define HTX_FIELD_CSC_B3_DEF                                0x70
#define HTX_FIELD_CSC_B3_BIT_SIZE                           8

#define HTX_REG_MAIN_26H_DEF                                0x02
#define HTX_FIELD_CSC_B4_MSB_DEF                            0x2
#define HTX_FIELD_CSC_B4_MSB_BIT_SIZE                       5

#define HTX_REG_MAIN_27H_DEF                                0x1E
#define HTX_FIELD_CSC_B4_DEF                                0x1e
#define HTX_FIELD_CSC_B4_BIT_SIZE                           8

#define HTX_REG_MAIN_28H_DEF                                0x00
#define HTX_FIELD_CSC_C1_MSB_DEF                            0x0
#define HTX_FIELD_CSC_C1_MSB_BIT_SIZE                       5

#define HTX_REG_MAIN_29H_DEF                                0x00
#define HTX_FIELD_CSC_C1_DEF                                0x0
#define HTX_FIELD_CSC_C1_BIT_SIZE                           8

#define HTX_REG_MAIN_2AH_DEF                                0x04
#define HTX_FIELD_CSC_C2_MSB_DEF                            0x4
#define HTX_FIELD_CSC_C2_MSB_BIT_SIZE                       5

#define HTX_REG_MAIN_2BH_DEF                                0xA8
#define HTX_FIELD_CSC_C2_DEF                                0xa8
#define HTX_FIELD_CSC_C2_BIT_SIZE                           8

#define HTX_REG_MAIN_2CH_DEF                                0x08
#define HTX_FIELD_CSC_C3_MSB_DEF                            0x8
#define HTX_FIELD_CSC_C3_MSB_BIT_SIZE                       5

#define HTX_REG_MAIN_2DH_DEF                                0x12
#define HTX_FIELD_CSC_C3_DEF                                0x12
#define HTX_FIELD_CSC_C3_BIT_SIZE                           8

#define HTX_REG_MAIN_2EH_DEF                                0x1B
#define HTX_FIELD_CSC_C4_MSB_DEF                            0x1b
#define HTX_FIELD_CSC_C4_MSB_BIT_SIZE                       5

#define HTX_REG_MAIN_2FH_DEF                                0xAC
#define HTX_FIELD_CSC_C4_DEF                                0xac
#define HTX_FIELD_CSC_C4_BIT_SIZE                           8

#define HTX_REG_MAIN_30H_DEF                                0x00
#define HTX_FIELD_VFE_HS_PLA_MSB_DEF                        0x0
#define HTX_FIELD_VFE_HS_PLA_MSB_BIT_SIZE                   8

#define HTX_REG_MAIN_31H_DEF                                0x00
#define HTX_FIELD_VFE_HS_PLA_DEF                            0x0
#define HTX_FIELD_VFE_HS_PLA_BIT_SIZE                       2

#define HTX_FIELD_VFE_HS_DUR_MSB_DEF                        0x0
#define HTX_FIELD_VFE_HS_DUR_MSB_BIT_SIZE                   6

#define HTX_REG_MAIN_32H_DEF                                0x00
#define HTX_FIELD_VFE_HS_DUR_DEF                            0x0
#define HTX_FIELD_VFE_HS_DUR_BIT_SIZE                       4

#define HTX_FIELD_VFE_VS_PLA_MSB_DEF                        0x0
#define HTX_FIELD_VFE_VS_PLA_MSB_BIT_SIZE                   4

#define HTX_REG_MAIN_33H_DEF                                0x00
#define HTX_FIELD_VFE_VS_PLA_DEF                            0x0
#define HTX_FIELD_VFE_VS_PLA_BIT_SIZE                       6

#define HTX_FIELD_VFE_VS_DUR_MSB_DEF                        0x0
#define HTX_FIELD_VFE_VS_DUR_MSB_BIT_SIZE                   2

#define HTX_REG_MAIN_34H_DEF                                0x00
#define HTX_FIELD_VFE_VS_DUR_DEF                            0x0
#define HTX_FIELD_VFE_VS_DUR_BIT_SIZE                       8

#define HTX_REG_MAIN_35H_DEF                                0x00
#define HTX_FIELD_VFE_HSYNCDELAYIN_MSB_DEF                  0x0
#define HTX_FIELD_VFE_HSYNCDELAYIN_MSB_BIT_SIZE             8

#define HTX_REG_MAIN_36H_DEF                                0x00
#define HTX_FIELD_VFE_HSYNCDELAYIN_DEF                      0x0
#define HTX_FIELD_VFE_HSYNCDELAYIN_BIT_SIZE                 2

#define HTX_FIELD_VFE_VSYNCDELAYIN_DEF                      0x0
#define HTX_FIELD_VFE_VSYNCDELAYIN_BIT_SIZE                 6

#define HTX_REG_MAIN_37H_DEF                                0x00
#define HTX_FIELD_VFE_OFFSET_DEF                            0x0
#define HTX_FIELD_VFE_OFFSET_BIT_SIZE                       3

#define HTX_FIELD_VFE_WIDTH_MSB_DEF                         0x0
#define HTX_FIELD_VFE_WIDTH_MSB_BIT_SIZE                    5

#define HTX_REG_MAIN_38H_DEF                                0x00
#define HTX_FIELD_VFE_WIDTH_DEF                             0x0
#define HTX_FIELD_VFE_WIDTH_BIT_SIZE                        7

#define HTX_REG_MAIN_39H_DEF                                0x00
#define HTX_FIELD_VFE_HEIGHT_MSB_DEF                        0x0
#define HTX_FIELD_VFE_HEIGHT_MSB_BIT_SIZE                   8

#define HTX_REG_MAIN_3AH_DEF                                0x00
#define HTX_FIELD_VFE_HEIGHT_DEF                            0x0
#define HTX_FIELD_VFE_HEIGHT_BIT_SIZE                       4

#define HTX_REG_MAIN_3BH_DEF                                0x80
#define HTX_FIELD_NC_EXT_AUDIOSF_SEL_DEF                    0x1
#define HTX_FIELD_NC_EXT_AUDIOSF_SEL_BIT_SIZE               1

#define HTX_FIELD_PR_MODE_DEF                               0x0
#define HTX_FIELD_PR_MODE_BIT_SIZE                          2

#define HTX_FIELD_EXT_PLL_PR_DEF                            0x0
#define HTX_FIELD_EXT_PLL_PR_BIT_SIZE                       2

#define HTX_FIELD_EXT_TARGET_PR_DEF                         0x0
#define HTX_FIELD_EXT_TARGET_PR_BIT_SIZE                    2

#define HTX_FIELD_NC_CSC_EN_DEF                             0x0
#define HTX_FIELD_NC_CSC_EN_BIT_SIZE                        1

#define HTX_REG_MAIN_3CH_DEF                                0x00
#define HTX_FIELD_EXT_VID_TO_RX_DEF                         0x0
#define HTX_FIELD_EXT_VID_TO_RX_BIT_SIZE                    6

#define HTX_REG_MAIN_3DH_DEF                                0x00
#define HTX_FIELD_PR_TO_RX_DEF                              0x0
#define HTX_FIELD_PR_TO_RX_BIT_SIZE                         2

#define HTX_FIELD_VID_TO_RX_DEF                             0x0
#define HTX_FIELD_VID_TO_RX_BIT_SIZE                        6

#define HTX_REG_MAIN_3EH_DEF                                0x00
#define HTX_FIELD_VFE_FMT_VID_DEF                           0x0
#define HTX_FIELD_VFE_FMT_VID_BIT_SIZE                      6

#define HTX_REG_MAIN_3FH_DEF                                0x00
#define HTX_FIELD_VFE_AUX_VID_DEF                           0x0
#define HTX_FIELD_VFE_AUX_VID_BIT_SIZE                      3

#define HTX_FIELD_VFE_PROG_MODE_DEF                         0x0
#define HTX_FIELD_VFE_PROG_MODE_BIT_SIZE                    2

#define HTX_REG_MAIN_40H_DEF                                0x00
#define HTX_FIELD_GC_PKT_EN_DEF                             0x0
#define HTX_FIELD_GC_PKT_EN_BIT_SIZE                        1

#define HTX_FIELD_SPD_PKT_EN_DEF                            0x0
#define HTX_FIELD_SPD_PKT_EN_BIT_SIZE                       1

#define HTX_FIELD_MPEG_PKT_EN_DEF                           0x0
#define HTX_FIELD_MPEG_PKT_EN_BIT_SIZE                      1

#define HTX_FIELD_ACP_PKT_EN_DEF                            0x0
#define HTX_FIELD_ACP_PKT_EN_BIT_SIZE                       1

#define HTX_FIELD_ISRC_PKT_EN_DEF                           0x0
#define HTX_FIELD_ISRC_PKT_EN_BIT_SIZE                      1

#define HTX_FIELD_GM_PKT_EN_DEF                             0x0
#define HTX_FIELD_GM_PKT_EN_BIT_SIZE                        1

#define HTX_FIELD_SPARE_PKT1_EN_DEF                         0x0
#define HTX_FIELD_SPARE_PKT1_EN_BIT_SIZE                    1

#define HTX_FIELD_SPARE_PKT0_EN_DEF                         0x0
#define HTX_FIELD_SPARE_PKT0_EN_BIT_SIZE                    1

#define HTX_REG_MAIN_41H_DEF                                0x50
#define HTX_FIELD_SYSTEM_PD_DEF                             0x1
#define HTX_FIELD_SYSTEM_PD_BIT_SIZE                        1

#define HTX_FIELD_LOGIC_RESET_DEF                           0x0
#define HTX_FIELD_LOGIC_RESET_BIT_SIZE                      1

#define HTX_FIELD_INTR_POL_DEF                              0x1
#define HTX_FIELD_INTR_POL_BIT_SIZE                         1

#define HTX_FIELD_SYNC_GEN_EN_DEF                           0x0
#define HTX_FIELD_SYNC_GEN_EN_BIT_SIZE                      1

#define HTX_REG_MAIN_42H_DEF                                0x90
#define HTX_FIELD_PD_POL_DEF                                0x1
#define HTX_FIELD_PD_POL_BIT_SIZE                           1

#define HTX_FIELD_HPD_STATE_DEF                             0x0
#define HTX_FIELD_HPD_STATE_BIT_SIZE                        1

#define HTX_FIELD_MSEN_STATE_DEF                            0x0
#define HTX_FIELD_MSEN_STATE_BIT_SIZE                       1

#define HTX_FIELD_I2S_32BIT_MODE_DEF                        0x0
#define HTX_FIELD_I2S_32BIT_MODE_BIT_SIZE                   1

#define HTX_FIELD_AUDIOFIFO_TESTDONE_DEF                    0x0
#define HTX_FIELD_AUDIOFIFO_TESTDONE_BIT_SIZE               1

#define HTX_REG_MAIN_43H_DEF                                0x7E
#define HTX_FIELD_EDID_ID_DEF                               0x7e
#define HTX_FIELD_EDID_ID_BIT_SIZE                          8

#define HTX_REG_MAIN_44H_DEF                                0x79
#define HTX_FIELD_NC_SPDIF_EN_DEF                           0x0
#define HTX_FIELD_NC_SPDIF_EN_BIT_SIZE                      1

#define HTX_FIELD_N_CTS_PKT_EN_DEF                          0x1
#define HTX_FIELD_N_CTS_PKT_EN_BIT_SIZE                     1

#define HTX_FIELD_AUDIO_SAMPLE_PKT_EN_DEF                   0x1
#define HTX_FIELD_AUDIO_SAMPLE_PKT_EN_BIT_SIZE              1

#define HTX_FIELD_AVIIF_PKT_EN_DEF                          0x1
#define HTX_FIELD_AVIIF_PKT_EN_BIT_SIZE                     1

#define HTX_FIELD_AUDIOIF_PKT_EN_DEF                        0x1
#define HTX_FIELD_AUDIOIF_PKT_EN_BIT_SIZE                   1

#define HTX_FIELD_PKT_READ_MODE_DEF                         0x1
#define HTX_FIELD_PKT_READ_MODE_BIT_SIZE                    1

#define HTX_REG_MAIN_45H_DEF                                0x70
#define HTX_FIELD_UDP_ID_DEF                                0x70
#define HTX_FIELD_UDP_ID_BIT_SIZE                           8

#define HTX_REG_MAIN_47H_DEF                                0x00
#define HTX_FIELD_DSD_MUX_EN_DEF                            0x0
#define HTX_FIELD_DSD_MUX_EN_BIT_SIZE                       1

#define HTX_FIELD_PAPB_SYNC_DEF                             0x0
#define HTX_FIELD_PAPB_SYNC_BIT_SIZE                        1

#define HTX_FIELD_SAMPLE_INVALID_DEF                        0x0
#define HTX_FIELD_SAMPLE_INVALID_BIT_SIZE                   4

#define HTX_REG_MAIN_48H_DEF                                0x00
#define HTX_FIELD_LOW_FREQ_VIDEO_DEF                        0x0
#define HTX_FIELD_LOW_FREQ_VIDEO_BIT_SIZE                   1

#define HTX_FIELD_BIT_REVERSE_DEF                           0x0
#define HTX_FIELD_BIT_REVERSE_BIT_SIZE                      1

#define HTX_FIELD_DDR_MSB_DEF                               0x0
#define HTX_FIELD_DDR_MSB_BIT_SIZE                          1

#define HTX_FIELD_RE_MAP_24BIT_DEF                          0x0
#define HTX_FIELD_RE_MAP_24BIT_BIT_SIZE                     2

#define HTX_REG_MAIN_49H_DEF                                0xA8
#define HTX_FIELD_DITHER_MODE_DEF                           0x2a
#define HTX_FIELD_DITHER_MODE_BIT_SIZE                      6

#define HTX_REG_MAIN_4AH_DEF                                0x80
#define HTX_FIELD_AUTO_CHECKSUM_EN_DEF                      0x1
#define HTX_FIELD_AUTO_CHECKSUM_EN_BIT_SIZE                 1

#define HTX_FIELD_AVI_UPDATE_DEF                            0x0
#define HTX_FIELD_AVI_UPDATE_BIT_SIZE                       1

#define HTX_FIELD_AUDIO_UPDATE_DEF                          0x0
#define HTX_FIELD_AUDIO_UPDATE_BIT_SIZE                     1

#define HTX_FIELD_GCP_UPDATE_DEF                            0x0
#define HTX_FIELD_GCP_UPDATE_BIT_SIZE                       1

#define HTX_REG_MAIN_4BH_DEF                                0x00
#define HTX_FIELD_CLEAR_AVMUTE_DEF                          0x0
#define HTX_FIELD_CLEAR_AVMUTE_BIT_SIZE                     1

#define HTX_FIELD_SET_AVMUTE_DEF                            0x0
#define HTX_FIELD_SET_AVMUTE_BIT_SIZE                       1

#define HTX_REG_MAIN_4CH_DEF                                0x00
#define HTX_FIELD_GC_PP_DEF                                 0x0
#define HTX_FIELD_GC_PP_BIT_SIZE                            4

#define HTX_FIELD_GC_CD_DEF                                 0x0
#define HTX_FIELD_GC_CD_BIT_SIZE                            4

#define HTX_REG_MAIN_4DH_DEF                                0x00
#define HTX_FIELD_GC_BYTE2_DEF                              0x0
#define HTX_FIELD_GC_BYTE2_BIT_SIZE                         8

#define HTX_REG_MAIN_4EH_DEF                                0x00
#define HTX_FIELD_GC_BYTE3_DEF                              0x0
#define HTX_FIELD_GC_BYTE3_BIT_SIZE                         8

#define HTX_REG_MAIN_4FH_DEF                                0x00
#define HTX_FIELD_GC_BYTE4_DEF                              0x0
#define HTX_FIELD_GC_BYTE4_BIT_SIZE                         8

#define HTX_REG_MAIN_50H_DEF                                0x00
#define HTX_FIELD_GC_BYTE5_DEF                              0x0
#define HTX_FIELD_GC_BYTE5_BIT_SIZE                         8

#define HTX_REG_MAIN_51H_DEF                                0x00
#define HTX_FIELD_GC_BYTE6_DEF                              0x0
#define HTX_FIELD_GC_BYTE6_BIT_SIZE                         8

#define HTX_REG_MAIN_52H_DEF                                0x02
#define HTX_FIELD_AVI_VERSION_DEF                           0x2
#define HTX_FIELD_AVI_VERSION_BIT_SIZE                      3

#define HTX_REG_MAIN_53H_DEF                                0x0D
#define HTX_FIELD_AVI_LENGTH_DEF                            0xd
#define HTX_FIELD_AVI_LENGTH_BIT_SIZE                       5

#define HTX_REG_MAIN_54H_DEF                                0x00
#define HTX_FIELD_AVI_CHECKSUM_DEF                          0x0
#define HTX_FIELD_AVI_CHECKSUM_BIT_SIZE                     8

#define HTX_REG_MAIN_56H_DEF                                0x00
#define HTX_FIELD_R3210_DEF                                 0x0
#define HTX_FIELD_R3210_BIT_SIZE                            4

#define HTX_REG_MAIN_57H_DEF                                0x00
#define HTX_FIELD_ITC_DEF                                   0x0
#define HTX_FIELD_ITC_BIT_SIZE                              1

#define HTX_FIELD_EC210_DEF                                 0x0
#define HTX_FIELD_EC210_BIT_SIZE                            3

#define HTX_FIELD_Q1Q0_DEF                                  0x0
#define HTX_FIELD_Q1Q0_BIT_SIZE                             2

#define HTX_FIELD_SC_DEF                                    0x0
#define HTX_FIELD_SC_BIT_SIZE                               2

#define HTX_REG_MAIN_58H_DEF                                0x00
#define HTX_FIELD_AVI_BYTE4_7_DEF                           0x0
#define HTX_FIELD_AVI_BYTE4_7_BIT_SIZE                      1

#define HTX_REG_MAIN_59H_DEF                                0x00
#define HTX_FIELD_AVI_BYTE5_7_4_DEF                         0x0
#define HTX_FIELD_AVI_BYTE5_7_4_BIT_SIZE                    4

#define HTX_REG_MAIN_5AH_DEF                                0x00
#define HTX_FIELD_AVI_BYTE6_DEF                             0x0
#define HTX_FIELD_AVI_BYTE6_BIT_SIZE                        8

#define HTX_REG_MAIN_5BH_DEF                                0x00
#define HTX_FIELD_AVI_BYTE7_DEF                             0x0
#define HTX_FIELD_AVI_BYTE7_BIT_SIZE                        8

#define HTX_REG_MAIN_5CH_DEF                                0x00
#define HTX_FIELD_AVI_BYTE8_DEF                             0x0
#define HTX_FIELD_AVI_BYTE8_BIT_SIZE                        8

#define HTX_REG_MAIN_5DH_DEF                                0x00
#define HTX_FIELD_AVI_BYTE9_DEF                             0x0
#define HTX_FIELD_AVI_BYTE9_BIT_SIZE                        8

#define HTX_REG_MAIN_5EH_DEF                                0x00
#define HTX_FIELD_AVI_BYTE10_DEF                            0x0
#define HTX_FIELD_AVI_BYTE10_BIT_SIZE                       8

#define HTX_REG_MAIN_5FH_DEF                                0x00
#define HTX_FIELD_AVI_BYTE11_DEF                            0x0
#define HTX_FIELD_AVI_BYTE11_BIT_SIZE                       8

#define HTX_REG_MAIN_60H_DEF                                0x00
#define HTX_FIELD_AVI_BYTE12_DEF                            0x0
#define HTX_FIELD_AVI_BYTE12_BIT_SIZE                       8

#define HTX_REG_MAIN_61H_DEF                                0x00
#define HTX_FIELD_AVI_BYTE13_DEF                            0x0
#define HTX_FIELD_AVI_BYTE13_BIT_SIZE                       8

#define HTX_REG_MAIN_62H_DEF                                0x00
#define HTX_FIELD_AVI_BYTE14_DEF                            0x0
#define HTX_FIELD_AVI_BYTE14_BIT_SIZE                       8

#define HTX_REG_MAIN_63H_DEF                                0x00
#define HTX_FIELD_AVI_BYTE15_DEF                            0x0
#define HTX_FIELD_AVI_BYTE15_BIT_SIZE                       8

#define HTX_REG_MAIN_64H_DEF                                0x00
#define HTX_FIELD_AVI_BYTE16_DEF                            0x0
#define HTX_FIELD_AVI_BYTE16_BIT_SIZE                       8

#define HTX_REG_MAIN_65H_DEF                                0x00
#define HTX_FIELD_AVI_BYTE17_DEF                            0x0
#define HTX_FIELD_AVI_BYTE17_BIT_SIZE                       8

#define HTX_REG_MAIN_66H_DEF                                0x00
#define HTX_FIELD_AVI_BYTE18_DEF                            0x0
#define HTX_FIELD_AVI_BYTE18_BIT_SIZE                       8

#define HTX_REG_MAIN_67H_DEF                                0x00
#define HTX_FIELD_AVI_BYTE19_DEF                            0x0
#define HTX_FIELD_AVI_BYTE19_BIT_SIZE                       8

#define HTX_REG_MAIN_68H_DEF                                0x00
#define HTX_FIELD_AVI_BYTE20_DEF                            0x0
#define HTX_FIELD_AVI_BYTE20_BIT_SIZE                       8

#define HTX_REG_MAIN_69H_DEF                                0x00
#define HTX_FIELD_AVI_BYTE21_DEF                            0x0
#define HTX_FIELD_AVI_BYTE21_BIT_SIZE                       8

#define HTX_REG_MAIN_6AH_DEF                                0x00
#define HTX_FIELD_AVI_BYTE22_DEF                            0x0
#define HTX_FIELD_AVI_BYTE22_BIT_SIZE                       8

#define HTX_REG_MAIN_6BH_DEF                                0x00
#define HTX_FIELD_AVI_BYTE23_DEF                            0x0
#define HTX_FIELD_AVI_BYTE23_BIT_SIZE                       8

#define HTX_REG_MAIN_6CH_DEF                                0x00
#define HTX_FIELD_AVI_BYTE24_DEF                            0x0
#define HTX_FIELD_AVI_BYTE24_BIT_SIZE                       8

#define HTX_REG_MAIN_6DH_DEF                                0x00
#define HTX_FIELD_AVI_BYTE25_DEF                            0x0
#define HTX_FIELD_AVI_BYTE25_BIT_SIZE                       8

#define HTX_REG_MAIN_6EH_DEF                                0x00
#define HTX_FIELD_AVI_BYTE26_DEF                            0x0
#define HTX_FIELD_AVI_BYTE26_BIT_SIZE                       8

#define HTX_REG_MAIN_6FH_DEF                                0x00
#define HTX_FIELD_AVI_BYTE27_DEF                            0x0
#define HTX_FIELD_AVI_BYTE27_BIT_SIZE                       8

#define HTX_REG_MAIN_70H_DEF                                0x01
#define HTX_FIELD_AUDIOIF_VERSION_DEF                       0x1
#define HTX_FIELD_AUDIOIF_VERSION_BIT_SIZE                  3

#define HTX_REG_MAIN_71H_DEF                                0x0A
#define HTX_FIELD_AUDIOIF_LENGTH_DEF                        0xa
#define HTX_FIELD_AUDIOIF_LENGTH_BIT_SIZE                   5

#define HTX_REG_MAIN_72H_DEF                                0x00
#define HTX_FIELD_AUDIOIF_CHECKSUM_DEF                      0x0
#define HTX_FIELD_AUDIOIF_CHECKSUM_BIT_SIZE                 8

#define HTX_REG_MAIN_73H_DEF                                0x00
#define HTX_FIELD_AUDIOIF_CT_DEF                            0x0
#define HTX_FIELD_AUDIOIF_CT_BIT_SIZE                       4

#define HTX_FIELD_AUDIOIF_BYTE1_3_DEF                       0x0
#define HTX_FIELD_AUDIOIF_BYTE1_3_BIT_SIZE                  1

#define HTX_FIELD_AUDIOIF_CC_DEF                            0x0
#define HTX_FIELD_AUDIOIF_CC_BIT_SIZE                       3

#define HTX_REG_MAIN_74H_DEF                                0x00
#define HTX_FIELD_AUDIOIF_BYTE2_7_5_DEF                     0x0
#define HTX_FIELD_AUDIOIF_BYTE2_7_5_BIT_SIZE                3

#define HTX_FIELD_AUDIOIF_SF_DEF                            0x0
#define HTX_FIELD_AUDIOIF_SF_BIT_SIZE                       3

#define HTX_FIELD_AUDIOIF_SS_DEF                            0x0
#define HTX_FIELD_AUDIOIF_SS_BIT_SIZE                       2

#define HTX_REG_MAIN_75H_DEF                                0x00
#define HTX_FIELD_AUDIOIF_BYTE3_DEF                         0x0
#define HTX_FIELD_AUDIOIF_BYTE3_BIT_SIZE                    8

#define HTX_REG_MAIN_76H_DEF                                0x00
#define HTX_FIELD_AUDIOIF_CA_DEF                            0x0
#define HTX_FIELD_AUDIOIF_CA_BIT_SIZE                       8

#define HTX_REG_MAIN_77H_DEF                                0x00
#define HTX_FIELD_AUDIOIF_DM_INH_DEF                        0x0
#define HTX_FIELD_AUDIOIF_DM_INH_BIT_SIZE                   1

#define HTX_FIELD_AUDIOIF_LSV_DEF                           0x0
#define HTX_FIELD_AUDIOIF_LSV_BIT_SIZE                      4

#define HTX_FIELD_AUDIOIF_BYTE5_2_0_DEF                     0x0
#define HTX_FIELD_AUDIOIF_BYTE5_2_0_BIT_SIZE                3

#define HTX_REG_MAIN_78H_DEF                                0x00
#define HTX_FIELD_AUDIOIF_BYTE6_DEF                         0x0
#define HTX_FIELD_AUDIOIF_BYTE6_BIT_SIZE                    8

#define HTX_REG_MAIN_79H_DEF                                0x00
#define HTX_FIELD_AUDIOIF_BYTE7_DEF                         0x0
#define HTX_FIELD_AUDIOIF_BYTE7_BIT_SIZE                    8

#define HTX_REG_MAIN_7AH_DEF                                0x00
#define HTX_FIELD_AUDIOIF_BYTE8_DEF                         0x0
#define HTX_FIELD_AUDIOIF_BYTE8_BIT_SIZE                    8

#define HTX_REG_MAIN_7BH_DEF                                0x00
#define HTX_FIELD_AUDIOIF_BYTE9_DEF                         0x0
#define HTX_FIELD_AUDIOIF_BYTE9_BIT_SIZE                    8

#define HTX_REG_MAIN_7CH_DEF                                0x00
#define HTX_FIELD_AUDIOIF_BYTE10_DEF                        0x0
#define HTX_FIELD_AUDIOIF_BYTE10_BIT_SIZE                   8

#define HTX_REG_MAIN_92H_DEF                                0x00
#define HTX_FIELD_CEC_CMD_INTR_MASK_DEF                     0x0
#define HTX_FIELD_CEC_CMD_INTR_MASK_BIT_SIZE                8

#define HTX_REG_MAIN_93H_DEF                                0x00
#define HTX_FIELD_CEC_CMD_INTR_DEF                          0x0
#define HTX_FIELD_CEC_CMD_INTR_BIT_SIZE                     8

#define HTX_REG_MAIN_94H_DEF                                0xC0
#define HTX_FIELD_HPD_INTR_MASK_DEF                         0x1
#define HTX_FIELD_HPD_INTR_MASK_BIT_SIZE                    1

#define HTX_FIELD_MSEN_INTR_MASK_DEF                        0x1
#define HTX_FIELD_MSEN_INTR_MASK_BIT_SIZE                   1

#define HTX_FIELD_VS_INTR_MASK_DEF                          0x0
#define HTX_FIELD_VS_INTR_MASK_BIT_SIZE                     1

#define HTX_FIELD_AUDIOFIFO_FULL_INTR_MASK_DEF              0x0
#define HTX_FIELD_AUDIOFIFO_FULL_INTR_MASK_BIT_SIZE         1

#define HTX_FIELD_ITU656_ERROR_INTR_MASK_DEF                0x0
#define HTX_FIELD_ITU656_ERROR_INTR_MASK_BIT_SIZE           1

#define HTX_FIELD_EDID_RDY_INTR_MASK_DEF                    0x0
#define HTX_FIELD_EDID_RDY_INTR_MASK_BIT_SIZE               1

#define HTX_FIELD_RI_RDY_INTR_MASK_DEF                      0x0
#define HTX_FIELD_RI_RDY_INTR_MASK_BIT_SIZE                 1

#define HTX_REG_MAIN_95H_DEF                                0x00
#define HTX_FIELD_HDCP_ERROR_INTR_MASK_DEF                  0x0
#define HTX_FIELD_HDCP_ERROR_INTR_MASK_BIT_SIZE             1

#define HTX_FIELD_BKSV_FLAG_MASK_DEF                        0x0
#define HTX_FIELD_BKSV_FLAG_MASK_BIT_SIZE                   1

#define HTX_FIELD_TX_READY_INTR_MASK_DEF                    0x0
#define HTX_FIELD_TX_READY_INTR_MASK_BIT_SIZE               1

#define HTX_FIELD_TX_ARBITRATION_LOST_INTR_MASK_DEF         0x0
#define HTX_FIELD_TX_ARBITRATION_LOST_INTR_MASK_BIT_SIZE    1

#define HTX_FIELD_TX_RETRY_TIMEOUT_INTR_MASK_DEF            0x0
#define HTX_FIELD_TX_RETRY_TIMEOUT_INTR_MASK_BIT_SIZE       1

#define HTX_FIELD_RX_READY_INTR_MASK_DEF                    0x0
#define HTX_FIELD_RX_READY_INTR_MASK_BIT_SIZE               3

#define HTX_REG_MAIN_96H_DEF                                0x00
#define HTX_FIELD_HPD_INTR_DEF                              0x0
#define HTX_FIELD_HPD_INTR_BIT_SIZE                         1

#define HTX_FIELD_MSEN_INTR_DEF                             0x0
#define HTX_FIELD_MSEN_INTR_BIT_SIZE                        1

#define HTX_FIELD_VS_INTR_DEF                               0x0
#define HTX_FIELD_VS_INTR_BIT_SIZE                          1

#define HTX_FIELD_AUDIOFIFO_FULL_INTR_DEF                   0x0
#define HTX_FIELD_AUDIOFIFO_FULL_INTR_BIT_SIZE              1

#define HTX_FIELD_ITU656_ERROR_INTR_DEF                     0x0
#define HTX_FIELD_ITU656_ERROR_INTR_BIT_SIZE                1

#define HTX_FIELD_EDID_RDY_INTR_DEF                         0x0
#define HTX_FIELD_EDID_RDY_INTR_BIT_SIZE                    1

#define HTX_FIELD_RI_RDY_INTR_DEF                           0x0
#define HTX_FIELD_RI_RDY_INTR_BIT_SIZE                      1

#define HTX_FIELD_PJ_RDY_INTR_DEF                           0x0
#define HTX_FIELD_PJ_RDY_INTR_BIT_SIZE                      1

#define HTX_REG_MAIN_97H_DEF                                0x00
#define HTX_FIELD_HDCP_ERROR_INTR_DEF                       0x0
#define HTX_FIELD_HDCP_ERROR_INTR_BIT_SIZE                  1

#define HTX_FIELD_BKSV_FLAG_DEF                             0x0
#define HTX_FIELD_BKSV_FLAG_BIT_SIZE                        1

#define HTX_FIELD_TX_READY_INTR_DEF                         0x0
#define HTX_FIELD_TX_READY_INTR_BIT_SIZE                    1

#define HTX_FIELD_TX_ARBITRATION_LOST_INTR_DEF              0x0
#define HTX_FIELD_TX_ARBITRATION_LOST_INTR_BIT_SIZE         1

#define HTX_FIELD_TX_RETRY_TIMEOUT_INTR_DEF                 0x0
#define HTX_FIELD_TX_RETRY_TIMEOUT_INTR_BIT_SIZE            1

#define HTX_FIELD_RX_READY_INTR_DEF                         0x0
#define HTX_FIELD_RX_READY_INTR_BIT_SIZE                    3

#define HTX_REG_MAIN_9AH_DEF                                0x00
#define HTX_FIELD_LOCK_FILT_EN_DEF                          0x0
#define HTX_FIELD_LOCK_FILT_EN_BIT_SIZE                     1

#define HTX_REG_MAIN_9DH_DEF                                0x60
#define HTX_FIELD_ANALOG_OPEN1_DEF                          0x0
#define HTX_FIELD_ANALOG_OPEN1_BIT_SIZE                     2

#define HTX_REG_MAIN_9EH_DEF                                0x00
#define HTX_FIELD_PLLLOCKED_DEF                             0x0
#define HTX_FIELD_PLLLOCKED_BIT_SIZE                        1

#define HTX_REG_MAIN_A1H_DEF                                0x00
#define HTX_FIELD_TERMPWRDWNI2C_DEF                         0x0
#define HTX_FIELD_TERMPWRDWNI2C_BIT_SIZE                    1

#define HTX_FIELD_CH0PWRDWNI2C_DEF                          0x0
#define HTX_FIELD_CH0PWRDWNI2C_BIT_SIZE                     1

#define HTX_FIELD_CH1PWRDWNI2C_DEF                          0x0
#define HTX_FIELD_CH1PWRDWNI2C_BIT_SIZE                     1

#define HTX_FIELD_CH2PWRDWNI2C_DEF                          0x0
#define HTX_FIELD_CH2PWRDWNI2C_BIT_SIZE                     1

#define HTX_FIELD_CLKDRVPWRDWNI2C_DEF                       0x0
#define HTX_FIELD_CLKDRVPWRDWNI2C_BIT_SIZE                  1

#define HTX_REG_MAIN_A2H_DEF                                0x80
#define HTX_FIELD_TXOUTPUTLVL_DEF                           0x10
#define HTX_FIELD_TXOUTPUTLVL_BIT_SIZE                      5

#define HTX_REG_MAIN_A4H_DEF                                0x08
#define HTX_FIELD_LBKLOGICRESETI2C_DEF                      0x0
#define HTX_FIELD_LBKLOGICRESETI2C_BIT_SIZE                 1

#define HTX_REG_MAIN_AFH_DEF                                0x14
#define HTX_FIELD_HDCP_DESIRED_DEF                          0x0
#define HTX_FIELD_HDCP_DESIRED_BIT_SIZE                     1

#define HTX_FIELD_FRAME_ENC_DEF                             0x1
#define HTX_FIELD_FRAME_ENC_BIT_SIZE                        1

#define HTX_FIELD_EXT_HDMI_MODE_DEF                         0x0
#define HTX_FIELD_EXT_HDMI_MODE_BIT_SIZE                    1

#define HTX_REG_MAIN_B0H_DEF                                0x00
#define HTX_FIELD_AN_0_DEF                                  0x0
#define HTX_FIELD_AN_0_BIT_SIZE                             8

#define HTX_REG_MAIN_B1H_DEF                                0x00
#define HTX_FIELD_AN_1_DEF                                  0x0
#define HTX_FIELD_AN_1_BIT_SIZE                             8

#define HTX_REG_MAIN_B2H_DEF                                0x00
#define HTX_FIELD_AN_2_DEF                                  0x0
#define HTX_FIELD_AN_2_BIT_SIZE                             8

#define HTX_REG_MAIN_B3H_DEF                                0x00
#define HTX_FIELD_AN_3_DEF                                  0x0
#define HTX_FIELD_AN_3_BIT_SIZE                             8

#define HTX_REG_MAIN_B4H_DEF                                0x00
#define HTX_FIELD_AN_4_DEF                                  0x0
#define HTX_FIELD_AN_4_BIT_SIZE                             8

#define HTX_REG_MAIN_B5H_DEF                                0x00
#define HTX_FIELD_AN_5_DEF                                  0x0
#define HTX_FIELD_AN_5_BIT_SIZE                             8

#define HTX_REG_MAIN_B6H_DEF                                0x00
#define HTX_FIELD_AN_6_DEF                                  0x0
#define HTX_FIELD_AN_6_BIT_SIZE                             8

#define HTX_REG_MAIN_B7H_DEF                                0x00
#define HTX_FIELD_AN_7_DEF                                  0x0
#define HTX_FIELD_AN_7_BIT_SIZE                             8

#define HTX_REG_MAIN_B8H_DEF                                0x00
#define HTX_FIELD_ENC_ON_DEF                                0x0
#define HTX_FIELD_ENC_ON_BIT_SIZE                           1

#define HTX_FIELD_KEYS_READ_ERROR_DEF                       0x0
#define HTX_FIELD_KEYS_READ_ERROR_BIT_SIZE                  1

#define HTX_REG_MAIN_BAH_DEF                                0x10
#define HTX_FIELD_CLK_DELAY_DEF                             0x0
#define HTX_FIELD_CLK_DELAY_BIT_SIZE                        3

#define HTX_FIELD_INT_EPP_ON_DEF                            0x1
#define HTX_FIELD_INT_EPP_ON_BIT_SIZE                       1

#define HTX_FIELD_EPP_CONFIG_DEF                            0x0
#define HTX_FIELD_EPP_CONFIG_BIT_SIZE                       1

#define HTX_REG_MAIN_BEH_DEF                                0x00
#define HTX_FIELD_BCAPS_DEF                                 0x0
#define HTX_FIELD_BCAPS_BIT_SIZE                            8

#define HTX_REG_MAIN_BFH_DEF                                0x00
#define HTX_FIELD_BKSV_4_DEF                                0x0
#define HTX_FIELD_BKSV_4_BIT_SIZE                           8

#define HTX_REG_MAIN_C0H_DEF                                0x00
#define HTX_FIELD_BKSV_3_DEF                                0x0
#define HTX_FIELD_BKSV_3_BIT_SIZE                           8

#define HTX_REG_MAIN_C1H_DEF                                0x00
#define HTX_FIELD_BKSV_2_DEF                                0x0
#define HTX_FIELD_BKSV_2_BIT_SIZE                           8

#define HTX_REG_MAIN_C2H_DEF                                0x00
#define HTX_FIELD_BKSV_1_DEF                                0x0
#define HTX_FIELD_BKSV_1_BIT_SIZE                           8

#define HTX_REG_MAIN_C3H_DEF                                0x00
#define HTX_FIELD_BKSV_0_DEF                                0x0
#define HTX_FIELD_BKSV_0_BIT_SIZE                           8

#define HTX_REG_MAIN_C4H_DEF                                0x00
#define HTX_FIELD_EDID_SEGMENT_DEF                          0x0
#define HTX_FIELD_EDID_SEGMENT_BIT_SIZE                     8

#define HTX_REG_MAIN_C7H_DEF                                0x00
#define HTX_FIELD_BKSV_COUNT_DEF                            0x0
#define HTX_FIELD_BKSV_COUNT_BIT_SIZE                       7

#define HTX_REG_MAIN_C8H_DEF                                0x00
#define HTX_FIELD_HDCP_CONTROLLER_ERROR_DEF                 0x0
#define HTX_FIELD_HDCP_CONTROLLER_ERROR_BIT_SIZE            4

#define HTX_FIELD_HDCP_CONTROLLER_STATE_DEF                 0x0
#define HTX_FIELD_HDCP_CONTROLLER_STATE_BIT_SIZE            4

#define HTX_REG_MAIN_C9H_DEF                                0x03
#define HTX_FIELD_EDID_READ_EN_DEF                          0x0
#define HTX_FIELD_EDID_READ_EN_BIT_SIZE                     1

#define HTX_FIELD_EDID_TRYS_DEF                             0x3
#define HTX_FIELD_EDID_TRYS_BIT_SIZE                        4

#define HTX_REG_MAIN_CAH_DEF                                0x00
#define HTX_FIELD_HDCP_BSTATUS_MSB_DEF                      0x0
#define HTX_FIELD_HDCP_BSTATUS_MSB_BIT_SIZE                 8

#define HTX_REG_MAIN_CBH_DEF                                0x00
#define HTX_FIELD_HDCP_BSTATUS_LSB_DEF                      0x0
#define HTX_FIELD_HDCP_BSTATUS_LSB_BIT_SIZE                 8

#define HTX_REG_MAIN_CDH_DEF                                0x00
#define HTX_FIELD_GEN444_CLK_EN_DEF                         0x0
#define HTX_FIELD_GEN444_CLK_EN_BIT_SIZE                    1

#define HTX_FIELD_CSC_CLK_EN_DEF                            0x0
#define HTX_FIELD_CSC_CLK_EN_BIT_SIZE                       1

#define HTX_FIELD_ISLAND_CLK_EN_DEF                         0x0
#define HTX_FIELD_ISLAND_CLK_EN_BIT_SIZE                    1

#define HTX_FIELD_TERC_CLK_EN_DEF                           0x0
#define HTX_FIELD_TERC_CLK_EN_BIT_SIZE                      1

#define HTX_REG_MAIN_CEH_DEF                                0x01
#define HTX_FIELD_PRESCALE_MSB_DEF                          0x1
#define HTX_FIELD_PRESCALE_MSB_BIT_SIZE                     8

#define HTX_REG_MAIN_CFH_DEF                                0x04
#define HTX_FIELD_PRESCALE_LSB_DEF                          0x4
#define HTX_FIELD_PRESCALE_LSB_BIT_SIZE                     8

#define HTX_REG_MAIN_D0H_DEF                                0x30
#define HTX_FIELD_DDR_CLK_SEL_DEF                           0x0
#define HTX_FIELD_DDR_CLK_SEL_BIT_SIZE                      1

#define HTX_FIELD_DELAY_DDR_DEF                             0x3
#define HTX_FIELD_DELAY_DDR_BIT_SIZE                        3

#define HTX_FIELD_SYNC_PULSE_SEL_DEF                        0x0
#define HTX_FIELD_SYNC_PULSE_SEL_BIT_SIZE                   2

#define HTX_FIELD_TIMING_GEN_SEQ_DEF                        0x0
#define HTX_FIELD_TIMING_GEN_SEQ_BIT_SIZE                   1

#define HTX_REG_MAIN_D5H_DEF                                0x00
#define HTX_FIELD_STEP_TURNONI2C_DEF                        0x0
#define HTX_FIELD_STEP_TURNONI2C_BIT_SIZE                   1

#define HTX_FIELD_HIGH_VSYNC_DEF                            0x0
#define HTX_FIELD_HIGH_VSYNC_BIT_SIZE                       2

#define HTX_FIELD_VIDEO_OFFSET_CTL_DEF                      0x0
#define HTX_FIELD_VIDEO_OFFSET_CTL_BIT_SIZE                 2

#define HTX_REG_MAIN_D6H_DEF                                0x00
#define HTX_FIELD_NEW_ANALOG_OPEN0_DEF                      0x0
#define HTX_FIELD_NEW_ANALOG_OPEN0_BIT_SIZE                 8

#define HTX_REG_MAIN_D7H_DEF                                0x00
#define HTX_REG_MAIN_D8H_DEF                                0x00
#define HTX_FIELD_SA_HS_PLA_DEF                             0x0
#define HTX_FIELD_SA_HS_PLA_BIT_SIZE                        10

#define HTX_REG_MAIN_D9H_DEF                                0x00
#define HTX_FIELD_SA_HS_DUR_DEF                             0x0
#define HTX_FIELD_SA_HS_DUR_BIT_SIZE                        10

#define HTX_REG_MAIN_DAH_DEF                                0x00
#define HTX_FIELD_SA_VS_PLA_DEF                             0x0
#define HTX_FIELD_SA_VS_PLA_BIT_SIZE                        10

#define HTX_REG_MAIN_DBH_DEF                                0x00
#define HTX_FIELD_SA_VS_DUR_DEF                             0x0
#define HTX_FIELD_SA_VS_DUR_BIT_SIZE                        10

#define HTX_REG_MAIN_DCH_DEF                                0x00
#define HTX_FIELD_SA_OFFSET_DEF                             0x0
#define HTX_FIELD_SA_OFFSET_BIT_SIZE                        3

#define HTX_REG_MAIN_DDH_DEF                                0x00
#define HTX_FIELD_SA_VS_WINDOW_DEF                          0x0
#define HTX_FIELD_SA_VS_WINDOW_BIT_SIZE                     9

#define HTX_REG_MAIN_DEH_DEF                                0x10
#define HTX_FIELD_TMDS_DRIVER_TEST0_DEF                     0x10
#define HTX_FIELD_TMDS_DRIVER_TEST0_BIT_SIZE                8

#define HTX_REG_MAIN_DFH_DEF                                0x01
#define HTX_FIELD_TMDS_DRIVER_TEST1_DEF                     0x1
#define HTX_FIELD_TMDS_DRIVER_TEST1_BIT_SIZE                8

#define HTX_REG_MAIN_E0H_DEF                                0x80
#define HTX_FIELD_TMDS_DRIVER_TEST2_DEF                     0x80
#define HTX_FIELD_TMDS_DRIVER_TEST2_BIT_SIZE                8

#define HTX_REG_MAIN_E1H_DEF                                0x78
#define HTX_FIELD_CEC_ID_DEF                                0x78
#define HTX_FIELD_CEC_ID_BIT_SIZE                           8

#define HTX_REG_MAIN_E2H_DEF                                0x00
#define HTX_FIELD_CEC_PD_DEF                                0x0
#define HTX_FIELD_CEC_PD_BIT_SIZE                           1

#define HTX_REG_MAIN_F5H_DEF                                0x75
#define HTX_FIELD_CHIPID_HIGH_BYTE_DEF                      0x75
#define HTX_FIELD_CHIPID_HIGH_BYTE_BIT_SIZE                 8

#define HTX_REG_MAIN_F6H_DEF                                0x11
#define HTX_FIELD_CHIPID_LOW_BYTE_DEF                       0x11
#define HTX_FIELD_CHIPID_LOW_BYTE_BIT_SIZE                  8

#define HTX_REG_MAIN_F7H_DEF                                0x00
#define HTX_FIELD_CHIPID_POSTFIX_DEF                        0x0
#define HTX_FIELD_CHIPID_POSTFIX_BIT_SIZE                   4

#define HTX_FIELD_BONDING_OPTIONS_DEF                       0x0
#define HTX_FIELD_BONDING_OPTIONS_BIT_SIZE                  4

#define HTX_REG_MAIN_F9H_DEF                                0x7C
#define HTX_FIELD_TEST_ID_DEF                               0x7c
#define HTX_FIELD_TEST_ID_BIT_SIZE                          8

#define HTX_REG_MAIN_FAH_DEF                                0x00
#define HTX_FIELD_ES_HS_PLA_MSB_DEF                         0x0
#define HTX_FIELD_ES_HS_PLA_MSB_BIT_SIZE                    3

#define HTX_FIELD_SA_HS_PLA_MSB_DEF                         0x0
#define HTX_FIELD_SA_HS_PLA_MSB_BIT_SIZE                    3

#define HTX_FIELD_SA_VS_WINDOW_MSB_DEF                      0x0
#define HTX_FIELD_SA_VS_WINDOW_MSB_BIT_SIZE                 2

#define HTX_REG_MAIN_FBH_DEF                                0x00
#define HTX_FIELD_DE_HSYNCDELAYIN_MSB_DEF                   0x0
#define HTX_FIELD_DE_HSYNCDELAYIN_MSB_BIT_SIZE              1

#define HTX_FIELD_DE_VSYNCDELAYIN_MSB_DEF                   0x0
#define HTX_FIELD_DE_VSYNCDELAYIN_MSB_BIT_SIZE              2

#define HTX_FIELD_DE_WIDTH_MSB_DEF                          0x0
#define HTX_FIELD_DE_WIDTH_MSB_BIT_SIZE                     1

#define HTX_FIELD_DE_HEIGHT_MSB_DEF                         0x0
#define HTX_FIELD_DE_HEIGHT_MSB_BIT_SIZE                    1

#define HTX_FIELD_LOWER_VSYNC_DEF                           0x0
#define HTX_FIELD_LOWER_VSYNC_BIT_SIZE                      2

#define HTX_REG_MAIN_FCH_DEF                                0x00
#define HTX_FIELD_RI_FREQ_SEL_DEF                           0x0
#define HTX_FIELD_RI_FREQ_SEL_BIT_SIZE                      2

#define HTX_FIELD_RI_DELAY_SEL_DEF                          0x0
#define HTX_FIELD_RI_DELAY_SEL_BIT_SIZE                     3

#define HTX_FIELD_BCAPS_DELAY_DEF                           0x0
#define HTX_FIELD_BCAPS_DELAY_BIT_SIZE                      3

#define HTX_REG_MAIN_FDH_DEF                                0x00
#define HTX_FIELD_AN_DELAY_DEF                              0x0
#define HTX_FIELD_AN_DELAY_BIT_SIZE                         3

#define HTX_FIELD_AKSV_DELAY_DEF                            0x0
#define HTX_FIELD_AKSV_DELAY_BIT_SIZE                       3

#define HTX_REG_MAIN_FEH_DEF                                0x00
#define HTX_FIELD_HDCP_START_DELAY_DEF                      0x0
#define HTX_FIELD_HDCP_START_DELAY_BIT_SIZE                 3

#endif
