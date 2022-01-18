/**********************************************************************************************
*																						      *
* Copyright (c) 2012 Analog Devices, Inc.  All Rights Reserved.                               *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/

/*============================================================================
 * This file contains all functions that are common between all devices
 * (wired and portable) that can't (or shouldn't) be implemented in
 * the tx_lib itself.
 * If a function in this file turns out to be devic-specific, it should be
 * moved to the chip-specifc (or family specific) HAL and duplicated for all 
 * other devices/families.
 *
 *===========================================================================*/
#include "tx_hal.h"
#include "tx_isr.h"

/*==========================================
 * Defines and macros
 *=========================================*/

/*==========================================
 * Local constants
 *=========================================*/
STATIC CONSTANT UCHAR CscYcc709ToRgb[]= {
    0xAC, 0x51, 0x08, 0x00, 0x00, 0x00, 0x19, 0xD7,
    0x1C, 0x54, 0x08, 0x00, 0x1E, 0x89, 0x02, 0x91,
    0x00, 0x00, 0x08, 0x00, 0x0E, 0x87, 0x18, 0xBC
};

STATIC CONSTANT UCHAR CscYuv709ToRgb[]= {
    0xE7, 0x2C, 0x04, 0xA7, 0x00, 0x00, 0x1C, 0x1F,
    0x1D, 0xDD, 0x04, 0xA7, 0x1F, 0x26, 0x01, 0x34,
    0x00, 0x00, 0x04, 0xA7, 0x08, 0x75, 0x1B, 0x7A
};

STATIC CONSTANT UCHAR CscYcc601ToRgb[]= {
    0xAA, 0xF7, 0x08, 0x00, 0x00, 0x00, 0x1A, 0x84,
    0x1A, 0x6A, 0x08, 0x00, 0x1D, 0x50, 0x04, 0x22,
    0x00, 0x00, 0x08, 0x00, 0x0D, 0xDB, 0x19, 0x12
};
 
STATIC CONSTANT UCHAR CscYuv601ToRgb[]= {
    0xE6, 0x62, 0x04, 0xA8, 0x00, 0x00, 0x1C, 0x84,
    0x1C, 0xBF, 0x04, 0xA8, 0x1E, 0x70, 0x02, 0x1E,
    0x00, 0x00, 0x04, 0xA8, 0x08, 0x12, 0x1B, 0xAC
};

STATIC CONSTANT UCHAR CscRgbToYcc709[]= {
    0x88, 0x2D, 0x18, 0x94, 0x1F, 0x40, 0x08, 0x00,
    0x03, 0x68, 0x0B, 0x70, 0x01, 0x26, 0x00, 0x00,
    0x1E, 0x21, 0x19, 0xB3, 0x08, 0x2D, 0x08, 0x00
};

STATIC CONSTANT UCHAR CscRgbToYuv709[]= {
    0x87, 0x06, 0x19, 0x9E, 0x1F, 0x5D, 0x08, 0x00,
    0x02, 0xED, 0x09, 0xD2, 0x00, 0xFD, 0x01, 0x00,
    0x1E, 0x63, 0x1A, 0x98, 0x07, 0x06, 0x08, 0x00
};

STATIC CONSTANT UCHAR CscRgbToYcc601[]= {
    0x88, 0x2D, 0x19, 0x27, 0x1E, 0xAD, 0x08, 0x00,
    0x03, 0xA9, 0x09, 0x64, 0x01, 0xD2, 0x00, 0x00,
    0x1D, 0x40, 0x1A, 0x94, 0x08, 0x2D, 0x08, 0x00
};
 
STATIC CONSTANT UCHAR CscRgbToYuv601[]= {
    0x87, 0x06, 0x1A, 0x1E, 0x1E, 0xDE, 0x08, 0x00,
    0x04, 0x1C, 0x08, 0x10, 0x01, 0x91, 0x01, 0x00,
    0x1D, 0xA2, 0x1B, 0x59, 0x07, 0x06, 0x08, 0x00
};

STATIC CONSTANT UCHAR CscRgbFRtoYcc709FR[]= {
    0x88, 0x00, 0x18, 0xBC, 0x1F, 0x45, 0x08, 0x00, 
    0x03, 0x66, 0x0B, 0x71, 0x01, 0x27, 0x00, 0x00,
    0x1E, 0x2B, 0x19, 0xD6, 0x08, 0x00, 0x08, 0x00
};

STATIC CONSTANT UCHAR CscRgbFRtoYcc601FR[]= {
    0x88, 0x00, 0x19, 0x4E, 0x1E, 0xB3, 0x08, 0x00,
    0x04, 0xC8, 0x09, 0x64, 0x01, 0xD2, 0x00, 0x00,
    0x1D, 0x4D, 0x1A, 0xB4, 0x08, 0x00, 0x08, 0x00
};

STATIC CONSTANT UCHAR CscRgbFRtoRgbLR[]= {
    0x8D, 0xBC, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,
    0x00, 0x00, 0x0D, 0xBC, 0x00, 0x00, 0x01, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x0D, 0xBC, 0x01, 0x00
};

STATIC CONSTANT UCHAR CscRgbLRtoRgbFR[]= {
    0xA9, 0x50, 0x00, 0x00, 0x00, 0x00, 0x1F, 0x6B,
    0x00, 0x00, 0x09, 0x50, 0x00, 0x00, 0x1F, 0x6B,
    0x00, 0x00, 0x00, 0x00, 0x09, 0x50, 0x1F, 0x6B
};

STATIC CONSTANT UCHAR CscYcc709FRtoRgbFR[]= {
    0xAC, 0x99, 0x08, 0x00, 0x00, 0x00, 0x19, 0xB3,
    0x1E, 0x80, 0x08, 0x00, 0x1C, 0x41, 0x02, 0x9F,
    0x00, 0x00, 0x08, 0x00, 0x0E, 0xD8, 0x18, 0x94
};

STATIC CONSTANT UCHAR CscYcc709FRtoRgbLR[]= {
    0xAA, 0x78, 0x06, 0xB3, 0x00, 0x0B, 0x1B, 0x3E,
    0x1C, 0xD9, 0x06, 0xB3, 0x1E, 0xBA, 0x02, 0xB6,
    0x1F, 0xF8, 0x06, 0xB3, 0x0C, 0x5A, 0x1A, 0x57
};

STATIC CONSTANT UCHAR CscYcc709LRtoYcc601LR[]= {
    0xA7, 0xDD, 0x00, 0x00, 0x1F, 0x6C, 0x00, 0x5B,
    0x01, 0x88, 0x08, 0x00, 0x00, 0xCB, 0x1E, 0xD6,
    0x1F, 0x1D, 0x00, 0x00, 0x07, 0xEB, 0x00, 0x7B
};

STATIC CONSTANT UCHAR CscYcc709LRtoYcc601FR[]= {
    0xA8, 0xEB, 0x00, 0x00, 0x1F, 0x58, 0x1F, 0xDE,
    0x01, 0xC9, 0x09, 0x50, 0x00, 0xEC, 0x1F, 0x25,
    0x1E, 0xFF, 0x00, 0x00, 0x08, 0xFA, 0x03, 0x1F
};

STATIC CONSTANT UCHAR CscYcc709LRtoYcc709FR[]= {
    0xA9, 0x1B, 0x00, 0x00, 0x00, 0x00, 0x1F, 0x72,
    0x00, 0x00, 0x09, 0x5A, 0x00, 0x00, 0x1F, 0x6A,
    0x00, 0x00, 0x00, 0x00, 0x09, 0x1B, 0x1F, 0x72
};

STATIC CONSTANT UCHAR CscYcc709FRtoYcc709LR[]= {
    0x8E, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF8,
    0x00, 0x00, 0x0D, 0xB0, 0x20, 0x00, 0x1F, 0x25,
    0x20, 0x00, 0x00, 0x00, 0x0E, 0x0E, 0x00, 0xF8
};

