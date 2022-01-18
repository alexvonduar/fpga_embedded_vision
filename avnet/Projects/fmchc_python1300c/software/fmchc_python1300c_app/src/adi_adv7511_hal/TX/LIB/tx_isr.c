/**********************************************************************************************
*																						      *
* Copyright (c) 2012 Analog Devices, Inc.  All Rights Reserved.                               *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/

#include "tx_hal.h"
#include "tx_isr.h"
#if TX_INCLUDE_CEC
#endif

/*================================
 * Defines, macros and externals
 *===============================*/
#define HDCP_MAX_DEVICE_ERR         0x80
#define HDCP_MAX_CASCADE_ERR        0x08

#define DS_IS_REP                   (TxBcaps & 0x40)
#define TOT_DS_BKSV_COUNT           (1 + (TxBstatus[1] & 0x7f))

/*=============================
 * Local constants
 *============================*/

/*=============================
 * Local variables
 *============================*/
#define EdidSegCount                (TxLibVars[TxCurrDevIdx].EdidSegCountN)
#define EdidBuf                     (TxLibVars[TxCurrDevIdx].EdidBufN)
#define TxBcaps                     (TxLibVars[TxCurrDevIdx].TxBcapsN)
#define TxBstatus                   (TxLibVars[TxCurrDevIdx].TxBstatusN)
#define BksvCount                   (TxLibVars[TxCurrDevIdx].BksvCountN)
#define BksvBuff                    (TxLibVars[TxCurrDevIdx].BksvBuffN)
#define BksvsReady                  (TxLibVars[TxCurrDevIdx].BksvsReadyN)
#define Authenticated               (TxLibVars[TxCurrDevIdx].AuthenticatedN)
#define LastHdcpError               (TxLibVars[TxCurrDevIdx].LastHdcpErrorN)
#define UsrEvents                   (TxLibVars[TxCurrDevIdx].UsrEventsN)
#define TotNofDsBksvs               (TxLibVars[TxCurrDevIdx].TotNofDsBksvsN)
#define TotBksvsReadByHw            (TxLibVars[TxCurrDevIdx].TotBksvsReadByHwN)

/*=============================
 * Local Prototypes
 *============================*/
STATIC void TxBksvListReady (void);
STATIC void TxBksvErrors (UCHAR NewCount);
STATIC void TxSoftwareInit (void);

/*==========================================================================
 * Check if TX interrupt is pending
 *
 * Entry:   None
 *
 * Return:  ATVERR_TRUE     if interrupt pending
 *          ATVERR_FALSE    if no interrupt pending
 *
 * Notes:
 *
 *=========================================================================*/
ATV_ERR ADIAPI_TxIntPending (void)
{
    if (InitDone)
    {
#if IGNORE_INT_LINES
        return (ATVERR_TRUE); 
        /*return (TXHAL_InterruptPending()? ATVERR_TRUE: ATVERR_FALSE);*/
#else
        return (HAL_TxIntPending()? ATVERR_TRUE: ATVERR_FALSE);
#endif
    }
    else
    {
        return (ATVERR_TRUE);
    }
}

/*==========================================================================
 * Process any pending TX interrupts
 *
 * Entry:   None
 *
 * Return:  ATVERR_OK       if interrupt detected, processing complete
 *          ATVERR_FAILED   if no interrupt detected
 *
 * Notes:
 *
 *=========================================================================*/
