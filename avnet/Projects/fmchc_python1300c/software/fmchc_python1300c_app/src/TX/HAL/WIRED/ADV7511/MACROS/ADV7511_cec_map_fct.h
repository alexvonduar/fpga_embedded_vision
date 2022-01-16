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
* DATE: 4 Nov 2009 18:16:24                                                    *
*                                                                              *
*******************************************************************************/


#ifndef ADV7511_CEC_MAP_FCT_H
#define ADV7511_CEC_MAP_FCT_H

#include "ADV7511_cfg.h"

#define HTX_get_TX_FRAME_HEADER(pval)                       ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x00, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_HEADER()                           ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x00, 0xFF, 0)
#define HTX_set_TX_FRAME_HEADER(val)                        ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x00, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA0(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x01, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA0()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x01, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA0(val)                         ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x01, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA1(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x02, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA1()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x02, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA1(val)                         ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x02, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA2(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x03, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA2()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x03, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA2(val)                         ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x03, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA3(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x04, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA3()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x04, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA3(val)                         ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x04, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA4(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x05, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA4()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x05, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA4(val)                         ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x05, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA5(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x06, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA5()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x06, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA5(val)                         ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x06, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA6(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x07, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA6()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x07, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA6(val)                         ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x07, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA7(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x08, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA7()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x08, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA7(val)                         ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x08, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA8(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x09, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA8()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x09, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA8(val)                         ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x09, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA9(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x0A, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA9()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x0A, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA9(val)                         ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x0A, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA10(pval)                       ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x0B, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA10()                           ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x0B, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA10(val)                        ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x0B, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA11(pval)                       ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x0C, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA11()                           ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x0C, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA11(val)                        ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x0C, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA12(pval)                       ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x0D, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA12()                           ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x0D, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA12(val)                        ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x0D, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA13(pval)                       ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x0E, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA13()                           ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x0E, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA13(val)                        ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x0E, 0xFF, 0, val)

#define HTX_get_TX_FRAME_DATA14(pval)                       ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x0F, 0xFF, 0, pval)
#define HTX_ret_TX_FRAME_DATA14()                           ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x0F, 0xFF, 0)
#define HTX_set_TX_FRAME_DATA14(val)                        ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x0F, 0xFF, 0, val)

#define HTX_get_TX_FRAME_LENGTH(pval)                       ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x10, 0x1F, 0, pval)
#define HTX_ret_TX_FRAME_LENGTH()                           ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x10, 0x1F, 0)
#define HTX_set_TX_FRAME_LENGTH(val)                        ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x10, 0x1F, 0, val)

#define HTX_is_TX_ENABLE_true()                             ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x11, 0x1, 0x0)
#define HTX_get_TX_ENABLE(pval)                             ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x11, 0x1, 0x0, pval)
#define HTX_ret_TX_ENABLE()                                 ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x11, 0x1, 0x0)
#define HTX_set_TX_ENABLE(val)                              ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x11, 0x1, 0x0, val)

#define HTX_get_TX_RETRY(pval)                              ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x12, 0x70, 4, pval)
#define HTX_ret_TX_RETRY()                                  ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x12, 0x70, 4)
#define HTX_set_TX_RETRY(val)                               ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x12, 0x70, 4, val)

#define HTX_get_TX_RETRY_SFT(pval)                          ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x12, 0xF, 0, pval)
#define HTX_ret_TX_RETRY_SFT()                              ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x12, 0xF, 0)
#define HTX_set_TX_RETRY_SFT(val)                           ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x12, 0xF, 0, val)

#define HTX_get_TX_SFT5(pval)                               ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x13, 0xF0, 4, pval)
#define HTX_ret_TX_SFT5()                                   ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x13, 0xF0, 4)
#define HTX_set_TX_SFT5(val)                                ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x13, 0xF0, 4, val)

#define HTX_get_TX_SFT7(pval)                               ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x13, 0xF, 0, pval)
#define HTX_ret_TX_SFT7()                                   ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x13, 0xF, 0)
#define HTX_set_TX_SFT7(val)                                ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x13, 0xF, 0, val)

#define HTX_get_TX_LOWDRIVE_COUNTER(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x14, 0xF0, 4, pval)
#define HTX_ret_TX_LOWDRIVE_COUNTER()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x14, 0xF0, 4)

#define HTX_get_TX_NACK_COUNTER(pval)                       ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x14, 0xF, 0, pval)
#define HTX_ret_TX_NACK_COUNTER()                           ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x14, 0xF, 0)