STATIC CONSTANT UCHAR CscYcc709FRtoYcc601LR[]= {
    0x8D, 0xD2, 0x00, 0x00, 0x1E, 0xFD, 0x01, 0x98,
    0x02, 0xB1, 0x0D, 0xB0, 0x01, 0x64, 0x1D, 0x1A,
    0x1E, 0x72, 0x00, 0x00, 0x0D, 0xEA, 0x01, 0xD2
};

STATIC CONSTANT UCHAR CscYcc601FRtoRgbFR[]= {
    0xAB, 0x37, 0x08, 0x00, 0x00, 0x00, 0x1A, 0x64, 
    0x1A, 0x4A, 0x08, 0x00, 0x1D, 0x3F, 0x04, 0x3B, 
    0x00, 0x00, 0x08, 0x00, 0x0E, 0x2D, 0x18, 0xE9
};

STATIC CONSTANT UCHAR CscYcc601FRtoRgbLR[]= {
    0xA9, 0x5C, 0x06, 0xB3, 0x00, 0x06, 0x1B, 0xCE,
    0x1B, 0x32, 0x06, 0xB3, 0x1D, 0xBC, 0x04, 0x09,
    0x1F, 0xE7, 0x06, 0xAC, 0x0B, 0xD9, 0x1A, 0xA0
};

STATIC CONSTANT UCHAR CscYcc601FRtoYcc709LR[]= {
    0xA7, 0x2D, 0x00, 0x00, 0x00, 0x87, 0x00, 0x25,
    0x1E, 0x89, 0x06, 0xDE, 0x1F, 0x41, 0x01, 0x9B,
    0x00, 0xCB, 0x00, 0x00, 0x07, 0x21, 0x00, 0x09
};

STATIC CONSTANT UCHAR CscYcc601LRtoYcc709LR[]= {
    0xA8, 0x33, 0x00, 0x00, 0x00, 0x99, 0x1F, 0x99,
    0x1E, 0x56, 0x08, 0x00, 0x1F, 0x13, 0x01, 0x4B,
    0x00, 0xEA, 0x00, 0x00, 0x08, 0x26, 0x1F, 0x78
};

STATIC CONSTANT UCHAR CscYcc601LRtoYcc601FR[]= {
    0xA9, 0x1B, 0x00, 0x00, 0x00, 0x00, 0x1F, 0x6E,
    0x00, 0x00, 0x09, 0x50, 0x00, 0x00, 0x1F, 0x6B,
    0x00, 0x00, 0x00, 0x00, 0x09, 0x1B, 0x1F, 0x6E
};

STATIC CONSTANT UCHAR CscYcc601FRtoYcc601LR[]= {
    0x8E, 0x0D, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,
    0x00, 0x00, 0x0D, 0xBC, 0x00, 0x00, 0x01, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x0E, 0x0D, 0x01, 0x00
};

STATIC CONSTANT UCHAR CscYcc601LRtoYcc709FR[]= {
    0xA9, 0x56, 0x00, 0x00, 0x00, 0xAE, 0x1E, 0xFE,
    0x1E, 0x0E, 0x09, 0x5A, 0x1E, 0xEC, 0x00, 0xED,
    0x01, 0x0B, 0x00, 0x00, 0x09, 0x46, 0x1E, 0xD7
};


typedef struct
{
    TX_CS_MODE  InClrSp;
    TX_CS_MODE  OutClrSp;
    CONSTANT UCHAR *ConvTable;
} CSC_TABLES;

STATIC CONSTANT CSC_TABLES CscTables[] = {
    {TX_CS_YCC_709,            TX_CS_RGB,                 CscYcc709ToRgb}, 
    {TX_CS_YUV_709,            TX_CS_RGB,                 CscYuv709ToRgb}, 
    {TX_CS_YCC_601,            TX_CS_RGB,                 CscYcc601ToRgb}, 
    {TX_CS_YUV_601,            TX_CS_RGB,                 CscYuv601ToRgb}, 
    {TX_CS_RGB,                TX_CS_YCC_709,             CscRgbToYcc709}, 
    {TX_CS_RGB,                TX_CS_YUV_709,             CscRgbToYuv709},
    {TX_CS_RGB,                TX_CS_YCC_601,             CscRgbToYcc601}, 
    {TX_CS_RGB,                TX_CS_YUV_601,             CscRgbToYuv601},
    {TX_CS_YCC_709_FULL_RANGE, TX_CS_RGB_FULL_RANGE,      CscYcc709FRtoRgbFR}, 
    {TX_CS_YCC_601_FULL_RANGE, TX_CS_RGB_FULL_RANGE,      CscYcc601FRtoRgbFR}, 
    {TX_CS_RGB_FULL_RANGE,     TX_CS_YCC_709_FULL_RANGE,  CscRgbFRtoYcc709FR}, 
    {TX_CS_RGB_FULL_RANGE,     TX_CS_YCC_601_FULL_RANGE,  CscRgbFRtoYcc601FR}, 
    {TX_CS_YCC_601_219,        TX_CS_YCC_709_219,         CscYcc601LRtoYcc709LR}, 
    {TX_CS_YCC_709_219,        TX_CS_YCC_601_219,         CscYcc709LRtoYcc601LR}, 
    {TX_CS_YCC_601_255,        TX_CS_YCC_709_219,         CscYcc601FRtoYcc709LR}, 
    {TX_CS_YCC_709_219,        TX_CS_YCC_601_255,         CscYcc709LRtoYcc601FR}, 
    {TX_CS_YCC_601_219,        TX_CS_YCC_601_255,         CscYcc601LRtoYcc601FR}, 
    {TX_CS_YCC_601_255,        TX_CS_YCC_601_219,         CscYcc601FRtoYcc601LR}, 
    {TX_CS_YCC_601_219,        TX_CS_YCC_709_255,         CscYcc601LRtoYcc709FR}, 
    {TX_CS_YCC_709_219,        TX_CS_YCC_709_255,         CscYcc709LRtoYcc709FR}, 
    {TX_CS_YCC_709_255,        TX_CS_YCC_709_219,         CscYcc709FRtoYcc709LR}, 
    {TX_CS_YCC_709_255,        TX_CS_YCC_601_219,         CscYcc709FRtoYcc601LR}, 
    {TX_CS_RGB,                TX_CS_RGB_FULL_RANGE,      CscRgbLRtoRgbFR}, 
    {TX_CS_RGB_FULL_RANGE,     TX_CS_RGB,                 CscRgbFRtoRgbLR}, 
    {TX_CS_YCC_709_255,        TX_CS_RGB,                 CscYcc709FRtoRgbLR}, 
    {TX_CS_YCC_601_255,        TX_CS_RGB,                 CscYcc601FRtoRgbLR}, 
    {TX_CS_AUTO,    TX_CS_AUTO,     NULL}
};

STATIC CONSTANT UCHAR ChanMapping[32] = {
        0x1, 0x3, 0x3, 0x3, 0x5, 0x7, 0x7, 0x7,
        0x5, 0x7, 0x7, 0x7, 0xD, 0xF, 0xF, 0xF,
        0xD, 0xF, 0xF, 0xF, 0x9, 0xB, 0xB, 0xB,
        0xD, 0xF, 0xF, 0xF, 0xD, 0xF, 0xF, 0xF
};

typedef struct
{
    TX_AUD_FORMAT   InFrmt;
    TX_AUD_PKT_TYPE PktType;
    UCHAR           AudSel;
    UCHAR           AudMode;
    UCHAR           I2SFormat;
} AUD_TABLES;

