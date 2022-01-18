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
* DATE: 4 Nov 2009 18:16:20                                                    *
*                                                                              *
*******************************************************************************/


#ifndef ADV7511_PACKET_MAP_FCT_H
#define ADV7511_PACKET_MAP_FCT_H

#include "ADV7511_cfg.h"

#define HTX_get_SPD_HEADER_BYTE_0(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x00, 0xFF, 0, pval)
#define HTX_ret_SPD_HEADER_BYTE_0()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x00, 0xFF, 0)
#define HTX_set_SPD_HEADER_BYTE_0(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x00, 0xFF, 0, val)

#define HTX_get_SPD_HEADER_BYTE_1(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x01, 0xFF, 0, pval)
#define HTX_ret_SPD_HEADER_BYTE_1()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x01, 0xFF, 0)
#define HTX_set_SPD_HEADER_BYTE_1(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x01, 0xFF, 0, val)

#define HTX_get_SPD_HEADER_BYTE_2(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x02, 0xFF, 0, pval)
#define HTX_ret_SPD_HEADER_BYTE_2()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x02, 0xFF, 0)
#define HTX_set_SPD_HEADER_BYTE_2(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x02, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_0(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x03, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_0()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x03, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_0(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x03, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_1(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x04, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_1()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x04, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_1(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x04, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_2(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x05, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_2()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x05, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_2(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x05, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_3(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x06, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_3()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x06, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_3(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x06, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_4(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x07, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_4()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x07, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_4(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x07, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_5(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x08, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_5()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x08, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_5(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x08, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_6(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x09, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_6()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x09, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_6(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x09, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_7(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x0A, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_7()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x0A, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_7(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x0A, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_8(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x0B, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_8()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x0B, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_8(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x0B, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_9(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x0C, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_9()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x0C, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_9(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x0C, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_10(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x0D, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_10()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x0D, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_10(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x0D, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_11(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x0E, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_11()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x0E, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_11(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x0E, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_12(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x0F, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_12()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x0F, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_12(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x0F, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_13(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x10, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_13()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x10, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_13(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x10, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_14(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x11, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_14()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x11, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_14(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x11, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_15(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x12, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_15()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x12, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_15(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x12, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_16(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x13, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_16()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x13, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_16(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x13, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_17(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x14, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_17()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x14, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_17(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x14, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_18(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x15, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_18()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x15, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_18(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x15, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_19(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x16, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_19()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x16, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_19(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x16, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_20(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x17, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_20()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x17, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_20(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x17, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_21(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x18, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_21()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x18, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_21(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x18, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_22(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x19, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_22()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x19, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_22(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x19, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_23(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x1A, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_23()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x1A, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_23(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x1A, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_24(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x1B, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_24()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x1B, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_24(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x1B, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_25(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x1C, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_25()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x1C, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_25(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x1C, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_26(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x1D, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_26()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x1D, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_26(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x1D, 0xFF, 0, val)

#define HTX_get_SPD_PACKET_BYTE_27(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x1E, 0xFF, 0, pval)
#define HTX_ret_SPD_PACKET_BYTE_27()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x1E, 0xFF, 0)
#define HTX_set_SPD_PACKET_BYTE_27(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x1E, 0xFF, 0, val)

#define HTX_is_SPD_UPDATE_true()                            ATV_I2CIsField8(HTX_PACKET_MAP_ADDR, 0x1F, 0x80, 0x7)
#define HTX_get_SPD_UPDATE(pval)                            ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x1F, 0x80, 0x7, pval)
#define HTX_ret_SPD_UPDATE()                                ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x1F, 0x80, 0x7)
#define HTX_set_SPD_UPDATE(val)                             ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x1F, 0x80, 0x7, val)

#define HTX_get_MPEG_HEADER_BYTE_0(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x20, 0xFF, 0, pval)
#define HTX_ret_MPEG_HEADER_BYTE_0()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x20, 0xFF, 0)
#define HTX_set_MPEG_HEADER_BYTE_0(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x20, 0xFF, 0, val)

