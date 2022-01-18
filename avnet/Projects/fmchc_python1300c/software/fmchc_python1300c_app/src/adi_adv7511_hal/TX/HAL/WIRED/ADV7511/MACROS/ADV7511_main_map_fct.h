/**********************************************************************************************
*																						      *
* Copyright (c) 2008 - 2012 Analog Devices, Inc.  All Rights Reserved.                        *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/
/*******************************************************************************
*                                                                              *

* This software is intended for use with the ADV7510 part only.                *
*                                                                              *
*******************************************************************************/

/*******************************************************************************
*                                                                              *
* FILE AUTOMATICALLY GENERATED.                                                *
* DATE: 30 May 2009 0:23:2                                                     *
*                                                                              *
*******************************************************************************/


#ifndef ADV7511_MAIN_MAP_FCT_H
#define ADV7511_MAIN_MAP_FCT_H

#include "ADV7511_cfg.h"

#define HTX_get_CHIP_REVISION(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x00, 0xFF, 0, pval)
#define HTX_ret_CHIP_REVISION()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x00, 0xFF, 0)

#define HTX_get_N(pval)                                     ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x01, 0xF, 0xFF, 0, 3, pval)
#define HTX_ret_N()                                         ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x01, 0xF, 0xFF, 0, 3)
#define HTX_set_N(val)                                      ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x01, 0xF, 0xFF, 0, 3, val)

#define HTX_get_SPDIF_SF(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x04, 0xF0, 4, pval)
#define HTX_ret_SPDIF_SF()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x04, 0xF0, 4)

#define HTX_get_INT_CTS(pval)                               ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x04, 0xF, 0xFF, 0, 3, pval)
#define HTX_ret_INT_CTS()                                   ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x04, 0xF, 0xFF, 0, 3)

#define HTX_get_EXTERNAL_CTS(pval)                          ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x07, 0xF, 0xFF, 0, 3, pval)
#define HTX_ret_EXTERNAL_CTS()                              ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x07, 0xF, 0xFF, 0, 3)
#define HTX_set_EXTERNAL_CTS(val)                           ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x07, 0xF, 0xFF, 0, 3, val)

#define HTX_is_CTS_SEL_true()                               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x0A, 0x80, 0x7)
#define HTX_get_CTS_SEL(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0A, 0x80, 0x7, pval)
#define HTX_ret_CTS_SEL()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0A, 0x80, 0x7)
#define HTX_set_CTS_SEL(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0A, 0x80, 0x7, val)

#define HTX_get_AUDIO_INPUT_SELECTION(pval)                 ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0A, 0x70, 4, pval)
#define HTX_ret_AUDIO_INPUT_SELECTION()                     ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0A, 0x70, 4)
#define HTX_set_AUDIO_INPUT_SELECTION(val)                  ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0A, 0x70, 4, val)

#define HTX_get_AUDIO_MODE(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0A, 0xC, 2, pval)
#define HTX_ret_AUDIO_MODE()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0A, 0xC, 2)
#define HTX_set_AUDIO_MODE(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0A, 0xC, 2, val)

#define HTX_get_MCLK_RATIO(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0A, 0x3, 0, pval)
#define HTX_ret_MCLK_RATIO()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0A, 0x3, 0)
#define HTX_set_MCLK_RATIO(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0A, 0x3, 0, val)

#define HTX_is_SPDIF_EN_true()                              ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x80, 0x7)
#define HTX_get_SPDIF_EN(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x80, 0x7, pval)
#define HTX_ret_SPDIF_EN()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x80, 0x7)
#define HTX_set_SPDIF_EN(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x80, 0x7, val)

#define HTX_is_MCLK_POL_true()                              ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x40, 0x6)
#define HTX_get_MCLK_POL(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x40, 0x6, pval)
#define HTX_ret_MCLK_POL()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x40, 0x6)
#define HTX_set_MCLK_POL(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x40, 0x6, val)

#define HTX_is_MCLK_EN_true()                               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x20, 0x5)
#define HTX_get_MCLK_EN(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x20, 0x5, pval)
#define HTX_ret_MCLK_EN()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x20, 0x5)
#define HTX_set_MCLK_EN(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x20, 0x5, val)

#define HTX_get_DELTA(pval)                                 ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x18, 3, pval)
#define HTX_ret_DELTA()                                     ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x18, 3)
#define HTX_set_DELTA(val)                                  ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x18, 3, val)

#define HTX_get_P_RANGE(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x6, 1, pval)
#define HTX_ret_P_RANGE()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x6, 1)
#define HTX_set_P_RANGE(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0B, 0x6, 1, val)

#define HTX_is_EXT_AUDIOSF_SEL_true()                       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x80, 0x7)
#define HTX_get_EXT_AUDIOSF_SEL(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x80, 0x7, pval)
#define HTX_ret_EXT_AUDIOSF_SEL()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x80, 0x7)
#define HTX_set_EXT_AUDIOSF_SEL(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x80, 0x7, val)

#define HTX_is_CS_BIT_OVERRIDE_true()                       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x40, 0x6)
#define HTX_get_CS_BIT_OVERRIDE(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x40, 0x6, pval)
#define HTX_ret_CS_BIT_OVERRIDE()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x40, 0x6)
#define HTX_set_CS_BIT_OVERRIDE(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x40, 0x6, val)

#define HTX_is_I2S2_ENABLE_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x10, 0x4)
#define HTX_get_I2S2_ENABLE(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x10, 0x4, pval)
#define HTX_ret_I2S2_ENABLE()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x10, 0x4)
#define HTX_set_I2S2_ENABLE(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x10, 0x4, val)

#define HTX_is_I2S1_ENABLE_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x8, 0x3)
#define HTX_get_I2S1_ENABLE(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x8, 0x3, pval)
#define HTX_ret_I2S1_ENABLE()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x8, 0x3)
#define HTX_set_I2S1_ENABLE(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x8, 0x3, val)

#define HTX_is_I2S0_ENABLE_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x4, 0x2)
#define HTX_get_I2S0_ENABLE(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x4, 0x2, pval)
#define HTX_ret_I2S0_ENABLE()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x4, 0x2)
#define HTX_set_I2S0_ENABLE(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x4, 0x2, val)

#define HTX_get_I2S_FORMAT(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x3, 0, pval)
#define HTX_ret_I2S_FORMAT()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x3, 0)
#define HTX_set_I2S_FORMAT(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0C, 0x3, 0, val)

#define HTX_get_I2S_BIT_WIDTH(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0D, 0x1F, 0, pval)
#define HTX_ret_I2S_BIT_WIDTH()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0D, 0x1F, 0)
#define HTX_set_I2S_BIT_WIDTH(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0D, 0x1F, 0, val)

#define HTX_get_SUBPKT0_L_SRC(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0E, 0x38, 3, pval)
#define HTX_ret_SUBPKT0_L_SRC()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0E, 0x38, 3)
#define HTX_set_SUBPKT0_L_SRC(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0E, 0x38, 3, val)

#define HTX_get_SUBPKT0_R_SRC(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0E, 0x7, 0, pval)
#define HTX_ret_SUBPKT0_R_SRC()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0E, 0x7, 0)
#define HTX_set_SUBPKT0_R_SRC(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0E, 0x7, 0, val)

#define HTX_get_SUBPKT1_L_SRC(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0F, 0x38, 3, pval)
#define HTX_ret_SUBPKT1_L_SRC()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0F, 0x38, 3)
#define HTX_set_SUBPKT1_L_SRC(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0F, 0x38, 3, val)

#define HTX_get_SUBPKT1_R_SRC(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x0F, 0x7, 0, pval)
#define HTX_ret_SUBPKT1_R_SRC()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x0F, 0x7, 0)
#define HTX_set_SUBPKT1_R_SRC(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x0F, 0x7, 0, val)

#define HTX_get_SUBPKT2_L_SRC(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x10, 0x38, 3, pval)
#define HTX_ret_SUBPKT2_L_SRC()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x10, 0x38, 3)
#define HTX_set_SUBPKT2_L_SRC(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x10, 0x38, 3, val)

#define HTX_get_SUBPKT2_R_SRC(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x10, 0x7, 0, pval)
#define HTX_ret_SUBPKT2_R_SRC()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x10, 0x7, 0)
#define HTX_set_SUBPKT2_R_SRC(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x10, 0x7, 0, val)

#define HTX_get_SUBPKT3_L_SRC(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x11, 0x38, 3, pval)
#define HTX_ret_SUBPKT3_L_SRC()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x11, 0x38, 3)
#define HTX_set_SUBPKT3_L_SRC(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x11, 0x38, 3, val)

#define HTX_get_SUBPKT3_R_SRC(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x11, 0x7, 0, pval)
#define HTX_ret_SUBPKT3_R_SRC()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x11, 0x7, 0)
#define HTX_set_SUBPKT3_R_SRC(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x11, 0x7, 0, val)

#define HTX_get_CHANNEL_STATUS(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x12, 0xC0, 6, pval)
#define HTX_ret_CHANNEL_STATUS()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x12, 0xC0, 6)
#define HTX_set_CHANNEL_STATUS(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x12, 0xC0, 6, val)

#define HTX_is_CR_BIT_true()                                ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x12, 0x20, 0x5)
#define HTX_get_CR_BIT(pval)                                ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x12, 0x20, 0x5, pval)
#define HTX_ret_CR_BIT()                                    ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x12, 0x20, 0x5)
#define HTX_set_CR_BIT(val)                                 ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x12, 0x20, 0x5, val)

#define HTX_get_A_INFO(pval)                                ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x12, 0x1C, 2, pval)
#define HTX_ret_A_INFO()                                    ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x12, 0x1C, 2)
#define HTX_set_A_INFO(val)                                 ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x12, 0x1C, 2, val)

#define HTX_get_CLK_ACC(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x12, 0x3, 0, pval)
#define HTX_ret_CLK_ACC()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x12, 0x3, 0)
#define HTX_set_CLK_ACC(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x12, 0x3, 0, val)

#define HTX_get_CATEGORY_CODE(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x13, 0xFF, 0, pval)
#define HTX_ret_CATEGORY_CODE()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x13, 0xFF, 0)
#define HTX_set_CATEGORY_CODE(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x13, 0xFF, 0, val)

#define HTX_get_SOURCE_NUMBER(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x14, 0xF0, 4, pval)
#define HTX_ret_SOURCE_NUMBER()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x14, 0xF0, 4)
#define HTX_set_SOURCE_NUMBER(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x14, 0xF0, 4, val)

#define HTX_get_WORD_LENGTH(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x14, 0xF, 0, pval)
#define HTX_ret_WORD_LENGTH()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x14, 0xF, 0)
#define HTX_set_WORD_LENGTH(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x14, 0xF, 0, val)

#define HTX_get_I2S_SF(pval)                                ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x15, 0xF0, 4, pval)
#define HTX_ret_I2S_SF()                                    ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x15, 0xF0, 4)
#define HTX_set_I2S_SF(val)                                 ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x15, 0xF0, 4, val)

#define HTX_get_VFE_INPUT_ID(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x15, 0xF, 0, pval)
#define HTX_ret_VFE_INPUT_ID()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x15, 0xF, 0)
#define HTX_set_VFE_INPUT_ID(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x15, 0xF, 0, val)

#define HTX_get_VFE_OUT_FMT(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x16, 0xC0, 6, pval)
#define HTX_ret_VFE_OUT_FMT()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x16, 0xC0, 6)
#define HTX_set_VFE_OUT_FMT(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x16, 0xC0, 6, val)

#define HTX_get_422_WIDTH(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x16, 0x30, 4, pval)
#define HTX_ret_422_WIDTH()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x16, 0x30, 4)
#define HTX_set_422_WIDTH(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x16, 0x30, 4, val)

#define HTX_get_VFE_INPUT_STYLE(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x16, 0xC, 2, pval)
#define HTX_ret_VFE_INPUT_STYLE()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x16, 0xC, 2)
#define HTX_set_VFE_INPUT_STYLE(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x16, 0xC, 2, val)

#define HTX_is_VFE_INPUT_EDGE_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x16, 0x2, 0x1)
#define HTX_get_VFE_INPUT_EDGE(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x16, 0x2, 0x1, pval)
#define HTX_ret_VFE_INPUT_EDGE()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x16, 0x2, 0x1)
#define HTX_set_VFE_INPUT_EDGE(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x16, 0x2, 0x1, val)

#define HTX_is_VFE_INPUT_CS_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x16, 0x1, 0x0)
#define HTX_get_VFE_INPUT_CS(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x16, 0x1, 0x0, pval)
#define HTX_ret_VFE_INPUT_CS()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x16, 0x1, 0x0)
#define HTX_set_VFE_INPUT_CS(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x16, 0x1, 0x0, val)

#define HTX_is_ITU_ERROR_CORRECT_EN_true()                  ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x17, 0x80, 0x7)
#define HTX_get_ITU_ERROR_CORRECT_EN(pval)                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x17, 0x80, 0x7, pval)
#define HTX_ret_ITU_ERROR_CORRECT_EN()                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x17, 0x80, 0x7)
#define HTX_set_ITU_ERROR_CORRECT_EN(val)                   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x17, 0x80, 0x7, val)

#define HTX_is_ITU_VSYNC_POL_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x17, 0x40, 0x6)
#define HTX_get_ITU_VSYNC_POL(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x17, 0x40, 0x6, pval)
#define HTX_ret_ITU_VSYNC_POL()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x17, 0x40, 0x6)
#define HTX_set_ITU_VSYNC_POL(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x17, 0x40, 0x6, val)

#define HTX_is_ITU_HSYNC_POL_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x17, 0x20, 0x5)
#define HTX_get_ITU_HSYNC_POL(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x17, 0x20, 0x5, pval)
#define HTX_ret_ITU_HSYNC_POL()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x17, 0x20, 0x5)
#define HTX_set_ITU_HSYNC_POL(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x17, 0x20, 0x5, val)

#define HTX_is_INTERPOLATION_STYLE_true()                   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x17, 0x4, 0x2)
#define HTX_get_INTERPOLATION_STYLE(pval)                   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x17, 0x4, 0x2, pval)
#define HTX_ret_INTERPOLATION_STYLE()                       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x17, 0x4, 0x2)
#define HTX_set_INTERPOLATION_STYLE(val)                    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x17, 0x4, 0x2, val)

#define HTX_is_ASPECT_RATIO_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x17, 0x2, 0x1)
#define HTX_get_ASPECT_RATIO(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x17, 0x2, 0x1, pval)
#define HTX_ret_ASPECT_RATIO()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x17, 0x2, 0x1)
#define HTX_set_ASPECT_RATIO(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x17, 0x2, 0x1, val)

#define HTX_is_GEN_444_EN_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x17, 0x1, 0x0)
#define HTX_get_GEN_444_EN(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x17, 0x1, 0x0, pval)
#define HTX_ret_GEN_444_EN()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x17, 0x1, 0x0)
#define HTX_set_GEN_444_EN(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x17, 0x1, 0x0, val)

#define HTX_is_CSC_EN_true()                                ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x18, 0x80, 0x7)
#define HTX_get_CSC_EN(pval)                                ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x18, 0x80, 0x7, pval)
#define HTX_ret_CSC_EN()                                    ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x18, 0x80, 0x7)
#define HTX_set_CSC_EN(val)                                 ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x18, 0x80, 0x7, val)

#define HTX_get_CSC_MODE(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x18, 0x60, 5, pval)
#define HTX_ret_CSC_MODE()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x18, 0x60, 5)
#define HTX_set_CSC_MODE(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x18, 0x60, 5, val)

#define HTX_get_CSC_A1(pval)                                ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x18, 0x1F, 0xFF, 0, 2, pval)
#define HTX_ret_CSC_A1()                                    ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x18, 0x1F, 0xFF, 0, 2)
#define HTX_set_CSC_A1(val)                                 ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x18, 0x1F, 0xFF, 0, 2, val)

#define HTX_is_COEFFI_UPDATE_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x1A, 0x20, 0x5)
#define HTX_get_COEFFI_UPDATE(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x1A, 0x20, 0x5, pval)
#define HTX_ret_COEFFI_UPDATE()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x1A, 0x20, 0x5)
#define HTX_set_COEFFI_UPDATE(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x1A, 0x20, 0x5, val)

#define HTX_get_CSC_A2(pval)                                ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x1A, 0x1F, 0xFF, 0, 2, pval)
#define HTX_ret_CSC_A2()                                    ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x1A, 0x1F, 0xFF, 0, 2)
#define HTX_set_CSC_A2(val)                                 ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x1A, 0x1F, 0xFF, 0, 2, val)

#define HTX_get_CSC_A3(pval)                                ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x1C, 0x1F, 0xFF, 0, 2, pval)
#define HTX_ret_CSC_A3()                                    ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x1C, 0x1F, 0xFF, 0, 2)
#define HTX_set_CSC_A3(val)                                 ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x1C, 0x1F, 0xFF, 0, 2, val)