STATIC CONSTANT AUD_TABLES AudTables[]= {
    {TX_I2S_STD,        AUD_SAMP_PKT, 0, 0, 0},
    {TX_I2S_RJUST,      AUD_SAMP_PKT, 0, 0, 1},
    {TX_I2S_LJUST,      AUD_SAMP_PKT, 0, 0, 2},
    {TX_I2S_AES3,       AUD_SAMP_PKT, 0, 0, 3},
    {TX_SPDIF,          AUD_SAMP_PKT, 1, 0, 0},
    {TX_I2S_STD,        HBR_STRM_PKT, 3, 1, 0},
    {TX_I2S_RJUST,      HBR_STRM_PKT, 3, 1, 1},
    {TX_I2S_LJUST,      HBR_STRM_PKT, 3, 1, 2},
    {TX_I2S_AES3,       HBR_STRM_PKT, 3, 1, 3},
    {TX_I2S_SPDIF,      HBR_STRM_PKT, 3, 0, 0},
    {TX_DSD_NORM,       ONE_BIT_ASP,  2, 0, 0},
    {TX_DSD_SDIF3,      ONE_BIT_ASP,  2, 2, 0},
    {TX_DSD_DST,        DST_AUD_PKT,  4, 0, 0},
    {TX_DSD_DST_SDR,    DST_AUD_PKT,  4, 1, 0},
    {TX_DSD_DST_DDR,    DST_AUD_PKT,  4, 3, 0},
    {TX_DSD_DST_DDR,    DST_AUD_PKT,  0xff, 0xff, 0xff}
};

STATIC CONSTANT UCHAR SfTable[] = {
        (UCHAR)TX_FS_32KHZ,     3,      (UCHAR)TX_FS_44KHZ,     0,
        (UCHAR)TX_FS_48KHZ,     2,      (UCHAR)TX_FS_88KHZ,     8,
        (UCHAR)TX_FS_96KHZ,    10,      (UCHAR)TX_FS_176KHZ,   12,
        (UCHAR)TX_FS_192KHZ,   14,      (UCHAR)TX_FS_HBR,       9,
        (UCHAR)TX_FS_FROM_STRM, 0,      0xff,                0xff
};
     
                                 /*  32    44    48     88     96    176    192    768   Undefined */
STATIC CONSTANT UINT32 NTable[9] ={4096, 6272, 6144, 12544, 12288, 25088, 24576, 98304,  4096};
STATIC CONSTANT UCHAR  NIdx[16]  ={ 1,  8,  2,  0,  8,  8,  8,  8, 
                                    3,  7,  4,  8,  5,  8,  6,  8};
STATIC CONSTANT UCHAR  SSize1[4] ={ 0, 16, 20, 24};
STATIC CONSTANT UCHAR  SSize2[16]={ 0,  0, 16, 20, 18, 22,  0,  0, 
                                   19, 23, 20, 24, 17, 21,  0,  0};

STATIC CONSTANT TX_HDCP_ERR HdcpErrorTable[]={TX_HDCP_ERR_NONE,
    TX_HDCP_ERR_BAD_RECV_BKSV,       TX_HDCP_ERR_RI_MISMATCH,
    TX_HDCP_ERR_PJ_MISMATCH,         TX_HDCP_ERR_I2C_ERROR,
    TX_HDCP_ERR_REP_DONE_TIMEOUT,    TX_HDCP_ERR_MAX_CASCADE_EXCEEDED,
    TX_HDCP_ERR_V_DASH_CHECK_FAILED, TX_HDCP_ERR_MAX_DEVICE_EXCEEDED};

/*==================================
 * Shared Variables
 *=================================*/
CONSTANT TX_DEV_ADDR TxDeviceAddress[TX_NUM_OF_DEVICES]= {
{
    TX_I2C_MAIN_MAP_ADDR,
    TX_I2C_PKT_MEM_MAP_ADDR,
    TX_I2C_EDID_MAP_ADDR,
    TX_I2C_CEC_MAP_ADDR
}
#if (TX_NUM_OF_DEVICES > 1)
,{
    TX2_I2C_MAIN_MAP_ADDR,
    TX2_I2C_PKT_MEM_MAP_ADDR,
    TX2_I2C_EDID_MAP_ADDR,
    TX2_I2C_CEC_MAP_ADDR
}
#endif
#if (TX_NUM_OF_DEVICES > 2)
,{
    TX3_I2C_MAIN_MAP_ADDR,
    TX3_I2C_PKT_MEM_MAP_ADDR,
    TX3_I2C_EDID_MAP_ADDR,
    TX3_I2C_CEC_MAP_ADDR
}
#endif
};

STATIC CONSTANT UCHAR IntMap[] = {
    CEC_INT_RX_RDY1,         TX_REG_CEC_INTS,    CEC_RX_RDY1_INT_BIT, 
    CEC_INT_RX_RDY2,         TX_REG_CEC_INTS,    CEC_RX_RDY2_INT_BIT, 
    CEC_INT_RX_RDY3,         TX_REG_CEC_INTS,    CEC_RX_RDY3_INT_BIT, 
    CEC_INT_RX_RDY,         TX_REG_CEC_INTS,    CEC_RX_RDY_INT_BIT, 
    CEC_INT_TX_TIMEOUT,     TX_REG_CEC_INTS,    CEC_TX_TIMEOUT_INT_BIT,
    CEC_INT_TX_ARB_LOST,    TX_REG_CEC_INTS,    CEC_TX_ARB_LOST_INT_BIT, 
    CEC_INT_TX_RDY,         TX_REG_CEC_INTS,    CEC_TX_RDY_INT_BIT,
    TX_INT_BKSV_READY,      TX_REG_CEC_INTS,    TX_BKSV_READY_INT_BIT,
    TX_INT_HDCP_ERR,        TX_REG_CEC_INTS,    TX_HDCP_ERR_INT_BIT,
    TX_INT_HPD_CHNG,        TX_REG_INTS,        TX_HPD_CHNG_INT_BIT,
    TX_INT_MSEN_CHNG,       TX_REG_INTS,        TX_MSEN_CHNG_INT_BIT,
    TX_INT_HDCP_AUTH,       TX_REG_INTS,        TX_HDCP_AUTH_INT_BIT,
    TX_INT_EDID_READY,      TX_REG_INTS,        TX_EDID_READY_INT_BIT,
    TX_INT_EMB_SYNC_ERR,    TX_REG_INTS,        TX_EMB_SYNC_ERR_INT_BIT,
    TX_INT_AUD_FIFO_FULL,   TX_REG_INTS,        TX_AUD_FIFO_FULL_INT_BIT,
    TX_INT_VSYNC_EDGE,      TX_REG_INTS,        TX_VSYNC_EDGE_INT_BIT,
    0xff
};

/*==========================================
 * Local prototypes
 *=========================================*/

/*==========================================================================
 *
 *
 *=========================================================================*/
ATV_ERR TXHAL_SetChipIndex (UCHAR ChipIdx)
{
    if (ChipIdx < TX_NUM_OF_INSTANCES)
    {
        TxCurrDevIdx = ChipIdx;
        if (TX_NUM_OF_DEVICES == 1)
        {
            TxDevAddr = &(TxDeviceAddress[0]);
        }
        else
        {
            TxDevAddr = &(TxDeviceAddress[TxCurrDevIdx]);
        }
        return (ATVERR_OK);
    }
    return (ATVERR_INV_PARM);
}

/*==========================================================================
 *
 *
 *=========================================================================*/