#define HTX_get_BUF0_RX_FRAME_HEADER(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x15, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_HEADER()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x15, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA0(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x16, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA0()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x16, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA1(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x17, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA1()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x17, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA2(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x18, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA2()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x18, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA3(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x19, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA3()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x19, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA4(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x1A, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA4()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x1A, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA5(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x1B, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA5()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x1B, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA6(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x1C, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA6()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x1C, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA7(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x1D, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA7()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x1D, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA8(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x1E, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA8()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x1E, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA9(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x1F, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA9()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x1F, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA10(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x20, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA10()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x20, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA11(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x21, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA11()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x21, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA12(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x22, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA12()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x22, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA13(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x23, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA13()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x23, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_DATA14(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x24, 0xFF, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_DATA14()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x24, 0xFF, 0)

#define HTX_get_BUF0_RX_FRAME_LENGTH(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x25, 0x1F, 0, pval)
#define HTX_ret_BUF0_RX_FRAME_LENGTH()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x25, 0x1F, 0)

#define HTX_is_RX_ENABLE_true()                             ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x26, 0x40, 0x6)
#define HTX_get_RX_ENABLE(pval)                             ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x26, 0x40, 0x6, pval)
#define HTX_ret_RX_ENABLE()                                 ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x26, 0x40, 0x6)

#define HTX_get_BUF2_TIMESTAMP(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x26, 0x30, 4, pval)
#define HTX_ret_BUF2_TIMESTAMP()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x26, 0x30, 4)

#define HTX_get_BUF1_TIMESTAMP(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x26, 0xC, 2, pval)
#define HTX_ret_BUF1_TIMESTAMP()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x26, 0xC, 2)

#define HTX_get_BUF0_TIMESTAMP(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x26, 0x3, 0, pval)
#define HTX_ret_BUF0_TIMESTAMP()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x26, 0x3, 0)

#define HTX_get_BUF1_RX_FRAME_HEADER(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x27, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_HEADER()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x27, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA0(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x28, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA0()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x28, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA1(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x29, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA1()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x29, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA2(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x2A, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA2()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x2A, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA3(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x2B, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA3()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x2B, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA4(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x2C, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA4()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x2C, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA5(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x2D, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA5()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x2D, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA6(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x2E, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA6()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x2E, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA7(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x2F, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA7()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x2F, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA8(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x30, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA8()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x30, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA9(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x31, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA9()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x31, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA10(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x32, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA10()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x32, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA11(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x33, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA11()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x33, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA12(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x34, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA12()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x34, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA13(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x35, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA13()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x35, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_DATA14(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x36, 0xFF, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_DATA14()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x36, 0xFF, 0)

#define HTX_get_BUF1_RX_FRAME_LENGTH(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x37, 0x1F, 0, pval)
#define HTX_ret_BUF1_RX_FRAME_LENGTH()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x37, 0x1F, 0)

#define HTX_get_BUF2_RX_FRAME_HEADER(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x38, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_HEADER()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x38, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA0(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x39, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA0()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x39, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA1(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x3A, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA1()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x3A, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA2(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x3B, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA2()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x3B, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA3(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x3C, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA3()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x3C, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA4(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x3D, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA4()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x3D, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA5(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x3E, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA5()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x3E, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA6(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x3F, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA6()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x3F, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA7(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x40, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA7()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x40, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA8(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x41, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA8()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x41, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA9(pval)                   ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x42, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA9()                       ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x42, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA10(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x43, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA10()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x43, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA11(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x44, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA11()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x44, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA12(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x45, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA12()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x45, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA13(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x46, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA13()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x46, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_DATA14(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x47, 0xFF, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_DATA14()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x47, 0xFF, 0)

#define HTX_get_BUF2_RX_FRAME_LENGTH(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x48, 0x1F, 0, pval)
#define HTX_ret_BUF2_RX_FRAME_LENGTH()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x48, 0x1F, 0)

#define HTX_is_RX_RDY2_true()                               ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x49, 0x4, 0x2)
#define HTX_get_RX_RDY2(pval)                               ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x49, 0x4, 0x2, pval)
#define HTX_ret_RX_RDY2()                                   ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x49, 0x4, 0x2)

#define HTX_is_RX_RDY1_true()                               ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x49, 0x2, 0x1)
#define HTX_get_RX_RDY1(pval)                               ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x49, 0x2, 0x1, pval)
#define HTX_ret_RX_RDY1()                                   ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x49, 0x2, 0x1)