#define HTX_get_CSC_A4(pval)                                ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x1E, 0x1F, 0xFF, 0, 2, pval)
#define HTX_ret_CSC_A4()                                    ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x1E, 0x1F, 0xFF, 0, 2)
#define HTX_set_CSC_A4(val)                                 ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x1E, 0x1F, 0xFF, 0, 2, val)

#define HTX_get_CSC_B1(pval)                                ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x20, 0x1F, 0xFF, 0, 2, pval)
#define HTX_ret_CSC_B1()                                    ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x20, 0x1F, 0xFF, 0, 2)
#define HTX_set_CSC_B1(val)                                 ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x20, 0x1F, 0xFF, 0, 2, val)

#define HTX_get_CSC_B2(pval)                                ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x22, 0x1F, 0xFF, 0, 2, pval)
#define HTX_ret_CSC_B2()                                    ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x22, 0x1F, 0xFF, 0, 2)
#define HTX_set_CSC_B2(val)                                 ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x22, 0x1F, 0xFF, 0, 2, val)

#define HTX_get_CSC_B3(pval)                                ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x24, 0x1F, 0xFF, 0, 2, pval)
#define HTX_ret_CSC_B3()                                    ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x24, 0x1F, 0xFF, 0, 2)
#define HTX_set_CSC_B3(val)                                 ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x24, 0x1F, 0xFF, 0, 2, val)

#define HTX_get_CSC_B4(pval)                                ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x26, 0x1F, 0xFF, 0, 2, pval)
#define HTX_ret_CSC_B4()                                    ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x26, 0x1F, 0xFF, 0, 2)
#define HTX_set_CSC_B4(val)                                 ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x26, 0x1F, 0xFF, 0, 2, val)

#define HTX_get_CSC_C1(pval)                                ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x28, 0x1F, 0xFF, 0, 2, pval)
#define HTX_ret_CSC_C1()                                    ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x28, 0x1F, 0xFF, 0, 2)
#define HTX_set_CSC_C1(val)                                 ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x28, 0x1F, 0xFF, 0, 2, val)

#define HTX_get_CSC_C2(pval)                                ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x2A, 0x1F, 0xFF, 0, 2, pval)
#define HTX_ret_CSC_C2()                                    ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x2A, 0x1F, 0xFF, 0, 2)
#define HTX_set_CSC_C2(val)                                 ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x2A, 0x1F, 0xFF, 0, 2, val)

#define HTX_get_CSC_C3(pval)                                ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x2C, 0x1F, 0xFF, 0, 2, pval)
#define HTX_ret_CSC_C3()                                    ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x2C, 0x1F, 0xFF, 0, 2)
#define HTX_set_CSC_C3(val)                                 ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x2C, 0x1F, 0xFF, 0, 2, val)

#define HTX_get_CSC_C4(pval)                                ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x2E, 0x1F, 0xFF, 0, 2, pval)
#define HTX_ret_CSC_C4()                                    ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x2E, 0x1F, 0xFF, 0, 2)
#define HTX_set_CSC_C4(val)                                 ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x2E, 0x1F, 0xFF, 0, 2, val)

#define HTX_get_VFE_HS_PLA(pval)                            ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x30, 0xFF, 0xC0, 6, 2, pval)
#define HTX_ret_VFE_HS_PLA()                                ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x30, 0xFF, 0xC0, 6, 2)
#define HTX_set_VFE_HS_PLA(val)                             ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x30, 0xFF, 0xC0, 6, 2, val)

#define HTX_get_VFE_HS_DUR(pval)                            ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x31, 0x3F, 0xF0, 4, 2, pval)
#define HTX_ret_VFE_HS_DUR()                                ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x31, 0x3F, 0xF0, 4, 2)
#define HTX_set_VFE_HS_DUR(val)                             ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x31, 0x3F, 0xF0, 4, 2, val)

#define HTX_get_VFE_VS_PLA(pval)                            ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x32, 0xF, 0xFC, 2, 2, pval)
#define HTX_ret_VFE_VS_PLA()                                ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x32, 0xF, 0xFC, 2, 2)
#define HTX_set_VFE_VS_PLA(val)                             ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x32, 0xF, 0xFC, 2, 2, val)

#define HTX_get_VFE_VS_DUR(pval)                            ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x33, 0x3, 0xFF, 0, 2, pval)
#define HTX_ret_VFE_VS_DUR()                                ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x33, 0x3, 0xFF, 0, 2)
#define HTX_set_VFE_VS_DUR(val)                             ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x33, 0x3, 0xFF, 0, 2, val)

#define HTX_get_VFE_HSYNCDELAYIN(pval)                      ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x35, 0xFF, 0xC0, 6, 2, pval)
#define HTX_ret_VFE_HSYNCDELAYIN()                          ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x35, 0xFF, 0xC0, 6, 2)
#define HTX_set_VFE_HSYNCDELAYIN(val)                       ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x35, 0xFF, 0xC0, 6, 2, val)

#define HTX_get_VFE_VSYNCDELAYIN(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x36, 0x3F, 0, pval)
#define HTX_ret_VFE_VSYNCDELAYIN()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x36, 0x3F, 0)
#define HTX_set_VFE_VSYNCDELAYIN(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x36, 0x3F, 0, val)

#define HTX_get_VFE_OFFSET(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x37, 0xE0, 5, pval)
#define HTX_ret_VFE_OFFSET()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x37, 0xE0, 5)
#define HTX_set_VFE_OFFSET(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x37, 0xE0, 5, val)

#define HTX_get_VFE_WIDTH(pval)                             ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x37, 0x1F, 0xFE, 1, 2, pval)
#define HTX_ret_VFE_WIDTH()                                 ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x37, 0x1F, 0xFE, 1, 2)
#define HTX_set_VFE_WIDTH(val)                              ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x37, 0x1F, 0xFE, 1, 2, val)

#define HTX_get_VFE_HEIGHT(pval)                            ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x39, 0xFF, 0xF0, 4, 2, pval)
#define HTX_ret_VFE_HEIGHT()                                ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x39, 0xFF, 0xF0, 4, 2)
#define HTX_set_VFE_HEIGHT(val)                             ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x39, 0xFF, 0xF0, 4, 2, val)

#define HTX_get_PR_MODE(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x3B, 0x60, 5, pval)
#define HTX_ret_PR_MODE()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x3B, 0x60, 5)
#define HTX_set_PR_MODE(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x3B, 0x60, 5, val)

#define HTX_get_EXT_PLL_PR(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x3B, 0x18, 3, pval)
#define HTX_ret_EXT_PLL_PR()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x3B, 0x18, 3)
#define HTX_set_EXT_PLL_PR(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x3B, 0x18, 3, val)

#define HTX_get_EXT_TARGET_PR(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x3B, 0x6, 1, pval)
#define HTX_ret_EXT_TARGET_PR()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x3B, 0x6, 1)
#define HTX_set_EXT_TARGET_PR(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x3B, 0x6, 1, val)

#define HTX_get_EXT_VID_TO_RX(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x3C, 0x3F, 0, pval)
#define HTX_ret_EXT_VID_TO_RX()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x3C, 0x3F, 0)
#define HTX_set_EXT_VID_TO_RX(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x3C, 0x3F, 0, val)

#define HTX_get_PR_TO_RX(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x3D, 0xC0, 6, pval)
#define HTX_ret_PR_TO_RX()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x3D, 0xC0, 6)

#define HTX_get_VID_TO_RX(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x3D, 0x3F, 0, pval)
#define HTX_ret_VID_TO_RX()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x3D, 0x3F, 0)

#define HTX_get_VFE_FMT_VID(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x3E, 0xFC, 2, pval)
#define HTX_ret_VFE_FMT_VID()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x3E, 0xFC, 2)

#define HTX_get_VFE_AUX_VID(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x3F, 0xE0, 5, pval)
#define HTX_ret_VFE_AUX_VID()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x3F, 0xE0, 5)

#define HTX_get_VFE_PROG_MODE(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x3F, 0x18, 3, pval)
#define HTX_ret_VFE_PROG_MODE()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x3F, 0x18, 3)

#define HTX_is_GC_PKT_EN_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x40, 0x80, 0x7)
#define HTX_get_GC_PKT_EN(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x40, 0x80, 0x7, pval)
#define HTX_ret_GC_PKT_EN()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x40, 0x80, 0x7)
#define HTX_set_GC_PKT_EN(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x40, 0x80, 0x7, val)

#define HTX_is_SPD_PKT_EN_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x40, 0x40, 0x6)
#define HTX_get_SPD_PKT_EN(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x40, 0x40, 0x6, pval)
#define HTX_ret_SPD_PKT_EN()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x40, 0x40, 0x6)
#define HTX_set_SPD_PKT_EN(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x40, 0x40, 0x6, val)

#define HTX_is_MPEG_PKT_EN_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x40, 0x20, 0x5)
#define HTX_get_MPEG_PKT_EN(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x40, 0x20, 0x5, pval)
#define HTX_ret_MPEG_PKT_EN()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x40, 0x20, 0x5)
#define HTX_set_MPEG_PKT_EN(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x40, 0x20, 0x5, val)

#define HTX_is_ACP_PKT_EN_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x40, 0x10, 0x4)
#define HTX_get_ACP_PKT_EN(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x40, 0x10, 0x4, pval)
#define HTX_ret_ACP_PKT_EN()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x40, 0x10, 0x4)
#define HTX_set_ACP_PKT_EN(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x40, 0x10, 0x4, val)

#define HTX_is_ISRC_PKT_EN_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x40, 0x8, 0x3)
#define HTX_get_ISRC_PKT_EN(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x40, 0x8, 0x3, pval)
#define HTX_ret_ISRC_PKT_EN()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x40, 0x8, 0x3)
#define HTX_set_ISRC_PKT_EN(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x40, 0x8, 0x3, val)

#define HTX_is_GM_PKT_EN_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x40, 0x4, 0x2)
#define HTX_get_GM_PKT_EN(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x40, 0x4, 0x2, pval)
#define HTX_ret_GM_PKT_EN()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x40, 0x4, 0x2)
#define HTX_set_GM_PKT_EN(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x40, 0x4, 0x2, val)

#define HTX_is_SPARE_PKT1_EN_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x40, 0x2, 0x1)
#define HTX_get_SPARE_PKT1_EN(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x40, 0x2, 0x1, pval)
#define HTX_ret_SPARE_PKT1_EN()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x40, 0x2, 0x1)
#define HTX_set_SPARE_PKT1_EN(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x40, 0x2, 0x1, val)

#define HTX_is_SPARE_PKT0_EN_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x40, 0x1, 0x0)
#define HTX_get_SPARE_PKT0_EN(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x40, 0x1, 0x0, pval)
#define HTX_ret_SPARE_PKT0_EN()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x40, 0x1, 0x0)
#define HTX_set_SPARE_PKT0_EN(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x40, 0x1, 0x0, val)

#define HTX_is_SYSTEM_PD_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x41, 0x40, 0x6)
#define HTX_get_SYSTEM_PD(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x41, 0x40, 0x6, pval)
#define HTX_ret_SYSTEM_PD()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x41, 0x40, 0x6)
#define HTX_set_SYSTEM_PD(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x41, 0x40, 0x6, val)

#define HTX_is_LOGIC_RESET_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x41, 0x20, 0x5)
#define HTX_get_LOGIC_RESET(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x41, 0x20, 0x5, pval)
#define HTX_ret_LOGIC_RESET()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x41, 0x20, 0x5)
#define HTX_set_LOGIC_RESET(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x41, 0x20, 0x5, val)

#define HTX_is_INTR_POL_true()                              ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x41, 0x10, 0x4)
#define HTX_get_INTR_POL(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x41, 0x10, 0x4, pval)
#define HTX_ret_INTR_POL()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x41, 0x10, 0x4)
#define HTX_set_INTR_POL(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x41, 0x10, 0x4, val)

#define HTX_is_INITIATE_SCAN_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x41, 0x8, 0x3)
#define HTX_get_INITIATE_SCAN(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x41, 0x8, 0x3, pval)
#define HTX_ret_INITIATE_SCAN()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x41, 0x8, 0x3)
#define HTX_set_INITIATE_SCAN(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x41, 0x8, 0x3, val)

#define HTX_is_AUDIOFIFO_TESTEN_true()                      ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x41, 0x4, 0x2)
#define HTX_get_AUDIOFIFO_TESTEN(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x41, 0x4, 0x2, pval)
#define HTX_ret_AUDIOFIFO_TESTEN()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x41, 0x4, 0x2)
#define HTX_set_AUDIOFIFO_TESTEN(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x41, 0x4, 0x2, val)

#define HTX_is_SYNC_GEN_EN_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x41, 0x2, 0x1)
#define HTX_get_SYNC_GEN_EN(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x41, 0x2, 0x1, pval)
#define HTX_ret_SYNC_GEN_EN()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x41, 0x2, 0x1)
#define HTX_set_SYNC_GEN_EN(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x41, 0x2, 0x1, val)

#define HTX_is_FPGA_EN_true()                               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x41, 0x1, 0x0)
#define HTX_get_FPGA_EN(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x41, 0x1, 0x0, pval)
#define HTX_ret_FPGA_EN()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x41, 0x1, 0x0)
#define HTX_set_FPGA_EN(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x41, 0x1, 0x0, val)

#define HTX_is_PD_POL_true()                                ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x42, 0x80, 0x7)
#define HTX_get_PD_POL(pval)                                ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x42, 0x80, 0x7, pval)
#define HTX_ret_PD_POL()                                    ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x42, 0x80, 0x7)

#define HTX_is_HPD_STATE_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x42, 0x40, 0x6)
#define HTX_get_HPD_STATE(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x42, 0x40, 0x6, pval)
#define HTX_ret_HPD_STATE()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x42, 0x40, 0x6)

#define HTX_is_MSEN_STATE_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x42, 0x20, 0x5)
#define HTX_get_MSEN_STATE(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x42, 0x20, 0x5, pval)
#define HTX_ret_MSEN_STATE()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x42, 0x20, 0x5)

#define HTX_is_AUDIOFIFO_TESTERROR_true()                   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x42, 0x10, 0x4)
#define HTX_get_AUDIOFIFO_TESTERROR(pval)                   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x42, 0x10, 0x4, pval)
#define HTX_ret_AUDIOFIFO_TESTERROR()                       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x42, 0x10, 0x4)

#define HTX_is_I2S_32BIT_MODE_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x42, 0x8, 0x3)
#define HTX_get_I2S_32BIT_MODE(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x42, 0x8, 0x3, pval)
#define HTX_ret_I2S_32BIT_MODE()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x42, 0x8, 0x3)

#define HTX_get_EDID_ID(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x43, 0xFF, 0, pval)
#define HTX_ret_EDID_ID()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x43, 0xFF, 0)
#define HTX_set_EDID_ID(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x43, 0xFF, 0, val)

#define HTX_is_N_CTS_PKT_EN_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x44, 0x40, 0x6)
#define HTX_get_N_CTS_PKT_EN(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x44, 0x40, 0x6, pval)
#define HTX_ret_N_CTS_PKT_EN()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x44, 0x40, 0x6)
#define HTX_set_N_CTS_PKT_EN(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x44, 0x40, 0x6, val)

#define HTX_is_AUDIO_SAMPLE_PKT_EN_true()                   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x44, 0x20, 0x5)
#define HTX_get_AUDIO_SAMPLE_PKT_EN(pval)                   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x44, 0x20, 0x5, pval)
#define HTX_ret_AUDIO_SAMPLE_PKT_EN()                       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x44, 0x20, 0x5)
#define HTX_set_AUDIO_SAMPLE_PKT_EN(val)                    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x44, 0x20, 0x5, val)

#define HTX_is_AVIIF_PKT_EN_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x44, 0x10, 0x4)
#define HTX_get_AVIIF_PKT_EN(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x44, 0x10, 0x4, pval)
#define HTX_ret_AVIIF_PKT_EN()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x44, 0x10, 0x4)
#define HTX_set_AVIIF_PKT_EN(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x44, 0x10, 0x4, val)

#define HTX_is_AUDIOIF_PKT_EN_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x44, 0x8, 0x3)
#define HTX_get_AUDIOIF_PKT_EN(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x44, 0x8, 0x3, pval)
#define HTX_ret_AUDIOIF_PKT_EN()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x44, 0x8, 0x3)
#define HTX_set_AUDIOIF_PKT_EN(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x44, 0x8, 0x3, val)

#define HTX_is_IO_RING_FILT_EN_true()                       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x44, 0x4, 0x2)
#define HTX_get_IO_RING_FILT_EN(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x44, 0x4, 0x2, pval)
#define HTX_ret_IO_RING_FILT_EN()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x44, 0x4, 0x2)
#define HTX_set_IO_RING_FILT_EN(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x44, 0x4, 0x2, val)

