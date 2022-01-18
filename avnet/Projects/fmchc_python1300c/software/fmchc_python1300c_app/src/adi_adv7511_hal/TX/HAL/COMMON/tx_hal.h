/**********************************************************************************************
*																						      *
* Copyright (c) 2012 Analog Devices, Inc.  All Rights Reserved.                               *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/

#ifndef _TX_HAL_H_
#define _TX_HAL_H_

#include "tx_lib.h"
#include "wrapper.h"

/*===============================================
 * Structures, enums and macros
 *==============================================*/
typedef struct
{
    UCHAR Main;
    UCHAR PktMem;
    UCHAR Edid;
    UCHAR Cec;
    UCHAR Test;
} TX_DEV_ADDR;

typedef struct
{
    BOOL TxReady;
    BOOL RxReady;
    BOOL ArbLost;
    BOOL Timeout;
    BOOL RxReady1;
    BOOL RxReady2;
    BOOL RxReady3;
    UCHAR RxFrameOrder[CEC_TRIPLE_NUMBER];
} CEC_INTS;

typedef struct
{
    BOOL Hpd;
    BOOL MonSen;
    BOOL EdidReady;
    BOOL Vsync;
    BOOL AudFifoFull;
    BOOL EmbSyncErr;
    BOOL HdcpAuth;
    BOOL BksvReady;
    BOOL HdcpError;
    CEC_INTS Cec;
} TX_INTERRUPTS;

enum
{
    TX_INT_HDCP_AUTH=0,
    TX_INT_EDID_READY,
    TX_INT_EMB_SYNC_ERR,
    TX_INT_AUD_FIFO_FULL,
    TX_INT_VSYNC_EDGE,
    TX_INT_MSEN_CHNG,
    TX_INT_HPD_CHNG,
    CEC_INT_RX_RDY1,
    CEC_INT_RX_RDY2,
    CEC_INT_RX_RDY3,
    CEC_INT_RX_RDY,
    CEC_INT_TX_TIMEOUT,
    CEC_INT_TX_ARB_LOST,
    CEC_INT_TX_RDY,
    TX_INT_BKSV_READY,
    TX_INT_HDCP_ERR
};

EXTERNAL UCHAR TxCurrDevIdx;
EXTERNAL UCHAR TxActiveCecIdx;
EXTERNAL CONSTANT TX_DEV_ADDR *TxDevAddr;
EXTERNAL CONSTANT TX_DEV_ADDR TxDeviceAddress[];

#define TX_DBG                      if(TxUsrConfig&TX_ENABLE_DBG)DBG_MSG("-t%d:",TxCurrDevIdx+1);if(TxUsrConfig&TX_ENABLE_DBG)ATV_PrintTime(" ",1," ");if(TxUsrConfig&TX_ENABLE_DBG)DBG_MSG
#define TX_PRINT                    if(TxUsrConfig&TX_ENABLE_DBG)DBG_MSG
#define TXDEV_MAIN_MAP              TxDevAddr->Main
#define TXDEV_PKTMEM_MAP            TxDevAddr->PktMem
#define TXDEV_EDID_MAP              TxDevAddr->Edid
#define TXDEV_CEC_MAP               TxDevAddr->Cec
#define TXDEV_ACTIVE_CEC_MAP        TxDeviceAddress[TxActiveCecIdx].Cec
#define TXDEV_ACTIVE_MAIN_MAP       TxDeviceAddress[TxActiveCecIdx].Main
#define TXDEV_TEST_MAP              TxDeviceAddress[TxActiveCecIdx].Main

/*===============================================
 * Chip-specific macros
 *==============================================*/
#if (TX_DEVICE == 7510)
#include "7510_hal.h"
#endif

#if (TX_DEVICE == 7520)
#include "7520_hal.h"
#endif

#if (TX_DEVICE == 7623) || (TX_DEVICE == 7622) || (TX_DEVICE == 76221)
#include "7623_tx_hal.h"
#endif

#if (TX_DEVICE == 3014)
#include "3014_tx_hal.h"
#endif

#if (TX_DEVICE == 7511)
#include "7511_hal.h"
#endif

#if (TX_DEVICE == 8002)
#include "8002_tx_hal.h"
#endif


#if (TX_DEVICE == 7850)
#include "7850_tx_hal.h"
#endif


#if (TX_DEVICE == 7541)
#include "7541_hal.h"
#endif

#if (TX_DEVICE == 7513)
#include "7513_hal.h"
#endif

/*===============================================
 * Defines and macros
 *==============================================*/

/*===============================================
 * CEC Macro Definitions
 *==============================================*/