#define HTX_is_RX_RDY0_true()                               ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x49, 0x1, 0x0)
#define HTX_get_RX_RDY0(pval)                               ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x49, 0x1, 0x0, pval)
#define HTX_ret_RX_RDY0()                                   ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x49, 0x1, 0x0)

#define HTX_is_USE_ALL_BUFS_true()                          ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x4A, 0x8, 0x3)
#define HTX_get_USE_ALL_BUFS(pval)                          ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4A, 0x8, 0x3, pval)
#define HTX_ret_USE_ALL_BUFS()                              ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4A, 0x8, 0x3)
#define HTX_set_USE_ALL_BUFS(val)                           ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4A, 0x8, 0x3, val)

#define HTX_is_CLR_RX_RDY2_true()                           ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x4A, 0x4, 0x2)
#define HTX_get_CLR_RX_RDY2(pval)                           ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4A, 0x4, 0x2, pval)
#define HTX_ret_CLR_RX_RDY2()                               ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4A, 0x4, 0x2)
#define HTX_set_CLR_RX_RDY2(val)                            ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4A, 0x4, 0x2, val)

#define HTX_is_CLR_RX_RDY1_true()                           ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x4A, 0x2, 0x1)
#define HTX_get_CLR_RX_RDY1(pval)                           ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4A, 0x2, 0x1, pval)
#define HTX_ret_CLR_RX_RDY1()                               ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4A, 0x2, 0x1)
#define HTX_set_CLR_RX_RDY1(val)                            ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4A, 0x2, 0x1, val)

#define HTX_is_CLR_RX_RDY0_true()                           ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x4A, 0x1, 0x0)
#define HTX_get_CLR_RX_RDY0(pval)                           ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4A, 0x1, 0x0, pval)
#define HTX_ret_CLR_RX_RDY0()                               ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4A, 0x1, 0x0)
#define HTX_set_CLR_RX_RDY0(val)                            ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4A, 0x1, 0x0, val)

#define HTX_get_LOGICAL_ADDRESS_MASK(pval)                  ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4B, 0x70, 4, pval)
#define HTX_ret_LOGICAL_ADDRESS_MASK()                      ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4B, 0x70, 4)
#define HTX_set_LOGICAL_ADDRESS_MASK(val)                   ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4B, 0x70, 4, val)

#define HTX_is_ERROR_REPORT_MODE_true()                     ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x4B, 0x8, 0x3)
#define HTX_get_ERROR_REPORT_MODE(pval)                     ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4B, 0x8, 0x3, pval)
#define HTX_ret_ERROR_REPORT_MODE()                         ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4B, 0x8, 0x3)
#define HTX_set_ERROR_REPORT_MODE(val)                      ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4B, 0x8, 0x3, val)

#define HTX_is_ERROR_DET_MODE_true()                        ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x4B, 0x4, 0x2)
#define HTX_get_ERROR_DET_MODE(pval)                        ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4B, 0x4, 0x2, pval)
#define HTX_ret_ERROR_DET_MODE()                            ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4B, 0x4, 0x2)
#define HTX_set_ERROR_DET_MODE(val)                         ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4B, 0x4, 0x2, val)

#define HTX_is_FORCE_NACK_true()                            ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x4B, 0x2, 0x1)
#define HTX_get_FORCE_NACK(pval)                            ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4B, 0x2, 0x1, pval)
#define HTX_ret_FORCE_NACK()                                ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4B, 0x2, 0x1)
#define HTX_set_FORCE_NACK(val)                             ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4B, 0x2, 0x1, val)

#define HTX_is_FORCE_IGNORE_true()                          ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x4B, 0x1, 0x0)
#define HTX_get_FORCE_IGNORE(pval)                          ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4B, 0x1, 0x0, pval)
#define HTX_ret_FORCE_IGNORE()                              ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4B, 0x1, 0x0)
#define HTX_set_FORCE_IGNORE(val)                           ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4B, 0x1, 0x0, val)

#define HTX_get_LOGICAL_ADDRESS1(pval)                      ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4C, 0xF0, 4, pval)
#define HTX_ret_LOGICAL_ADDRESS1()                          ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4C, 0xF0, 4)
#define HTX_set_LOGICAL_ADDRESS1(val)                       ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4C, 0xF0, 4, val)