ATV_ERR TXHAL_Initialize (BOOL FullInit)
{
    /*========================================
     * Send AV mute and power down TMDS lines 
     *=======================================*/
    TXHAL_EnableTmds (FALSE, TRUE);
    TXHAL_SetAvMute(TX_AVMUTE_ON);

    /*========================================
     * Power up the chip and load default 
     * registers values
     *=======================================*/
    HAL_DelayMs(20);
    TXHAL_Powerup();

    /*====================================
     * Disable CSC and Enable audio
     * Disable all info-frames and CEC
     * Set default input format
     *===================================*/
    TXREG_SET_CSC_ENABLE(0);
    TXREG_SET_LOW_FRQ_VIDEO(0);
    TXREG_SET_PIXEL_REP_MODE(0);
    TXREG_SET_I2S_ENABLE(1);
    TXREG_SET_SPDIF_ENABLE(1);
#if TX_INCLUDE_CEC
    if ((FullInit) || (TxCurrDevIdx != TxActiveCecIdx))
    {
        TXREG_SET_CEC_PD(1);        /* Only one CEC engine can be active */
    }
#else
    TXREG_SET_CEC_PD(1);
#endif
    TXHAL_EnableInfoFrames (PKT_ALL_PACKETS, FALSE);
    TXHAL_SetInputFormat (12, SDR_444_SEP_SYNC, 1, ALIGN_EVEN, FALSE, TRUE);

    return (ATVERR_OK);
}

/*==========================================================================
 *
 *
 *=========================================================================*/
void TXHAL_SetAvMute (TX_AVMUTE State)
{
    switch (State)
    {
        case TX_AVMUTE_ON:
            TXREG_SET_AVMUTE_ON(TRUE);
            break;
        case TX_AVMUTE_OFF:
            TXREG_SET_AVMUTE_ON(FALSE);
            break;
        case TX_AVMUTE_NONE:
            TXREG_SET_SET_AVMUTE(FALSE);
            TXREG_SET_CLEAR_AVMUTE(FALSE);
            break;
        case TX_AVMUTE_BOTH:
            TXREG_SET_SET_AVMUTE(TRUE);
            TXREG_SET_CLEAR_AVMUTE(TRUE);
            break;
        default:
            break;
    }
}

/*==========================================================================
 * Enable or disable all of TMDS channels and clock lines
 *
 * Entry:   Enable  = TRUE to enable TMDS lines
 *                  = FALSE to disable TMDS lines
 *          SoftOn  = TRUE/FALSE to turn soft TMDS on
 *
 * Return:  None
 *
 *=========================================================================*/
void TXHAL_EnableTmds (BOOL Enable, BOOL SoftOn)
{
    /*====================================
     * Enable soft turn on TMDS
     *===================================*/
    if (Enable && SoftOn)
    {
        TXREG_SET_SOFT_TMDS_ON(1);
        TXREG_SET_SOFT_CLK_GATING(1);
    }
#if (TX_DEVICE == 7850)
    TXREG_SET_TMDS_PD(Enable? 0x0f: 0);
#else
    TXREG_SET_TMDS_PD(Enable? 0: 0x0f);
#endif
    /*====================================
     * Disable soft turn on TMDS
     *===================================*/
    if (Enable && SoftOn)
    {
        TXREG_SET_SOFT_TMDS_ON(0);
        TXREG_SET_SOFT_CLK_GATING(0);
    }
}

/*===========================================================================
 * Enable/Disable packets and info-frames
 *
 * Entry:   InfoFrames  = Packets to enable or disable ORed together
 *          Enable      = TRUE/FALSE to enable/disable packets or InfoFrames
 *
 * Return:  None
 *
 *===========================================================================*/
void TXHAL_EnableInfoFrames (UINT16 InfoFrames, BOOL Enable)
{
    UINT16 PktEn;

    PktEn = Enable? 1: 0;

    if (InfoFrames & PKT_AV_INFO_FRAME)
    {
        TXREG_SET_AVIIF_PKT_EN(PktEn);
    }
    if (InfoFrames & PKT_AUDIO_INFO_FRAME)
    {
        TXREG_SET_AUDIOIF_PKT_EN(PktEn);
    }
    if (InfoFrames & PKT_ACP_PACKET)
    {
        TXREG_SET_ACP_PKT_EN(PktEn);
    }
    if (InfoFrames & PKT_SPD_PACKET)
    {
        TXREG_SET_SPD_PKT_EN(PktEn);
    }
    if (InfoFrames & PKT_ISRC1_PACKET)      /* En/Dis on ISRC 1 only */
    {
        TXREG_SET_ISRC_PKT_EN(PktEn);
    }
    if (InfoFrames & PKT_GMD_PACKET)
    {
        TXREG_SET_GMD_PKT_EN(PktEn);
    }
    if (InfoFrames & PKT_MPEG_PACKET)
    {
        TXREG_SET_MPEG_PKT_EN(PktEn);
    }
    if (InfoFrames & PKT_VS_PACKET)
    {
        TXREG_SET_SPARE1_PKT_EN(PktEn);
    }
    if (InfoFrames & PKT_GC_PACKET)
    {
        TXREG_SET_GC_PKT_EN(PktEn);
    }
    if (InfoFrames & PKT_ACR_PACKET)
    {
        TXREG_SET_N_CTS_PKT_EN(PktEn);
    }
    if (InfoFrames & PKT_AUDIO_SAMPLE_PACKET)
    {
        TXREG_SET_AUD_SAMPLE_PKT_EN(PktEn);
    }
}

/*==========================================================================
 * 
 *
 *
 *
 *=========================================================================*/
ATV_ERR TXHAL_SetInputFormat (UCHAR BitsPerColor, TX_IN_FORMAT Format,
                              UCHAR Style, TX_CHAN_ALIGN Alignment, 
                              BOOL ClkEdge, BOOL BitSwap)
{
    UCHAR Frmt, Align;
    CONSTANT UCHAR Bpc[]= {10, 1, 12, 2, 8, 3, 0xff, 0xff};
    CONSTANT UCHAR Sty[]= { 1, 0,  2, 1, 3, 3, 0xff, 0xff};
    CONSTANT UCHAR Alg[]= {(UCHAR) ALIGN_EVEN,   0, (UCHAR) ALIGN_RIGHT, 1, 
                           (UCHAR) ALIGN_LEFT,   2, 0xff,                0xff};
    CONSTANT UCHAR Frm[]= {
        (UCHAR) SDR_444_SEP_SYNC, 0,        (UCHAR) SDR_422_SEP_SYNC, 1,
        (UCHAR) SDR_422_EMP_SYNC, 2,        (UCHAR) SDR_422_SEP_SYNC_2X_CLK, 3,
        (UCHAR) SDR_422_EMB_SYNC_2X_CLK, 4, (UCHAR) DDR_444_SEP_SYNC, 5,
        (UCHAR) DDR_422_SEP_SYNC, 6,        (UCHAR) DDR_422_EMB_SYNC, 8,
        0xff,                     0xff};

    BitsPerColor = Bpc[ATV_LookupValue8((UCHAR *)Bpc, BitsPerColor,     0xff, 2)+1];
    Style        = Sty[ATV_LookupValue8((UCHAR *)Sty, Style,            0xff, 2)+1];
    Frmt         = Frm[ATV_LookupValue8((UCHAR *)Frm, (UCHAR)Format,    0xff, 2)+1];
    Align        = Alg[ATV_LookupValue8((UCHAR *)Alg, (UCHAR)Alignment, 0xff, 2)+1];

    if ((BitsPerColor | Style | Frmt | Align) == 0xff)
    {
        return (ATVERR_INV_PARM);
    }
    TXREG_SET_INPUT_VID_FORMAT(Frmt);
    TXREG_SET_INPUT_VID_STYLE(Style);
    TXREG_SET_INPUT_VID_CLR_DEPTH(BitsPerColor);
    TXREG_SET_INPUT_VID_ALIGN(Align);
    TXREG_SET_INPUT_VID_CLK_EDGE(ClkEdge? 1: 0);
    TXREG_SET_INPUT_VID_BIT_SWAP(BitSwap? 1: 0);
    return (ATVERR_OK);
}

/*==========================================================================
 *
 *
 *
 *=========================================================================*/
TX_HDCP_ERR TXHAL_GetHdcpError (void)
{
    UCHAR Err;

    Err = TXREG_GET_HDCP_ERROR();
    if (Err > 8)
    {
        Err = 0;
    }
    return (HdcpErrorTable[Err]);
}