#if TX_INCLUDE_CEC
#define CEC_I2C_MAP_BASE            TXDEV_ACTIVE_CEC_MAP
#if (TX_DEVICE == 7511)
    #define CEC_REG_RX_FRAME1_HDR              0x27
    #define CEC_REG_RX_FRAME1_DATA0            0x28
    #define CEC_REG_RX_FRAME2_HDR              0x38
    #define CEC_REG_RX_FRAME2_DATA0            0x39
    #define CEC_REG_RX_BUFFER_CONTROL          0x4A
    #define CEC_BUFFER1_READY                  0x01
    #define CEC_BUFFER2_READY                  0x02
    #define CEC_BUFFER3_READY                  0x04
    #define CEC_THREE_BUFFERS_ENABLE           0x08
    #define CECREG_SET_CLR_RX_RDY1(val)        ATV_I2CWriteField8(CEC_I2C_MAP_BASE, CEC_REG_RX_BUFFER_CONTROL, 0x01, 0x0, val)
    #define CECREG_SET_CLR_RX_RDY2(val)        ATV_I2CWriteField8(CEC_I2C_MAP_BASE, CEC_REG_RX_BUFFER_CONTROL, 0x02, 0x1, val)
    #define CECREG_SET_CLR_RX_RDY3(val)        ATV_I2CWriteField8(CEC_I2C_MAP_BASE, CEC_REG_RX_BUFFER_CONTROL, 0x04, 0x2, val)
    #define CECREG_SET_BUFFER_CONTROL(val)     HAL_I2CWriteByte(CEC_I2C_MAP_BASE, CEC_REG_RX_BUFFER_CONTROL, val)
    #define CECREG_SET_NUM_RX_BUFFERS(val)     ATV_I2CWriteField8(CEC_I2C_MAP_BASE, CEC_REG_RX_BUFFER_CONTROL, 0x08, 3, val)
#elif (TX_DEVICE == 8002)   
    #define CEC_REG_RX_FRAME1_HDR              0x27 
    #define CEC_REG_RX_FRAME1_DATA0            0x28
    #define CEC_REG_RX_FRAME2_HDR              0x38
    #define CEC_REG_RX_FRAME2_DATA0            0x39
    #define CEC_REG_RX_BUFFER_CONTROL          0x4A
    #define CEC_BUFFER1_READY                  0x01
    #define CEC_BUFFER2_READY                  0x02
    #define CEC_BUFFER3_READY                  0x04
    #define CEC_THREE_BUFFERS_ENABLE           0x08    
    #define CECREG_SET_CLR_RX_RDY1(val)        CECREG_SET_RX_BUFFER1_READY(val)
    #define CECREG_SET_CLR_RX_RDY2(val)        CECREG_SET_RX_BUFFER2_READY(val)
    #define CECREG_SET_CLR_RX_RDY3(val)        CECREG_SET_RX_BUFFER3_READY(val)
    #define HTX_get_BUF2_TIMESTAMP(pval)       ATV_I2C16GetField8(CEC_I2C_MAP_BASE, VTX_REG_OFFSET(0xF0, 0x26), 0x30, 4, pval)
    #define HTX_get_BUF1_TIMESTAMP(pval)       ATV_I2C16GetField8(CEC_I2C_MAP_BASE, VTX_REG_OFFSET(0xF0, 0x26), 0x0C, 2, pval)
    #define HTX_get_BUF0_TIMESTAMP(pval)       ATV_I2C16GetField8(CEC_I2C_MAP_BASE, VTX_REG_OFFSET(0xF0, 0x26), 0x03, 0, pval)
#else
    #define CECREG_SET_NUM_RX_BUFFERS(val)     NULL  
#endif
#endif

#if (TX_DEVICE != 7511 )
#define CEC_RX_RDY3_INT_BIT             0x04
#define CEC_RX_RDY2_INT_BIT             0x02
#define CEC_RX_RDY1_INT_BIT             0x01
#endif

/*===============================================
 * I2C Macro Definitions
 *==============================================*/

#if (TX_DEVICE == 8002)
#define TXHAL_I2CWriteBlock(a,b,c,d)        HAL_I2C16WriteBlock8(a,b,c,d)
#define TXHAL_I2CReadBlock(a,b,c,d)         HAL_I2C16ReadBlock8(a,b,c,d)
#define TXHAL_I2CWriteByte(a,b,c)           HAL_I2C16WriteByte(a,b,c)
#define TXHAL_I2CReadByte(a,b,c)            HAL_I2C16ReadBlock8(a,b,c,1)
#define TXHAL_I2CWriteField8(a,b,c,d,e)     ATV_I2C16WriteField8(a,b,c,d,e)
#define TXHAL_REG_OFFSET(a,b)               TX_RegOffset(a,b)
#else
#define TXHAL_I2CWriteBlock                 HAL_I2CWriteBlock
#define TXHAL_I2CReadBlock                  HAL_I2CReadBlock
#define TXHAL_I2CWriteByte                  HAL_I2CWriteByte
#define TXHAL_I2CReadByte                   HAL_I2CReadByte
#define TXHAL_I2CWriteField8                ATV_I2CWriteField8
#define TXHAL_REG_OFFSET(a,b)               b
#endif