#define HTX_get_MPEG_HEADER_BYTE_1(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x21, 0xFF, 0, pval)
#define HTX_ret_MPEG_HEADER_BYTE_1()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x21, 0xFF, 0)
#define HTX_set_MPEG_HEADER_BYTE_1(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x21, 0xFF, 0, val)

#define HTX_get_MPEG_HEADER_BYTE_2(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x22, 0xFF, 0, pval)
#define HTX_ret_MPEG_HEADER_BYTE_2()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x22, 0xFF, 0)
#define HTX_set_MPEG_HEADER_BYTE_2(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x22, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_0(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x23, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_0()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x23, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_0(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x23, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_1(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x24, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_1()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x24, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_1(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x24, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_2(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x25, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_2()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x25, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_2(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x25, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_3(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x26, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_3()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x26, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_3(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x26, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_4(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x27, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_4()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x27, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_4(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x27, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_5(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x28, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_5()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x28, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_5(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x28, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_6(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x29, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_6()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x29, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_6(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x29, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_7(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x2A, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_7()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x2A, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_7(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x2A, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_8(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x2B, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_8()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x2B, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_8(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x2B, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_9(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x2C, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_9()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x2C, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_9(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x2C, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_10(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x2D, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_10()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x2D, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_10(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x2D, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_11(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x2E, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_11()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x2E, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_11(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x2E, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_12(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x2F, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_12()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x2F, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_12(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x2F, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_13(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x30, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_13()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x30, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_13(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x30, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_14(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x31, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_14()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x31, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_14(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x31, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_15(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x32, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_15()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x32, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_15(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x32, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_16(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x33, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_16()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x33, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_16(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x33, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_17(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x34, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_17()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x34, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_17(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x34, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_18(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x35, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_18()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x35, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_18(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x35, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_19(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x36, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_19()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x36, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_19(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x36, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_20(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x37, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_20()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x37, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_20(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x37, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_21(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x38, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_21()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x38, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_21(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x38, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_22(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x39, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_22()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x39, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_22(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x39, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_23(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x3A, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_23()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x3A, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_23(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x3A, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_24(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x3B, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_24()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x3B, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_24(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x3B, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_25(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x3C, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_25()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x3C, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_25(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x3C, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_26(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x3D, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_26()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x3D, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_26(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x3D, 0xFF, 0, val)

#define HTX_get_MPEG_PACKET_BYTE_27(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x3E, 0xFF, 0, pval)
#define HTX_ret_MPEG_PACKET_BYTE_27()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x3E, 0xFF, 0)
#define HTX_set_MPEG_PACKET_BYTE_27(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x3E, 0xFF, 0, val)

#define HTX_is_MPEG_UPDATE_true()                           ATV_I2CIsField8(HTX_PACKET_MAP_ADDR, 0x3F, 0x80, 0x7)
#define HTX_get_MPEG_UPDATE(pval)                           ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x3F, 0x80, 0x7, pval)
#define HTX_ret_MPEG_UPDATE()                               ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x3F, 0x80, 0x7)
#define HTX_set_MPEG_UPDATE(val)                            ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x3F, 0x80, 0x7, val)

#define HTX_get_ACP_HEADER_BYTE_0(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x40, 0xFF, 0, pval)
#define HTX_ret_ACP_HEADER_BYTE_0()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x40, 0xFF, 0)
#define HTX_set_ACP_HEADER_BYTE_0(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x40, 0xFF, 0, val)

#define HTX_get_ACP_HEADER_BYTE_1(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x41, 0xFF, 0, pval)
#define HTX_ret_ACP_HEADER_BYTE_1()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x41, 0xFF, 0)
#define HTX_set_ACP_HEADER_BYTE_1(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x41, 0xFF, 0, val)