/*==========================================================================
 *
 *
 *=========================================================================*/
ATV_ERR TXHAL_ReadBksvs (UCHAR *BksvBuf, UCHAR Count)
{
    UCHAR Bksv0[5];

    if (Count)
    {
        TXHAL_I2CReadBlock(TXDEV_EDID_MAP, 
                TXHAL_REG_OFFSET(TXDEV_EDID_OFFSET, TX_REG_BKSVS), 
                BksvBuf, (UINT16)Count*5);
    }
    else
    {
        TXHAL_I2CReadBlock(TXDEV_MAIN_MAP, 
                TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_BKSV_0), 
                Bksv0, 5);
        BksvBuf[0] = Bksv0[4];      /* BKSV 0 is inverted */
        BksvBuf[1] = Bksv0[3];
        BksvBuf[2] = Bksv0[2];
        BksvBuf[3] = Bksv0[1];
        BksvBuf[4] = Bksv0[0];
    }
    return (ATVERR_OK);
}

/*==========================================================================
 *
 *
 *=========================================================================*/
ATV_ERR TXHAL_ReadEdid (UCHAR *EdidBuf)
{
    TXHAL_I2CReadBlock(TXDEV_EDID_MAP, 
            TXHAL_REG_OFFSET(TXDEV_EDID_OFFSET, 0), 
            EdidBuf, 256);
    return (ATVERR_OK);
}

/*==========================================================================
 * 
 * 
 *
 *
 *=========================================================================*/
ATV_ERR TXHAL_HdcpEnable (BOOL EncEn, BOOL FrmEncEn)
{
#if 0
    TXREG_SET_HDCP_ENABLE(EncEn? 1: 0);
    if ((!EncEn) && (!FrmEncEn))
    {
        HAL_DelayMs(10);
    }
    TXREG_SET_HDCP_FRAME_ENABLE(FrmEncEn? 1: 0);
#else
    if ((!EncEn) && (!FrmEncEn))
    {
        TXREG_SET_HDCP_FRAME_ENABLE(0);
        HAL_DelayMs(20);
        TXREG_SET_HDCP_ENABLE(0);
    }
    else if (EncEn && FrmEncEn)
    {
        TXREG_SET_HDCP_ENABLE(1);
        HAL_DelayMs(20);
        TXREG_SET_HDCP_FRAME_ENABLE(1);
    }
    else
    {
        TXREG_SET_HDCP_ENABLE(EncEn? 1: 0);
        TXREG_SET_HDCP_FRAME_ENABLE(FrmEncEn? 1: 0);
    }
#endif
    return (ATVERR_OK);
}

/*==========================================================================
 * Set Right Justified Audio sample size from audio info-frame (if not 0)
 * or from channel status data
 *
 *
 *=========================================================================*/
void TXHAL_SetRJI2SSampSize (void)
{
    UCHAR SampSize;

    SampSize = TXREG_GET_AUDIO_IF_SF();
    if (SampSize)
    {
        SampSize = SSize1[SampSize & 3];
    }
    else
    {
        SampSize = SSize2[TXREG_GET_CHST_4BIT_WLEN() & 0xf];
    }
    TXREG_SET_I2S_RJ_BIT_WIDTH(SampSize);
}

/*==========================================================================
 * 
 *
 *
 *
 *=========================================================================*/
ATV_ERR TXHAL_SetCSC (TX_CS_MODE InCs, TX_CS_MODE OutCs)
{
    UCHAR i;
    ATV_ERR RetVal = ATVERR_INV_PARM;

    /*==================================
     * If CSC should be disabled
     *=================================*/
    if ((InCs == OutCs) || (InCs == TX_CS_AUTO) || (OutCs == TX_CS_AUTO))
    {
        TXREG_SET_CSC_ENABLE(0);
        RetVal = ATVERR_OK;
    }
    else
    {
        for (i=0; CscTables[i].ConvTable; i++)
        {
            if ((CscTables[i].InClrSp == InCs) && (CscTables[i].OutClrSp == OutCs))
            {
                TXHAL_I2CWriteBlock (TXDEV_MAIN_MAP, 
                        TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_CSC_BASE),
                                   (UCHAR *)(CscTables[i].ConvTable), 24);
                TXREG_SET_CSC_ENABLE(1);
                RetVal = ATVERR_OK;
                break;
            }
        }
    }
    return (RetVal);
}

/*==========================================================================
 * 
 *
 *
 *
 *=========================================================================*/
void TXHAL_SetChanStatusBits (TX_CHAN_STATUS *ChStat)
{
    UCHAR Count = 3;
    UCHAR Bytes[4];

    Bytes[0] = (ChStat->CsSampType?  0x80: 0) |
               (ChStat->CsConsumer?  0x40: 0) |
               (ChStat->CsCopyright? 0x20: 0) |
              ((ChStat->CsEmphasis & 0x07) << 2) |
               (ChStat->CsClkAccur & 0x03);
    Bytes[1] = ChStat->CsCatCode;
    Bytes[2] = ((ChStat->CsSrcNum & 0x0f) << 4) | ChStat->CsWordLen;
    if (ChStat->CsSampFreq != 0xff)
    {
        TXHAL_I2CReadByte(TXDEV_MAIN_MAP, 
                TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_CS_SF), 
                &(Bytes[3]));
        Bytes[3] &= 0x0f;
        Bytes[3] |= ((ChStat->CsSampFreq & 0x0f) << 4);
        Count++;
    }
    TXHAL_I2CWriteBlock(TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_CS_DATA), 
            Bytes, Count);
}

/*===========================================================================
 * Set the source and value for sampling frequency
 *
 * Entry:   SampFreq = Required sampling frequency
 *                      TX_FS_32KHZ
 *                      TX_FS_44KHZ
 *                      TX_FS_48KHZ
 *                      TX_FS_88KHZ
 *                      TX_FS_96KHZ
 *                      TX_FS_176KHZ
 *                      TX_FS_192KHZ
 *                      TX_FS_HBR
 *                      TX_FS_FROM_STRM
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes: 
 *
 *==========================================================================*/
ATV_ERR TXHAL_SetChStatSF (TX_AUD_FS SampFreq)
{
    UCHAR i;
    ATV_ERR RetVal = ATVERR_INV_PARM;

    i = ATV_LookupValue8 ((UCHAR *)SfTable, (UCHAR)SampFreq, 0xff, 2);
    if (SfTable[i] != 0xff)
    {
        /*==========================
         * If from register
         *=========================*/
        if (SampFreq != TX_FS_FROM_STRM)
        {
            TXREG_SET_CHST_SAMP_FREQ(SfTable[i+1]);
            i = 1;
        }
        else
        {
            i = 0;
        }
        TXREG_SET_AUD_SF_FROM_REG(i);
        RetVal = ATVERR_OK;
    }
    return (RetVal);
}

/*==========================================================================
 * Enable I2S audio input 0-3 based on audio info-frame channel allocation
 * and if the input stream is HBR
 *
 * Entry:   ChanCount = Number of audio channels (0-7)
 *                      Not used if ChanAlloc is valid (ChanAlloc < 32)
 *                      Not used if input audio is HBR
 *          ChanAlloc = Channel allocation filed from audio info-frame
 *                      Not used if input audio is HBR
 *          AudType   = Input audio type. If set to HBR_STRM_PKT, it will
 *                      enable all I2S inputs regardless of ChanCount and
 *                      ChanAlloc setting
 *
 *=========================================================================*/