#define HTX_is_MAIN_OPEN_2_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x44, 0x2, 0x1)
#define HTX_get_MAIN_OPEN_2(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x44, 0x2, 0x1, pval)
#define HTX_ret_MAIN_OPEN_2()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x44, 0x2, 0x1)
#define HTX_set_MAIN_OPEN_2(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x44, 0x2, 0x1, val)

#define HTX_is_PKT_READ_MODE_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x44, 0x1, 0x0)
#define HTX_get_PKT_READ_MODE(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x44, 0x1, 0x0, pval)
#define HTX_ret_PKT_READ_MODE()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x44, 0x1, 0x0)
#define HTX_set_PKT_READ_MODE(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x44, 0x1, 0x0, val)

#define HTX_get_UDP_ID(pval)                                ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x45, 0xFF, 0, pval)
#define HTX_ret_UDP_ID()                                    ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x45, 0xFF, 0)
#define HTX_set_UDP_ID(val)                                 ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x45, 0xFF, 0, val)

#define HTX_get_DSD_EN(pval)                                ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x46, 0xFF, 0, pval)
#define HTX_ret_DSD_EN()                                    ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x46, 0xFF, 0)
#define HTX_set_DSD_EN(val)                                 ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x46, 0xFF, 0, val)

#define HTX_is_DSD_MUX_EN_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x47, 0x80, 0x7)
#define HTX_get_DSD_MUX_EN(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x47, 0x80, 0x7, pval)
#define HTX_ret_DSD_MUX_EN()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x47, 0x80, 0x7)
#define HTX_set_DSD_MUX_EN(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x47, 0x80, 0x7, val)

#define HTX_is_PAPB_SYNC_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x47, 0x40, 0x6)
#define HTX_get_PAPB_SYNC(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x47, 0x40, 0x6, pval)
#define HTX_ret_PAPB_SYNC()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x47, 0x40, 0x6)
#define HTX_set_PAPB_SYNC(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x47, 0x40, 0x6, val)

#define HTX_get_SAMPLE_INVALID_EXPANDED(pval)               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x47, 0x3C, 2, pval)
#define HTX_ret_SAMPLE_INVALID_EXPANDED()                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x47, 0x3C, 2)
#define HTX_set_SAMPLE_INVALID_EXPANDED(val)                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x47, 0x3C, 2, val)

#define HTX_is_BIT_REVERSE_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x48, 0x40, 0x6)
#define HTX_get_BIT_REVERSE(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x48, 0x40, 0x6, pval)
#define HTX_ret_BIT_REVERSE()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x48, 0x40, 0x6)
#define HTX_set_BIT_REVERSE(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x48, 0x40, 0x6, val)

#define HTX_is_DDR_MSB_true()                               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x48, 0x20, 0x5)
#define HTX_get_DDR_MSB(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x48, 0x20, 0x5, pval)
#define HTX_ret_DDR_MSB()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x48, 0x20, 0x5)
#define HTX_set_DDR_MSB(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x48, 0x20, 0x5, val)

#define HTX_get_RE_MAP_24BIT(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x48, 0x18, 3, pval)
#define HTX_ret_RE_MAP_24BIT()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x48, 0x18, 3)
#define HTX_set_RE_MAP_24BIT(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x48, 0x18, 3, val)

#define HTX_get_BIT_TRIMMING_MODE(pval)                     ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x49, 0xFC, 2, pval)
#define HTX_ret_BIT_TRIMMING_MODE()                         ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x49, 0xFC, 2)

#define HTX_is_AUTO_CHECKSUM_EN_true()                      ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x80, 0x7)
#define HTX_get_AUTO_CHECKSUM_EN(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x80, 0x7, pval)
#define HTX_ret_AUTO_CHECKSUM_EN()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x80, 0x7)
#define HTX_set_AUTO_CHECKSUM_EN(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x80, 0x7, val)

#define HTX_is_AVI_UPDATE_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x40, 0x6)
#define HTX_get_AVI_UPDATE(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x40, 0x6, pval)
#define HTX_ret_AVI_UPDATE()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x40, 0x6)
#define HTX_set_AVI_UPDATE(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x40, 0x6, val)

#define HTX_is_AUDIO_UPDATE_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x20, 0x5)
#define HTX_get_AUDIO_UPDATE(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x20, 0x5, pval)
#define HTX_ret_AUDIO_UPDATE()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x20, 0x5)
#define HTX_set_AUDIO_UPDATE(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x20, 0x5, val)

#define HTX_is_GCP_UPDATE_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x10, 0x4)
#define HTX_get_GCP_UPDATE(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x10, 0x4, pval)
#define HTX_ret_GCP_UPDATE()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x10, 0x4)
#define HTX_set_GCP_UPDATE(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x4A, 0x10, 0x4, val)


#define HTX_is_CLEAR_AVMUTE_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x4B, 0x80, 0x7)
#define HTX_get_CLEAR_AVMUTE(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x4B, 0x80, 0x7, pval)
#define HTX_ret_CLEAR_AVMUTE()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x4B, 0x80, 0x7)
#define HTX_set_CLEAR_AVMUTE(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x4B, 0x80, 0x7, val)

#define HTX_is_SET_AVMUTE_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x4B, 0x40, 0x6)
#define HTX_get_SET_AVMUTE(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x4B, 0x40, 0x6, pval)
#define HTX_ret_SET_AVMUTE()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x4B, 0x40, 0x6)
#define HTX_set_SET_AVMUTE(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x4B, 0x40, 0x6, val)

#define HTX_get_GG_PP(pval)                                 ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x4C, 0xF0, 4, pval)
#define HTX_ret_GG_PP()                                     ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x4C, 0xF0, 4)
#define HTX_set_GG_PP(val)                                  ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x4C, 0xF0, 4, val)

#define HTX_get_GC_CD(pval)                                 ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x4C, 0xF, 0, pval)
#define HTX_ret_GC_CD()                                     ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x4C, 0xF, 0)
#define HTX_set_GC_CD(val)                                  ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x4C, 0xF, 0, val)

#define HTX_get_GC_BYTE2(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x4D, 0xFF, 0, pval)
#define HTX_ret_GC_BYTE2()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x4D, 0xFF, 0)
#define HTX_set_GC_BYTE2(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x4D, 0xFF, 0, val)

#define HTX_get_GC_BYTE3(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x4E, 0xFF, 0, pval)
#define HTX_ret_GC_BYTE3()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x4E, 0xFF, 0)
#define HTX_set_GC_BYTE3(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x4E, 0xFF, 0, val)

#define HTX_get_GC_BYTE4(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x4F, 0xFF, 0, pval)
#define HTX_ret_GC_BYTE4()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x4F, 0xFF, 0)
#define HTX_set_GC_BYTE4(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x4F, 0xFF, 0, val)

#define HTX_get_GC_BYTE5(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x50, 0xFF, 0, pval)
#define HTX_ret_GC_BYTE5()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x50, 0xFF, 0)
#define HTX_set_GC_BYTE5(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x50, 0xFF, 0, val)

#define HTX_get_GC_BYTE6(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x51, 0xFF, 0, pval)
#define HTX_ret_GC_BYTE6()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x51, 0xFF, 0)
#define HTX_set_GC_BYTE6(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x51, 0xFF, 0, val)

#define HTX_get_AVI_VERSION(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x52, 0x7, 0, pval)
#define HTX_ret_AVI_VERSION()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x52, 0x7, 0)
#define HTX_set_AVI_VERSION(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x52, 0x7, 0, val)

#define HTX_get_AVI_LENGTH(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x53, 0x1F, 0, pval)
#define HTX_ret_AVI_LENGTH()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x53, 0x1F, 0)
#define HTX_set_AVI_LENGTH(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x53, 0x1F, 0, val)

#define HTX_get_AVI_CHECKSUM(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x54, 0xFF, 0, pval)
#define HTX_ret_AVI_CHECKSUM()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x54, 0xFF, 0)
#define HTX_set_AVI_CHECKSUM(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x54, 0xFF, 0, val)

#define HTX_is_AVI_BYTE1_7_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x55, 0x80, 0x7)
#define HTX_get_AVI_BYTE1_7(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x55, 0x80, 0x7, pval)
#define HTX_ret_AVI_BYTE1_7()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x55, 0x80, 0x7)
#define HTX_set_AVI_BYTE1_7(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x55, 0x80, 0x7, val)

#define HTX_get_Y1Y0(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x55, 0x60, 5, pval)
#define HTX_ret_Y1Y0()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x55, 0x60, 5)
#define HTX_set_Y1Y0(val)                                   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x55, 0x60, 5, val)

#define HTX_is_A0_true()                                    ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x55, 0x10, 0x4)
#define HTX_get_A0(pval)                                    ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x55, 0x10, 0x4, pval)
#define HTX_ret_A0()                                        ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x55, 0x10, 0x4)
#define HTX_set_A0(val)                                     ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x55, 0x10, 0x4, val)

#define HTX_get_B1B0(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x55, 0xC, 2, pval)
#define HTX_ret_B1B0()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x55, 0xC, 2)
#define HTX_set_B1B0(val)                                   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x55, 0xC, 2, val)

#define HTX_get_S1S0(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x55, 0x3, 0, pval)
#define HTX_ret_S1S0()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x55, 0x3, 0)
#define HTX_set_S1S0(val)                                   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x55, 0x3, 0, val)

#define HTX_get_C1C0(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x56, 0xC0, 6, pval)
#define HTX_ret_C1C0()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x56, 0xC0, 6)
#define HTX_set_C1C0(val)                                   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x56, 0xC0, 6, val)

#define HTX_get_M1M0(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x56, 0x30, 4, pval)
#define HTX_ret_M1M0()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x56, 0x30, 4)
#define HTX_set_M1M0(val)                                   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x56, 0x30, 4, val)

#define HTX_get_R3210(pval)                                 ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x56, 0xF, 0, pval)
#define HTX_ret_R3210()                                     ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x56, 0xF, 0)
#define HTX_set_R3210(val)                                  ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x56, 0xF, 0, val)

#define HTX_is_ITC_true()                                   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x57, 0x80, 0x7)
#define HTX_get_ITC(pval)                                   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x57, 0x80, 0x7, pval)
#define HTX_ret_ITC()                                       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x57, 0x80, 0x7)
#define HTX_set_ITC(val)                                    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x57, 0x80, 0x7, val)

#define HTX_get_EC210(pval)                                 ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x57, 0x70, 4, pval)
#define HTX_ret_EC210()                                     ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x57, 0x70, 4)
#define HTX_set_EC210(val)                                  ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x57, 0x70, 4, val)

#define HTX_get_Q1Q0(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x57, 0xC, 2, pval)
#define HTX_ret_Q1Q0()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x57, 0xC, 2)
#define HTX_set_Q1Q0(val)                                   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x57, 0xC, 2, val)

#define HTX_get_SC(pval)                                    ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x57, 0x3, 0, pval)
#define HTX_ret_SC()                                        ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x57, 0x3, 0)
#define HTX_set_SC(val)                                     ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x57, 0x3, 0, val)

#define HTX_is_AVI_BYTE4_7_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x58, 0x80, 0x7)
#define HTX_get_AVI_BYTE4_7(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x58, 0x80, 0x7, pval)
#define HTX_ret_AVI_BYTE4_7()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x58, 0x80, 0x7)
#define HTX_set_AVI_BYTE4_7(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x58, 0x80, 0x7, val)

#define HTX_get_AVI_BYTE5_7_4(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x59, 0xF0, 4, pval)
#define HTX_ret_AVI_BYTE5_7_4()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x59, 0xF0, 4)
#define HTX_set_AVI_BYTE5_7_4(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x59, 0xF0, 4, val)

#define HTX_get_AVI_BYTE6(pval)                             ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x5A, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_AVI_BYTE6()                                 ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x5A, 0xFF, 0xFF, 0, 2)
#define HTX_set_AVI_BYTE6(val)                              ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x5A, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_AVI_BYTE8(pval)                             ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x5C, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_AVI_BYTE8()                                 ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x5C, 0xFF, 0xFF, 0, 2)
#define HTX_set_AVI_BYTE8(val)                              ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x5C, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_AVI_BYTE10(pval)                            ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x5E, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_AVI_BYTE10()                                ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x5E, 0xFF, 0xFF, 0, 2)
#define HTX_set_AVI_BYTE10(val)                             ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x5E, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_AVI_BYTE12(pval)                            ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0x60, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_AVI_BYTE12()                                ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0x60, 0xFF, 0xFF, 0, 2)
#define HTX_set_AVI_BYTE12(val)                             ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0x60, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_AVI_BYTE14(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x62, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE14()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x62, 0xFF, 0)
#define HTX_set_AVI_BYTE14(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x62, 0xFF, 0, val)

#define HTX_get_AVI_BYTE15(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x63, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE15()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x63, 0xFF, 0)
#define HTX_set_AVI_BYTE15(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x63, 0xFF, 0, val)

#define HTX_get_AVI_BYTE16(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x64, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE16()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x64, 0xFF, 0)
#define HTX_set_AVI_BYTE16(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x64, 0xFF, 0, val)

#define HTX_get_AVI_BYTE17(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x65, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE17()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x65, 0xFF, 0)
#define HTX_set_AVI_BYTE17(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x65, 0xFF, 0, val)

#define HTX_get_AVI_BYTE18(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x66, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE18()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x66, 0xFF, 0)
#define HTX_set_AVI_BYTE18(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x66, 0xFF, 0, val)

#define HTX_get_AVI_BYTE19(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x67, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE19()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x67, 0xFF, 0)
#define HTX_set_AVI_BYTE19(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x67, 0xFF, 0, val)

#define HTX_get_AVI_BYTE20(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x68, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE20()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x68, 0xFF, 0)
#define HTX_set_AVI_BYTE20(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x68, 0xFF, 0, val)

#define HTX_get_AVI_BYTE21(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x69, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE21()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x69, 0xFF, 0)
#define HTX_set_AVI_BYTE21(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x69, 0xFF, 0, val)

#define HTX_get_AVI_BYTE22(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x6A, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE22()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x6A, 0xFF, 0)
#define HTX_set_AVI_BYTE22(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x6A, 0xFF, 0, val)

#define HTX_get_AVI_BYTE23(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x6B, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE23()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x6B, 0xFF, 0)
#define HTX_set_AVI_BYTE23(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x6B, 0xFF, 0, val)

#define HTX_get_AVI_BYTE24(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x6C, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE24()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x6C, 0xFF, 0)
#define HTX_set_AVI_BYTE24(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x6C, 0xFF, 0, val)

#define HTX_get_AVI_BYTE25(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x6D, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE25()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x6D, 0xFF, 0)
#define HTX_set_AVI_BYTE25(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x6D, 0xFF, 0, val)

#define HTX_get_AVI_BYTE26(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x6E, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE26()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x6E, 0xFF, 0)
#define HTX_set_AVI_BYTE26(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x6E, 0xFF, 0, val)

#define HTX_get_AVI_BYTE27(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x6F, 0xFF, 0, pval)
#define HTX_ret_AVI_BYTE27()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x6F, 0xFF, 0)
#define HTX_set_AVI_BYTE27(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x6F, 0xFF, 0, val)

#define HTX_get_AUDIOIF_VERSION(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x70, 0x7, 0, pval)
#define HTX_ret_AUDIOIF_VERSION()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x70, 0x7, 0)
#define HTX_set_AUDIOIF_VERSION(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x70, 0x7, 0, val)

#define HTX_get_AUDIOIF_LENGTH(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x71, 0x1F, 0, pval)
#define HTX_ret_AUDIOIF_LENGTH()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x71, 0x1F, 0)
#define HTX_set_AUDIOIF_LENGTH(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x71, 0x1F, 0, val)

#define HTX_get_AUDIOIF_CHECKSUM(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x72, 0xFF, 0, pval)
#define HTX_ret_AUDIOIF_CHECKSUM()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x72, 0xFF, 0)
#define HTX_set_AUDIOIF_CHECKSUM(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x72, 0xFF, 0, val)

#define HTX_get_AUDIOIF_CT(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x73, 0xF0, 4, pval)
#define HTX_ret_AUDIOIF_CT()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x73, 0xF0, 4)
#define HTX_set_AUDIOIF_CT(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x73, 0xF0, 4, val)

#define HTX_is_AUDIOIF_BYTE1_3_true()                       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x73, 0x8, 0x3)
#define HTX_get_AUDIOIF_BYTE1_3(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x73, 0x8, 0x3, pval)
#define HTX_ret_AUDIOIF_BYTE1_3()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x73, 0x8, 0x3)
#define HTX_set_AUDIOIF_BYTE1_3(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x73, 0x8, 0x3, val)

