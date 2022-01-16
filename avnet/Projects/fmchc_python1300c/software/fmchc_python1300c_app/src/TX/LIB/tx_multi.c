/**********************************************************************************************
*																						      *
* Copyright (c) 2012 Analog Devices, Inc.  All Rights Reserved.                               *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/

#include "tx_hal.h"

#if (TX_NUM_OF_DEVICES > 1)

/*======================================
 * Defines, Macros and Externals
 *=====================================*/
#define SINGLE_PREFIX       ATV_ERR RetVal = ATVERR_INV_PARM;               \
                            UCHAR OrgIdx;                                   \
                            if (DevIdx < TX_NUM_OF_DEVICES)                 \
                            {                                               \
                                OrgIdx = TxCurrDevIdx;                      \
                                TxCurrDevIdx = DevIdx;                      \
                                TxDevAddr = &(TxDeviceAddress[TxCurrDevIdx]);

#define SINGLE_SUFFIX           TxCurrDevIdx = OrgIdx;                      \
                                TxDevAddr = &(TxDeviceAddress[TxCurrDevIdx]); \
                            }                                               \
                            return (RetVal);                                


#define MULTI_PREFIX        ATV_ERR RetVal = ATVERR_INV_PARM;               \
                            UCHAR OrgIdx, StartIdx, EndIdx;                 \
                            OrgIdx = TxCurrDevIdx;                          \
                            if (DevIdx == TX_ALL_DEV)                       \
                            {                                               \
                                StartIdx = 0;                               \
                                EndIdx = TX_NUM_OF_DEVICES;                 \
                            }                                               \
                            else if (DevIdx < TX_NUM_OF_DEVICES)            \
                            {                                               \
                                StartIdx = DevIdx;                          \
                                EndIdx = StartIdx + 1;                      \
                            }                                               \
                            else                                            \
                            {                                               \
                                return (RetVal);                            \
                            }                                               \
                            for (; StartIdx<EndIdx; StartIdx++)             \
                            {                                               \
                                TxCurrDevIdx = StartIdx;                    \
                                TxDevAddr = &(TxDeviceAddress[TxCurrDevIdx]);

#define MULTI_SUFFIX        }                                               \
                            TxCurrDevIdx = OrgIdx;                          \
                            TxDevAddr = &(TxDeviceAddress[TxCurrDevIdx]);   \
                            return (RetVal);

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxInitN (UCHAR DevIdx, BOOL FullInit)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxInit(FullInit);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxShutdownN (UCHAR DevIdx, TX_PD_MODE PdMode)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxShutdown(PdMode);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetConfigN (UCHAR DevIdx, TX_CONFIG UserConfig, BOOL Set)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetConfig(UserConfig, Set);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxIsrN (UCHAR DevIdx)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxIsr();
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetEnabledEventsN (UCHAR DevIdx, TX_EVENT Events, BOOL Enable)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetEnabledEvents(Events, Enable);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxGetChipRevisionN (UCHAR DevIdx, UINT16 *TxRev)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxGetChipRevision(TxRev);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxOverrideHpdPdN (UCHAR DevIdx, BOOL Override)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxOverrideHpdPd(Override);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxEnableTmdsN (UCHAR DevIdx, BOOL Enable, BOOL SoftOn)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxEnableTmds(Enable, SoftOn);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetInputPixelFormatN (UCHAR DevIdx, UCHAR BitsPerColor, 
                        TX_IN_FORMAT Format, UCHAR Style, TX_CHAN_ALIGN Align, 
                        BOOL RisingEdge, BOOL BitSwap)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetInputPixelFormat(BitsPerColor, Format, Style, Align, RisingEdge, BitSwap);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetInputVideoClockN (UCHAR DevIdx, UCHAR ClkDivide)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetInputVideoClock(ClkDivide);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetOutputPixelFormatN (UCHAR DevIdx, TX_OUT_ENCODING OutEnc, BOOL Interpolate)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetOutputPixelFormat(OutEnc, Interpolate);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetManualPixelRepeatN (UCHAR DevIdx, UCHAR Vic, UCHAR Factor, UCHAR PrValue)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetManualPixelRepeat(Vic, Factor, PrValue);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetAutoPixelRepeatN (UCHAR DevIdx, UCHAR Mode, UCHAR Vic, TX_REFR_RATE RefRate, UCHAR AspectRatio)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetAutoPixelRepeat(Mode, Vic, RefRate, AspectRatio);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetOutputColorDepthN (UCHAR DevIdx, UCHAR Depth, TX_DC_METHOD DcMethod)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetOutputColorDepth(Depth, DcMethod);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetCSCN (UCHAR DevIdx, TX_CS_MODE InColorSpace, TX_CS_MODE OutColorSpace)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetCSC(InColorSpace, OutColorSpace);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetAudioInterfaceN (UCHAR DevIdx, TX_AUD_FORMAT InputFormat, TX_AUD_PKT_TYPE OutType, UCHAR HbrStrmCount)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetAudioInterface(InputFormat, OutType, HbrStrmCount);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetAudChanMappingN (UCHAR DevIdx, TX_AUD_CHAN InChan, TX_AUD_CHAN OutSample)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetAudChanMapping(InChan, OutSample);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetAudNValueN (UCHAR DevIdx, UINT32 NValue)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetAudNValue(NValue);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetAudCTSN (UCHAR DevIdx, UINT32 CTS)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetAudCTS(CTS);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetAudMCLKN (UCHAR DevIdx, TX_MCLK_FREQ MClk)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetAudMCLK(MClk);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetAudClkPolarityN (UCHAR DevIdx, BOOL RisingEdge)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetAudClkPolarity(RisingEdge);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetAudChStatSampFreqN (UCHAR DevIdx, TX_AUD_FS SampFreq)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetAudChStatSampFreq(SampFreq);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetAudChanStatusN (UCHAR DevIdx, BOOL FromStream, TX_CHAN_STATUS *ChanStat)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetAudChanStatus(FromStream, ChanStat);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxAudInputEnableN (UCHAR DevIdx, TX_AUD_INTERFACE Interface, BOOL Enable)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxAudInputEnable(Interface, Enable);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetI2sInputN (UCHAR DevIdx, UCHAR ChanCount, UCHAR ChanAlloc, TX_AUD_PKT_TYPE AudType)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetI2sInput(ChanCount, ChanAlloc, AudType);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetOutputModeN (UCHAR DevIdx, TX_OUTPUT_MODE OutMode)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetOutputMode(OutMode);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxHdcpEnableN (UCHAR DevIdx, BOOL EncEnable, BOOL FrameEncEnable)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxHdcpEnable(EncEnable, FrameEncEnable);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxGetBksvListN (UCHAR DevIdx, UCHAR *BksvList, UCHAR *NumOfBksvs)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxGetBksvList(BksvList, NumOfBksvs);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxGetBstatusN (UCHAR DevIdx, UINT16 *Bstatus, UCHAR *Bcaps)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxGetBstatus(Bstatus, Bcaps);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxGetHdcpStateN (UCHAR DevIdx, TX_HDCP_STATE *HdcpState)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxGetHdcpState(HdcpState);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxGetLastHdcpErrorN (UCHAR DevIdx, TX_HDCP_ERR *Error)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxGetLastHdcpError(Error);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxGetEdidSegmentN (UCHAR DevIdx, UCHAR SegNum, UCHAR *SegBuf)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxGetEdidSegment(SegNum, SegBuf);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxGetHpdMsenStateN (UCHAR DevIdx, BOOL *Hpd, BOOL *Msen)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxGetHpdMsenState(Hpd, Msen);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxGetEdidControllerStateN (UCHAR DevIdx, TX_EDID_CTRL_STATE *State)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxGetEdidControllerState (State);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxOutputModeHdmiN (UCHAR DevIdx, BOOL *IsHdmi)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxOutputModeHdmi (IsHdmi);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxHdcpEnabledN (UCHAR DevIdx, BOOL *HdcpOn)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxHdcpEnabled (HdcpOn);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxOutputEncryptedN (UCHAR DevIdx, BOOL *Encrypted)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxOutputEncrypted (Encrypted);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxPllLockedN (UCHAR DevIdx, BOOL *Locked)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxPllLocked (Locked);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxGetStatusN (UCHAR DevIdx, TX_STATUS *TxStat)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxGetStatus(TxStat);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxMuteAudioN (UCHAR DevIdx, BOOL Mute)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxMuteAudio(Mute);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxMuteVideoN (UCHAR DevIdx, BOOL Mute)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxMuteVideo(Mute);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetAvmuteN (UCHAR DevIdx, TX_AVMUTE State)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSetAvmute(State);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxEnablePacketsN (UCHAR DevIdx, UINT16 Packets, BOOL Enable)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxEnablePackets(Packets, Enable);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxGetEnabledPacketsN (UCHAR DevIdx, UINT16 *Packets)
{
    SINGLE_PREFIX
    RetVal = ADIAPI_TxGetEnabledPackets(Packets);
    SINGLE_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSendAVInfoFrameN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSendAVInfoFrame(Packet, Size);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSendAudioInfoFrameN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSendAudioInfoFrame(Packet, Size);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSendACPPacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSendACPPacket(Packet, Size);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSendSPDPacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSendSPDPacket(Packet, Size);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSendISRC1PacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSendISRC1Packet(Packet, Size);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSendISRC2PacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSendISRC2Packet(Packet, Size);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSendGMDPacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSendGMDPacket(Packet, Size);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSendMpegPacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSendMpegPacket(Packet, Size);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSendSpare1PacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSendSpare1Packet(Packet, Size);
    MULTI_SUFFIX
}

/*============================================================================
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSendSpare2PacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size)
{
    MULTI_PREFIX
    RetVal = ADIAPI_TxSendSpare2Packet(Packet, Size);
    MULTI_SUFFIX
}

#endif
