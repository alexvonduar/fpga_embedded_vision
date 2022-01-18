/**********************************************************************************************
*																						      *
* Copyright (c) 2012 Analog Devices, Inc.  All Rights Reserved.                               *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/

#ifndef _7511_HAL_H_
#define _7511_HAL_H_

/*==============================
 * Includes
 *=============================*/
#include "7511_cfg.h"
#include "ADV7511_lib.h"

/* 2nd generation CEC engine */
#if (TX_INCLUDE_CEC == 1)
#define CEC_TX_2G                          1
#endif


/*==============================
 * Defines
 *=============================*/
#define TXDEV_AVI_MAP                   TXDEV_MAIN_MAP
#define TXDEV_AUDIF_MAP                 TXDEV_MAIN_MAP
#define TXDEV_SPD_MAP                   TXDEV_PKTMEM_MAP
#define TXDEV_ISRC_MAP                  TXDEV_PKTMEM_MAP
#define TXDEV_GMD_MAP                   TXDEV_PKTMEM_MAP
#define TXDEV_ACP_MAP                   TXDEV_PKTMEM_MAP
#define TXDEV_MPEG_MAP                  TXDEV_PKTMEM_MAP
#define TXDEV_SPARE1_MAP                TXDEV_PKTMEM_MAP
#define TXDEV_SPARE2_MAP                TXDEV_PKTMEM_MAP

#define TXDEV_MAIN_OFFSET               0x00        /*These offset aren't used*/
#define TXDEV_EDID_OFFSET               0x00        /*for 8-bit addressing    */ 
#define TXDEV_PACKET_OFFSET             0x00        /*I2C space               */
#define TXDEV_CEC_OFFSET                0x00

#define TX_REG_CS_DATA                  0x12
#define TX_REG_CS_SF                    0x15
#define TX_REG_CSC_BASE                 0x18
#define TX_REG_PIXEL_REP                0x3B
#define TX_REG_PKT_ENABLE               0x40
#define TX_REG_EDID_ADDR                0x43
#define TX_REG_IF_PKT_ENABLE            0x44
#define TX_REG_PKTMEM_ADDR              0x45
#define TX_REG_DOWN_CONV                0x49
#define TX_REG_AVMUTE                   0x4B
#define TX_REG_INTS_MASK                0x94
#define TX_REG_CEC_INTS_MASK            0x95
#define TX_REG_INTS                     0x96
#define TX_REG_CEC_INTS                 0x97
#define TX_REG_TMDS_PD                  0xA1
#define TX_REG_HDCP_CTRL                0xAF
#define TX_REG_BCAPS                    0xBE
#define TX_REG_BKSV_0                   0xBF
#define TX_REG_BSTATUS                  0xCA
#define TX_REG_CEC_ID                   0xE1
#define TX_REG_CEC_PD                   0xE2
#define TX_REG_BKSVS                    0x00    /* In EDID MAP */

#define AVI_BYTE1_ADDR                  0x55
#define AVI_BYTE6_ADDR                  0x5A
#define AUDIF_BYTE1_ADDR                0x73
#define SPD_HB0_ADDR                    0x00
#define MPEG_HB0_ADDR                   0x20
#define ACP_HB0_ADDR                    0x40
#define ISRC1_HB0_ADDR                  0x60
#define ISRC2_HB0_ADDR                  0x80
#define GMD_HB0_ADDR                    0xA0
#define SPARE1_HB0_ADDR                 0xC0
#define SPARE2_HB0_ADDR                 0xE0

#define TXEDID_BASE_ADDR                0x00    /* In EDID MAP */ 

#define CEC_RX_RDY_INT_BIT              0x04
#define CEC_TX_TIMEOUT_INT_BIT          0x08
#define CEC_TX_ARB_LOST_INT_BIT         0x10
#define CEC_TX_RDY_INT_BIT              0x20
#define TX_BKSV_READY_INT_BIT           0x40
#define TX_HDCP_ERR_INT_BIT             0x80
#define TX_CEC_INTS_ALL_BITS            0xFC
#define CEC_RX_RDY3_INT_BIT             0x04
#define CEC_RX_RDY2_INT_BIT             0x02
#define CEC_RX_RDY1_INT_BIT             0x01

