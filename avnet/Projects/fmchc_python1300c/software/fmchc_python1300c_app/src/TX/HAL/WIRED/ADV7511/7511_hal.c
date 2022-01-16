/**********************************************************************************************
*																						      *
* Copyright (c) 2012 Analog Devices, Inc.  All Rights Reserved.                               *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/

/*============================================================================
 * This file contains all functions that are chip-specific
 *
 *===========================================================================*/

#include "tx_hal.h"
#include "tx_isr.h"

#if (TX_DEVICE == 7511) 

EXTERNAL CONSTANT UCHAR TxInitTable[];

CONSTANT UCHAR TxInitTable[] = {
    0x16, 0x20,     /* RGB ouput, 444, 8 bit */
/*    0x3E, 0x04, */
    0x41, 0x10,     /* Power up */
    0x48, 0x40,
    0x49, 0xA8,
    0x96, 0xC0,
    0x98, 0x03,     /* Recommended setting R0x98=0x03*/
    0x99, 0x02,
    0x9C, 0x30,     /* Recommended setting R0x9C=0x30*/
    0x9D, 0x61,     /* Recommended setting R0x9D[1:0]=0b01 */
    0xA2, 0xA4,     /* Recommended setting R0xA2=0xA4 */
    0xA3, 0xA4,     /* Recommended setting R0xA3=0xA4 */
    0xAF, 0x04,     /*0x16,*/
#if(ADVANTIV)
    0xBA, 0x60,     /* C0 - DMT 1660 video format issue *//* Recommended setting  */
#else
	0xBA, 0xC0,
#endif
    0xBB, 0x00,     /* 0xFF */
    0xDE, 0x10,     /* Recommended setting R0xDE[7:4]=0b0001,[2:0]=0b000  */
    0xE0, 0xD0 /*0x4C*/ /*0x9C*/,     /* Recommended setting R0xE0[7:6]=0b10,[4:2]=0b111  */
    0xE4, 0x60,
    0xF9, 0x9C,     /* Set dummy I2C address to avoid address 0x7C conflict with the RX InfoFrame map */
    0xDF, 0x01,     /* Power Down ARC block */
    0x9A, 0xE0,     /* Recommended setting R0x9A[7:5] = 0b111 */
    0xFD, 0xE0,     /* Add some delay before writing An       */
    0xFE, 0x80,     /* Add some delay before re-starting HDCP */
    0x00, 0x00
};


CONSTANT UCHAR RecomSettingEs2[] = 
{
    0x00, 0x00
};

CONSTANT UCHAR RecomSettingEs3[] = 
{
    0x00, 0x00
};

/*==========================================================================
 *
 *
 *=========================================================================*/
void TXHAL_Powerdown (void)
{
    TXREG_SET_POWER_DOWN(1);
    PoweredUp = FALSE;
}

/*==========================================================================
 *
 *
 *=========================================================================*/