#define HTX_get_ACP_HEADER_BYTE_2(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x42, 0xFF, 0, pval)
#define HTX_ret_ACP_HEADER_BYTE_2()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x42, 0xFF, 0)
#define HTX_set_ACP_HEADER_BYTE_2(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x42, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_0(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x43, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_0()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x43, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_0(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x43, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_1(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x44, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_1()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x44, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_1(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x44, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_2(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x45, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_2()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x45, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_2(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x45, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_3(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x46, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_3()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x46, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_3(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x46, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_4(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x47, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_4()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x47, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_4(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x47, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_5(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x48, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_5()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x48, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_5(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x48, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_6(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x49, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_6()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x49, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_6(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x49, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_7(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x4A, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_7()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x4A, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_7(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x4A, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_8(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x4B, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_8()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x4B, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_8(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x4B, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_9(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x4C, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_9()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x4C, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_9(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x4C, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_10(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x4D, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_10()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x4D, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_10(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x4D, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_11(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x4E, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_11()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x4E, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_11(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x4E, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_12(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x4F, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_12()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x4F, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_12(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x4F, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_13(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x50, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_13()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x50, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_13(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x50, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_14(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x51, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_14()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x51, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_14(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x51, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_15(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x52, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_15()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x52, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_15(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x52, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_16(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x53, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_16()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x53, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_16(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x53, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_17(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x54, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_17()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x54, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_17(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x54, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_18(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x55, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_18()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x55, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_18(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x55, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_19(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x56, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_19()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x56, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_19(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x56, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_20(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x57, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_20()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x57, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_20(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x57, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_21(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x58, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_21()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x58, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_21(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x58, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_22(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x59, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_22()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x59, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_22(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x59, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_23(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x5A, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_23()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x5A, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_23(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x5A, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_24(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x5B, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_24()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x5B, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_24(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x5B, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_25(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x5C, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_25()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x5C, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_25(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x5C, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_26(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x5D, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_26()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x5D, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_26(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x5D, 0xFF, 0, val)

#define HTX_get_ACP_PACKET_BYTE_27(pval)                    ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x5E, 0xFF, 0, pval)
#define HTX_ret_ACP_PACKET_BYTE_27()                        ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x5E, 0xFF, 0)
#define HTX_set_ACP_PACKET_BYTE_27(val)                     ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x5E, 0xFF, 0, val)

#define HTX_is_ACP_UPDATE_true()                            ATV_I2CIsField8(HTX_PACKET_MAP_ADDR, 0x5F, 0x80, 0x7)
#define HTX_get_ACP_UPDATE(pval)                            ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x5F, 0x80, 0x7, pval)
#define HTX_ret_ACP_UPDATE()                                ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x5F, 0x80, 0x7)
#define HTX_set_ACP_UPDATE(val)                             ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x5F, 0x80, 0x7, val)

#define HTX_get_ISRC1_HEADER_BYTE_0(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x60, 0xFF, 0, pval)
#define HTX_ret_ISRC1_HEADER_BYTE_0()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x60, 0xFF, 0)
#define HTX_set_ISRC1_HEADER_BYTE_0(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x60, 0xFF, 0, val)

#define HTX_get_ISRC1_HEADER_BYTE_1(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x61, 0xFF, 0, pval)
#define HTX_ret_ISRC1_HEADER_BYTE_1()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x61, 0xFF, 0)
#define HTX_set_ISRC1_HEADER_BYTE_1(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x61, 0xFF, 0, val)

#define HTX_get_ISRC1_HEADER_BYTE_2(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x62, 0xFF, 0, pval)
#define HTX_ret_ISRC1_HEADER_BYTE_2()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x62, 0xFF, 0)
#define HTX_set_ISRC1_HEADER_BYTE_2(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x62, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_0(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x63, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_0()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x63, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_0(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x63, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_1(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x64, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_1()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x64, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_1(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x64, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_2(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x65, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_2()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x65, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_2(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x65, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_3(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x66, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_3()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x66, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_3(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x66, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_4(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x67, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_4()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x67, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_4(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x67, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_5(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x68, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_5()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x68, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_5(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x68, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_6(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x69, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_6()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x69, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_6(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x69, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_7(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x6A, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_7()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x6A, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_7(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x6A, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_8(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x6B, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_8()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x6B, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_8(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x6B, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_9(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x6C, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_9()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x6C, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_9(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x6C, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_10(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x6D, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_10()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x6D, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_10(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x6D, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_11(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x6E, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_11()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x6E, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_11(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x6E, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_12(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x6F, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_12()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x6F, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_12(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x6F, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_13(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x70, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_13()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x70, 0xFF, 0)