#if CEC_TX_2G
#undef  CEC_RX_RDY_INT_BIT  
#define CEC_RX_RDY_INT_BIT              0x01
#endif


#define TX_HDCP_AUTH_INT_BIT            0x02
#define TX_EDID_READY_INT_BIT           0x04
#define TX_EMB_SYNC_ERR_INT_BIT         0x08
#define TX_AUD_FIFO_FULL_INT_BIT        0x10
#define TX_VSYNC_EDGE_INT_BIT           0x20
#define TX_MSEN_CHNG_INT_BIT            0x40
#define TX_HPD_CHNG_INT_BIT             0x80
#define TX_INTS_ALL_BITS                0xFE

/*==============================
 * Macros
 *=============================*/
#define TXREG_GET_CHIP_REVISION         HTX_ret_CHIP_REVISION
#define TXREG_GET_HPD_STATE             HTX_ret_HPD_STATE
#define TXREG_GET_MSEN_STATE            HTX_ret_MSEN_STATE
#define TXREG_SET_SET_AVMUTE            HTX_set_SET_AVMUTE
#define TXREG_SET_CLEAR_AVMUTE          HTX_set_CLEAR_AVMUTE
#define TXREG_SET_COLOR_DEPTH           HTX_set_GC_CD
#define TXREG_GET_COLOR_DEPTH           HTX_ret_GC_CD
#define TXREG_SET_DWNCONV_METHOD(a)     ATV_I2CWriteField8 (TXDEV_MAIN_MAP, TX_REG_DOWN_CONV, 0xfc, 2, a)
#define TXREG_GET_SET_AVMUTE            HTX_ret_SET_AVMUTE
#define TXREG_GET_CLEAR_AVMUTE          HTX_ret_CLEAR_AVMUTE
#define TXREG_GET_ENC_ON                HTX_ret_ENC_ON
#define TXREG_SET_CH0PWRDWN             HTX_set_CH0PWRDWNI2C
#define TXREG_SET_CH1PWRDWN             HTX_set_CH1PWRDWNI2C
#define TXREG_SET_CH2PWRDWN             HTX_set_CH2PWRDWNI2C
#define TXREG_SET_CLKPWRDWN             HTX_set_CLKDRVPWRDWNI2C
#define TXREG_SET_POWER_DOWN            HTX_set_SYSTEM_PD
#define TXREG_GET_POWER_DOWN            HTX_ret_SYSTEM_PD
#define TXREG_SET_RX_SENSE_PD           HTX_set_TERMPWRDWNI2C
#define TXREG_SET_RX_SENSE_RESET        HTX_set_TERMMONRESET
#define TXREG_SET_IN_CLK_PD             HTX_set_AUDIO_AND_VIDEO_INPUT_GATING
#define TXREG_SET_CLOCK_GATING          HTX_set_CLOCK_DIVIDE_RESET
#define TXREG_SET_CLOCK_DIVIDE          HTX_set_ANALOG_OPEN1
#define TXREG_GET_RX_SENSE              HTX_ret_MSEN_STATE
#define TXREG_SET_EDID_READ_RETRY       HTX_set_EDID_TRYS
#define TXREG_GET_EDID_READ_RETRY       HTX_ret_EDID_TRYS
#define TXREG_SET_EDID_FORCED_READ      HTX_set_EDID_READ_EN
#define TXREG_GET_EDID_SEGMENT          HTX_ret_EDID_SEGMENT
#define TXREG_SET_EDID_SEGMENT          HTX_set_EDID_SEGMENT
#define TXREG_GET_EXT_HDMI_MODE         HTX_ret_EXT_HDMI_MODE
#define TXREG_SET_EXT_HDMI_MODE         HTX_set_EXT_HDMI_MODE
#define TXREG_SET_GC_PKT_EN             HTX_set_GC_PKT_EN
#define TXREG_GET_HDCP_ENABLE           HTX_ret_HDCP_DESIRED
#define TXREG_SET_HDCP_ENABLE           HTX_set_HDCP_DESIRED
#define TXREG_SET_HDCP_FRAME_ENABLE     HTX_set_FRAME_ENC
#define TXREG_GET_HDCP_FRAME_ENABLE     HTX_ret_FRAME_ENC
#define TXREG_GET_HDCP_STATE            HTX_ret_HDCP_CONTROLLER_STATE
#define TXREG_GET_BCAPS()               ATV_I2CReadField8 (TXDEV_MAIN_MAP, TX_REG_BCAPS, 0xff, 0)
#define TXREG_GET_BKSV_COUNT            HTX_ret_BKSV_COUNT
#define TXREG_GET_BSTATUS(a)            HAL_I2CReadBlock(TXDEV_MAIN_MAP, TX_REG_BSTATUS, a, 2)
#define TXREG_GET_HDCP_ERROR            HTX_ret_HDCP_CONTROLLER_ERROR
#define TXREG_SET_OUTPUT_CS_YUV         HTX_set_VFE_INPUT_CS
#define TXREG_SET_OUTPUT_COL_FORMAT     HTX_set_VFE_OUT_FMT
#define TXREG_SET_INTERPOLATE_EN        HTX_set_INTERPOLATION_STYLE
#define TXREG_GET_Y1Y0                  HTX_ret_Y1Y0
#define TXREG_GET_AVIIF_PKT_EN          HTX_ret_AVIIF_PKT_EN