#define HTX_get_AUDIOIF_CC(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x73, 0x7, 0, pval)
#define HTX_ret_AUDIOIF_CC()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x73, 0x7, 0)
#define HTX_set_AUDIOIF_CC(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x73, 0x7, 0, val)

#define HTX_get_AUDIOIF_BYTE2_7_5(pval)                     ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x74, 0xE0, 5, pval)
#define HTX_ret_AUDIOIF_BYTE2_7_5()                         ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x74, 0xE0, 5)
#define HTX_set_AUDIOIF_BYTE2_7_5(val)                      ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x74, 0xE0, 5, val)

#define HTX_get_AUDIOIF_SF(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x74, 0x1C, 2, pval)
#define HTX_ret_AUDIOIF_SF()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x74, 0x1C, 2)
#define HTX_set_AUDIOIF_SF(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x74, 0x1C, 2, val)

#define HTX_get_AUDIOIF_SS(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x74, 0x3, 0, pval)
#define HTX_ret_AUDIOIF_SS()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x74, 0x3, 0)
#define HTX_set_AUDIOIF_SS(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x74, 0x3, 0, val)

#define HTX_get_AUDIOIF_BYTE3(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x75, 0xFF, 0, pval)
#define HTX_ret_AUDIOIF_BYTE3()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x75, 0xFF, 0)
#define HTX_set_AUDIOIF_BYTE3(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x75, 0xFF, 0, val)

#define HTX_get_AUDIOIF_CA(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x76, 0xFF, 0, pval)
#define HTX_ret_AUDIOIF_CA()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x76, 0xFF, 0)
#define HTX_set_AUDIOIF_CA(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x76, 0xFF, 0, val)

#define HTX_is_AUDIOIF_DM_INH_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x77, 0x80, 0x7)
#define HTX_get_AUDIOIF_DM_INH(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x77, 0x80, 0x7, pval)
#define HTX_ret_AUDIOIF_DM_INH()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x77, 0x80, 0x7)
#define HTX_set_AUDIOIF_DM_INH(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x77, 0x80, 0x7, val)

#define HTX_get_AUDIOIF_LSV(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x77, 0x78, 3, pval)
#define HTX_ret_AUDIOIF_LSV()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x77, 0x78, 3)
#define HTX_set_AUDIOIF_LSV(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x77, 0x78, 3, val)

#define HTX_get_AUDIOIF_BYTE5_2_0(pval)                     ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x77, 0x7, 0, pval)
#define HTX_ret_AUDIOIF_BYTE5_2_0()                         ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x77, 0x7, 0)
#define HTX_set_AUDIOIF_BYTE5_2_0(val)                      ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x77, 0x7, 0, val)

#define HTX_get_AUDIOIF_BYTE6(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x78, 0xFF, 0, pval)
#define HTX_ret_AUDIOIF_BYTE6()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x78, 0xFF, 0)
#define HTX_set_AUDIOIF_BYTE6(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x78, 0xFF, 0, val)

#define HTX_get_AUDIOIF_BYTE7(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x79, 0xFF, 0, pval)
#define HTX_ret_AUDIOIF_BYTE7()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x79, 0xFF, 0)
#define HTX_set_AUDIOIF_BYTE7(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x79, 0xFF, 0, val)

#define HTX_get_AUDIOIF_BYTE8(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x7A, 0xFF, 0, pval)
#define HTX_ret_AUDIOIF_BYTE8()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x7A, 0xFF, 0)
#define HTX_set_AUDIOIF_BYTE8(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x7A, 0xFF, 0, val)

#define HTX_get_AUDIOIF_BYTE9(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x7B, 0xFF, 0, pval)
#define HTX_ret_AUDIOIF_BYTE9()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x7B, 0xFF, 0)
#define HTX_set_AUDIOIF_BYTE9(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x7B, 0xFF, 0, val)

#define HTX_get_AUDIOIF_BYTE10(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x7C, 0xFF, 0, pval)
#define HTX_ret_AUDIOIF_BYTE10()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x7C, 0xFF, 0)
#define HTX_set_AUDIOIF_BYTE10(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x7C, 0xFF, 0, val)

#define HTX_is_CEC_WAKEUP_OPCODE1_INTERRUPT_ENABLE_true()   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x92, 0x80, 0x7)
#define HTX_get_CEC_WAKEUP_OPCODE1_INTERRUPT_ENABLE(pval)   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x92, 0x80, 0x7, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE1_INTERRUPT_ENABLE()       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x92, 0x80, 0x7)
#define HTX_set_CEC_WAKEUP_OPCODE1_INTERRUPT_ENABLE(val)    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x92, 0x80, 0x7, val)

#define HTX_is_CEC_WAKEUP_OPCODE2_INTERRUPT_ENABLE_true()   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x92, 0x40, 0x6)
#define HTX_get_CEC_WAKEUP_OPCODE2_INTERRUPT_ENABLE(pval)   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x92, 0x40, 0x6, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE2_INTERRUPT_ENABLE()       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x92, 0x40, 0x6)
#define HTX_set_CEC_WAKEUP_OPCODE2_INTERRUPT_ENABLE(val)    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x92, 0x40, 0x6, val)


#define HTX_is_CEC_WAKEUP_OPCODE3_INTERRUPT_ENABLE_true()   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x92, 0x20, 0x5)
#define HTX_get_CEC_WAKEUP_OPCODE3_INTERRUPT_ENABLE(pval)   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x92, 0x20, 0x5, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE3_INTERRUPT_ENABLE()       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x92, 0x20, 0x5)
#define HTX_set_CEC_WAKEUP_OPCODE3_INTERRUPT_ENABLE(val)    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x92, 0x20, 0x5, val)


#define HTX_is_CEC_WAKEUP_OPCODE4_INTERRUPT_ENABLE_true()   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x92, 0x10, 0x4)
#define HTX_get_CEC_WAKEUP_OPCODE4_INTERRUPT_ENABLE(pval)   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x92, 0x10, 0x4, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE4_INTERRUPT_ENABLE()       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x92, 0x10, 0x4)
#define HTX_set_CEC_WAKEUP_OPCODE4_INTERRUPT_ENABLE(val)    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x92, 0x10, 0x4, val)

#define HTX_is_CEC_WAKEUP_OPCODE5_INTERRUPT_ENABLE_true()   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x92, 0x8, 0x3)
#define HTX_get_CEC_WAKEUP_OPCODE5_INTERRUPT_ENABLE(pval)   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x92, 0x8, 0x3, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE5_INTERRUPT_ENABLE()       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x92, 0x8, 0x3)
#define HTX_set_CEC_WAKEUP_OPCODE5_INTERRUPT_ENABLE(val)    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x92, 0x8, 0x3, val)

#define HTX_is_CEC_WAKEUP_OPCODE6_INTERRUPT_ENABLE_true()   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x92, 0x4, 0x2)
#define HTX_get_CEC_WAKEUP_OPCODE6_INTERRUPT_ENABLE(pval)   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x92, 0x4, 0x2, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE6_INTERRUPT_ENABLE()       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x92, 0x4, 0x2)
#define HTX_set_CEC_WAKEUP_OPCODE6_INTERRUPT_ENABLE(val)    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x92, 0x4, 0x2, val)

#define HTX_is_CEC_WAKEUP_OPCODE7_INTERRUPT_ENABLE_true()   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x92, 0x2, 0x1)
#define HTX_get_CEC_WAKEUP_OPCODE7_INTERRUPT_ENABLE(pval)   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x92, 0x2, 0x1, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE7_INTERRUPT_ENABLE()       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x92, 0x2, 0x1)
#define HTX_set_CEC_WAKEUP_OPCODE7_INTERRUPT_ENABLE(val)    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x92, 0x2, 0x1, val)

#define HTX_is_CEC_WAKEUP_OPCODE8_INTERRUPT_ENABLE_true()   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x92, 0x1, 0x0)
#define HTX_get_CEC_WAKEUP_OPCODE8_INTERRUPT_ENABLE(pval)   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x92, 0x1, 0x0, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE8_INTERRUPT_ENABLE()       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x92, 0x1, 0x0)
#define HTX_set_CEC_WAKEUP_OPCODE8_INTERRUPT_ENABLE(val)    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x92, 0x1, 0x0, val)

#define HTX_is_CEC_WAKEUP_OPCODE1_INTR_true()               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x93, 0x80, 0x7)
#define HTX_get_CEC_WAKEUP_OPCODE1_INTR(pval)               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x93, 0x80, 0x7, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE1_INTR()                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x93, 0x80, 0x7)
#define HTX_set_CEC_WAKEUP_OPCODE1_INTR(val)                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x93, 0x80, 0x7, val)

#define HTX_is_CEC_WAKEUP_OPCODE2_INTR_true()               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x93, 0x40, 0x6)
#define HTX_get_CEC_WAKEUP_OPCODE2_INTR(pval)               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x93, 0x40, 0x6, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE2_INTR()                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x93, 0x40, 0x6)
#define HTX_set_CEC_WAKEUP_OPCODE2_INTR(val)                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x93, 0x40, 0x6, val)

#define HTX_is_CEC_WAKEUP_OPCODE3_INTR_true()               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x93, 0x20, 0x5)
#define HTX_get_CEC_WAKEUP_OPCODE3_INTR(pval)               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x93, 0x20, 0x5, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE3_INTR()                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x93, 0x20, 0x5)
#define HTX_set_CEC_WAKEUP_OPCODE3_INTR(val)                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x93, 0x20, 0x5, val)

#define HTX_is_CEC_WAKEUP_OPCODE4_INTR_true()               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x93, 0x10, 0x4)
#define HTX_get_CEC_WAKEUP_OPCODE4_INTR(pval)               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x93, 0x10, 0x4, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE4_INTR()                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x93, 0x10, 0x4)
#define HTX_set_CEC_WAKEUP_OPCODE4_INTR(val)                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x93, 0x10, 0x4, val)

#define HTX_is_CEC_WAKEUP_OPCODE5_INTR_true()               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x93, 0x8, 0x3)
#define HTX_get_CEC_WAKEUP_OPCODE5_INTR(pval)               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x93, 0x8, 0x3, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE5_INTR()                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x93, 0x8, 0x3)
#define HTX_set_CEC_WAKEUP_OPCODE5_INTR(val)                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x93, 0x8, 0x3, val)

#define HTX_is_CEC_WAKEUP_OPCODE6_INTR_true()               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x93, 0x4, 0x2)
#define HTX_get_CEC_WAKEUP_OPCODE6_INTR(pval)               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x93, 0x4, 0x2, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE6_INTR()                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x93, 0x4, 0x2)
#define HTX_set_CEC_WAKEUP_OPCODE6_INTR(val)                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x93, 0x4, 0x2, val)

#define HTX_is_CEC_WAKEUP_OPCODE7_INTR_true()               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x93, 0x2, 0x1)
#define HTX_get_CEC_WAKEUP_OPCODE7_INTR(pval)               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x93, 0x2, 0x1, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE7_INTR()                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x93, 0x2, 0x1)
#define HTX_set_CEC_WAKEUP_OPCODE7_INTR(val)                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x93, 0x2, 0x1, val)

#define HTX_is_CEC_WAKEUP_OPCODE8_INTR_true()               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x93, 0x1, 0x0)
#define HTX_get_CEC_WAKEUP_OPCODE8_INTR(pval)               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x93, 0x1, 0x0, pval)
#define HTX_ret_CEC_WAKEUP_OPCODE8_INTR()                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x93, 0x1, 0x0)
#define HTX_set_CEC_WAKEUP_OPCODE8_INTR(val)                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x93, 0x1, 0x0, val)


#define HTX_is_HPD_INTERRUPT_ENABLE_true()                  ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x94, 0x80, 0x7)
#define HTX_get_HPD_INTERRUPT_ENABLE(pval)                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x94, 0x80, 0x7, pval)
#define HTX_ret_HPD_INTERRUPT_ENABLE()                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x94, 0x80, 0x7)
#define HTX_set_HPD_INTERRUPT_ENABLE(val)                   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x94, 0x80, 0x7, val)

#define HTX_is_RX_SENSE_INTERRUPT_ENABLE_true()             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x94, 0x40, 0x6)
#define HTX_get_RX_SENSE_INTERRUPT_ENABLE(pval)             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x94, 0x40, 0x6, pval)
#define HTX_ret_RX_SENSE_INTERRUPT_ENABLE()                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x94, 0x40, 0x6)
#define HTX_set_RX_SENSE_INTERRUPT_ENABLE(val)              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x94, 0x40, 0x6, val)

#define HTX_is_VSYNC_INTERRUPT_ENABLE_true()                ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x94, 0x20, 0x5)
#define HTX_get_VSYNC_INTERRUPT_ENABLE(pval)                ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x94, 0x20, 0x5, pval)
#define HTX_ret_VSYNC_INTERRUPT_ENABLE()                    ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x94, 0x20, 0x5)
#define HTX_set_VSYNC_INTERRUPT_ENABLE(val)                 ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x94, 0x20, 0x5, val)

#define HTX_is_AUDIO_FIFO_FULL_INTERRUPT_ENABLE_true()      ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x94, 0x10, 0x4)
#define HTX_get_AUDIO_FIFO_FULL_INTERRUPT_ENABLE(pval)      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x94, 0x10, 0x4, pval)
#define HTX_ret_AUDIO_FIFO_FULL_INTERRUPT_ENABLE()          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x94, 0x10, 0x4)
#define HTX_set_AUDIO_FIFO_FULL_INTERRUPT_ENABLE(val)       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x94, 0x10, 0x4, val)

#define HTX_is_EMBEDDED_SYNC_PARITRY_ERROR_INTERRUPT_ENABLE_true()ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x94, 0x8, 0x3)
#define HTX_get_EMBEDDED_SYNC_PARITRY_ERROR_INTERRUPT_ENABLE(pval)ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x94, 0x8, 0x3, pval)
#define HTX_ret_EMBEDDED_SYNC_PARITRY_ERROR_INTERRUPT_ENABLE()ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x94, 0x8, 0x3)
#define HTX_set_EMBEDDED_SYNC_PARITRY_ERROR_INTERRUPT_ENABLE(val)ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x94, 0x8, 0x3, val)

#define HTX_is_EDID_READY_INTERRUPT_ENABLE_true()           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x94, 0x4, 0x2)
#define HTX_get_EDID_READY_INTERRUPT_ENABLE(pval)           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x94, 0x4, 0x2, pval)
#define HTX_ret_EDID_READY_INTERRUPT_ENABLE()               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x94, 0x4, 0x2)
#define HTX_set_EDID_READY_INTERRUPT_ENABLE(val)            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x94, 0x4, 0x2, val)

#define HTX_is_HDPC_AUTHENTICATED_ENABLE_true()             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x94, 0x2, 0x1)
#define HTX_get_HDPC_AUTHENTICATED_ENABLE(pval)             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x94, 0x2, 0x1, pval)
#define HTX_ret_HDPC_AUTHENTICATED_ENABLE()                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x94, 0x2, 0x1)
#define HTX_set_HDPC_AUTHENTICATED_ENABLE(val)              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x94, 0x2, 0x1, val)

#define HTX_is_HDCP_CONTROLLER_ERROR_INTERRUPT_true()       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x95, 0x80, 0x7)
#define HTX_get_HDCP_CONTROLLER_ERROR_INTERRUPT(pval)       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x95, 0x80, 0x7, pval)
#define HTX_ret_HDCP_CONTROLLER_ERROR_INTERRUPT()           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x95, 0x80, 0x7)
#define HTX_set_HDCP_CONTROLLER_ERROR_INTERRUPT(val)        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x95, 0x80, 0x7, val)

#define HTX_is_BKSV_FLAT_INTERRUPT_ENABLE_true()            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x95, 0x40, 0x6)
#define HTX_get_BKSV_FLAT_INTERRUPT_ENABLE(pval)            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x95, 0x40, 0x6, pval)
#define HTX_ret_BKSV_FLAT_INTERRUPT_ENABLE()                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x95, 0x40, 0x6)
#define HTX_set_BKSV_FLAT_INTERRUPT_ENABLE(val)             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x95, 0x40, 0x6, val)

#define HTX_is_TX_READY_INTERRUPT_ENABLE_true()             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x95, 0x20, 0x5)
#define HTX_get_TX_READY_INTERRUPT_ENABLE(pval)             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x95, 0x20, 0x5, pval)
#define HTX_ret_TX_READY_INTERRUPT_ENABLE()                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x95, 0x20, 0x5)
#define HTX_set_TX_READY_INTERRUPT_ENABLE(val)              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x95, 0x20, 0x5, val)