void TXHAL_SetI2SEnable (UCHAR ChanCount, UCHAR ChanAlloc, 
                         TX_AUD_PKT_TYPE AudType)
{
    UCHAR I2sChanCount;

    if (AudType == HBR_STRM_PKT)
    {
        I2sChanCount = 0xF;
    }
    else if (ChanAlloc < 32)
    {
        I2sChanCount = (UINT16) (ChanMapping[ChanAlloc]);
    }
    else
    {
        I2sChanCount = 1;
        if (ChanCount > 2)
        {
            I2sChanCount = 3;
        }
        if (ChanCount > 4)
        {
            I2sChanCount = 7;
        }
        if (ChanCount > 6)
        {
            I2sChanCount = 0xF;
        }
    }
    TXREG_SET_I2S_ENABLE(I2sChanCount);
}

/*==========================================================================
 * 
 *
 *
 *
 *=========================================================================*/
ATV_ERR TXHAL_SetAudInterface (TX_AUD_FORMAT InFormat, TX_AUD_PKT_TYPE OutType,
                               UCHAR HbrStrmCnt)
{
    UCHAR i, j=0;

    for (i=0; AudTables[i].AudSel!=0xff; i++)
    {
        if ((AudTables[i].InFrmt == InFormat) && 
            (AudTables[i].PktType == OutType))
        {
            TXREG_SET_AUD_SELECT(AudTables[i].AudSel);
            if ((OutType == HBR_STRM_PKT) && (HbrStrmCnt == 1))
            {
                j = 2;
            }
            TXREG_SET_AUD_MODE(AudTables[i].AudMode | j);
            TXREG_SET_I2S_FORMAT(AudTables[i].I2SFormat);
            if (OutType == HBR_STRM_PKT)
            {
                TXHAL_SetI2SEnable(0, 31, HBR_STRM_PKT);
                TXREG_SET_AUD_SF_FROM_REG(1);
                TXREG_SET_CHST_SAMP_FREQ(9);
/* mbw not needed   TXREG_SET_AUDIO_IF_CA(0x1f); */
/* mbw not needed   TXREG_SET_AUDIO_IF_CC(7); */
                TXREG_SET_MCLK_RATIO(0);
                TXREG_SET_PAPB_SYNC(0);
                TXREG_SET_PAPB_SYNC(1);
            }
            return (ATVERR_OK);
        }
    }
    return (ATVERR_INV_PARM);
}

/*==========================================================================
 *
 *
 *=========================================================================*/
void TXHAL_GetChipStatus (TX_STATUS *TxStat)
{    
    TxStat->ChipPd      = (BOOL) TXREG_GET_POWER_DOWN();
    TxStat->TmdsPd      = (BOOL) TXREG_GET_TMDS_PD_STATE();
    TxStat->Hpd         = (BOOL) TXREG_GET_HPD_STATE();
    TxStat->MonSen      = (BOOL) TXREG_GET_MSEN_STATE();
    TxStat->OutputHdmi  = (BOOL) TXREG_GET_EXT_HDMI_MODE();
    TxStat->PllLocked   = (BOOL) TXREG_GET_PLL_STATE();
    TxStat->VideoMuted  = (BOOL) TXREG_GET_BLACK_LEVEL_STATE();
    TxStat->ClearAVMute = (BOOL) TXREG_GET_CLEAR_AVMUTE();
    TxStat->SetAVMute   = (BOOL) TXREG_GET_SET_AVMUTE();
    TxStat->AudioRep    = (BOOL) TXREG_GET_AUD_SAMPLE_PKT_EN();
    TxStat->SpdifEnable = (BOOL) TXREG_GET_SPDIF_ENABLE();
    TxStat->I2SEnable   = (UCHAR) TXREG_GET_I2S_ENABLE();
    TxStat->DetectedVic = (UCHAR) TXREG_GET_DETECTED_VIC();
    TxStat->LastHdcpErr = (UCHAR) 0;  /* mbw fix */
}
    
/*==========================================================================
 * Calculate N Value from audio infoframe/channel status bits
 *
 *
 *
 *=========================================================================*/
UINT32 TXHAL_CalculateNValue (void)
{
    UINT32 NValue;
    UCHAR SFreq;

    /*================================================
     * Calculate N from audio Infoframe/Chan status
     *===============================================*/
    SFreq = TXREG_GET_AUDIO_IF_SF();
    if (SFreq == 0)                                     /* Refer to strm hdr */
    {
        SFreq = NIdx[TXREG_GET_CHST_SAMP_FREQ() & 0xf];   /* Index 0 - 8 */
    }
    else
    {
        SFreq--;                                        /* Index 0 - 7 */
    }
    NValue = NTable[SFreq];
    return (NValue);
}

/*===========================================================================
 *
 * Entry:   Packet = Pointer to AVI packet header byte 0
 *          Size   = Packet size (must not exceed 30, including header)
 *
 *
 *===========================================================================*/
ATV_ERR TXHAL_WriteAvIfPacket (UCHAR *Packet, UCHAR Size)
{
    if ((Size < 31) && (Size > 3))
    {
        TXREG_SET_AVIF_VER(Packet[1]);
        TXREG_SET_AVIF_LEN(Packet[2]);
        TXHAL_I2CWriteBlock(TXDEV_AVI_MAP, 
                TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, AVI_BYTE1_ADDR), 
                Packet+3, Size-3);
        return (ATVERR_OK);
    }
    return (ATVERR_INV_PARM);
}

/*===========================================================================
 *
 * Entry:   Packet = Pointer to Audio IF packet header byte 0
 *          Size   = Packet size (must be 13 bytes, including header)
 *
 *
 *===========================================================================*/
ATV_ERR TXHAL_WriteAudIfPacket (UCHAR *Packet, UCHAR Size)
{
    if (Size == 13)
    {
        TXREG_SET_AUDIO_IF_VER(Packet[1]);
        TXREG_SET_AUDIO_IF_LEN(Packet[2]);
        TXHAL_I2CWriteBlock(TXDEV_AUDIF_MAP, 
                TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET,  AUDIF_BYTE1_ADDR), 
                Packet+3, 10);
        return (ATVERR_OK);
    }
    return (ATVERR_INV_PARM);
}

/*===========================================================================
 *
 * Entry:   Packet = Pointer to ACP packet header byte 0
 *          Size   = Packet size (not to exceed 31 bytes, including header)
 *
 *
 *===========================================================================*/
ATV_ERR TXHAL_WriteAcpPacket (UCHAR *Packet, UCHAR Size)
{
    if (Size < 32)
    {
        TXHAL_I2CWriteBlock(TXDEV_ACP_MAP, 
                TXHAL_REG_OFFSET(TXDEV_PACKET_OFFSET, ACP_HB0_ADDR), 
                Packet, Size);
        return (ATVERR_OK);
    }
    return (ATVERR_INV_PARM);
}

/*============================================================================
 *
 * Entry:   Packet = Pointer to SPD packet header byte 0
 *          Size   = Packet size (not to exceed 31 bytes, including header)
 *
 *===========================================================================*/
ATV_ERR TXHAL_WriteSpdPacket (UCHAR *Packet, UCHAR Size)
{
    if (Size < 32)
    {
        if (Size == 31)
        {
            Size = 30;      /* SPD PB0 is the checksum and not sent out*/
        }
        TXHAL_I2CWriteBlock(TXDEV_SPD_MAP, 
                TXHAL_REG_OFFSET(TXDEV_PACKET_OFFSET, SPD_HB0_ADDR), 
                Packet, 3);
        TXHAL_I2CWriteBlock(TXDEV_SPD_MAP, 
                TXHAL_REG_OFFSET(TXDEV_PACKET_OFFSET, SPD_HB0_ADDR+4), 
                Packet+3, Size-3);
        return (ATVERR_OK);
    }
    return (ATVERR_INV_PARM);
}

/*============================================================================
 *
 * Entry:   Packet = Pointer to GMD packet header byte 0
 *          Size   = Packet size (not to exceed 31 bytes, including header)
 *
 *===========================================================================*/