ATV_ERR ADIAPI_TxIsr (void)
{
    TX_INTERRUPTS Interrupts;
    ATV_ERR RetVal = ATVERR_FAILED;
    UCHAR i, j, NofBksvsInFifo, NewBksvs;
    BOOL  IntOn;
#if TX_INCLUDE_CEC
    CEC_INTERRUPTS CecInts;
#endif

    /*=======================================
     * Get asserted interrupts
     *======================================*/
    TXHAL_GetInterrupts (&Interrupts);

    /*=======================================
     * Check HPD changed
     *======================================*/
    if (Interrupts.Hpd)
    {
        /*=====================================================
         * Clear HPD int BEFORE resetting TX. If you reset TX 
         * before clearing int, you may miss another HPD int 
         * that happens immediately after TX reset
         *====================================================*/
        TXHAL_ClearInterrupts(TX_INT_HPD_CHNG, &Interrupts);
        TxSoftwareInit();
        IntOn = (BOOL) TXREG_GET_HPD_STATE();
        TX_DBG("HPD changed to %s\n\r", IntOn? "HI": "LOW");
        if ((IntOn  && (TxUsrConfig & TX_INIT_ON_HPD_HIGH)) ||
            (!IntOn && (TxUsrConfig & TX_INIT_ON_HPD_LOW)))
        {
            ADIAPI_TxInit(FALSE);
        }
        NOTIFY_USER(TX_EVENT_HPD_CHG, 0, &IntOn);
        RetVal = ATVERR_OK;
    }

    /*=======================================
     * Check MSEN changed 
     *======================================*/
    if (Interrupts.MonSen)
    {
        /*========================================
         * Clear int BEFORE resetting TX so we
         * won't miss MSEN int AFTER reset
         *=======================================*/
        TXHAL_ClearInterrupts(TX_INT_MSEN_CHNG, &Interrupts);
        IntOn = (BOOL) TXREG_GET_MSEN_STATE();
        TX_DBG("MSEN changed to %s\n\r", IntOn? "HI": "LOW");
        NOTIFY_USER(TX_EVENT_MSEN_CHG, 0, &IntOn);
        RetVal = ATVERR_OK;
    }

    /*=========================
     * EDID ready
     *========================*/
    if (Interrupts.EdidReady)
    {
        i = TXREG_GET_EDID_SEGMENT();
        if ((i != EdidSegCount) || (i > (TX_SUPPORTED_EDID_SEGMENTS - 1)))
        {
            TX_DBG("Invalid EDID segment number received: %d\n\r", i);
            TXHAL_ClearInterrupts(TX_INT_EDID_READY, &Interrupts);
            if (TxUsrConfig & TX_INIT_ON_EDID_ERROR)
            {
                ADIAPI_TxInit(FALSE);
            }
        }
        else
        {
            /*================================
             * Read segment to buffer
             *===============================*/
            TXHAL_ReadEdid (EdidBuf + (((UINT16)i) << 8));
            TX_DBG("EDID Segment %d received\n\r", i);
            EdidSegCount++;

            TXREG_SET_EDID_READ_RETRY(TX_EDID_RETRY_COUNT);
            /*====================================================
             * Read more segments if available and we support it
             *===================================================*/
            j = EdidBuf[0x7E] >> 1;     /* j = Nof additional segments */
            if ((j > i) && (EdidSegCount < TX_SUPPORTED_EDID_SEGMENTS))
            {
                TXREG_SET_EDID_SEGMENT(EdidSegCount); /* mbw must toggle 10 times */
            }
            /*================================================
             * Clear EDID interrupt only after reading EDID
             * so that HDCP will not overwrite it
             *===============================================*/
            TXHAL_ClearInterrupts(TX_INT_EDID_READY, &Interrupts);
            NOTIFY_USER(TX_EVENT_EDID_READY, (UINT16)i, EdidBuf + (((UINT16)i) << 8));
        }
        RetVal = ATVERR_OK;
    }

    /*=========================
     * BKSV ready
     *========================*/
    if (Interrupts.BksvReady)
    {
        Authenticated = FALSE;
        NofBksvsInFifo = TXREG_GET_BKSV_COUNT();
        TxBcaps = TXREG_GET_BCAPS();

        /*=======================================
         * If this is the first BKSV interrupt
         *======================================*/
        if (NofBksvsInFifo == 0)
        {
            Tx_ResetHdcpVars();
            NewBksvs = 1;
            TotNofDsBksvs = 1;
            TotBksvsReadByHw = 1;
            TXHAL_ReadBksvs (BksvBuff, 0);
            TX_DBG("Received first BKSV\n\r");
        }
        else
        {
            /*==========================
             * Read DS Bstatus
             *=========================*/
            if (BksvCount == 1)
            {
                /*=================================================
                 * DS Bstatus contain the following information:
                 *
                 * DEVICE_COUNT = Total DS device count, not
                 *                including attached DS repeater
                 * DEPTH        = Nof levels below DS repeater
                 *                (not including DS repeater)
                 *================================================*/
                TXREG_GET_BSTATUS(TxBstatus); /* Return MSB in [0] */
                TotNofDsBksvs = TOT_DS_BKSV_COUNT;
                TX_DBG("%d BKSVs attached to DS device (Bstatus=0x%02x%02x)\n\r", 
                        TotNofDsBksvs, TxBstatus[0], TxBstatus[1]);
            }
            i = NofBksvsInFifo;
            TX_DBG("%d more BKSV(s) received.\n\r", NofBksvsInFifo);
            if ((BksvCount+NofBksvsInFifo) > TX_SUPPORTED_DS_DEVICE_COUNT)
            {
                i = TX_SUPPORTED_DS_DEVICE_COUNT - BksvCount;
            }

            /*=========================================
             * i= Nof BKSVs to read into our buffer
             *========================================*/
            if (i)
            {
                TXHAL_ReadBksvs (BksvBuff+(((UINT16)BksvCount)*5), i);
            }
            NewBksvs = i;
            TotBksvsReadByHw+= NofBksvsInFifo;
        }

        if (NewBksvs)
        {
            /*============================================
             * Check if any errors in the new BKSVs
             *===========================================*/
            TxBksvErrors(NewBksvs);
        }

        /*===========================================
         * Notify user if all BKSV reading are done
         *==========================================*/
        if (TotBksvsReadByHw == TotNofDsBksvs)
        {
            if ((!DS_IS_REP) || (BksvCount > 1))
            {
                TxBksvListReady();
            }
        }
        TXHAL_ClearInterrupts(TX_INT_BKSV_READY, &Interrupts);
        RetVal = ATVERR_OK;
    }

            
    /*=========================
     * HDCP Authenticated
     *========================*/
    if (Interrupts.HdcpAuth)
    {
        TXHAL_ClearInterrupts(TX_INT_HDCP_AUTH, &Interrupts);
        /*======================================
         * If this is a correct authent. int
         *=====================================*/
        if (!Authenticated)
        {
            /*===============================================
             * Case when DS is REP with no devices attached
             *==============================================*/
            if ((!BksvsReady) && DS_IS_REP && (BksvCount == 1))
            {
                TxBksvListReady();
            }
            if (BksvsReady)
            {
                TX_DBG("HDCP authenticated\n\r");
                Authenticated = TRUE;
                NOTIFY_USER(TX_EVENT_AUTHENTICATED, 0, NULL);
            }
            else
            {
                TX_DBG("HDCP authenticated and BKSVs not ready\n\r");
            }
        }
        else
        {
            TX_DBG("Auth. interrupt while already auth.\n\r");
        }
        RetVal = ATVERR_OK;
    }

    /*=========================
     * HDCP Error
     *========================*/
    if (Interrupts.HdcpError)
    {
        LastHdcpError = TXHAL_GetHdcpError();
        i = (UCHAR)LastHdcpError;
        NOTIFY_USER(TX_EVENT_HDCP_ERROR, 0, &i);
        if (TxUsrConfig & TX_HDCP_DISABLE_ON_ERROR)
        {
            ADIAPI_TxHdcpEnable(FALSE, FALSE);
        }
        TXHAL_ClearInterrupts(TX_INT_HDCP_ERR, &Interrupts);
        RetVal = ATVERR_OK;
    }

#if TX_INCLUDE_CEC
    CecInts.TxReady = Interrupts.Cec.TxReady;
    CecInts.RxReady = Interrupts.Cec.RxReady;
    CecInts.ArbLost = Interrupts.Cec.ArbLost;
    CecInts.Timeout = Interrupts.Cec.Timeout;

#if ((TX_DEVICE==8002) || (TX_DEVICE==7511))
    CecInts.RxReady1 = Interrupts.Cec.RxReady1;
    CecInts.RxReady2 = Interrupts.Cec.RxReady2;
    CecInts.RxReady3 = Interrupts.Cec.RxReady3;
#endif
    
    for ( i = 0; i < CEC_TRIPLE_NUMBER ;i++)
    {
        CecInts.RxFrameOrder[i] = Interrupts.Cec.RxFrameOrder[i];
    }
    
    CEC_Isr(&CecInts);

    if (CecInts.TxReady)
    {
        TXHAL_ClearInterrupts(CEC_INT_TX_RDY, &Interrupts);
        RetVal = ATVERR_OK;
    }
    
#if ((TX_DEVICE==8002) || (TX_DEVICE==7511))
   if (CecInts.RxReady1)
    {
        TXHAL_ClearInterrupts(CEC_INT_RX_RDY1, &Interrupts);
        RetVal = ATVERR_OK;
    }
   if (CecInts.RxReady2)
    {
        TXHAL_ClearInterrupts(CEC_INT_RX_RDY2, &Interrupts);
        RetVal = ATVERR_OK;
    }
   if (CecInts.RxReady3)
    {
        TXHAL_ClearInterrupts(CEC_INT_RX_RDY3, &Interrupts);
        RetVal = ATVERR_OK;
    }        

#else            
    if (CecInts.RxReady)
    {
        TXHAL_ClearInterrupts(CEC_INT_RX_RDY, &Interrupts);
        RetVal = ATVERR_OK;
    }
#endif
    
    if (CecInts.Timeout)
    {
        TXHAL_ClearInterrupts(CEC_INT_TX_TIMEOUT, &Interrupts);
        RetVal = ATVERR_OK;
    }
    if (CecInts.ArbLost)
    {
        TXHAL_ClearInterrupts(CEC_INT_TX_ARB_LOST, &Interrupts);
        RetVal = ATVERR_OK;
    }
#endif

    if (Interrupts.Vsync)
    {
        NOTIFY_USER(TX_EVENT_VSYNC_INT, 0, NULL);
        TXHAL_ClearInterrupts(TX_INT_VSYNC_EDGE, &Interrupts);
        RetVal = ATVERR_OK;
    }
    if (Interrupts.AudFifoFull)
    {
        NOTIFY_USER(TX_EVENT_AUD_FIFO_FULL, 0, NULL);
        TXHAL_ClearInterrupts(TX_INT_AUD_FIFO_FULL, &Interrupts);
        RetVal = ATVERR_OK;
    }
    if (Interrupts.EmbSyncErr)
    {
        NOTIFY_USER(TX_EVENT_EMB_SYNC_ERR, 0, NULL);
        TXHAL_ClearInterrupts(TX_INT_EMB_SYNC_ERR, &Interrupts);
        RetVal = ATVERR_OK;
    }
    return (RetVal);
}