#define HTX_is_TX_ARBITRATION_LOST_INTERRUPT_ENABLE_true()  ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x95, 0x10, 0x4)
#define HTX_get_TX_ARBITRATION_LOST_INTERRUPT_ENABLE(pval)  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x95, 0x10, 0x4, pval)
#define HTX_ret_TX_ARBITRATION_LOST_INTERRUPT_ENABLE()      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x95, 0x10, 0x4)
#define HTX_set_TX_ARBITRATION_LOST_INTERRUPT_ENABLE(val)   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x95, 0x10, 0x4, val)

#define HTX_is_TX_RETRY_TIMEOUT_INTERRUPT_ENABLE_true()     ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x95, 0x8, 0x3)
#define HTX_get_TX_RETRY_TIMEOUT_INTERRUPT_ENABLE(pval)     ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x95, 0x8, 0x3, pval)
#define HTX_ret_TX_RETRY_TIMEOUT_INTERRUPT_ENABLE()         ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x95, 0x8, 0x3)
#define HTX_set_TX_RETRY_TIMEOUT_INTERRUPT_ENABLE(val)      ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x95, 0x8, 0x3, val)

#define HTX_is_RX_READY_INTERRUPT_ENABLE_true()             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x95, 0x4, 0x2)
#define HTX_get_RX_READY_INTERRUPT_ENABLE(pval)             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x95, 0x4, 0x2, pval)
#define HTX_ret_RX_READY_INTERRUPT_ENABLE()                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x95, 0x4, 0x2)
#define HTX_set_RX_READY_INTERRUPT_ENABLE(val)              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x95, 0x4, 0x2, val)

#define HTX_is_RX_READY3_INTERRUPT_ENABLE_true()            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x95, 0x4, 0x2)
#define HTX_get_RX_READY3_INTERRUPT_ENABLE(pval)            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x95, 0x4, 0x2, pval)
#define HTX_ret_RX_READY3_INTERRUPT_ENABLE()                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x95, 0x4, 0x2)
#define HTX_set_RX_READY3_INTERRUPT_ENABLE(val)             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x95, 0x4, 0x2, val)

#define HTX_is_RX_READY2_INTERRUPT_ENABLE_true()            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x95, 0x2, 0x1)
#define HTX_get_RX_READY2_INTERRUPT_ENABLE(pval)            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x95, 0x2, 0x1, pval)
#define HTX_ret_RX_READY2_INTERRUPT_ENABLE()                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x95, 0x2, 0x1)
#define HTX_set_RX_READY2_INTERRUPT_ENABLE(val)             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x95, 0x2, 0x1, val)

#define HTX_is_RX_READY1_INTERRUPT_ENABLE_true()            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x95, 0x1, 0x0)
#define HTX_get_RX_READY1_INTERRUPT_ENABLE(pval)            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x95, 0x1, 0x0, pval)
#define HTX_ret_RX_READY1_INTERRUPT_ENABLE()                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x95, 0x1, 0x0)
#define HTX_set_RX_READY1_INTERRUPT_ENABLE(val)             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x95, 0x1, 0x0, val)



#define HTX_is_HPD_INTR_true()                              ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x96, 0x80, 0x7)
#define HTX_get_HPD_INTR(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x96, 0x80, 0x7, pval)
#define HTX_ret_HPD_INTR()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x96, 0x80, 0x7)
#define HTX_set_HPD_INTR(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x96, 0x80, 0x7, val)

#define HTX_is_MSEN_INTR_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x96, 0x40, 0x6)
#define HTX_get_MSEN_INTR(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x96, 0x40, 0x6, pval)
#define HTX_ret_MSEN_INTR()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x96, 0x40, 0x6)
#define HTX_set_MSEN_INTR(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x96, 0x40, 0x6, val)

#define HTX_is_VS_INTR_true()                               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x96, 0x20, 0x5)
#define HTX_get_VS_INTR(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x96, 0x20, 0x5, pval)
#define HTX_ret_VS_INTR()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x96, 0x20, 0x5)
#define HTX_set_VS_INTR(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x96, 0x20, 0x5, val)

#define HTX_is_AUDIOFIFO_FULL_INTR_true()                   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x96, 0x10, 0x4)
#define HTX_get_AUDIOFIFO_FULL_INTR(pval)                   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x96, 0x10, 0x4, pval)
#define HTX_ret_AUDIOFIFO_FULL_INTR()                       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x96, 0x10, 0x4)
#define HTX_set_AUDIOFIFO_FULL_INTR(val)                    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x96, 0x10, 0x4, val)

#define HTX_is_ITU656_ERROR_INTR_true()                     ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x96, 0x8, 0x3)
#define HTX_get_ITU656_ERROR_INTR(pval)                     ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x96, 0x8, 0x3, pval)
#define HTX_ret_ITU656_ERROR_INTR()                         ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x96, 0x8, 0x3)
#define HTX_set_ITU656_ERROR_INTR(val)                      ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x96, 0x8, 0x3, val)

#define HTX_is_EDID_RDY_INTR_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x96, 0x4, 0x2)
#define HTX_get_EDID_RDY_INTR(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x96, 0x4, 0x2, pval)
#define HTX_ret_EDID_RDY_INTR()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x96, 0x4, 0x2)
#define HTX_set_EDID_RDY_INTR(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x96, 0x4, 0x2, val)

#define HTX_is_HDCP_CONTROLLER_STATE_4_INTR_true()          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x96, 0x2, 0x1)
#define HTX_get_HDCP_CONTROLLER_STATE_4_INTR(pval)          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x96, 0x2, 0x1, pval)
#define HTX_ret_HDCP_CONTROLLER_STATE_4_INTR()              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x96, 0x2, 0x1)
#define HTX_set_HDCP_CONTROLLER_STATE_4_INTR(val)           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x96, 0x2, 0x1, val)

#define HTX_is_PJ_RDY_INTR_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x96, 0x1, 0x0)
#define HTX_get_PJ_RDY_INTR(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x96, 0x1, 0x0, pval)
#define HTX_ret_PJ_RDY_INTR()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x96, 0x1, 0x0)
#define HTX_set_PJ_RDY_INTR(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x96, 0x1, 0x0, val)

#define HTX_is_HDCP_ERROR_INTR_true()                       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x97, 0x80, 0x7)
#define HTX_get_HDCP_ERROR_INTR(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x97, 0x80, 0x7, pval)
#define HTX_ret_HDCP_ERROR_INTR()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x97, 0x80, 0x7)
#define HTX_set_HDCP_ERROR_INTR(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x97, 0x80, 0x7, val)

#define HTX_is_BKSV_FLAG_INTR_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x97, 0x40, 0x6)
#define HTX_get_BKSV_FLAG_INTR(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x97, 0x40, 0x6, pval)
#define HTX_ret_BKSV_FLAG_INTR()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x97, 0x40, 0x6)
#define HTX_set_BKSV_FLAG_INTR(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x97, 0x40, 0x6, val)

#define HTX_is_TX_READY_INTERRUPT_true()                    ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x97, 0x20, 0x5)
#define HTX_get_TX_READY_INTERRUPT(pval)                    ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x97, 0x20, 0x5, pval)
#define HTX_ret_TX_READY_INTERRUPT()                        ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x97, 0x20, 0x5)
#define HTX_set_TX_READY_INTERRUPT(val)                     ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x97, 0x20, 0x5, val)

#define HTX_is_TX_ARBITRATION_LOST_INTERRUPT_true()         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x97, 0x10, 0x4)
#define HTX_get_TX_ARBITRATION_LOST_INTERRUPT(pval)         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x97, 0x10, 0x4, pval)
#define HTX_ret_TX_ARBITRATION_LOST_INTERRUPT()             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x97, 0x10, 0x4)
#define HTX_set_TX_ARBITRATION_LOST_INTERRUPT(val)          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x97, 0x10, 0x4, val)

#define HTX_is_TX_RETRY_TIMEOUT_INTERRUPT_true()            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x97, 0x8, 0x3)
#define HTX_get_TX_RETRY_TIMEOUT_INTERRUPT(pval)            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x97, 0x8, 0x3, pval)
#define HTX_ret_TX_RETRY_TIMEOUT_INTERRUPT()                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x97, 0x8, 0x3)
#define HTX_set_TX_RETRY_TIMEOUT_INTERRUPT(val)             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x97, 0x8, 0x3, val)

#define HTX_is_RX_READY_INTERRUPT_true()                    ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x97, 0x4, 0x2)
#define HTX_get_RX_READY_INTERRUPT(pval)                    ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x97, 0x4, 0x2, pval)
#define HTX_ret_RX_READY_INTERRUPT()                        ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x97, 0x4, 0x2)
#define HTX_set_RX_READY_INTERRUPT(val)                     ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x97, 0x4, 0x2, val)

#define HTX_is_RX_READY3_INTERRUPT_true()                   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x97, 0x4, 0x2)
#define HTX_get_RX_READY3_INTERRUPT(pval)                   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x97, 0x4, 0x2, pval)
#define HTX_ret_RX_READY3_INTERRUPT()                       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x97, 0x4, 0x2)
#define HTX_set_RX_READY3_INTERRUPT(val)                    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x97, 0x4, 0x2, val)

#define HTX_is_RX_READY2_INTERRUPT_true()                   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x97, 0x2, 0x1)
#define HTX_get_RX_READY2_INTERRUPT(pval)                   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x97, 0x2, 0x1, pval)
#define HTX_ret_RX_READY2_INTERRUPT()                       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x97, 0x2, 0x1)
#define HTX_set_RX_READY2_INTERRUPT(val)                    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x97, 0x2, 0x1, val)

#define HTX_is_RX_READY1_INTERRUPT_true()                   ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x97, 0x1, 0x0)
#define HTX_get_RX_READY1_INTERRUPT(pval)                   ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x97, 0x1, 0x0, pval)
#define HTX_ret_RX_READY1_INTERRUPT()                       ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x97, 0x1, 0x0)
#define HTX_set_RX_READY1_INTERRUPT(val)                    ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x97, 0x1, 0x0, val)


#define HTX_is_GEAREXTERNALI2C_true()                       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x98, 0x80, 0x7)
#define HTX_get_GEAREXTERNALI2C(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x98, 0x80, 0x7, pval)
#define HTX_ret_GEAREXTERNALI2C()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x98, 0x80, 0x7)
#define HTX_set_GEAREXTERNALI2C(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x98, 0x80, 0x7, val)

#define HTX_get_VCOGEARFROMI2C(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x98, 0x70, 4, pval)
#define HTX_ret_VCOGEARFROMI2C()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x98, 0x70, 4)
#define HTX_set_VCOGEARFROMI2C(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x98, 0x70, 4, val)

#define HTX_get_CPSET(pval)                                 ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x98, 0xF, 0, pval)
#define HTX_ret_CPSET()                                     ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x98, 0xF, 0)
#define HTX_set_CPSET(val)                                  ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x98, 0xF, 0, val)

#define HTX_get_LOCKCOUNTLIMIT(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x99, 0xFF, 0, pval)
#define HTX_ret_LOCKCOUNTLIMIT()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x99, 0xFF, 0)
#define HTX_set_LOCKCOUNTLIMIT(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x99, 0xFF, 0, val)

#define HTX_is_LOCK_FILT_EN_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x9A, 0x80, 0x7)
#define HTX_get_LOCK_FILT_EN(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9A, 0x80, 0x7, pval)
#define HTX_ret_LOCK_FILT_EN()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9A, 0x80, 0x7)
#define HTX_set_LOCK_FILT_EN(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9A, 0x80, 0x7, val)

#define HTX_get_WAIT_TIME_SEL(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9A, 0x60, 5, pval)
#define HTX_ret_WAIT_TIME_SEL()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9A, 0x60, 5)
#define HTX_set_WAIT_TIME_SEL(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9A, 0x60, 5, val)

#define HTX_get_PARTIALLSB(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9A, 0x1E, 1, pval)
#define HTX_ret_PARTIALLSB()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9A, 0x1E, 1)
#define HTX_set_PARTIALLSB(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9A, 0x1E, 1, val)

#define HTX_get_SERICTRLI2C(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9B, 0x38, 3, pval)
#define HTX_ret_SERICTRLI2C()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9B, 0x38, 3)
#define HTX_set_SERICTRLI2C(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9B, 0x38, 3, val)

#define HTX_is_FORCEFILTERNODEI2C_true()                    ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x9B, 0x4, 0x2)
#define HTX_get_FORCEFILTERNODEI2C(pval)                    ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9B, 0x4, 0x2, pval)
#define HTX_ret_FORCEFILTERNODEI2C()                        ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9B, 0x4, 0x2)
#define HTX_set_FORCEFILTERNODEI2C(val)                     ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9B, 0x4, 0x2, val)

#define HTX_get_LOCK_SEL(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9B, 0x3, 0, pval)
#define HTX_ret_LOCK_SEL()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9B, 0x3, 0)
#define HTX_set_LOCK_SEL(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9B, 0x3, 0, val)

#define HTX_get_FILTERCTRL(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9C, 0xE0, 5, pval)
#define HTX_ret_FILTERCTRL()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9C, 0xE0, 5)
#define HTX_set_FILTERCTRL(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9C, 0xE0, 5, val)

#define HTX_get_FILTER_CTRL(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9C, 0x7, 0, pval)
#define HTX_ret_FILTER_CTRL()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9C, 0x7, 0)
#define HTX_set_FILTER_CTRL(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9C, 0x7, 0, val)

#define HTX_get_CLKICTRL(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9D, 0xE0, 5, pval)
#define HTX_ret_CLKICTRL()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9D, 0xE0, 5)
#define HTX_set_CLKICTRL(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9D, 0xE0, 5, val)

#define HTX_is_I2CAGFORCECP_OFF_true()                      ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x9D, 0x10, 0x4)
#define HTX_get_I2CAGFORCECP_OFF(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9D, 0x10, 0x4, pval)
#define HTX_ret_I2CAGFORCECP_OFF()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9D, 0x10, 0x4)
#define HTX_set_I2CAGFORCECP_OFF(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9D, 0x10, 0x4, val)

#define HTX_get_ANALOG_OPEN1(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9D, 0xC, 2, pval)
#define HTX_ret_ANALOG_OPEN1()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9D, 0xC, 2)
#define HTX_set_ANALOG_OPEN1(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9D, 0xC, 2, val)

#define HTX_get_IREFINCREASE_MSB(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9D, 0x3, 0, pval)
#define HTX_ret_IREFINCREASE_MSB()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9D, 0x3, 0)
#define HTX_set_IREFINCREASE_MSB(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9D, 0x3, 0, val)

#define HTX_is_PLLLOCKED_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x9E, 0x10, 0x4)
#define HTX_get_PLLLOCKED(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9E, 0x10, 0x4, pval)
#define HTX_ret_PLLLOCKED()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9E, 0x10, 0x4)

#define HTX_get_GEAR_SELECTED(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9E, 0xE, 1, pval)
#define HTX_ret_GEAR_SELECTED()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9E, 0xE, 1)

#define HTX_is_LEADLAG_true()                               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0x9E, 0x1, 0x0)
#define HTX_get_LEADLAG(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9E, 0x1, 0x0, pval)
#define HTX_ret_LEADLAG()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9E, 0x1, 0x0)

#define HTX_get_IREFINCREASE_LSB(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0x9F, 0xFF, 0, pval)
#define HTX_ret_IREFINCREASE_LSB()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0x9F, 0xFF, 0)
#define HTX_set_IREFINCREASE_LSB(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0x9F, 0xFF, 0, val)

#define HTX_get_LOCKCOUNTDIFF(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA0, 0xFF, 0, pval)
#define HTX_ret_LOCKCOUNTDIFF()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA0, 0xFF, 0)

#define HTX_is_TERMMONRESET_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x80, 0x7)
#define HTX_get_TERMMONRESET(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x80, 0x7, pval)
#define HTX_ret_TERMMONRESET()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x80, 0x7)
#define HTX_set_TERMMONRESET(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x80, 0x7, val)

#define HTX_is_TERMPWRDWNI2C_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x40, 0x6)
#define HTX_get_TERMPWRDWNI2C(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x40, 0x6, pval)
#define HTX_ret_TERMPWRDWNI2C()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x40, 0x6)
#define HTX_set_TERMPWRDWNI2C(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x40, 0x6, val)

#define HTX_is_CH0PWRDWNI2C_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x20, 0x5)
#define HTX_get_CH0PWRDWNI2C(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x20, 0x5, pval)
#define HTX_ret_CH0PWRDWNI2C()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x20, 0x5)
#define HTX_set_CH0PWRDWNI2C(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x20, 0x5, val)

#define HTX_is_CH1PWRDWNI2C_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x10, 0x4)
#define HTX_get_CH1PWRDWNI2C(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x10, 0x4, pval)
#define HTX_ret_CH1PWRDWNI2C()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x10, 0x4)
#define HTX_set_CH1PWRDWNI2C(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x10, 0x4, val)