void TXHAL_Powerup (void)
{
    UINT16 i, ChipRev;
    UCHAR j=0;
    UCHAR CONSTANT *EsTable = NULL;

    TXREG_SET_POWER_DOWN(0);
    ChipRev = TXREG_GET_CHIP_REVISION();

    /*====================================================
     * Init local variables
     *===================================================*/
    if (!PoweredUp)
    {
        PoweredUp = TRUE;
        InitDone  = FALSE;
    }

    /*====================================================
     * Set default and recommended settings registers
     *===================================================*/
    i = 0;
    while (TxInitTable[i])
    {
        TXHAL_I2CWriteByte(TXDEV_MAIN_MAP, 
                           TXHAL_REG_OFFSET(0, TxInitTable[i]), 
                           TxInitTable[i+1]); 
        i+= 2;
    }
    if (ChipRev == TX_CHIP_REV_ES2)
    {
        EsTable = RecomSettingEs2;
    }
    else if (ChipRev > TX_CHIP_REV_ES2)
    {
        EsTable = RecomSettingEs3;
    }
    if (EsTable)
    {
        i = 0;
        while (EsTable[i])
        {
            TXHAL_I2CWriteByte(TXDEV_MAIN_MAP, 
                               TXHAL_REG_OFFSET(0, EsTable[i]),
                               EsTable[i+1]);
            i+= 2;
        }
    }
    TXREG_SET_RX_SENSE_PD(j);
    TXREG_SET_RX_SENSE_RESET(j);
    TXREG_SET_IN_CLK_PD(j);

    /*===============================================
     * Set packet memory, EDID and CEC i2c address
     *==============================================*/
    TXREG_SET_PKT_MEM_MAP_ADDR (TXDEV_PKTMEM_MAP);
    TXREG_SET_EDID_MAP_ADDR (TXDEV_EDID_MAP);
    TXREG_SET_CEC_MAP_ADDR (TXDEV_CEC_MAP);

    /*====================================
     * Set reserved registers fields
     *===================================*/
    TXREG_SET_R30(8);
    TXREG_SET_SERIALIZER_CURR(1);
    TXREG_SET_HDCP_ROM_LOC(TX_INTERNAL_HDCP_EPROM);

    /*====================================
     * Disable HDCP 1.1 Features
     *===================================*/
     TXHAL_DisableAutoPjCheck (TRUE);
#if TX_USER_INIT
    /*====================================
     * Set User-specified init values
     *===================================*/
    i = 0;
    while (UserTxRegInitTable[i])
    {
        j = TXHAL_GetCurrMapAddr (UserTxRegInitTable[i]);
        if (j)
        {
            TXHAL_I2CWriteByte(j, 
                         TXHAL_REG_OFFSET(0, UserTxRegInitTable[i+1]),
                         UserTxRegInitTable[i+2]);
        }
        i+= 3;
    }
    i = 0;
    while (UserTxFieldInitTable[i])
    {
        j = TXHAL_GetCurrMapAddr (UserTxFieldInitTable[i]);
        if (j)
        {
            TXHAL_I2CWriteField8(j, 
                      TXHAL_REG_OFFSET(0, UserTxFieldInitTable[i+1]),
                      UserTxFieldInitTable[i+2], 0, UserTxFieldInitTable[i+3]);
        }
        i+= 4;
    }
#endif
}

/*==========================================================================
 *
 *
 *=========================================================================*/
ATV_ERR TXHAL_ArcSetMode(TX_ARC_MODE ArcMode)
{
    switch (ArcMode)
    {
        case TX_ARC_SINGLE:
            TXREG_SET_ARC_MODE(1);
            break;
        case TX_ARC_COMMON:
            TXREG_SET_ARC_MODE(0);
            break;
        case TX_ARC_OFF:
        default:
            break;
    }
    TXREG_SET_ARC_DISABLE((ArcMode==TX_ARC_OFF)? 1: 0);
    return (ATVERR_OK);
}
/*===========================================================================
 * On ADI Tx Devices If HDCP encryption is enabled and the Tx Device Reads
 * via the BCAPs register that the connected Rx supports HDCP 1.1 Features.
 * The Tx will by default automatically enable 1.1 feature Pj checking.
 *
 * Due to  various interpretations of the spec and incorrect implementation
 * it Pj checking can cause HDCP failure with non 1.1 Compliant Rx Devices.
 *
 * In the latest revision of the ADV7511(Rev code 0x14) there is an option
 * to turn off the auto enabling of 1.1 features, regardless of BCAPs status.
 *
 *
 * Entry: Disable - TRUE  Disable Automatic 1.1 encryption based on BCAPS
 *                  FALSE -Enable Automatic 1.1 Encryption based on BCAPS
 *
 *
 *==========================================================================*/
ATV_ERR TXHAL_DisableAutoPjCheck (BOOL Disable)
{
   UCHAR ChipRev=0x0;

   HTX_get_CHIP_REVISION(&ChipRev);

   if(ChipRev == 0x14)
   {
      TXREG_SET_DIS_PJ_CHECK(Disable);
      return(ATVERR_OK);
   }
   else
   {
      return (ATVERR_NOT_AVAILABLE);
   }
}
#endif