/*===========================================================================
 * Get BKSV list
 *
 * Entry:   BksvList    = Pointer to receive BKSV list. This can be set to
 *                        NULL if not required.
 *          NumOfBksvs  = Number of BKSVs returned in BksvList
 *
 * Return:  ATVERR_OK
 *
 * Notes: 
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxGetBksvList (UCHAR *BksvList, UCHAR *NumOfBksvs)
{
    if (BksvsReady)
    {
        if (BksvList)
        {
            memcpy (BksvList, BksvBuff, BksvCount*5);
        }
        *NumOfBksvs = BksvCount;
        return (ATVERR_OK);
    }
    return (ATVERR_FAILED);
}

/*===========================================================================
 * 
 *
 * Entry:   
 *
 * Return:  ATVERR_OK
 *
 * Notes: 
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxGetLastHdcpError (TX_HDCP_ERR *Error)
{
    *Error = LastHdcpError;
    return (ATVERR_OK);
}

/*===========================================================================
 * 
 *
 * Entry:   
 *
 * Return:  ATVERR_OK
 *
 * Notes: 
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxGetBstatus (UINT16 *Bstatus, UCHAR *Bcaps)
{
    if (BksvsReady)
    {
        if (Bstatus)
        {
            *Bstatus = ((UINT16)(TxBstatus[1])) + ((UINT16)(TxBstatus[0]) << 8);
        }
        if (Bcaps)
        {
            *Bcaps = TxBcaps;
        }
        return (ATVERR_OK);
    }
    return (ATVERR_FAILED);
}

/*===========================================================================
 * 
 *
 * Entry:   SegNum =
 *          SegBuf =
 *
 * Return:  ATVERR_OK
 *          ATVERR_FAILED
 *
 * Notes: 
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxGetEdidSegment (UCHAR SegNum, UCHAR *SegBuf)
{
    if (SegNum < EdidSegCount)
    {
        memcpy (SegBuf, EdidBuf+(((UINT16)SegNum)<<8), 256);
        return (ATVERR_OK);
    }
    return (ATVERR_FAILED);
}

/*============================================================================
 * Enable or disable user notification of certain events
 *
 * Entry:   Events  = Events to be enabled/disabled ORed together
 *          Enable  = TRUE to enable events
 *                    FALSE to disable events
 *
 * Return:  ATVERR_OK
 *
 * Notes: 
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetEnabledEvents (TX_EVENT Events, BOOL Enable)
{
    if (Enable)
    {
        UsrEvents |= Events;
    }   
    else
    {
        UsrEvents &= (~Events);
    }
    TXHAL_SetInterrupts(UsrEvents);
    return (ATVERR_OK);
}

/*==========================================================================
 * The function is called from the CEC ISR to do CEC notification
 *
 *
 *=========================================================================*/