#define HTX_get_ISRC1_PACKET_BYTE_14(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x71, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_14()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x71, 0xFF, 0)

#define HTX_get_ISRC1_PACKET_BYTE_15(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x72, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_15()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x72, 0xFF, 0)

#define HTX_get_ISRC1_PACKET_BYTE_16(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x73, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_16()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x73, 0xFF, 0)

#define HTX_get_ISRC1_PACKET_BYTE_17(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x74, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_17()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x74, 0xFF, 0)

#define HTX_get_ISRC1_PACKET_BYTE_18(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x75, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_18()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x75, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_18(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x75, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_19(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x76, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_19()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x76, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_19(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x76, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_20(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x77, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_20()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x77, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_20(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x77, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_21(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x78, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_21()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x78, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_21(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x78, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_22(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x79, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_22()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x79, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_22(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x79, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_23(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x7A, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_23()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x7A, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_23(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x7A, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_24(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x7B, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_24()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x7B, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_24(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x7B, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_25(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x7C, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_25()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x7C, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_25(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x7C, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_26(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x7D, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_26()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x7D, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_26(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x7D, 0xFF, 0, val)

#define HTX_get_ISRC1_PACKET_BYTE_27(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x7E, 0xFF, 0, pval)
#define HTX_ret_ISRC1_PACKET_BYTE_27()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x7E, 0xFF, 0)
#define HTX_set_ISRC1_PACKET_BYTE_27(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x7E, 0xFF, 0, val)

#define HTX_is_ISRC1_UPDATE_true()                          ATV_I2CIsField8(HTX_PACKET_MAP_ADDR, 0x7F, 0x80, 0x7)
#define HTX_get_ISRC1_UPDATE(pval)                          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x7F, 0x80, 0x7, pval)
#define HTX_ret_ISRC1_UPDATE()                              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x7F, 0x80, 0x7)
#define HTX_set_ISRC1_UPDATE(val)                           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x7F, 0x80, 0x7, val)

#define HTX_get_ISRC2_HEADER_BYTE_0(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x80, 0xFF, 0, pval)
#define HTX_ret_ISRC2_HEADER_BYTE_0()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x80, 0xFF, 0)
#define HTX_set_ISRC2_HEADER_BYTE_0(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x80, 0xFF, 0, val)

#define HTX_get_ISRC2_HEADER_BYTE_1(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x81, 0xFF, 0, pval)
#define HTX_ret_ISRC2_HEADER_BYTE_1()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x81, 0xFF, 0)
#define HTX_set_ISRC2_HEADER_BYTE_1(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x81, 0xFF, 0, val)