#define HTX_is_CH2PWRDWNI2C_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x8, 0x3)
#define HTX_get_CH2PWRDWNI2C(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x8, 0x3, pval)
#define HTX_ret_CH2PWRDWNI2C()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x8, 0x3)
#define HTX_set_CH2PWRDWNI2C(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x8, 0x3, val)

#define HTX_is_CLKDRVPWRDWNI2C_true()                       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x4, 0x2)
#define HTX_get_CLKDRVPWRDWNI2C(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x4, 0x2, pval)
#define HTX_ret_CLKDRVPWRDWNI2C()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x4, 0x2)
#define HTX_set_CLKDRVPWRDWNI2C(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA1, 0x4, 0x2, val)

#define HTX_get_TXOUTPUTLVL(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA2, 0xF8, 3, pval)
#define HTX_ret_TXOUTPUTLVL()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA2, 0xF8, 3)
#define HTX_set_TXOUTPUTLVL(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA2, 0xF8, 3, val)

#define HTX_is_TXDRVLVL_true()                              ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA2, 0x4, 0x2)
#define HTX_get_TXDRVLVL(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA2, 0x4, 0x2, pval)
#define HTX_ret_TXDRVLVL()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA2, 0x4, 0x2)
#define HTX_set_TXDRVLVL(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA2, 0x4, 0x2, val)

#define HTX_get_IDRIVE(pval)                                ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA2, 0x3, 0, pval)
#define HTX_ret_IDRIVE()                                    ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA2, 0x3, 0)
#define HTX_set_IDRIVE(val)                                 ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA2, 0x3, 0, val)

#define HTX_get_CLKTXOUTPUTLVL(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA3, 0xF8, 3, pval)
#define HTX_ret_CLKTXOUTPUTLVL()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA3, 0xF8, 3)
#define HTX_set_CLKTXOUTPUTLVL(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA3, 0xF8, 3, val)

#define HTX_is_CLKTXDRVLVL_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA3, 0x4, 0x2)
#define HTX_get_CLKTXDRVLVL(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA3, 0x4, 0x2, pval)
#define HTX_ret_CLKTXDRVLVL()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA3, 0x4, 0x2)
#define HTX_set_CLKTXDRVLVL(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA3, 0x4, 0x2, val)

#define HTX_get_CLKIDRIVE(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA3, 0x3, 0, pval)
#define HTX_ret_CLKIDRIVE()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA3, 0x3, 0)
#define HTX_set_CLKIDRIVE(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA3, 0x3, 0, val)

#define HTX_is_CHANSELLBKI2C_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x80, 0x7)
#define HTX_get_CHANSELLBKI2C(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x80, 0x7, pval)
#define HTX_ret_CHANSELLBKI2C()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x80, 0x7)
#define HTX_set_CHANSELLBKI2C(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x80, 0x7, val)

#define HTX_is_CLOCK_DIVIDE_RESET_true()                    ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x40, 0x6)
#define HTX_get_CLOCK_DIVIDE_RESET(pval)                    ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x40, 0x6, pval)
#define HTX_ret_CLOCK_DIVIDE_RESET()                        ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x40, 0x6)
#define HTX_set_CLOCK_DIVIDE_RESET(val)                     ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x40, 0x6, val)

#define HTX_is_LBKLOGICRESETI2C_true()                      ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x10, 0x4)
#define HTX_get_LBKLOGICRESETI2C(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x10, 0x4, pval)
#define HTX_ret_LBKLOGICRESETI2C()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x10, 0x4)
#define HTX_set_LBKLOGICRESETI2C(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x10, 0x4, val)

#define HTX_is_LBKPWRDWNI2C_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x8, 0x3)
#define HTX_get_LBKPWRDWNI2C(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x8, 0x3, pval)
#define HTX_ret_LBKPWRDWNI2C()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x8, 0x3)
#define HTX_set_LBKPWRDWNI2C(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x8, 0x3, val)

#define HTX_is_OSCPWRDWNI2C_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x4, 0x2)
#define HTX_get_OSCPWRDWNI2C(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x4, 0x2, pval)
#define HTX_ret_OSCPWRDWNI2C()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x4, 0x2)
#define HTX_set_OSCPWRDWNI2C(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x4, 0x2, val)

#define HTX_is_PLLPWRDWNI2C_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x2, 0x1)
#define HTX_get_PLLPWRDWNI2C(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x2, 0x1, pval)
#define HTX_ret_PLLPWRDWNI2C()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x2, 0x1)
#define HTX_set_PLLPWRDWNI2C(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA4, 0x2, 0x1, val)

#define HTX_get_LBCHANSEL(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA5, 0xC0, 6, pval)
#define HTX_ret_LBCHANSEL()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA5, 0xC0, 6)
#define HTX_set_LBCHANSEL(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA5, 0xC0, 6, val)

#define HTX_is_LBTESTSTART_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA5, 0x20, 0x5)
#define HTX_get_LBTESTSTART(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA5, 0x20, 0x5, pval)
#define HTX_ret_LBTESTSTART()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA5, 0x20, 0x5)
#define HTX_set_LBTESTSTART(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA5, 0x20, 0x5, val)

#define HTX_get_LBRUNCNTSEL(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA5, 0x18, 3, pval)
#define HTX_ret_LBRUNCNTSEL()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA5, 0x18, 3)
#define HTX_set_LBRUNCNTSEL(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA5, 0x18, 3, val)

#define HTX_get_LBPATDATAMODE(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA5, 0x6, 1, pval)
#define HTX_ret_LBPATDATAMODE()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA5, 0x6, 1)
#define HTX_set_LBPATDATAMODE(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA5, 0x6, 1, val)

#define HTX_get_LBTESTPAT_MSB(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA6, 0xFF, 0, pval)
#define HTX_ret_LBTESTPAT_MSB()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA6, 0xFF, 0)
#define HTX_set_LBTESTPAT_MSB(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA6, 0xFF, 0, val)

#define HTX_get_LBTESTPAT_MID_1(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA7, 0xFF, 0, pval)
#define HTX_ret_LBTESTPAT_MID_1()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA7, 0xFF, 0)
#define HTX_set_LBTESTPAT_MID_1(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA7, 0xFF, 0, val)

#define HTX_get_LBTESTPAT_MID_2(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA8, 0xFF, 0, pval)
#define HTX_ret_LBTESTPAT_MID_2()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA8, 0xFF, 0)
#define HTX_set_LBTESTPAT_MID_2(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA8, 0xFF, 0, val)

#define HTX_get_LBTESTPAT_LSB(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA9, 0xFC, 2, pval)
#define HTX_ret_LBTESTPAT_LSB()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA9, 0xFC, 2)
#define HTX_set_LBTESTPAT_LSB(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA9, 0xFC, 2, val)

#define HTX_is_LB_FORCE_BITLOC_true()                       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xA9, 0x2, 0x1)
#define HTX_get_LB_FORCE_BITLOC(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xA9, 0x2, 0x1, pval)
#define HTX_ret_LB_FORCE_BITLOC()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xA9, 0x2, 0x1)
#define HTX_set_LB_FORCE_BITLOC(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xA9, 0x2, 0x1, val)

#define HTX_is_LBFORCEPH_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAA, 0x80, 0x7)
#define HTX_get_LBFORCEPH(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAA, 0x80, 0x7, pval)
#define HTX_ret_LBFORCEPH()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAA, 0x80, 0x7)
#define HTX_set_LBFORCEPH(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAA, 0x80, 0x7, val)

#define HTX_get_LBFORCEPHSEL(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAA, 0x60, 5, pval)
#define HTX_ret_LBFORCEPHSEL()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAA, 0x60, 5)
#define HTX_set_LBFORCEPHSEL(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAA, 0x60, 5, val)

#define HTX_get_LBBITLOCSEL(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAA, 0x1F, 0, pval)
#define HTX_ret_LBBITLOCSEL()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAA, 0x1F, 0)
#define HTX_set_LBBITLOCSEL(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAA, 0x1F, 0, val)

#define HTX_is_LBERRCNTMODE_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAB, 0x80, 0x7)
#define HTX_get_LBERRCNTMODE(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAB, 0x80, 0x7, pval)
#define HTX_ret_LBERRCNTMODE()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAB, 0x80, 0x7)
#define HTX_set_LBERRCNTMODE(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAB, 0x80, 0x7, val)

#define HTX_get_LBREFDLYNUM(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAB, 0x70, 4, pval)
#define HTX_ret_LBREFDLYNUM()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAB, 0x70, 4)
#define HTX_set_LBREFDLYNUM(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAB, 0x70, 4, val)

#define HTX_get_ERR_NUM_MSB(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAC, 0xFF, 0, pval)
#define HTX_ret_ERR_NUM_MSB()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAC, 0xFF, 0)

#define HTX_get_ERR_NUM_LSB(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAD, 0xFF, 0, pval)
#define HTX_ret_ERR_NUM_LSB()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAD, 0xFF, 0)

#define HTX_is_TEST_OVER_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAE, 0x80, 0x7)
#define HTX_get_TEST_OVER(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAE, 0x80, 0x7, pval)
#define HTX_ret_TEST_OVER()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAE, 0x80, 0x7)

#define HTX_is_TEST_FAIL_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAE, 0x40, 0x6)
#define HTX_get_TEST_FAIL(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAE, 0x40, 0x6, pval)
#define HTX_ret_TEST_FAIL()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAE, 0x40, 0x6)

#define HTX_is_LB_GOODPHASE_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAE, 0x20, 0x5)
#define HTX_get_LB_GOODPHASE(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAE, 0x20, 0x5, pval)
#define HTX_ret_LB_GOODPHASE()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAE, 0x20, 0x5)

#define HTX_is_HDCP_DESIRED_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x80, 0x7)
#define HTX_get_HDCP_DESIRED(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x80, 0x7, pval)
#define HTX_ret_HDCP_DESIRED()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x80, 0x7)
#define HTX_set_HDCP_DESIRED(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x80, 0x7, val)

#define HTX_is_AN_OVERRIDE_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x40, 0x6)
#define HTX_get_AN_OVERRIDE(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x40, 0x6, pval)
#define HTX_ret_AN_OVERRIDE()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x40, 0x6)
#define HTX_set_AN_OVERRIDE(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x40, 0x6, val)

#define HTX_is_SIG_CHECK_EN_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x20, 0x5)
#define HTX_get_SIG_CHECK_EN(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x20, 0x5, pval)
#define HTX_ret_SIG_CHECK_EN()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x20, 0x5)
#define HTX_set_SIG_CHECK_EN(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x20, 0x5, val)

#define HTX_is_FRAME_ENC_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x10, 0x4)
#define HTX_get_FRAME_ENC(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x10, 0x4, pval)
#define HTX_ret_FRAME_ENC()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x10, 0x4)
#define HTX_set_FRAME_ENC(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x10, 0x4, val)

#define HTX_is_EPP_PROG_EN_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x8, 0x3)
#define HTX_get_EPP_PROG_EN(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x8, 0x3, pval)
#define HTX_ret_EPP_PROG_EN()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x8, 0x3)
#define HTX_set_EPP_PROG_EN(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x8, 0x3, val)

#define HTX_is_HDMI_MODE_SEL_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x4, 0x2)
#define HTX_get_HDMI_MODE_SEL(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x4, 0x2, pval)
#define HTX_ret_HDMI_MODE_SEL()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x4, 0x2)
#define HTX_set_HDMI_MODE_SEL(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x4, 0x2, val)

#define HTX_is_EXT_HDMI_MODE_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x2, 0x1)
#define HTX_get_EXT_HDMI_MODE(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x2, 0x1, pval)
#define HTX_ret_EXT_HDMI_MODE()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x2, 0x1)
#define HTX_set_EXT_HDMI_MODE(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x2, 0x1, val)

#define HTX_is_HDCPVUMASK_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x1, 0x0)
#define HTX_get_HDCPVUMASK(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x1, 0x0, pval)
#define HTX_ret_HDCPVUMASK()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x1, 0x0)
#define HTX_set_HDCPVUMASK(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xAF, 0x1, 0x0, val)

#define HTX_get_AN_0(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB0, 0xFF, 0, pval)
#define HTX_ret_AN_0()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB0, 0xFF, 0)

#define HTX_get_AN_1(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB1, 0xFF, 0, pval)
#define HTX_ret_AN_1()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB1, 0xFF, 0)

#define HTX_get_AN_2(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB2, 0xFF, 0, pval)
#define HTX_ret_AN_2()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB2, 0xFF, 0)

#define HTX_get_AN_3(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB3, 0xFF, 0, pval)
#define HTX_ret_AN_3()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB3, 0xFF, 0)

#define HTX_get_AN_4(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB4, 0xFF, 0, pval)
#define HTX_ret_AN_4()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB4, 0xFF, 0)

#define HTX_get_AN_5(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB5, 0xFF, 0, pval)
#define HTX_ret_AN_5()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB5, 0xFF, 0)

#define HTX_get_AN_6(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB6, 0xFF, 0, pval)
#define HTX_ret_AN_6()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB6, 0xFF, 0)

#define HTX_get_AN_7(pval)                                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB7, 0xFF, 0, pval)
#define HTX_ret_AN_7()                                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB7, 0xFF, 0)

#define HTX_is_SIG_CHECK_FAIL_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xB8, 0x80, 0x7)
#define HTX_get_SIG_CHECK_FAIL(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB8, 0x80, 0x7, pval)
#define HTX_ret_SIG_CHECK_FAIL()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB8, 0x80, 0x7)

#define HTX_is_ENC_ON_true()                                ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xB8, 0x40, 0x6)
#define HTX_get_ENC_ON(pval)                                ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB8, 0x40, 0x6, pval)
#define HTX_ret_ENC_ON()                                    ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB8, 0x40, 0x6)

#define HTX_is_INT_HDMI_MODE_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xB8, 0x20, 0x5)
#define HTX_get_INT_HDMI_MODE(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB8, 0x20, 0x5, pval)
#define HTX_ret_INT_HDMI_MODE()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB8, 0x20, 0x5)

#define HTX_is_KEYS_READ_ERROR_true()                       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xB8, 0x10, 0x4)
#define HTX_get_KEYS_READ_ERROR(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB8, 0x10, 0x4, pval)
#define HTX_ret_KEYS_READ_ERROR()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB8, 0x10, 0x4)

#define HTX_is_OUTPUTTESTEN_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x80, 0x7)
#define HTX_get_OUTPUTTESTEN(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x80, 0x7, pval)
#define HTX_ret_OUTPUTTESTEN()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x80, 0x7)
#define HTX_set_OUTPUTTESTEN(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x80, 0x7, val)

#define HTX_is_INPUTTESTEN_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x40, 0x6)
#define HTX_get_INPUTTESTEN(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x40, 0x6, pval)
#define HTX_ret_INPUTTESTEN()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x40, 0x6)
#define HTX_set_INPUTTESTEN(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x40, 0x6, val)

#define HTX_is_INPUTTESTGP_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x20, 0x5)
#define HTX_get_INPUTTESTGP(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x20, 0x5, pval)
#define HTX_ret_INPUTTESTGP()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x20, 0x5)
#define HTX_set_INPUTTESTGP(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x20, 0x5, val)

#define HTX_get_TESTSEL(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x1F, 0, pval)
#define HTX_ret_TESTSEL()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x1F, 0)
#define HTX_set_TESTSEL(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xB9, 0x1F, 0, val)

#define HTX_get_CLK_DELAY(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBA, 0xE0, 5, pval)
#define HTX_ret_CLK_DELAY()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBA, 0xE0, 5)
#define HTX_set_CLK_DELAY(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xBA, 0xE0, 5, val)

#define HTX_is_INT_EPP_ON_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xBA, 0x10, 0x4)
#define HTX_get_INT_EPP_ON(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBA, 0x10, 0x4, pval)
#define HTX_ret_INT_EPP_ON()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBA, 0x10, 0x4)
#define HTX_set_INT_EPP_ON(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xBA, 0x10, 0x4, val)

#define HTX_is_EPP_CONFIG_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xBA, 0x8, 0x3)
#define HTX_get_EPP_CONFIG(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBA, 0x8, 0x3, pval)
#define HTX_ret_EPP_CONFIG()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBA, 0x8, 0x3)
#define HTX_set_EPP_CONFIG(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xBA, 0x8, 0x3, val)

#define HTX_get_HDCP_OPEN_1(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBA, 0x7, 0, pval)
#define HTX_ret_HDCP_OPEN_1()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBA, 0x7, 0)
#define HTX_set_HDCP_OPEN_1(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xBA, 0x7, 0, val)

#define HTX_get_EPP_PROG_PWD(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBB, 0xFF, 0, pval)
#define HTX_ret_EPP_PROG_PWD()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBB, 0xFF, 0)
#define HTX_set_EPP_PROG_PWD(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xBB, 0xFF, 0, val)