UINT16 Tx_IsrNotify (TX_EVENT Ev, UINT16 Cnt, void *Buf)
{
    UINT16 RetVal = 0;

    if (UsrEvents & Ev)
    {
        RetVal = TX_CALLBACK_FUNCTION(Ev, Cnt, Buf);
    }
    return (RetVal);
}

/*==========================================================================
 * Reset HDCP varaibles
 *
 * Entry:   None
 *
 * Return:  None
 *
 *
 *=========================================================================*/
void Tx_ResetHdcpVars (void)
{
    BksvCount = 0;
    TxBstatus[0] = 0;
    TxBstatus[1] = 0;
    BksvsReady = FALSE;
    Authenticated = FALSE;
    LastHdcpError = TX_HDCP_ERR_NONE;
}

/*==========================================================================
 * Notify application that BKSV list is ready
 *
 * Entry:   None
 *
 * Return:  None
 *
 *
 *=========================================================================*/
STATIC void TxBksvListReady (void)
{
    UINT16 i, j;

    /*================================
     * Display BKSV list
     *===============================*/
    TX_DBG("%d of %d BKSVs Read\n\r", BksvCount, TOT_DS_BKSV_COUNT);
    for (i=0; i<BksvCount*5; i+=5)
    {
        TX_PRINT("             ");
        for (j=0; j<5; j++)
        {
            TX_PRINT("%02x ", BksvBuff[i+j]);
        }
        TX_PRINT("\n\r");
    }

    BksvsReady = TRUE;
    NOTIFY_USER(TX_EVENT_BKSV_READY, (UINT16)BksvCount, BksvBuff);
}