/*===============================================
 * Prototypes
 *==============================================*/


/*==========================================
 * APIs that have different implementations 
 * between Tx Devices 
 *=========================================*/
ATV_ERR TXHAL_SetChipIndex (UCHAR ChipIdx);
ATV_ERR TXHAL_Initialize (BOOL FullInit);
ATV_ERR TXHAL_SetInputFormat (UCHAR BitsPerColor, TX_IN_FORMAT Format,
                              UCHAR Style, TX_CHAN_ALIGN Alignment,
                              BOOL ClkEdge, BOOL BitSwap);
ATV_ERR TXHAL_ReadBksvs (UCHAR *BksvBuf, UCHAR Count);
ATV_ERR TXHAL_ReadEdid (UCHAR *EdidBuf);
ATV_ERR TXHAL_HdcpEnable (BOOL EncEn, BOOL FrmEncEn);
ATV_ERR TXHAL_SetCSC (TX_CS_MODE InCs, TX_CS_MODE OutCs);
ATV_ERR TXHAL_SetChStatSF (TX_AUD_FS SampFreq);
ATV_ERR TXHAL_SetAudInterface (TX_AUD_FORMAT InFormat, TX_AUD_PKT_TYPE OutType,
                               UCHAR HbrStrmCnt);
ATV_ERR TXHAL_WriteAvIfPacket (UCHAR *Packet, UCHAR Size);
ATV_ERR TXHAL_WriteAudIfPacket (UCHAR *Packet, UCHAR Size);
ATV_ERR TXHAL_WriteAcpPacket (UCHAR *Packet, UCHAR Size);
ATV_ERR TXHAL_WriteSpdPacket (UCHAR *Packet, UCHAR Size);
ATV_ERR TXHAL_WriteIsrc1Packet (UCHAR *Packet, UCHAR Size);
ATV_ERR TXHAL_WriteIsrc2Packet (UCHAR *Packet, UCHAR Size);
ATV_ERR TXHAL_WriteGmdPacket (UCHAR *Packet, UCHAR Size);
ATV_ERR TXHAL_WriteMpegPacket (UCHAR *Packet, UCHAR Size);
ATV_ERR TXHAL_WriteSpare1Packet (UCHAR *Packet, UCHAR Size);
ATV_ERR TXHAL_WriteSpare2Packet (UCHAR *Packet, UCHAR Size);
ATV_ERR TXHAL_TxInit (BOOL FullInit);


UCHAR   TXHAL_GetCurrMapAddr (UCHAR Dev0Addr);
TX_HDCP_ERR TXHAL_GetHdcpError (void);
void    TXHAL_GetChipStatus (TX_STATUS *TxStat);
void    TXHAL_SetChanStatusBits (TX_CHAN_STATUS *ChStat);
void    TXHAL_SetI2SEnable (UCHAR ChanCount, UCHAR ChanAlloc,
                            TX_AUD_PKT_TYPE AudType);
void    TXHAL_SetRJI2SSampSize (void);
UINT32  TXHAL_CalculateNValue (void);
void    TXHAL_EnableTmds (BOOL Enable, BOOL SoftOn);
void    TXHAL_EnableInfoFrames (UINT16 InfoFrames, BOOL Enable);
void    TXHAL_SetAvMute (TX_AVMUTE State);
void    TXHAL_Powerup (void);
void    TXHAL_Powerdown (void);
BOOL    TXHAL_InterruptPending (void);
void    TXHAL_GetInterrupts (TX_INTERRUPTS *TxInts);
void    TXHAL_SetInterrupts (TX_EVENT UserEvents);
void    TXHAL_ClearInterrupts (UCHAR Interrupt, TX_INTERRUPTS *TxInts);
void    TXHAL_GetEnabledPackets (UINT16 *Packets);


/*==========================================
 * Prototypes that to All Tx Devices Except 
 * ADV7850 
 *=========================================*/
#if(TX_DEVICE != 7850)
ATV_ERR TXHAL_SetInputVideoClock (UCHAR ClkDivide);
ATV_ERR TXHAL_ArcSetMode(TX_ARC_MODE ArcMode);
#endif
/*==========================================
 * Prototypes that to All Tx Devices Except 
 * ADV8002 Only
 *=========================================*/
#if (TX_DEVICE == 8002)   
void    TXHAL_TXReset (UCHAR txid);
void    TXHAL_ResetDefaultAudSamFreq(UCHAR SampFreq);
void    TXHAL_ResetDefaultAudio(UCHAR *pktptr);
void    TXHAL_ResetDefaultVideo(UCHAR *pktptr);
void    TXHAL_AdjustFreqRange(UCHAR Vic);
#endif
#if (TX_DEVICE == 7511)
ATV_ERR TXHAL_DisableAutoPjCheck(BOOL Disable);
#endif
#endif
