/**********************************************************************************************
*																						      *
* Copyright (c) 2012 Analog Devices, Inc.  All Rights Reserved.                               *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/

#include "tx_hal.h"

#if TX_INCLUDE_CEC
#include "tx_isr.h"


/*============================================================================
 * Set the device to be used for CEC processing. Only one CEC engine can be
 * active at any given time
 * 
 * Entry:   DevIndex = Device Index to be used for CEC processing
 * 
 * Return:  ATVERR_OK
 * 
 *===========================================================================*/
ATV_ERR ADIAPI_TxCecSetActiveDevice (UCHAR DevIndex)
{
    ATV_ERR RetVal = ATVERR_INV_PARM;

    if (DevIndex < TX_NUM_OF_DEVICES)
    {
        if  (DevIndex != TxActiveCecIdx)
        {
            /*======================================
             * Disable active CEC controller
             *=====================================*/
            ADIAPI_TxCecEnable(FALSE);

            /*======================================
             * Set new active CEC controller
             *=====================================*/
            TxActiveCecIdx = DevIndex;
            ADIAPI_TxCecEnable(TRUE);
        }
        RetVal = ATVERR_OK;
    }
    return (RetVal);
}

/*============================================================================
 * Reset CEC controller
 * 
 * Entry:   None
 * 
 * Return:  ATVERR_OK
 * 
 *===========================================================================*/
ATV_ERR ADIAPI_TxCecReset (void)
{
    TXREG_SET_ACTIVE_CEC_MAP(TXDEV_ACTIVE_CEC_MAP);
    CEC_Reset();
    TXREG_SET_ACTIVE_CEC_MAP(TXDEV_ACTIVE_CEC_MAP);
    return (ATVERR_OK);
}

/*============================================================================
 * Enable/Disable CEC controller
 * 
 * Entry:   Enable = TRUE to enable CEC controller
 *                   FALSE to disable
 * 
 * Return:  ATVERR_OK
 * 
 *===========================================================================*/
ATV_ERR ADIAPI_TxCecEnable (BOOL Enable)
{
    TXREG_SET_ACTIVE_CEC_MAP(TXDEV_ACTIVE_CEC_MAP);
    TXREG_SET_ACTIVE_CEC_PD(Enable? 0 : 1);
    CEC_Enable(Enable);
    return (ATVERR_OK);
}

/*============================================================================
 * Set the logical address for one of 3 logical devices
 * 
 * Entry:   LogAddr = Logical address for the device
 *          DevId   = The device to set the logical address to. (0, 1 or 2)
 *          Enable  = TRUE to enable the logical device
 *                    FALSE to disable the logical device
 * 
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM if DevId is larger than 2
 * 
 *===========================================================================*/
ATV_ERR ADIAPI_TxCecSetLogicalAddr (UCHAR LogAddr, UCHAR DevId, BOOL Enable)
{
    return (CEC_SetLogicalAddr(LogAddr, DevId, Enable));
}

/*============================================================================
 * Send message to CEC
 * 
 * Entry:   MsgPtr = Pointer to the message to be sent
 *          MsgLen
 * 
 * Return:  ATVERR_OK
 *          ATVERR_FAILED if CEC controller is busy
 *          ATVERR_INV_PARM if MsgLen is larger than max message size
 * 
 *===========================================================================*/
ATV_ERR ADIAPI_TxCecSendMessage (UCHAR *MsgPtr, UCHAR MsgLen)
{
    return (CEC_SendMessage(MsgPtr, MsgLen));
}

/*============================================================================
 * to check if any CEC message in buffer, if yes, to send one
 * 
 * Entry:   none
 * 
 * Return:  ATVERR_OK
 *          ATVERR_FAILED if CEC controller is busy
  * 
 *===========================================================================*/
ATV_ERR ADIAPI_TxCecSendMessageOut(void)
{
    return (CEC_SendMessageOut()); 
}    

/*============================================================================
 * Resend last sent message to CEC
 * 
 * Entry:   None
 * 
 * Return:  ATVERR_OK
 *          ATVERR_FAILED if CEC controller is busy
 * 
 *===========================================================================*/
ATV_ERR ADIAPI_TxCecResendLastMessage (void)
{
    return (CEC_ResendLastMessage());
}

/*============================================================================
 * Perform logical address allocation
 *
 * Entry:   LogAddrList = Pointer to a prioritized list of logical addresses 
 *                        that the device will try to obtain, terminated by
 *                        0xff.
 *
 * Return:  ATVERR_OK
 *          ATVERR_FAILED if CEC is busy
 *          ATVERR_INV_PARM if LogAddrList is too long or contains no data
 * 
 * This function returns immediately. If a logical address slot is found,
 * the caller will be notified by the event ADI_EVENT_CEC_LOG_ADDR_ALLOC
 * 
 *===========================================================================*/
ATV_ERR ADIAPI_TxCecAllocateLogAddr (UCHAR *LogAddrList)
{
    return (CEC_AllocateLogAddr(LogAddrList));
}

/*============================================================================
 * 
 *
 * Entry:   
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 * 
 * 
 *===========================================================================*/
ATV_ERR ADIAPI_TxCecReadMessage (UCHAR *MsgPtr, UCHAR *MsgLen)
{
    return (ATVERR_OK);
}

/*============================================================================
 * 
 *
 * Entry:   
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 * 
 * 
 *===========================================================================*/
ATV_ERR ADIAPI_TxCecGetStatus (UCHAR *Status)
{
    return (ATVERR_OK);
}

/*============================================================================
 * This function is called from the CEC module ISR
 *
 * Entry:   
 *
 * Return:  
 * 
 *===========================================================================*/
UINT16 Cec_Notification (UCHAR Event, UINT16 Len, void *Buff)
{
    UINT16 RetVal = 0;
    TX_EVENT Ev = (TX_EVENT)0;

    switch (Event)
    {
        case CEC_EVENT_RX_MSG:
            Ev = TX_EVENT_CEC_RX_MSG;
            break;
        case CEC_EVENT_TX_DONE:
            Ev = TX_EVENT_CEC_TX_DONE;
            break;
        case CEC_EVENT_TX_TIMEOUT:
            Ev = TX_EVENT_CEC_TX_TIMEOUT;
            break;
        case CEC_EVENT_TX_ARB_LOST:
            Ev = TX_EVENT_CEC_TX_ARB_LOST;
            break;
        case CEC_EVENT_LOG_ADDR_ALLOC:
            Ev = TX_EVENT_CEC_LOG_ADDR_ALLOC;
            break;
        case CEC_EVENT_RX_MSG_RESPOND:
            Ev = TX_EVENT_CEC_RX_MSG_RESPOND;
            break;
            
        default:
           break;
    }
    RetVal = Tx_IsrNotify(Ev, Len, Buff);
    return (RetVal);
}

#endif