#define TXREG_SET_MANUAL_VIC            HTX_set_EXT_VID_TO_RX
#define TXREG_SET_PIXEL_REP_MODE        HTX_set_PR_MODE
#define TXREG_SET_PIXEL_REP_VAL(a)      ATV_I2CWriteField8(TXDEV_MAIN_MAP, TX_REG_PIXEL_REP, 0x06, 1, a)
#define TXREG_SET_PIXEL_REP_PLL(a)      ATV_I2CWriteField8(TXDEV_MAIN_MAP, TX_REG_PIXEL_REP, 0x18, 3, a)
#define TXREG_SET_LOW_FRQ_VIDEO         HTX_set_LOW_FRQ_VIDEO
#define TXREG_SET_HI_FRQ_VIDEO          HTX_set_HIGH_VSYNC
#define TXREG_SET_R30                   HTX_set_R3210
#define TXREG_SET_AVIF_LEN              HTX_set_AVI_LENGTH
#define TXREG_SET_AVIF_VER              HTX_set_AVI_VERSION
#define TXREG_SET_ASPECT_16X9           HTX_set_ASPECT_RATIO
#define TXREG_SET_AVIIF_PKT_EN          HTX_set_AVIIF_PKT_EN
#define TXREG_SET_ACP_PKT_EN            HTX_set_ACP_PKT_EN
#define TXREG_SET_ISRC_PKT_EN           HTX_set_ISRC_PKT_EN
#define TXREG_SET_SPD_PKT_EN            HTX_set_SPD_PKT_EN
#define TXREG_SET_GMD_PKT_EN            HTX_set_GM_PKT_EN
#define TXREG_SET_MPEG_PKT_EN           HTX_set_MPEG_PKT_EN
#define TXREG_SET_SPARE1_PKT_EN         HTX_set_SPARE_PKT0_EN
#define TXREG_SET_SPARE2_PKT_EN         HTX_set_SPARE_PKT1_EN
#define TXREG_SET_CEC_PD(a)             ATV_I2CWriteField8(TXDEV_MAIN_MAP, TX_REG_CEC_PD, 0x01, 0, a)
#define TXREG_SET_CEC_MAP_ADDR(a)       ATV_I2CWriteField8(TXDEV_MAIN_MAP, TX_REG_CEC_ID, 0xff, 0, a)
#define TXREG_SET_ACTIVE_CEC_PD(a)      ATV_I2CWriteField8(TXDEV_ACTIVE_MAIN_MAP, TX_REG_CEC_PD, 0x01, 0, a)
#define TXREG_SET_ACTIVE_CEC_MAP(a)     ATV_I2CWriteField8(TXDEV_ACTIVE_MAIN_MAP, TX_REG_CEC_ID, 0xff, 0, a)
#define TXREG_SET_PKT_MEM_MAP_ADDR      HTX_set_UDP_ID
#define TXREG_SET_EDID_MAP_ADDR         HTX_set_EDID_ID
#define TXREG_SET_HPD_PD_OVERIDE(a)     ATV_I2CWriteField8(TXDEV_MAIN_MAP, 0xD6, 0x40, 6, a)