#define HTX_get_ISRC2_HEADER_BYTE_2(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x82, 0xFF, 0, pval)
#define HTX_ret_ISRC2_HEADER_BYTE_2()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x82, 0xFF, 0)
#define HTX_set_ISRC2_HEADER_BYTE_2(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x82, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_0(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x83, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_0()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x83, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_0(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x83, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_1(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x84, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_1()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x84, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_1(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x84, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_2(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x85, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_2()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x85, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_2(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x85, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_3(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x86, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_3()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x86, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_3(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x86, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_4(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x87, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_4()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x87, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_4(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x87, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_5(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x88, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_5()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x88, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_5(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x88, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_6(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x89, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_6()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x89, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_6(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x89, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_7(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x8A, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_7()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x8A, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_7(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x8A, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_8(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x8B, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_8()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x8B, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_8(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x8B, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_9(pval)                   ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x8C, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_9()                       ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x8C, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_9(val)                    ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x8C, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_10(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x8D, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_10()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x8D, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_10(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x8D, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_11(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x8E, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_11()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x8E, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_11(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x8E, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_12(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x8F, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_12()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x8F, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_12(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x8F, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_13(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x90, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_13()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x90, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_13(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x90, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_14(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x91, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_14()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x91, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_14(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x91, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_15(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x92, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_15()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x92, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_15(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x92, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_16(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x93, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_16()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x93, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_16(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x93, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_17(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x94, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_17()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x94, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_17(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x94, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_18(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x95, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_18()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x95, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_18(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x95, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_19(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x96, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_19()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x96, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_19(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x96, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_20(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x97, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_20()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x97, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_20(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x97, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_21(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x98, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_21()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x98, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_21(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x98, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_22(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x99, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_22()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x99, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_22(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x99, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_23(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x9A, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_23()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x9A, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_23(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x9A, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_24(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x9B, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_24()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x9B, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_24(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x9B, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_25(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x9C, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_25()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x9C, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_25(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x9C, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_26(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x9D, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_26()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x9D, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_26(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x9D, 0xFF, 0, val)

#define HTX_get_ISRC2_PACKET_BYTE_27(pval)                  ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x9E, 0xFF, 0, pval)
#define HTX_ret_ISRC2_PACKET_BYTE_27()                      ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x9E, 0xFF, 0)
#define HTX_set_ISRC2_PACKET_BYTE_27(val)                   ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x9E, 0xFF, 0, val)

#define HTX_is_ISRC2_UPDATE_true()                          ATV_I2CIsField8(HTX_PACKET_MAP_ADDR, 0x9F, 0x80, 0x7)
#define HTX_get_ISRC2_UPDATE(pval)                          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0x9F, 0x80, 0x7, pval)
#define HTX_ret_ISRC2_UPDATE()                              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0x9F, 0x80, 0x7)
#define HTX_set_ISRC2_UPDATE(val)                           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0x9F, 0x80, 0x7, val)

#define HTX_get_GM_HEADER_BYTE_0(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xA0, 0xFF, 0, pval)
#define HTX_ret_GM_HEADER_BYTE_0()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xA0, 0xFF, 0)
#define HTX_set_GM_HEADER_BYTE_0(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xA0, 0xFF, 0, val)

#define HTX_get_GM_HEADER_BYTE_1(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xA1, 0xFF, 0, pval)
#define HTX_ret_GM_HEADER_BYTE_1()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xA1, 0xFF, 0)
#define HTX_set_GM_HEADER_BYTE_1(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xA1, 0xFF, 0, val)

#define HTX_get_GM_HEADER_BYTE_2(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xA2, 0xFF, 0, pval)
#define HTX_ret_GM_HEADER_BYTE_2()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xA2, 0xFF, 0)
#define HTX_set_GM_HEADER_BYTE_2(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xA2, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_0(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xA3, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_0()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xA3, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_0(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xA3, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_1(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xA4, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_1()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xA4, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_1(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xA4, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_2(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xA5, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_2()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xA5, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_2(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xA5, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_3(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xA6, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_3()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xA6, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_3(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xA6, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_4(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xA7, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_4()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xA7, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_4(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xA7, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_5(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xA8, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_5()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xA8, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_5(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xA8, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_6(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xA9, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_6()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xA9, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_6(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xA9, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_7(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xAA, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_7()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xAA, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_7(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xAA, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_8(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xAB, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_8()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xAB, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_8(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xAB, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_9(pval)                      ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xAC, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_9()                          ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xAC, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_9(val)                       ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xAC, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_10(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xAD, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_10()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xAD, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_10(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xAD, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_11(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xAE, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_11()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xAE, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_11(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xAE, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_12(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xAF, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_12()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xAF, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_12(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xAF, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_13(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xB0, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_13()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xB0, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_13(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xB0, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_14(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xB1, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_14()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xB1, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_14(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xB1, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_15(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xB2, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_15()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xB2, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_15(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xB2, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_16(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xB3, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_16()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xB3, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_16(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xB3, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_17(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xB4, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_17()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xB4, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_17(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xB4, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_18(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xB5, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_18()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xB5, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_18(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xB5, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_19(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xB6, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_19()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xB6, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_19(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xB6, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_20(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xB7, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_20()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xB7, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_20(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xB7, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_21(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xB8, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_21()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xB8, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_21(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xB8, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_22(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xB9, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_22()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xB9, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_22(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xB9, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_23(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xBA, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_23()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xBA, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_23(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xBA, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_24(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xBB, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_24()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xBB, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_24(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xBB, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_25(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xBC, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_25()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xBC, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_25(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xBC, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_26(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xBD, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_26()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xBD, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_26(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xBD, 0xFF, 0, val)

