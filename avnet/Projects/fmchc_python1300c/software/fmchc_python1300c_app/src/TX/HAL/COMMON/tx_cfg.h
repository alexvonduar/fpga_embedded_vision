/**********************************************************************************************
*																						      *
* Copyright (c) 2012 Analog Devices, Inc.  All Rights Reserved.                               *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/

#ifndef _TX_CFG_H_
#define _TX_CFG_H_

#if TX_USER_CONFIG

#include "wrapper.h"

#else

#if (TX_DEVICE == 7623) || (TX_DEVICE == 7622) || (TX_DEVICE == 76221)
#define TX_I2C_MAIN_MAP_ADDR            0xBA
#elif (TX_DEVICE == 8002)
#define TX_I2C_MAIN_MAP_ADDR            0x1A
#elif (TX_DEVICE == 7850)
#define TX_I2C_MAIN_MAP_ADDR            0xB8
#else
#define TX_I2C_MAIN_MAP_ADDR            0x72
#endif
#define TX_I2C_PKT_MEM_MAP_ADDR         0x70
#define TX_I2C_CEC_MAP_ADDR             0x78
#define TX_I2C_EDID_MAP_ADDR            0x7E


#define TX2_I2C_MAIN_MAP_ADDR           0x7A
#define TX2_I2C_PKT_MEM_MAP_ADDR        0x76
#define TX2_I2C_CEC_MAP_ADDR            0x82
#define TX2_I2C_EDID_MAP_ADDR           0x86

#define TX_NUM_OF_DEVICES               1
#define TX_INCLUDE_CEC                  1
#define TX_SUPPORTED_DS_DEVICE_COUNT    10
#define TX_SUPPORTED_EDID_SEGMENTS      2
#define TX_EDID_RETRY_COUNT             8

#endif

#ifndef TX_NUM_OF_INSTANCES
#define TX_NUM_OF_INSTANCES             TX_NUM_OF_DEVICES
#endif

#if TX_USER_INIT
EXTERNAL CONSTANT UCHAR UserTxRegInitTable[];
EXTERNAL CONSTANT UCHAR UserTxFieldInitTable[];
#endif

#if (TX_DEVICE == 7510)
#include "7510_cfg.h"
#endif

#if (TX_DEVICE == 7520)
#include "7520_cfg.h"
#endif

#if (TX_DEVICE == 7623) || (TX_DEVICE == 7622) || (TX_DEVICE == 76221)
#include "7623_tx_cfg.h"
#endif

#if (TX_DEVICE == 7511)
#include "7511_cfg.h"
#endif

#if (TX_DEVICE == 8002)
#include "8002_tx_cfg.h"
#endif


#if (TX_DEVICE == 7850)
#include "7850_tx_cfg.h"
#endif


#if (TX_DEVICE == 7541)
#include "7541_cfg.h"
#endif

#if (TX_DEVICE == 7513)
#include "7513_cfg.h"
#endif

#endif