#define TXREG_SET_I2S_ENABLE(a)         ATV_I2CWriteField8(TXDEV_MAIN_MAP, 0x0C, 0x3C, 0x2, a)
#define TXREG_GET_I2S_ENABLE()          ATV_I2CReadField8(TXDEV_MAIN_MAP, 0x0C, 0x3C, 0x2)
#define TXREG_SET_SPDIF_ENABLE          HTX_set_SPDIF_EN
#define TXREG_GET_SPDIF_ENABLE          HTX_ret_SPDIF_EN
#define TXREG_SET_DSD_ENABLE            HTX_set_DSD_EN
#define TXREG_GET_DSD_ENABLE            HTX_ret_DSD_EN
#define TXREG_SET_AUD_SAMPLE_PKT_EN     HTX_set_AUDIO_SAMPLE_PKT_EN
#define TXREG_GET_AUD_SAMPLE_PKT_EN     HTX_ret_AUDIO_SAMPLE_PKT_EN
#define TXREG_GET_AUDIO_IF_SF           HTX_ret_AUDIOIF_SF
#define TXREG_SET_N_CTS_PKT_EN          HTX_set_N_CTS_PKT_EN

#define TXREG_SET_AUDIO_IF_VER          HTX_set_AUDIOIF_VERSION
#define TXREG_SET_AUDIO_IF_LEN          HTX_set_AUDIOIF_LENGTH
#define TXREG_SET_AUDIOIF_PKT_EN        HTX_set_AUDIOIF_PKT_EN
#define TXREG_SET_SB0_LEFT_CHAN         HTX_set_SUBPKT0_L_SRC
#define TXREG_SET_SB0_RIGHT_CHAN        HTX_set_SUBPKT0_R_SRC
#define TXREG_SET_SB1_LEFT_CHAN         HTX_set_SUBPKT1_L_SRC
#define TXREG_SET_SB1_RIGHT_CHAN        HTX_set_SUBPKT1_R_SRC
#define TXREG_SET_SB2_LEFT_CHAN         HTX_set_SUBPKT2_L_SRC
#define TXREG_SET_SB2_RIGHT_CHAN        HTX_set_SUBPKT2_R_SRC
#define TXREG_SET_SB3_LEFT_CHAN         HTX_set_SUBPKT3_L_SRC
#define TXREG_SET_SB3_RIGHT_CHAN        HTX_set_SUBPKT3_R_SRC
#define TXREG_SET_MCLK_RATIO            HTX_set_MCLK_RATIO
#define TXREG_SET_USER_MCLK_SELECT      HTX_set_MCLK_EN
#define TXREG_SET_MCLK_POLARITY         HTX_set_MCLK_POL
#define TXREG_SET_AUD_SF_FROM_REG       HTX_set_EXT_AUDIOSF_SEL
#define TXREG_SET_CS_FROM_REG           HTX_set_CS_BIT_OVERRIDE
#define TXREG_SET_N_VALUE               HTX_set_N
#define TXREG_SET_CTS                   HTX_set_EXTERNAL_CTS
#define TXREG_SET_USER_CTS_SELECT       HTX_set_CTS_SEL
#define TXREG_SET_I2S_RJ_BIT_WIDTH      HTX_set_I2S_BIT_WIDTH