#define HTX_get_GM_PACKET_BYTE_27(pval)                     ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xBE, 0xFF, 0, pval)
#define HTX_ret_GM_PACKET_BYTE_27()                         ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xBE, 0xFF, 0)
#define HTX_set_GM_PACKET_BYTE_27(val)                      ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xBE, 0xFF, 0, val)

#define HTX_is_GM_UPDATE_true()                             ATV_I2CIsField8(HTX_PACKET_MAP_ADDR, 0xBF, 0x80, 0x7)
#define HTX_get_GM_UPDATE(pval)                             ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xBF, 0x80, 0x7, pval)
#define HTX_ret_GM_UPDATE()                                 ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xBF, 0x80, 0x7)
#define HTX_set_GM_UPDATE(val)                              ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xBF, 0x80, 0x7, val)

#define HTX_get_SPARE_PACKET_1_HEADER_BYTE_0(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xC0, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_HEADER_BYTE_0()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xC0, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_HEADER_BYTE_0(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xC0, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_HEADER_BYTE_1(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xC1, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_HEADER_BYTE_1()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xC1, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_HEADER_BYTE_1(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xC1, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_HEADER_BYTE_2(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xC2, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_HEADER_BYTE_2()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xC2, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_HEADER_BYTE_2(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xC2, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_0(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xC3, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_0()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xC3, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_0(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xC3, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_1(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xC4, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_1()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xC4, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_1(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xC4, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_2(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xC5, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_2()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xC5, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_2(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xC5, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_3(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xC6, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_3()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xC6, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_3(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xC6, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_4(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xC7, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_4()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xC7, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_4(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xC7, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_5(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xC8, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_5()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xC8, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_5(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xC8, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_6(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xC9, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_6()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xC9, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_6(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xC9, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_7(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xCA, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_7()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xCA, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_7(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xCA, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_8(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xCB, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_8()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xCB, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_8(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xCB, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_9(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xCC, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_9()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xCC, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_9(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xCC, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_10(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xCD, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_10()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xCD, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_10(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xCD, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_11(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xCE, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_11()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xCE, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_11(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xCE, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_12(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xCF, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_12()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xCF, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_12(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xCF, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_13(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xD0, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_13()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xD0, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_13(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xD0, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_14(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xD1, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_14()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xD1, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_14(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xD1, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_15(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xD2, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_15()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xD2, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_15(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xD2, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_16(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xD3, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_16()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xD3, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_16(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xD3, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_17(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xD4, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_17()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xD4, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_17(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xD4, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_18(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xD5, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_18()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xD5, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_18(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xD5, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_19(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xD6, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_19()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xD6, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_19(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xD6, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_20(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xD7, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_20()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xD7, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_20(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xD7, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_21(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xD8, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_21()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xD8, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_21(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xD8, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_22(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xD9, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_22()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xD9, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_22(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xD9, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_23(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xDA, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_23()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xDA, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_23(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xDA, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_24(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xDB, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_24()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xDB, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_24(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xDB, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_25(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xDC, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_25()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xDC, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_25(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xDC, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_26(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xDD, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_26()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xDD, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_26(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xDD, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_1_PACKET_BYTE_27(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xDE, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_1_PACKET_BYTE_27()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xDE, 0xFF, 0)
#define HTX_set_SPARE_PACKET_1_PACKET_BYTE_27(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xDE, 0xFF, 0, val)