ATV_ERR TXHAL_WriteGmdPacket (UCHAR *Packet, UCHAR Size)
{
    if (Size < 32)
    {
        TXHAL_I2CWriteBlock(TXDEV_GMD_MAP, 
                TXHAL_REG_OFFSET(TXDEV_PACKET_OFFSET, GMD_HB0_ADDR), 
                Packet, Size);
        return (ATVERR_OK);
    }
    return (ATVERR_INV_PARM);
}

/*===========================================================================
 *
 * Entry:   Packet = Pointer to ISRC1 packet header byte 0
 *          Size   = Packet size (not to exceed 31 bytes, including header)
 *
 *===========================================================================*/
ATV_ERR TXHAL_WriteIsrc1Packet (UCHAR *Packet, UCHAR Size)
{
    if (Size < 32)
    {
        TXHAL_I2CWriteBlock(TXDEV_ISRC_MAP, 
                TXHAL_REG_OFFSET(TXDEV_PACKET_OFFSET, ISRC1_HB0_ADDR), 
                Packet, Size);
        return (ATVERR_OK);
    }
    return (ATVERR_INV_PARM);
}

/*===========================================================================
 *
 * Entry:   Packet = Pointer to ISRC2 packet header byte 0
 *          Size   = Packet size (not to exceed 31 bytes, including header)
 *
 *===========================================================================*/
ATV_ERR TXHAL_WriteIsrc2Packet (UCHAR *Packet, UCHAR Size)
{
    if (Size < 32)
    {
        TXHAL_I2CWriteBlock(TXDEV_ISRC_MAP, 
                TXHAL_REG_OFFSET(TXDEV_PACKET_OFFSET, ISRC2_HB0_ADDR), 
                Packet, Size);
        return (ATVERR_OK);
    }
    return (ATVERR_INV_PARM);
}

/*============================================================================
 *
 * Entry:   Packet = Pointer to MPEG packet header byte 0
 *          Size   = Packet size (not to exceed 31 bytes, including header)
 *
 *===========================================================================*/
ATV_ERR TXHAL_WriteMpegPacket (UCHAR *Packet, UCHAR Size)
{
    if (Size < 32)
    {
        if (Size == 31)
        {
            Size = 30;      /* MPEG PB0 is the checksum and not sent out*/
        }
        TXHAL_I2CWriteBlock(TXDEV_MPEG_MAP, 
                TXHAL_REG_OFFSET(TXDEV_PACKET_OFFSET, MPEG_HB0_ADDR), 
                Packet, 3);
        TXHAL_I2CWriteBlock(TXDEV_MPEG_MAP, 
                TXHAL_REG_OFFSET(TXDEV_PACKET_OFFSET, MPEG_HB0_ADDR+4), 
                Packet+3, Size-3);
        return (ATVERR_OK);
    }
    return (ATVERR_INV_PARM);
}

/*============================================================================
 *
 * Entry:   Packet = Pointer to packet header byte 0
 *          Size   = Packet size (not to exceed 31 bytes, including header)
 *
 *===========================================================================*/
ATV_ERR TXHAL_WriteSpare1Packet (UCHAR *Packet, UCHAR Size)
{
    if (Size < 32)
    {
        TXHAL_I2CWriteBlock(TXDEV_SPARE1_MAP, 
                TXHAL_REG_OFFSET(TXDEV_PACKET_OFFSET, SPARE1_HB0_ADDR), 
                Packet, Size);
        return (ATVERR_OK);
    }
    return (ATVERR_INV_PARM);
}

/*============================================================================
 *
 * Entry:   Packet = Pointer to packet header byte 0
 *          Size   = Packet size (not to exceed 31 bytes, including header)
 *
 *===========================================================================*/
ATV_ERR TXHAL_WriteSpare2Packet (UCHAR *Packet, UCHAR Size)
{
    if (Size < 32)
    {
        TXHAL_I2CWriteBlock(TXDEV_SPARE2_MAP, 
                TXHAL_REG_OFFSET(TXDEV_PACKET_OFFSET, SPARE2_HB0_ADDR), 
                Packet, Size);
        return (ATVERR_OK);
    }
    return (ATVERR_INV_PARM);
}

/*==========================================================================
 * Return the current I2C map address (in mutli-device configuration)
 * corresponding to any device 0 map
 *
 *=========================================================================*/
UCHAR TXHAL_GetCurrMapAddr (UCHAR Dev0Addr)
{
    UCHAR CurrDev;

    switch (Dev0Addr)
    {
        case TX_I2C_MAIN_MAP_ADDR:
            CurrDev = TXDEV_MAIN_MAP;
            break; 
        case TX_I2C_PKT_MEM_MAP_ADDR:
            CurrDev = TXDEV_PKTMEM_MAP;
            break; 
        case TX_I2C_EDID_MAP_ADDR:
            CurrDev = TXDEV_EDID_MAP;
            break; 
        case TX_I2C_CEC_MAP_ADDR:
            CurrDev = TXDEV_CEC_MAP;
            break; 
        default:
            CurrDev = 0;
            break;
    }
    return (CurrDev);
}

/*==========================================================================
 *
 *
 *=========================================================================*/
void TXHAL_SetInterrupts (TX_EVENT Events)
{
    UCHAR MaskBits;
    TXHAL_I2CReadByte (TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_INTS_MASK), 
            &MaskBits);
    MaskBits &= ~(TX_INTS_ALL_BITS);
    MaskBits |= TX_HPD_CHNG_INT_BIT | TX_EDID_READY_INT_BIT |
                TX_HDCP_AUTH_INT_BIT;
    if (Events & TX_EVENT_MSEN_CHG)
    {
        MaskBits |= TX_MSEN_CHNG_INT_BIT;
    }
    if (Events & TX_EVENT_VSYNC_INT)
    {
        MaskBits |= TX_VSYNC_EDGE_INT_BIT;
    }
    if (Events & TX_EVENT_AUD_FIFO_FULL)
    {
        MaskBits |= TX_AUD_FIFO_FULL_INT_BIT;
    }
    if (Events & TX_EVENT_EMB_SYNC_ERR)
    {
        MaskBits |= TX_EMB_SYNC_ERR_INT_BIT;
    }
    TXHAL_I2CWriteByte (TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_INTS_MASK), 
            MaskBits);
    TXHAL_I2CReadByte (TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_CEC_INTS_MASK), 
            &MaskBits);
    MaskBits &= ~(TX_CEC_INTS_ALL_BITS);
    MaskBits |= TX_BKSV_READY_INT_BIT;
#if TX_INCLUDE_CEC
#if ((TX_DEVICE==8002) || (TX_DEVICE==7511))
        MaskBits |= CEC_TX_RDY_INT_BIT  | CEC_RX_RDY1_INT_BIT |
                    CEC_RX_RDY2_INT_BIT | CEC_RX_RDY3_INT_BIT |
                    CEC_TX_ARB_LOST_INT_BIT | CEC_TX_TIMEOUT_INT_BIT;
   #else
        MaskBits |= CEC_TX_RDY_INT_BIT | CEC_RX_RDY_INT_BIT |
                    CEC_TX_ARB_LOST_INT_BIT | CEC_TX_TIMEOUT_INT_BIT;
#endif                
#endif
    if (Events & TX_EVENT_HDCP_ERROR)
    {
        MaskBits |= TX_HDCP_ERR_INT_BIT;
    }
    TXHAL_I2CWriteByte (TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_CEC_INTS_MASK), 
            MaskBits);
}

/*==========================================================================
 *
 *
 *=========================================================================*/
BOOL TXHAL_InterruptPending (void)
{
    UCHAR i, HtxIntReg, CecIntReg;

    TXHAL_I2CReadByte(TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_INTS_MASK), 
            &i);
    TXHAL_I2CReadByte(TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_INTS), 
            &HtxIntReg);
    HtxIntReg &= i;
    TXHAL_I2CReadByte(TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_CEC_INTS_MASK), 
            &i);
    TXHAL_I2CReadByte(TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_CEC_INTS), 
            &CecIntReg);
    CecIntReg &= i;
    return((HtxIntReg || CecIntReg)? TRUE: FALSE);
}