#define HTX_get_EPP_SIG_MSB(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBC, 0xFF, 0, pval)
#define HTX_ret_EPP_SIG_MSB()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBC, 0xFF, 0)

#define HTX_get_EPP_SIG_LSB(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBD, 0xFF, 0, pval)
#define HTX_ret_EPP_SIG_LSB()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBD, 0xFF, 0)

#define HTX_is_BCAPS_HDMI_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x80, 0x7)
#define HTX_get_BCAPS_HDMI(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x80, 0x7, pval)
#define HTX_ret_BCAPS_HDMI()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x80, 0x7)

#define HTX_get_BCAPS(pval)                                 ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x1C, 0, pval)
#define HTX_ret_BCAPS()                                     ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x1C, 0)

#define HTX_is_REPEATER_true()                              ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x40, 0x6)
#define HTX_get_REPEATER(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x40, 0x6, pval)
#define HTX_ret_REPEATER()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x40, 0x6)

#define HTX_is_KSV_FIFO_READY_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x20, 0x5)
#define HTX_get_KSV_FIFO_READY(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x20, 0x5, pval)
#define HTX_ret_KSV_FIFO_READY()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x20, 0x5)

#define HTX_is_HDCP_SUPPORT_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x2, 0x1)
#define HTX_get_HDCP_SUPPORT(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x2, 0x1, pval)
#define HTX_ret_HDCP_SUPPORT()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x2, 0x1)

#define HTX_is_FAST_HDCP_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x1, 0x0)
#define HTX_get_FAST_HDCP(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x1, 0x0, pval)
#define HTX_ret_FAST_HDCP()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xBE, 0x1, 0x0)

#define HTX_get_BKSV(pval)                                  ATV_I2CGetMultiField(HTX_MAIN_MAP_ADDR, 0xBF, 5, pval)

#define HTX_get_EDID_SEGMENT(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC4, 0xFF, 0, pval)
#define HTX_ret_EDID_SEGMENT()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC4, 0xFF, 0)
#define HTX_set_EDID_SEGMENT(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC4, 0xFF, 0, val)

#define HTX_is_ERROR_FLAG_true()                            ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x80, 0x7)
#define HTX_get_ERROR_FLAG(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x80, 0x7, pval)
#define HTX_ret_ERROR_FLAG()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x80, 0x7)
#define HTX_set_ERROR_FLAG(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x80, 0x7, val)

#define HTX_is_AN_STOP_true()                               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x40, 0x6)
#define HTX_get_AN_STOP(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x40, 0x6, pval)
#define HTX_ret_AN_STOP()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x40, 0x6)
#define HTX_set_AN_STOP(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x40, 0x6, val)

#define HTX_is_HDCP_ENABLED_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x20, 0x5)
#define HTX_get_HDCP_ENABLED(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x20, 0x5, pval)
#define HTX_ret_HDCP_ENABLED()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x20, 0x5)
#define HTX_set_HDCP_ENABLED(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x20, 0x5, val)

#define HTX_is_EDID_READY_FLAG_true()                       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x10, 0x4)
#define HTX_get_EDID_READY_FLAG(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x10, 0x4, pval)
#define HTX_ret_EDID_READY_FLAG()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x10, 0x4)
#define HTX_set_EDID_READY_FLAG(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x10, 0x4, val)

#define HTX_is_I2C_INTERRUPT_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x8, 0x3)
#define HTX_get_I2C_INTERRUPT(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x8, 0x3, pval)
#define HTX_ret_I2C_INTERRUPT()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x8, 0x3)
#define HTX_set_I2C_INTERRUPT(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x8, 0x3, val)

#define HTX_is_RI_FLAG_true()                               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x4, 0x2)
#define HTX_get_RI_FLAG(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x4, 0x2, pval)
#define HTX_ret_RI_FLAG()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x4, 0x2)
#define HTX_set_RI_FLAG(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x4, 0x2, val)

#define HTX_is_BKSV_UPDATE_FLAG_true()                      ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x2, 0x1)
#define HTX_get_BKSV_UPDATE_FLAG(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x2, 0x1, pval)
#define HTX_ret_BKSV_UPDATE_FLAG()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x2, 0x1)
#define HTX_set_BKSV_UPDATE_FLAG(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x2, 0x1, val)

#define HTX_is_PJ_FLAG_true()                               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x1, 0x0)
#define HTX_get_PJ_FLAG(pval)                               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x1, 0x0, pval)
#define HTX_ret_PJ_FLAG()                                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x1, 0x0)
#define HTX_set_PJ_FLAG(val)                                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC5, 0x1, 0x0, val)


#define HTX_is_BKSV_FLAG_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xC7, 0x80, 0x7)
#define HTX_get_BKSV_FLAG(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC7, 0x80, 0x7, pval)
#define HTX_ret_BKSV_FLAG()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC7, 0x80, 0x7)
#define HTX_set_BKSV_FLAG(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC7, 0x80, 0x7, val)

#define HTX_get_BKSV_COUNT(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC7, 0x7F, 0, pval)
#define HTX_ret_BKSV_COUNT()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC7, 0x7F, 0)
#define HTX_set_BKSV_COUNT(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC7, 0x7F, 0, val)

#define HTX_get_HDCP_CONTROLLER_ERROR(pval)                 ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC8, 0xF0, 4, pval)
#define HTX_ret_HDCP_CONTROLLER_ERROR()                     ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC8, 0xF0, 4)

#define HTX_get_HDCP_CONTROLLER_STATE(pval)                 ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC8, 0xF, 0, pval)
#define HTX_ret_HDCP_CONTROLLER_STATE()                     ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC8, 0xF, 0)

#define HTX_is_EDID_READ_EN_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xC9, 0x10, 0x4)
#define HTX_get_EDID_READ_EN(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC9, 0x10, 0x4, pval)
#define HTX_ret_EDID_READ_EN()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC9, 0x10, 0x4)
#define HTX_set_EDID_READ_EN(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC9, 0x10, 0x4, val)

#define HTX_get_EDID_TRYS(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xC9, 0xF, 0, pval)
#define HTX_ret_EDID_TRYS()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xC9, 0xF, 0)
#define HTX_set_EDID_TRYS(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xC9, 0xF, 0, val)

#define HTX_get_HDCP_BSTATUS(pval)                          ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0xCA, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_HDCP_BSTATUS()                              ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0xCA, 0xFF, 0xFF, 0, 2)

#define HTX_is_IROM_BIST_PASS_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xCC, 0x4, 0x2)
#define HTX_get_IROM_BIST_PASS(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xCC, 0x4, 0x2, pval)
#define HTX_ret_IROM_BIST_PASS()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xCC, 0x4, 0x2)

#define HTX_is_IROM_BIST_DONE_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xCC, 0x2, 0x1)
#define HTX_get_IROM_BIST_DONE(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xCC, 0x2, 0x1, pval)
#define HTX_ret_IROM_BIST_DONE()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xCC, 0x2, 0x1)

#define HTX_is_IROM_BIST_ENABLE_true()                      ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xCC, 0x1, 0x0)
#define HTX_get_IROM_BIST_ENABLE(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xCC, 0x1, 0x0, pval)
#define HTX_ret_IROM_BIST_ENABLE()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xCC, 0x1, 0x0)

#define HTX_is_NC_AVI_BYTE1_7_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xCD, 0x80, 0x7)
#define HTX_get_NC_AVI_BYTE1_7(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xCD, 0x80, 0x7, pval)
#define HTX_ret_NC_AVI_BYTE1_7()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xCD, 0x80, 0x7)
#define HTX_set_NC_AVI_BYTE1_7(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xCD, 0x80, 0x7, val)

#define HTX_get_NC_AVI_BYTE3_7_2(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xCD, 0x7E, 1, pval)
#define HTX_ret_NC_AVI_BYTE3_7_2()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xCD, 0x7E, 1)
#define HTX_set_NC_AVI_BYTE3_7_2(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xCD, 0x7E, 1, val)

#define HTX_get_NC_AVI_BYTE5_7_4(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xCE, 0xF0, 4, pval)
#define HTX_ret_NC_AVI_BYTE5_7_4()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xCE, 0xF0, 4)
#define HTX_set_NC_AVI_BYTE5_7_4(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xCE, 0xF0, 4, val)

#define HTX_get_NC_UDP_ID(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xCF, 0xFF, 0, pval)
#define HTX_ret_NC_UDP_ID()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xCF, 0xFF, 0)
#define HTX_set_NC_UDP_ID(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xCF, 0xFF, 0, val)

#define HTX_is_DDR_CLK_SEL_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x80, 0x7)
#define HTX_get_DDR_CLK_SEL(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x80, 0x7, pval)
#define HTX_ret_DDR_CLK_SEL()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x80, 0x7)
#define HTX_set_DDR_CLK_SEL(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x80, 0x7, val)

#define HTX_get_DELAY_DDR(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x70, 4, pval)
#define HTX_ret_DELAY_DDR()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x70, 4)
#define HTX_set_DELAY_DDR(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x70, 4, val)

#define HTX_get_SYNC_PULSE_SEL(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD0, 0xC, 2, pval)
#define HTX_ret_SYNC_PULSE_SEL()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD0, 0xC, 2)
#define HTX_set_SYNC_PULSE_SEL(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD0, 0xC, 2, val)

#define HTX_is_TIMING_GEN_SEQ_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x2, 0x1)
#define HTX_get_TIMING_GEN_SEQ(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x2, 0x1, pval)
#define HTX_ret_TIMING_GEN_SEQ()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x2, 0x1)
#define HTX_set_TIMING_GEN_SEQ(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x2, 0x1, val)

#define HTX_is_RXSENSE_FILT_ON_true()                       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x1, 0x0)
#define HTX_get_RXSENSE_FILT_ON(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x1, 0x0, pval)
#define HTX_ret_RXSENSE_FILT_ON()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x1, 0x0)
#define HTX_set_RXSENSE_FILT_ON(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD0, 0x1, 0x0, val)

#define HTX_get_SERENABLE(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD1, 0xE0, 5, pval)
#define HTX_ret_SERENABLE()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD1, 0xE0, 5)
#define HTX_set_SERENABLE(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD1, 0xE0, 5, val)

#define HTX_get_TRANSDRVENABLE(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD1, 0x1C, 2, pval)
#define HTX_ret_TRANSDRVENABLE()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD1, 0x1C, 2)
#define HTX_set_TRANSDRVENABLE(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD1, 0x1C, 2, val)

#define HTX_is_CLKSERENABLE_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD1, 0x2, 0x1)
#define HTX_get_CLKSERENABLE(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD1, 0x2, 0x1, pval)
#define HTX_ret_CLKSERENABLE()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD1, 0x2, 0x1)
#define HTX_set_CLKSERENABLE(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD1, 0x2, 0x1, val)

#define HTX_is_CLKDRVENABLE_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD1, 0x1, 0x0)
#define HTX_get_CLKDRVENABLE(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD1, 0x1, 0x0, pval)
#define HTX_ret_CLKDRVENABLE()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD1, 0x1, 0x0)
#define HTX_set_CLKDRVENABLE(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD1, 0x1, 0x0, val)

#define HTX_get_TXOUTPUTLVLCH2(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD2, 0xF8, 3, pval)
#define HTX_ret_TXOUTPUTLVLCH2()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD2, 0xF8, 3)
#define HTX_set_TXOUTPUTLVLCH2(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD2, 0xF8, 3, val)

#define HTX_is_TXDRVLVLCH2_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD2, 0x4, 0x2)
#define HTX_get_TXDRVLVLCH2(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD2, 0x4, 0x2, pval)
#define HTX_ret_TXDRVLVLCH2()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD2, 0x4, 0x2)
#define HTX_set_TXDRVLVLCH2(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD2, 0x4, 0x2, val)

#define HTX_get_SERPARTIALCH2(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD2, 0x3, 0, pval)
#define HTX_ret_SERPARTIALCH2()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD2, 0x3, 0)
#define HTX_set_SERPARTIALCH2(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD2, 0x3, 0, val)

#define HTX_get_TXOUTPUTLVLCH1(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD3, 0xF8, 3, pval)
#define HTX_ret_TXOUTPUTLVLCH1()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD3, 0xF8, 3)
#define HTX_set_TXOUTPUTLVLCH1(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD3, 0xF8, 3, val)

#define HTX_is_TXDRVLVLCH1_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD3, 0x4, 0x2)
#define HTX_get_TXDRVLVLCH1(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD3, 0x4, 0x2, pval)
#define HTX_ret_TXDRVLVLCH1()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD3, 0x4, 0x2)
#define HTX_set_TXDRVLVLCH1(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD3, 0x4, 0x2, val)

#define HTX_get_SERPARTIALCH1(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD3, 0x3, 0, pval)
#define HTX_ret_SERPARTIALCH1()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD3, 0x3, 0)
#define HTX_set_SERPARTIALCH1(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD3, 0x3, 0, val)

#define HTX_get_TXOUTPUTLVLCH0(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD4, 0xF8, 3, pval)
#define HTX_ret_TXOUTPUTLVLCH0()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD4, 0xF8, 3)
#define HTX_set_TXOUTPUTLVLCH0(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD4, 0xF8, 3, val)

#define HTX_is_TXDRVLVLCH0_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD4, 0x4, 0x2)
#define HTX_get_TXDRVLVLCH0(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD4, 0x4, 0x2, pval)
#define HTX_ret_TXDRVLVLCH0()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD4, 0x4, 0x2)
#define HTX_set_TXDRVLVLCH0(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD4, 0x4, 0x2, val)

#define HTX_get_SERPARTIALCH0(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD4, 0x3, 0, pval)
#define HTX_ret_SERPARTIALCH0()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD4, 0x3, 0)
#define HTX_set_SERPARTIALCH0(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD4, 0x3, 0, val)

#define HTX_get_CLKPARTIAL(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD5, 0xC0, 6, pval)
#define HTX_ret_CLKPARTIAL()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD5, 0xC0, 6)
#define HTX_set_CLKPARTIAL(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD5, 0xC0, 6, val)

#define HTX_is_OUTPUT_DRV_STYLE_true()                      ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x20, 0x5)
#define HTX_get_OUTPUT_DRV_STYLE(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x20, 0x5, pval)
#define HTX_ret_OUTPUT_DRV_STYLE()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x20, 0x5)
#define HTX_set_OUTPUT_DRV_STYLE(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x20, 0x5, val)

#define HTX_is_STEP_TURNONI2C_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x10, 0x4)
#define HTX_get_STEP_TURNONI2C(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x10, 0x4, pval)
#define HTX_ret_STEP_TURNONI2C()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x10, 0x4)
#define HTX_set_STEP_TURNONI2C(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x10, 0x4, val)

#define HTX_get_HIGH_VSYNC(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD5, 0xC, 2, pval)
#define HTX_ret_HIGH_VSYNC()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD5, 0xC, 2)
#define HTX_set_HIGH_VSYNC(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD5, 0xC, 2, val)

#define HTX_is_VIDEO_OFFSET_CTL_true()                      ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x2, 0x1)
#define HTX_get_VIDEO_OFFSET_CTL(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x2, 0x1, pval)
#define HTX_ret_VIDEO_OFFSET_CTL()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x2, 0x1)
#define HTX_set_VIDEO_OFFSET_CTL(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x2, 0x1, val)

#define HTX_is_BLACK_LEVEL_OUTPUT_true()                    ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x1, 0x0)
#define HTX_get_BLACK_LEVEL_OUTPUT(pval)                    ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x1, 0x0, pval)
#define HTX_ret_BLACK_LEVEL_OUTPUT()                        ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x1, 0x0)
#define HTX_set_BLACK_LEVEL_OUTPUT(val)                     ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD5, 0x1, 0x0, val)

#define HTX_is_NEW_ANALOG_OPEN0_7_5_true()                  ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x80, 0x7)
#define HTX_get_NEW_ANALOG_OPEN0_7_5(pval)                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x80, 0x7, pval)
#define HTX_ret_NEW_ANALOG_OPEN0_7_5()                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x80, 0x7)
#define HTX_set_NEW_ANALOG_OPEN0_7_5(val)                   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x80, 0x7, val)


#define HTX_is_HPD_OVERRIDE_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x40, 0x6)
#define HTX_get_HPD_OVERRIDE(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x40, 0x6, pval)
#define HTX_ret_HPD_OVERRIDE()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x40, 0x6)
#define HTX_set_HPD_OVERRIDE(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x40, 0x6, val)

#define HTX_is_HPD_CONTROL_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD6, 0xC0, 0x6)
#define HTX_get_HPD_CONTROL(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD6, 0xC0, 0x6, pval)
#define HTX_ret_HPD_CONTROL()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD6, 0xC0, 0x6)
#define HTX_set_HPD_CONTROL(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD6, 0xC0, 0x6, val)