#define HTX_get_LOGICAL_ADDRESS0(pval)                      ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4C, 0xF, 0, pval)
#define HTX_ret_LOGICAL_ADDRESS0()                          ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4C, 0xF, 0)
#define HTX_set_LOGICAL_ADDRESS0(val)                       ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4C, 0xF, 0, val)

#define HTX_get_LOGICAL_ADDRESS2(pval)                      ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4D, 0xF, 0, pval)
#define HTX_ret_LOGICAL_ADDRESS2()                          ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4D, 0xF, 0)
#define HTX_set_LOGICAL_ADDRESS2(val)                       ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4D, 0xF, 0, val)

#define HTX_get_CLOCK_DIVIDER(pval)                         ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4E, 0xFC, 2, pval)
#define HTX_ret_CLOCK_DIVIDER()                             ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4E, 0xFC, 2)
#define HTX_set_CLOCK_DIVIDER(val)                          ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4E, 0xFC, 2, val)

#define HTX_get_POWER_MODE(pval)                            ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4E, 0x3, 0, pval)
#define HTX_ret_POWER_MODE()                                ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4E, 0x3, 0)
#define HTX_set_POWER_MODE(val)                             ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4E, 0x3, 0, val)

#define HTX_get_GLITCH_FILTER_CTRL(pval)                    ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x4F, 0x3F, 0, pval)
#define HTX_ret_GLITCH_FILTER_CTRL()                        ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x4F, 0x3F, 0)
#define HTX_set_GLITCH_FILTER_CTRL(val)                     ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x4F, 0x3F, 0, val)

#define HTX_is_SOFT_RESET_true()                            ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x50, 0x1, 0x0)
#define HTX_get_SOFT_RESET(pval)                            ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x50, 0x1, 0x0, pval)
#define HTX_ret_SOFT_RESET()                                ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x50, 0x1, 0x0)
#define HTX_set_SOFT_RESET(val)                             ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x50, 0x1, 0x0, val)

#define HTX_get_ST_TOTAL(pval)                              ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x51, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_ST_TOTAL()                                  ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x51, 0xFF, 0xFF, 0, 2)
#define HTX_set_ST_TOTAL(val)                               ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x51, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_ST_TOTAL_MIN(pval)                          ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x53, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_ST_TOTAL_MIN()                              ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x53, 0xFF, 0xFF, 0, 2)
#define HTX_set_ST_TOTAL_MIN(val)                           ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x53, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_ST_TOTAL_MAX(pval)                          ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x55, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_ST_TOTAL_MAX()                              ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x55, 0xFF, 0xFF, 0, 2)
#define HTX_set_ST_TOTAL_MAX(val)                           ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x55, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_ST_LOW(pval)                                ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x57, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_ST_LOW()                                    ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x57, 0xFF, 0xFF, 0, 2)
#define HTX_set_ST_LOW(val)                                 ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x57, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_ST_LOW_MIN(pval)                            ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x59, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_ST_LOW_MIN()                                ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x59, 0xFF, 0xFF, 0, 2)
#define HTX_set_ST_LOW_MIN(val)                             ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x59, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_ST_LOW_MAX(pval)                            ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x5B, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_ST_LOW_MAX()                                ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x5B, 0xFF, 0xFF, 0, 2)
#define HTX_set_ST_LOW_MAX(val)                             ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x5B, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_BIT_TOTAL(pval)                             ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x5D, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_BIT_TOTAL()                                 ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x5D, 0xFF, 0xFF, 0, 2)
#define HTX_set_BIT_TOTAL(val)                              ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x5D, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_BIT_TOTAL_MIN(pval)                         ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x5F, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_BIT_TOTAL_MIN()                             ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x5F, 0xFF, 0xFF, 0, 2)
#define HTX_set_BIT_TOTAL_MIN(val)                          ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x5F, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_BIT_TOTAL_MAX(pval)                         ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x61, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_BIT_TOTAL_MAX()                             ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x61, 0xFF, 0xFF, 0, 2)
#define HTX_set_BIT_TOTAL_MAX(val)                          ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x61, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_BIT_LOW_ONE(pval)                           ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x63, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_BIT_LOW_ONE()                               ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x63, 0xFF, 0xFF, 0, 2)
#define HTX_set_BIT_LOW_ONE(val)                            ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x63, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_BIT_LOW_ZERO(pval)                          ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x65, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_BIT_LOW_ZERO()                              ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x65, 0xFF, 0xFF, 0, 2)
#define HTX_set_BIT_LOW_ZERO(val)                           ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x65, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_BIT_LOW_MAX(pval)                           ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x67, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_BIT_LOW_MAX()                               ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x67, 0xFF, 0xFF, 0, 2)
#define HTX_set_BIT_LOW_MAX(val)                            ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x67, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_SAMPLE_TIME(pval)                           ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x69, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_SAMPLE_TIME()                               ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x69, 0xFF, 0xFF, 0, 2)
#define HTX_set_SAMPLE_TIME(val)                            ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x69, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_LINE_ERROR_TIME(pval)                       ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x6B, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_LINE_ERROR_TIME()                           ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x6B, 0xFF, 0xFF, 0, 2)
#define HTX_set_LINE_ERROR_TIME(val)                        ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x6B, 0xFF, 0xFF, 0, 2, val)