/*==========================================================================
 *
 *
 *=========================================================================*/
void TXHAL_GetInterrupts (TX_INTERRUPTS *TxInts)
{
#if ((TX_DEVICE==8002) || (TX_DEVICE==7511))
#if(TX_INCLUDE_CEC)  
    UCHAR CecBufTimeStamp1;
    UCHAR CecBufTimeStamp2;
    UCHAR CecBufTimeStamp3;
    UCHAR i;
#endif
#endif          
    UCHAR HtxIntReg, CecIntReg;
    TXHAL_I2CReadByte(TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_INTS), 
            &HtxIntReg);
    TXHAL_I2CReadByte(TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_CEC_INTS), 
            &CecIntReg);
    TxInts->Hpd         = (BOOL) (HtxIntReg & TX_HPD_CHNG_INT_BIT);
    TxInts->MonSen      = (BOOL) (HtxIntReg & TX_MSEN_CHNG_INT_BIT);
    TxInts->EdidReady   = (BOOL) (HtxIntReg & TX_EDID_READY_INT_BIT);
    TxInts->Vsync       = (BOOL) (HtxIntReg & TX_VSYNC_EDGE_INT_BIT);
    TxInts->AudFifoFull = (BOOL) (HtxIntReg & TX_AUD_FIFO_FULL_INT_BIT);
    TxInts->EmbSyncErr  = (BOOL) (HtxIntReg & TX_EMB_SYNC_ERR_INT_BIT);
    TxInts->HdcpAuth    = (BOOL) (HtxIntReg & TX_HDCP_AUTH_INT_BIT);
    TxInts->BksvReady   = (BOOL) (CecIntReg & TX_BKSV_READY_INT_BIT);
    TxInts->HdcpError   = (BOOL) (CecIntReg & TX_HDCP_ERR_INT_BIT);
#if(TX_INCLUDE_CEC)    
    TxInts->Cec.TxReady = (BOOL) (CecIntReg & CEC_TX_RDY_INT_BIT);
    TxInts->Cec.RxReady = (BOOL) (CecIntReg & CEC_RX_RDY_INT_BIT);
    TxInts->Cec.ArbLost = (BOOL) (CecIntReg & CEC_TX_ARB_LOST_INT_BIT);
    TxInts->Cec.Timeout = (BOOL) (CecIntReg & CEC_TX_TIMEOUT_INT_BIT);

    /*======================================================
     * Force HPD/MSEN interrupts first time s/w starts
     *=====================================================*/
#if ((TX_DEVICE==8002) || (TX_DEVICE==7511))
    TxInts->Cec.RxReady1 = (BOOL) (CecIntReg & CEC_RX_RDY1_INT_BIT);
    TxInts->Cec.RxReady2 = (BOOL) (CecIntReg & CEC_RX_RDY2_INT_BIT);
    TxInts->Cec.RxReady3 = (BOOL) (CecIntReg & CEC_RX_RDY3_INT_BIT);
    
    /*======================================================
     * Force HPD/MSEN interrupts first time s/w starts
     *=====================================================*/

   
    for ( i = 0; i < CEC_TRIPLE_NUMBER; i++)
    {
        TxInts->Cec.RxFrameOrder[i] = 0;     
    }
    
    HTX_get_BUF0_TIMESTAMP(&CecBufTimeStamp1);
    HTX_get_BUF1_TIMESTAMP(&CecBufTimeStamp2);
    HTX_get_BUF2_TIMESTAMP(&CecBufTimeStamp3);
    
    TxInts->Cec.RxFrameOrder[0] = CecBufTimeStamp1;
    TxInts->Cec.RxFrameOrder[1] = CecBufTimeStamp2;
    TxInts->Cec.RxFrameOrder[2] = CecBufTimeStamp3; 
    
#endif 
#endif                
    if (!InitDone)
    {
        TxInts->Hpd     = TRUE;
        TxInts->MonSen  = TRUE;
        InitDone        = TRUE;
    }
}

/*==========================================================================
 *
 *
 *=========================================================================*/
void TXHAL_ClearInterrupts (UCHAR Interrupt, TX_INTERRUPTS *TxInts)
{
    UINT16 i;
    i = ATV_LookupValue8 ((UCHAR *)IntMap, Interrupt, 0xff, 3);
    if (IntMap[i] != 0xff)
    {
        TXHAL_I2CWriteByte(TXDEV_MAIN_MAP, 
                TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, IntMap[i+1]), 
                IntMap[i+2]);
    }
}

/*==========================================================================
 *
 *
 *=========================================================================*/
void TXHAL_GetEnabledPackets (UINT16 *Packets)
{
    UCHAR ByteX;
    *Packets = 0;
    TXHAL_I2CReadByte(TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_PKT_ENABLE), 
            &ByteX);
    if (ByteX & 0x80)
    {
        *Packets |= PKT_GC_PACKET;
    }
    if (ByteX & 0x40)
    {
        *Packets |= PKT_SPD_PACKET;
    }
    if (ByteX & 0x20)
    {
        *Packets |= PKT_MPEG_PACKET;
    }
    if (ByteX & 0x10)
    {
        *Packets |= PKT_ACP_PACKET;
    }
    if (ByteX & 0x08)
    {
        *Packets |= (PKT_ISRC1_PACKET | PKT_ISRC2_PACKET);
    }
    if (ByteX & 0x04)
    {
        *Packets |= PKT_GMD_PACKET;
    }
    if (ByteX & 0x01)
    {
        *Packets |= PKT_VS_PACKET;
    }
    TXHAL_I2CReadByte(TXDEV_MAIN_MAP, 
            TXHAL_REG_OFFSET(TXDEV_MAIN_OFFSET, TX_REG_IF_PKT_ENABLE), 
            &ByteX);
    if (ByteX & 0x40)
    {
        *Packets |= PKT_ACR_PACKET;
    }
    if (ByteX & 0x20)
    {
        *Packets |= PKT_AUDIO_SAMPLE_PACKET;
    }
    if (ByteX & 0x10)
    {
        *Packets |= PKT_AV_INFO_FRAME;
    }
    if (ByteX & 0x08)
    {
        *Packets |= PKT_AUDIO_INFO_FRAME;
    }
}
#if (TX_DEVICE !=7850)
ATV_ERR TXHAL_SetInputVideoClock (UCHAR ClkDivide)
{
    UCHAR ClkDiv=0, ClkGating=0;
    ATV_ERR RetVal = ATVERR_OK;

    switch (ClkDivide)
    {
        case 1:
            break;
        case 2:
            ClkDiv = ClkGating = 1;
            break;
        case 4:
            ClkDiv = 2;
            ClkGating = 1;
            break;
        default:
            RetVal = ATVERR_INV_PARM;
            break;
    }

    if (RetVal == ATVERR_OK)
    {
        TXREG_SET_CLOCK_DIVIDE(ClkDiv);
        TXREG_SET_CLOCK_GATING(ClkGating);
    }
    return (RetVal);
}

/*==========================================================================
 *
 *
 *=========================================================================*/
ATV_ERR TXHAL_TxInit (BOOL FullInit)
{
    /*================================
     * Init local variables
     *===============================*/
    TxUsrNVal = 0;
    TxUsrMClk = TX_MCLK_AUTO;

    /*================================
     * Init chip hardware
     *===============================*/
    TXHAL_Initialize(FullInit);
    if (TxUsrConfig & TX_ENABLE_TMDS_ON_INIT)
    {
        ADIAPI_TxEnableTmds (TRUE, TRUE);
    }
    return (ATVERR_OK);
}
#endif