#define HTX_is_SOFT_TURNON_RESET_true()                     ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x10, 0x4)
#define HTX_get_SOFT_TURNON_RESET(pval)                     ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x10, 0x4, pval)
#define HTX_ret_SOFT_TURNON_RESET()                         ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x10, 0x4)
#define HTX_set_SOFT_TURNON_RESET(val)                      ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x10, 0x4, val)

#define HTX_is_SOFT_TMDS_CLOCK_TURN_ON_true()               ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x8, 0x3)
#define HTX_get_SOFT_TMDS_CLOCK_TURN_ON(pval)               ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x8, 0x3, pval)
#define HTX_ret_SOFT_TMDS_CLOCK_TURN_ON()                   ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x8, 0x3)
#define HTX_set_SOFT_TMDS_CLOCK_TURN_ON(val)                ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x8, 0x3, val)

#define HTX_get_HDCP_WAIT_TIME_CONTROL(pval)                ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x6, 1, pval)
#define HTX_ret_HDCP_WAIT_TIME_CONTROL()                    ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x6, 1)
#define HTX_set_HDCP_WAIT_TIME_CONTROL(val)                 ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x6, 1, val)

#define HTX_is_AUDIO_AND_VIDEO_INPUT_GATING_true()          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x1, 0x0)
#define HTX_get_AUDIO_AND_VIDEO_INPUT_GATING(pval)          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x1, 0x0, pval)
#define HTX_ret_AUDIO_AND_VIDEO_INPUT_GATING()              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x1, 0x0)
#define HTX_set_AUDIO_AND_VIDEO_INPUT_GATING(val)           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xD6, 0x1, 0x0, val)

#define HTX_get_SA_HS_PLA(pval)                             ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0xD7, 0xFF, 0xC0, 6, 2, pval)
#define HTX_ret_SA_HS_PLA()                                 ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0xD7, 0xFF, 0xC0, 6, 2)
#define HTX_set_SA_HS_PLA(val)                              ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0xD7, 0xFF, 0xC0, 6, 2, val)

#define HTX_get_SA_HS_DUR(pval)                             ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0xD8, 0x3F, 0xF0, 4, 2, pval)
#define HTX_ret_SA_HS_DUR()                                 ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0xD8, 0x3F, 0xF0, 4, 2)
#define HTX_set_SA_HS_DUR(val)                              ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0xD8, 0x3F, 0xF0, 4, 2, val)

#define HTX_get_SA_VS_PLA(pval)                             ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0xD9, 0xF, 0xFC, 2, 2, pval)
#define HTX_ret_SA_VS_PLA()                                 ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0xD9, 0xF, 0xFC, 2, 2)
#define HTX_set_SA_VS_PLA(val)                              ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0xD9, 0xF, 0xFC, 2, 2, val)

#define HTX_get_SA_VS_DUR(pval)                             ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0xDA, 0x3, 0xFF, 0, 2, pval)
#define HTX_ret_SA_VS_DUR()                                 ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0xDA, 0x3, 0xFF, 0, 2)
#define HTX_set_SA_VS_DUR(val)                              ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0xDA, 0x3, 0xFF, 0, 2, val)

#define HTX_get_SA_OFFSET(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xDC, 0xE0, 5, pval)
#define HTX_ret_SA_OFFSET()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xDC, 0xE0, 5)
#define HTX_set_SA_OFFSET(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xDC, 0xE0, 5, val)

#define HTX_get_SA_VS_WINDOW(pval)                          ATV_I2CGetField32(HTX_MAIN_MAP_ADDR, 0xDC, 0x1F, 0xF0, 4, 2, pval)
#define HTX_ret_SA_VS_WINDOW()                              ATV_I2CReadField32(HTX_MAIN_MAP_ADDR, 0xDC, 0x1F, 0xF0, 4, 2)
#define HTX_set_SA_VS_WINDOW(val)                           ATV_I2CWriteField32(HTX_MAIN_MAP_ADDR, 0xDC, 0x1F, 0xF0, 4, 2, val)

#define HTX_is_IINJECT_CTRL_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x80, 0x7)
#define HTX_get_IINJECT_CTRL(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x80, 0x7, pval)
#define HTX_ret_IINJECT_CTRL()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x80, 0x7)
#define HTX_set_IINJECT_CTRL(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x80, 0x7, val)

#define HTX_is_SERENABLEDDUMMY_true()                       ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x40, 0x6)
#define HTX_get_SERENABLEDDUMMY(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x40, 0x6, pval)
#define HTX_ret_SERENABLEDDUMMY()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x40, 0x6)
#define HTX_set_SERENABLEDDUMMY(val)                        ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x40, 0x6, val)

#define HTX_get_TMDS_DRIVER_TEST0(pval)                     ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x3E, 1, pval)
#define HTX_ret_TMDS_DRIVER_TEST0()                         ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x3E, 1)
#define HTX_set_TMDS_DRIVER_TEST0(val)                      ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x3E, 1, val)

#define HTX_is_TMDS_CLOCK_INVERSION_true()                  ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x8, 0x3)
#define HTX_get_TMDS_CLOCK_INVERSION(pval)                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x8, 0x3, pval)
#define HTX_ret_TMDS_CLOCK_INVERSION()                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x8, 0x3)
#define HTX_set_TMDS_CLOCK_INVERSION(val)                   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x8, 0x3, val)

#define HTX_is_VCTRL_PWRDWN_true()                          ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x1, 0x0)
#define HTX_get_VCTRL_PWRDWN(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x1, 0x0, pval)
#define HTX_ret_VCTRL_PWRDWN()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x1, 0x0)
#define HTX_set_VCTRL_PWRDWN(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xDE, 0x1, 0x0, val)

#define HTX_get_ARC_MODE(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xDF, 0x80, 7, pval)
#define HTX_ret_ARC_MODE()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xDF, 0x80, 7)
#define HTX_set_ARC_MODE(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xDF, 0x80, 7, val)

#define HTX_get_ARC_DISABLE(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xDF, 0x1, 0, pval)
#define HTX_ret_ARC_DISABLE()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xDF, 0x1, 0)
#define HTX_set_ARC_DISABLE(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xDF, 0x1, 0, val)

#define HTX_get_INVERTED_SPDIF_OUT(pval)                    ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xE0, 0x20, 5, pval)
#define HTX_ret_INVERTED_SPDIF_OUT()                        ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xE0, 0x20, 5)
#define HTX_set_INVERTED_SPDIF_OUT(val)                     ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xE0, 0x20, 5, val)

#define HTX_get_HPD_PULLDOWN(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xE0, 0x1, 0, pval)
#define HTX_ret_HPD_PULLDOWN()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xE0, 0x1, 0)
#define HTX_set_HPD_PULLDOWN(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xE0, 0x1, 0, val)

#define HTX_get_CEC_ID(pval)                                ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xE1, 0xFF, 0, pval)
#define HTX_ret_CEC_ID()                                    ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xE1, 0xFF, 0)
#define HTX_set_CEC_ID(val)                                 ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xE1, 0xFF, 0, val)

#define HTX_get_OTP_CONFIG(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xE2, 0xE, 1, pval)
#define HTX_ret_OTP_CONFIG()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xE2, 0xE, 1)
#define HTX_set_OTP_CONFIG(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xE2, 0xE, 1, val)

#define HTX_is_CEC_POWET_DOWN_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xE2, 0x1, 0x0)
#define HTX_get_CEC_POWET_DOWN(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xE2, 0x1, 0x0, pval)
#define HTX_ret_CEC_POWET_DOWN()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xE2, 0x1, 0x0)
#define HTX_set_CEC_POWET_DOWN(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xE2, 0x1, 0x0, val)

#define HTX_is_PLL_DIV_OVERRIDE_true()                      ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xE3, 0x80, 0x7)
#define HTX_get_PLL_DIV_OVERRIDE(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xE3, 0x80, 0x7, pval)
#define HTX_ret_PLL_DIV_OVERRIDE()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xE3, 0x80, 0x7)
#define HTX_set_PLL_DIV_OVERRIDE(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xE3, 0x80, 0x7, val)

#define HTX_get_EXT_PLL_M(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xE3, 0x70, 4, pval)
#define HTX_ret_EXT_PLL_M()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xE3, 0x70, 4)
#define HTX_set_EXT_PLL_M(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xE3, 0x70, 4, val)

#define HTX_get_EXT_PLL_N(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xE3, 0xE, 1, pval)
#define HTX_ret_EXT_PLL_N()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xE3, 0xE, 1)
#define HTX_set_EXT_PLL_N(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xE3, 0xE, 1, val)

#define HTX_get_VSWINGSETI2C(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xE4, 0xC0, 6, pval)
#define HTX_ret_VSWINGSETI2C()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xE4, 0xC0, 6)
#define HTX_set_VSWINGSETI2C(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xE4, 0xC0, 6, val)

#define HTX_get_LIMITSELI2C(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xE4, 0x30, 4, pval)
#define HTX_ret_LIMITSELI2C()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xE4, 0x30, 4)
#define HTX_set_LIMITSELI2C(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xE4, 0x30, 4, val)

#define HTX_is_VRSELLI2C_true()                             ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xE4, 0x8, 0x3)
#define HTX_get_VRSELLI2C(pval)                             ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xE4, 0x8, 0x3, pval)
#define HTX_ret_VRSELLI2C()                                 ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xE4, 0x8, 0x3)
#define HTX_set_VRSELLI2C(val)                              ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xE4, 0x8, 0x3, val)

#define HTX_is_LBT_HIDRVEN_true()                           ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xE4, 0x4, 0x2)
#define HTX_get_LBT_HIDRVEN(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xE4, 0x4, 0x2, pval)
#define HTX_ret_LBT_HIDRVEN()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xE4, 0x4, 0x2)
#define HTX_set_LBT_HIDRVEN(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xE4, 0x4, 0x2, val)

#define HTX_get_CHIPID_HIGH_BYTE(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xF5, 0xFF, 0, pval)
#define HTX_ret_CHIPID_HIGH_BYTE()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xF5, 0xFF, 0)

#define HTX_get_CHIPID_LOW_BYTE(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xF6, 0xFF, 0, pval)
#define HTX_ret_CHIPID_LOW_BYTE()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xF6, 0xFF, 0)

#define HTX_get_CHIPID_POSTFIX(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xF7, 0xF0, 4, pval)
#define HTX_ret_CHIPID_POSTFIX()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xF7, 0xF0, 4)

#define HTX_get_BONDING_OPTIONS(pval)                       ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xF7, 0xF, 0, pval)
#define HTX_ret_BONDING_OPTIONS()                           ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xF7, 0xF, 0)

#define HTX_is_PKTRAM_TESTEN_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x80, 0x7)
#define HTX_get_PKTRAM_TESTEN(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x80, 0x7, pval)
#define HTX_ret_PKTRAM_TESTEN()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x80, 0x7)
#define HTX_set_PKTRAM_TESTEN(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x80, 0x7, val)

#define HTX_is_LB_MULTI_CHECK_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x40, 0x6)
#define HTX_get_LB_MULTI_CHECK(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x40, 0x6, pval)
#define HTX_ret_LB_MULTI_CHECK()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x40, 0x6)
#define HTX_set_LB_MULTI_CHECK(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x40, 0x6, val)

#define HTX_get_GOOD_RESULT_ID(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x30, 4, pval)
#define HTX_ret_GOOD_RESULT_ID()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x30, 4)
#define HTX_set_GOOD_RESULT_ID(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x30, 4, val)

#define HTX_is_TEST_ALL_CHANNEL_true()                      ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x8, 0x3)
#define HTX_get_TEST_ALL_CHANNEL(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x8, 0x3, pval)
#define HTX_ret_TEST_ALL_CHANNEL()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x8, 0x3)
#define HTX_set_TEST_ALL_CHANNEL(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xF9, 0x8, 0x3, val)

#define HTX_get_VFE_HS_PLA_MSB(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFA, 0xE0, 5, pval)
#define HTX_ret_VFE_HS_PLA_MSB()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFA, 0xE0, 5)
#define HTX_set_VFE_HS_PLA_MSB(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFA, 0xE0, 5, val)

#define HTX_get_SA_HS_PLA_MSB(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFA, 0x1C, 2, pval)
#define HTX_ret_SA_HS_PLA_MSB()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFA, 0x1C, 2)
#define HTX_set_SA_HS_PLA_MSB(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFA, 0x1C, 2, val)

#define HTX_get_SA_VS_WINDOW_MSB(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFA, 0x3, 0, pval)
#define HTX_ret_SA_VS_WINDOW_MSB()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFA, 0x3, 0)
#define HTX_set_SA_VS_WINDOW_MSB(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFA, 0x3, 0, val)

#define HTX_is_VFE_HSYNCDELAYIN_MSB_true()                  ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x80, 0x7)
#define HTX_get_VFE_HSYNCDELAYIN_MSB(pval)                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x80, 0x7, pval)
#define HTX_ret_VFE_HSYNCDELAYIN_MSB()                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x80, 0x7)
#define HTX_set_VFE_HSYNCDELAYIN_MSB(val)                   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x80, 0x7, val)

#define HTX_get_VFE_VSYNCDELAYIN_MSB(pval)                  ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x60, 5, pval)
#define HTX_ret_VFE_VSYNCDELAYIN_MSB()                      ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x60, 5)
#define HTX_set_VFE_VSYNCDELAYIN_MSB(val)                   ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x60, 5, val)

#define HTX_is_VFE_WIDTH_MSB_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x10, 0x4)
#define HTX_get_VFE_WIDTH_MSB(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x10, 0x4, pval)
#define HTX_ret_VFE_WIDTH_MSB()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x10, 0x4)
#define HTX_set_VFE_WIDTH_MSB(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x10, 0x4, val)

#define HTX_is_VFE_HEIGHT_MSB_true()                        ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x8, 0x3)
#define HTX_get_VFE_HEIGHT_MSB(pval)                        ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x8, 0x3, pval)
#define HTX_ret_VFE_HEIGHT_MSB()                            ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x8, 0x3)
#define HTX_set_VFE_HEIGHT_MSB(val)                         ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x8, 0x3, val)

#define HTX_is_LOW_FRQ_VIDEO_true()                         ATV_I2CIsField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x06, 0x1)
#define HTX_get_LOW_FRQ_VIDEO(pval)                         ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x06, 0x1, pval)
#define HTX_ret_LOW_FRQ_VIDEO()                             ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x06, 0x1)
#define HTX_set_LOW_FRQ_VIDEO(val)                          ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFB, 0x06, 0x1, val)

#define HTX_get_LBSTARTDELAY_MSB(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFB, 0xFF, 0, pval)
#define HTX_ret_LBSTARTDELAY_MSB()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFB, 0xFF, 0)
#define HTX_set_LBSTARTDELAY_MSB(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFB, 0xFF, 0, val)

#define HTX_get_RI_FREQ_SEL(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFC, 0xC0, 6, pval)
#define HTX_ret_RI_FREQ_SEL()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFC, 0xC0, 6)
#define HTX_set_RI_FREQ_SEL(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFC, 0xC0, 6, val)

#define HTX_get_RI_DELAY_SEL(pval)                          ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFC, 0x38, 3, pval)
#define HTX_ret_RI_DELAY_SEL()                              ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFC, 0x38, 3)
#define HTX_set_RI_DELAY_SEL(val)                           ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFC, 0x38, 3, val)

#define HTX_get_BCAPS_DELAY(pval)                           ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFC, 0x7, 0, pval)
#define HTX_ret_BCAPS_DELAY()                               ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFC, 0x7, 0)
#define HTX_set_BCAPS_DELAY(val)                            ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFC, 0x7, 0, val)

#define HTX_get_AN_DELAY(pval)                              ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFD, 0xE0, 5, pval)
#define HTX_ret_AN_DELAY()                                  ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFD, 0xE0, 5)
#define HTX_set_AN_DELAY(val)                               ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFD, 0xE0, 5, val)

#define HTX_get_AKSV_DELAY(pval)                            ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFD, 0x1C, 2, pval)
#define HTX_ret_AKSV_DELAY()                                ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFD, 0x1C, 2)
#define HTX_set_AKSV_DELAY(val)                             ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFD, 0x1C, 2, val)

#define HTX_get_HDCP_START_DELAY(pval)                      ATV_I2CGetField8(HTX_MAIN_MAP_ADDR, 0xFE, 0xE0, 5, pval)
#define HTX_ret_HDCP_START_DELAY()                          ATV_I2CReadField8(HTX_MAIN_MAP_ADDR, 0xFE, 0xE0, 5)
#define HTX_set_HDCP_START_DELAY(val)                       ATV_I2CWriteField8(HTX_MAIN_MAP_ADDR, 0xFE, 0xE0, 5, val)


#endif