#define HTX_is_CEC_PIN_MODE_true()                          ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x6D, 0x1, 0x0)
#define HTX_get_CEC_PIN_MODE(pval)                          ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x6D, 0x1, 0x0, pval)
#define HTX_ret_CEC_PIN_MODE()                              ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x6D, 0x1, 0x0)
#define HTX_set_CEC_PIN_MODE(val)                           ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x6D, 0x1, 0x0, val)

#define HTX_get_RISE_TIME(pval)                             ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x6E, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_RISE_TIME()                                 ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x6E, 0xFF, 0xFF, 0, 2)
#define HTX_set_RISE_TIME(val)                              ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x6E, 0xFF, 0xFF, 0, 2, val)

#define HTX_is_BIT_LOW_DETMODE_true()                       ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x70, 0x1, 0x0)
#define HTX_get_BIT_LOW_DETMODE(pval)                       ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x70, 0x1, 0x0, pval)
#define HTX_ret_BIT_LOW_DETMODE()                           ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x70, 0x1, 0x0)
#define HTX_set_BIT_LOW_DETMODE(val)                        ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x70, 0x1, 0x0, val)

#define HTX_get_BIT_LOW_ONE_MIN(pval)                       ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x71, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_BIT_LOW_ONE_MIN()                           ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x71, 0xFF, 0xFF, 0, 2)
#define HTX_set_BIT_LOW_ONE_MIN(val)                        ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x71, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_BIT_LOW_ONE_MAX(pval)                       ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x73, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_BIT_LOW_ONE_MAX()                           ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x73, 0xFF, 0xFF, 0, 2)
#define HTX_set_BIT_LOW_ONE_MAX(val)                        ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x73, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_BIT_LOW_ZERO_MIN(pval)                      ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x75, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_BIT_LOW_ZERO_MIN()                          ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x75, 0xFF, 0xFF, 0, 2)
#define HTX_set_BIT_LOW_ZERO_MIN(val)                       ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x75, 0xFF, 0xFF, 0, 2, val)

#define HTX_get_WAKE_OPCODE0(pval)                          ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x77, 0xFF, 0, pval)
#define HTX_ret_WAKE_OPCODE0()                              ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x77, 0xFF, 0)
#define HTX_set_WAKE_OPCODE0(val)                           ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x77, 0xFF, 0, val)

#define HTX_get_WAKE_OPCODE1(pval)                          ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x78, 0xFF, 0, pval)
#define HTX_ret_WAKE_OPCODE1()                              ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x78, 0xFF, 0)
#define HTX_set_WAKE_OPCODE1(val)                           ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x78, 0xFF, 0, val)

#define HTX_get_WAKE_OPCODE2(pval)                          ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x79, 0xFF, 0, pval)
#define HTX_ret_WAKE_OPCODE2()                              ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x79, 0xFF, 0)
#define HTX_set_WAKE_OPCODE2(val)                           ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x79, 0xFF, 0, val)

#define HTX_get_WAKE_OPCODE3(pval)                          ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x7A, 0xFF, 0, pval)
#define HTX_ret_WAKE_OPCODE3()                              ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x7A, 0xFF, 0)
#define HTX_set_WAKE_OPCODE3(val)                           ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x7A, 0xFF, 0, val)

#define HTX_get_WAKE_OPCODE4(pval)                          ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x7B, 0xFF, 0, pval)
#define HTX_ret_WAKE_OPCODE4()                              ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x7B, 0xFF, 0)
#define HTX_set_WAKE_OPCODE4(val)                           ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x7B, 0xFF, 0, val)

#define HTX_get_WAKE_OPCODE5(pval)                          ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x7C, 0xFF, 0, pval)
#define HTX_ret_WAKE_OPCODE5()                              ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x7C, 0xFF, 0)
#define HTX_set_WAKE_OPCODE5(val)                           ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x7C, 0xFF, 0, val)

