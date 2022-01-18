/**********************************************************************************************
*																						      *
* Copyright (c) 2012 Analog Devices, Inc.  All Rights Reserved.                               *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/

#ifndef _TX_ISR_H_
#define _TX_ISR_H_

#ifdef TX_CALLBACK_FUNCTION
EXTERNAL UINT16 TX_CALLBACK_FUNCTION (TX_EVENT Ev, UINT16 Cnt, void *Buf);
#else
#define TX_CALLBACK_FUNCTION(a,b,c)             0
#endif

#ifdef TX_CHECK_BKSV_REVOKED_FUNCTION
EXTERNAL UINT16 TX_CHECK_BKSV_REVOKED_FUNCTION (UCHAR Count, UCHAR *Buff);
#else
#define TX_CHECK_BKSV_REVOKED_FUNCTION(a,b)     FALSE
#endif

#define NOTIFY_USER(a,b,c)          if(UsrEvents&a)TX_CALLBACK_FUNCTION(a,b,c)

typedef struct
{
    /*============================
     * ISR variables
     *===========================*/
    UCHAR EdidSegCountN;            /* Nof EDID segments in EdidBuf */
    UCHAR EdidBufN[TX_SUPPORTED_EDID_SEGMENTS * 256];
    UCHAR TxBcapsN;                 /* Downstream BCAPS             */
    UCHAR TxBstatusN[2];            /* Downstream Bstatus           */
    UCHAR BksvCountN;               /* Nof BKSVs in BksvBuff        */
    UCHAR BksvBuffN[(TX_SUPPORTED_DS_DEVICE_COUNT+1)*5];
    BOOL  BksvsReadyN;              /* TRUE when all BKSVs are read */
    BOOL  AuthenticatedN;           /* Authenticated state          */
    TX_HDCP_ERR LastHdcpErrorN;
    TX_EVENT UsrEventsN;            /* Enabled user notification events     */
    UCHAR TotNofDsBksvsN;
    UCHAR TotBksvsReadByHwN;

    /*============================
     * LIB variables
     *===========================*/
    UINT32       UsrNValN;          /* 0 indicate automatic N calculation   */
    TX_MCLK_FREQ UsrMClkN;          /* User specified MCLK                  */
    TX_CONFIG    UsrConfigN;        /* User configuration                   */
    BOOL         PoweredUpN;        /* Chip is powered up                   */
    BOOL         InitDoneN;         /* Init done per device                 */
} TX_LIB_VARS;

#define TxUsrNVal                   (TxLibVars[TxCurrDevIdx].UsrNValN)
#define TxUsrMClk                   (TxLibVars[TxCurrDevIdx].UsrMClkN)
#define TxUsrConfig                 (TxLibVars[TxCurrDevIdx].UsrConfigN)
#define PoweredUp                   (TxLibVars[TxCurrDevIdx].PoweredUpN)
#define InitDone                    (TxLibVars[TxCurrDevIdx].InitDoneN)

EXTERNAL TX_LIB_VARS TxLibVars[];

UINT16  Tx_IsrNotify (TX_EVENT Ev, UINT16 Cnt, void *Buf);
void    Tx_ResetHdcpVars (void);

#endif