/*==========================================================================
 * Check if any BKSV errors (max dev/cas exceeded or revocation)
 * If max exceeded error, disable HDCP if TxUsrConfig is set to do so
 *
 * Entry:   NewCount = Nof new BKSVs read into our buffer by the ISR
 *
 * Return:  ATVERR_OK
 *
 *=========================================================================*/
STATIC void TxBksvErrors (UCHAR NewCount)
{
    BOOL IsError = FALSE;

    /*============================================
     * Call application revocation function
     *===========================================*/
    if (TX_CHECK_BKSV_REVOKED_FUNCTION(NewCount, BksvBuff+BksvCount))
    {
        ADIAPI_TxHdcpEnable(FALSE, FALSE);
    }

    BksvCount+= NewCount;

    /*============================================
     * Check if we read all BKSVs
     *===========================================*/
    if (BksvCount == TOT_DS_BKSV_COUNT)
    {
        if ((!DS_IS_REP) || (BksvCount > 1))
        {
            /*==================================================
             * All BKSVs are read. Check Bstatus exceeded bits
             *==================================================*/
            if ((TxBstatus[1] & HDCP_MAX_DEVICE_ERR) ||
                (TxBstatus[0] & HDCP_MAX_CASCADE_ERR))
            {
                 IsError = TRUE;
            }
        }
    }
    else if (BksvCount == TX_SUPPORTED_DS_DEVICE_COUNT)
    {
        /*==================================================
         * Our buff is full. Set Bstatus exceeded bits
         *==================================================*/
        TxBstatus[1] |= HDCP_MAX_DEVICE_ERR;
        IsError = TRUE;
    }

    /*==================================================
     * All BKSVs are read. Check Bstatus exceeded bits
     *==================================================*/
    if (IsError && (TxUsrConfig & TX_HDCP_DISABLE_ON_ERROR))
    {
        ADIAPI_TxHdcpEnable(FALSE, FALSE);
    }
}

/*==========================================================================
 * Initialize TX library s/w
 *
 * Entry:   None
 *
 * Return:  None
 *
 *
 *=========================================================================*/
STATIC void TxSoftwareInit (void)
{
    EdidSegCount = 0;
    memset(EdidBuf, 0, TX_SUPPORTED_EDID_SEGMENTS * 256);
    Tx_ResetHdcpVars();
}