#define HTX_is_SPARE1_UPDATE_true()                         ATV_I2CIsField8(HTX_PACKET_MAP_ADDR, 0xDF, 0x80, 0x7)
#define HTX_get_SPARE1_UPDATE(pval)                         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xDF, 0x80, 0x7, pval)
#define HTX_ret_SPARE1_UPDATE()                             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xDF, 0x80, 0x7)
#define HTX_set_SPARE1_UPDATE(val)                          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xDF, 0x80, 0x7, val)

#define HTX_get_SPARE_PACKET_2_HEADER_BYTE_0(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xE0, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_HEADER_BYTE_0()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xE0, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_HEADER_BYTE_0(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xE0, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_HEADER_BYTE_1(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xE1, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_HEADER_BYTE_1()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xE1, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_HEADER_BYTE_1(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xE1, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_HEADER_BYTE_2(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xE2, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_HEADER_BYTE_2()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xE2, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_HEADER_BYTE_2(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xE2, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_0(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xE3, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_0()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xE3, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_0(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xE3, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_1(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xE4, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_1()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xE4, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_1(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xE4, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_2(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xE5, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_2()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xE5, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_2(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xE5, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_3(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xE6, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_3()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xE6, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_3(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xE6, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_4(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xE7, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_4()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xE7, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_4(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xE7, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_5(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xE8, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_5()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xE8, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_5(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xE8, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_6(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xE9, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_6()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xE9, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_6(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xE9, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_7(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xEA, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_7()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xEA, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_7(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xEA, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_8(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xEB, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_8()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xEB, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_8(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xEB, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_9(pval)          ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xEC, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_9()              ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xEC, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_9(val)           ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xEC, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_10(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xED, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_10()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xED, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_10(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xED, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_11(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xEE, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_11()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xEE, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_11(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xEE, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_12(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xEF, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_12()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xEF, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_12(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xEF, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_13(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xF0, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_13()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xF0, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_13(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xF0, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_14(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xF1, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_14()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xF1, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_14(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xF1, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_15(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xF2, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_15()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xF2, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_15(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xF2, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_16(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xF3, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_16()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xF3, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_16(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xF3, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_17(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xF4, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_17()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xF4, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_17(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xF4, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_18(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xF5, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_18()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xF5, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_18(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xF5, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_19(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xF6, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_19()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xF6, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_19(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xF6, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_20(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xF7, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_20()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xF7, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_20(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xF7, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_21(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xF8, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_21()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xF8, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_21(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xF8, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_22(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xF9, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_22()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xF9, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_22(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xF9, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_23(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xFA, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_23()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xFA, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_23(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xFA, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_24(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xFB, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_24()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xFB, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_24(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xFB, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_25(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xFC, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_25()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xFC, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_25(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xFC, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_26(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xFD, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_26()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xFD, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_26(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xFD, 0xFF, 0, val)

#define HTX_get_SPARE_PACKET_2_PACKET_BYTE_27(pval)         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xFE, 0xFF, 0, pval)
#define HTX_ret_SPARE_PACKET_2_PACKET_BYTE_27()             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xFE, 0xFF, 0)
#define HTX_set_SPARE_PACKET_2_PACKET_BYTE_27(val)          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xFE, 0xFF, 0, val)

#define HTX_is_SPARE2_UPDATE_true()                         ATV_I2CIsField8(HTX_PACKET_MAP_ADDR, 0xFF, 0x80, 0x7)
#define HTX_get_SPARE2_UPDATE(pval)                         ATV_I2CGetField8(HTX_PACKET_MAP_ADDR, 0xFF, 0x80, 0x7, pval)
#define HTX_ret_SPARE2_UPDATE()                             ATV_I2CReadField8(HTX_PACKET_MAP_ADDR, 0xFF, 0x80, 0x7)
#define HTX_set_SPARE2_UPDATE(val)                          ATV_I2CWriteField8(HTX_PACKET_MAP_ADDR, 0xFF, 0x80, 0x7, val)

#endif