#define TXREG_SET_CHST_SAMP_FREQ        HTX_set_I2S_SF
#define TXREG_GET_CHST_SAMP_FREQ        HTX_ret_I2S_SF
#define TXREG_GET_CHST_4BIT_WLEN        HTX_ret_WORD_LENGTH

#define TXREG_SET_SOFT_TMDS_ON          HTX_set_STEP_TURNONI2C
#define TXREG_SET_SOFT_CLK_GATING       HTX_set_SOFT_TMDS_CLOCK_TURN_ON
#define TXREG_SET_TMDS_PD(a)            ATV_I2CWriteField8(TXDEV_MAIN_MAP, TX_REG_TMDS_PD, 0x3C, 2, a)
#define TXREG_SET_SERIALIZER_CURR       HTX_set_IREFINCREASE_MSB
#define TXREG_SET_INP_CLK_DELAY_SEL     HTX_set_CLK_DELAY
#define TXREG_SET_HDCP_ROM_LOC          HTX_set_INT_EPP_ON
#define TXREG_SET_CSC_ENABLE            HTX_set_CSC_EN
#define TXREG_SET_INPUT_VID_FORMAT      HTX_set_VFE_INPUT_ID
#define TXREG_SET_INPUT_VID_STYLE       HTX_set_VFE_INPUT_STYLE
#define TXREG_SET_INPUT_VID_CLR_DEPTH   HTX_set_422_WIDTH
#define TXREG_SET_INPUT_VID_ALIGN       HTX_set_RE_MAP_24BIT
#define TXREG_SET_INPUT_VID_CLK_EDGE    HTX_set_VFE_INPUT_EDGE
#define TXREG_SET_INPUT_VID_BIT_SWAP    HTX_set_BIT_REVERSE

#define TXREG_SET_AUD_SELECT            HTX_set_AUDIO_INPUT_SELECTION
#define TXREG_SET_AUD_MODE              HTX_set_AUDIO_MODE
#define TXREG_SET_I2S_FORMAT            HTX_set_I2S_FORMAT
#define TXREG_SET_PAPB_SYNC             HTX_set_PAPB_SYNC
#define TXREG_GET_PLL_STATE             HTX_ret_PLLLOCKED
#define TXREG_GET_BLACK_LEVEL_STATE     HTX_ret_BLACK_LEVEL_OUTPUT
#define TXREG_SET_BLACK_LEVEL_OUTPUT    HTX_set_BLACK_LEVEL_OUTPUT
#define TXREG_GET_DETECTED_VIC          HTX_ret_VFE_FMT_VID
#define TXREG_GET_TMDS_PD_STATE()       ATV_I2CReadField8 (TXDEV_MAIN_MAP, TX_REG_TMDS_PD, 0x3C, 2)
#define TXREG_SET_AVMUTE_ON(a)          ATV_I2CWriteField8 (TXDEV_MAIN_MAP, TX_REG_AVMUTE, 0xC0, 6, a? 1: 2);
#define TXREG_SET_ARC_DISABLE           HTX_set_ARC_DISABLE
#define TXREG_SET_ARC_MODE              HTX_set_ARC_MODE
#define TXREG_SET_DIS_PJ_CHECK(val)     ATV_I2CWriteField8(TXDEV_MAIN_MAP, 0xCF, 0x1, 0, val);
/*==========================================================================
 * API functions not supported on ADV7511
 *
 *=========================================================================*/

#define TXHAL_AdjustFreqRange(a)         (ATVERR_NOT_AVAILABLE)
#define TXHAL_NormalOp()                 (ATVERR_NOT_AVAILABLE)
#define TXHAL_SetAutoTmdsPdnMode(a,b)    (ATVERR_NOT_AVAILABLE)

#endif