#define HTX_get_WAKE_OPCODE6(pval)                          ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x7D, 0xFF, 0, pval)
#define HTX_ret_WAKE_OPCODE6()                              ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x7D, 0xFF, 0)
#define HTX_set_WAKE_OPCODE6(val)                           ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x7D, 0xFF, 0, val)

#define HTX_get_WAKE_OPCODE7(pval)                          ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x7E, 0xFF, 0, pval)
#define HTX_ret_WAKE_OPCODE7()                              ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x7E, 0xFF, 0)
#define HTX_set_WAKE_OPCODE7(val)                           ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x7E, 0xFF, 0, val)

#define HTX_is_CDC_ARBITRATION_ENABLE_true()                ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x7F, 0x80, 0x7)
#define HTX_get_CDC_ARBITRATION_ENABLE(pval)                ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x7F, 0x80, 0x7, pval)
#define HTX_ret_CDC_ARBITRATION_ENABLE()                    ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x7F, 0x80, 0x7)
#define HTX_set_CDC_ARBITRATION_ENABLE(val)                 ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x7F, 0x80, 0x7, val)

#define HTX_is_CDC_HPD_RESPONSE_ENABLE_true()               ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x7F, 0x40, 0x6)
#define HTX_get_CDC_HPD_RESPONSE_ENABLE(pval)               ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x7F, 0x40, 0x6, pval)
#define HTX_ret_CDC_HPD_RESPONSE_ENABLE()                   ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x7F, 0x40, 0x6)
#define HTX_set_CDC_HPD_RESPONSE_ENABLE(val)                ATV_I2CWriteField8(HTX_CEC_MAP_ADDR, 0x7F, 0x40, 0x6, val)

#define HTX_get_CEC_PHYSICAL_ADDRESS(pval)                  ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0x80, 0xFF, 0xFF, 0, 2, pval)
#define HTX_ret_CEC_PHYSICAL_ADDRESS()                      ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0x80, 0xFF, 0xFF, 0, 2)
#define HTX_set_CEC_PHYSICAL_ADDRESS(val)                   ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0x80, 0xFF, 0xFF, 0, 2, val)

#define HTX_is_CDC_HPD_true()                               ATV_I2CIsField8(HTX_CEC_MAP_ADDR, 0x83, 0x80, 0x7)
#define HTX_get_CDC_HPD(pval)                               ATV_I2CGetField8(HTX_CEC_MAP_ADDR, 0x83, 0x80, 0x7, pval)
#define HTX_ret_CDC_HPD()                                   ATV_I2CReadField8(HTX_CEC_MAP_ADDR, 0x83, 0x80, 0x7)

#define HTX_get_Y_MIN(pval)                                 ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0xC0, 0xF, 0xFF, 0, 2, pval)
#define HTX_ret_Y_MIN()                                     ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0xC0, 0xF, 0xFF, 0, 2)
#define HTX_set_Y_MIN(val)                                  ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0xC0, 0xF, 0xFF, 0, 2, val)

#define HTX_get_Y_OR_RGB_MAXIMUM(pval)                      ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0xC2, 0xF, 0xFF, 0, 2, pval)
#define HTX_ret_Y_OR_RGB_MAXIMUM()                          ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0xC2, 0xF, 0xFF, 0, 2)
#define HTX_set_Y_OR_RGB_MAXIMUM(val)                       ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0xC2, 0xF, 0xFF, 0, 2, val)

#define HTX_get_CBCR_MINIMUM(pval)                          ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0xC4, 0xF, 0xFF, 0, 2, pval)
#define HTX_ret_CBCR_MINIMUM()                              ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0xC4, 0xF, 0xFF, 0, 2)
#define HTX_set_CBCR_MINIMUM(val)                           ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0xC4, 0xF, 0xFF, 0, 2, val)

#define HTX_get_CBCR_MAXIMUM(pval)                          ATV_I2CGetField32(HTX_CEC_MAP_ADDR, 0xC6, 0xF, 0xFF, 0, 2, pval)
#define HTX_ret_CBCR_MAXIMUM()                              ATV_I2CReadField32(HTX_CEC_MAP_ADDR, 0xC6, 0xF, 0xFF, 0, 2)
#define HTX_set_CBCR_MAXIMUM(val)                           ATV_I2CWriteField32(HTX_CEC_MAP_ADDR, 0xC6, 0xF, 0xFF, 0, 2, val)

#endif
