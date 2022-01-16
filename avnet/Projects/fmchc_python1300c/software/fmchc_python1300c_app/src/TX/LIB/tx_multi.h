/**********************************************************************************************
*																						      *
* Copyright (c) 2012 Analog Devices, Inc.  All Rights Reserved.                               *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/

#ifndef _TX_MULTI_H_
#define _TX_MULTI_H_

/*========================================
 * Multi-device APIs
 *=======================================*/
#if TX_NUM_OF_DEVICES > 1

#ifdef __cplusplus
extern "C" {
#endif

ATV_ERR ADIAPI_TxInitN (UCHAR DevIdx, BOOL FullInit);
ATV_ERR ADIAPI_TxShutdownN (UCHAR DevIdx, TX_PD_MODE PdMode);
ATV_ERR ADIAPI_TxSetConfigN (UCHAR DevIdx, TX_CONFIG UserConfig, BOOL Set);
ATV_ERR ADIAPI_TxIsrN (UCHAR DevIdx);
ATV_ERR ADIAPI_TxSetEnabledEventsN (UCHAR DevIdx, TX_EVENT Events, BOOL Enable);
ATV_ERR ADIAPI_TxGetChipRevisionN (UCHAR DevIdx, UINT16 *TxRev);
ATV_ERR ADIAPI_TxOverrideHpdPdN (UCHAR DevIdx, BOOL Override);
ATV_ERR ADIAPI_TxEnableTmdsN (UCHAR DevIdx, BOOL Enable, BOOL SoftOn);
ATV_ERR ADIAPI_TxSetInputPixelFormatN (UCHAR DevIdx, UCHAR BitsPerColor, TX_IN_FORMAT Format, UCHAR Style, TX_CHAN_ALIGN Align, BOOL RisingEdge, BOOL BitSwap);
ATV_ERR ADIAPI_TxSetInputVideoClockN (UCHAR DevIdx, UCHAR ClkDivide);
ATV_ERR ADIAPI_TxSetOutputPixelFormatN (UCHAR DevIdx, TX_OUT_ENCODING OutEnc, BOOL Interpolate);
ATV_ERR ADIAPI_TxSetManualPixelRepeatN (UCHAR DevIdx, UCHAR Vic, UCHAR Factor, UCHAR PrValue);
ATV_ERR ADIAPI_TxSetAutoPixelRepeatN (UCHAR DevIdx, UCHAR Mode, UCHAR Vic, TX_REFR_RATE RefRate, UCHAR AspectRatio);
ATV_ERR ADIAPI_TxSetOutputColorDepthN (UCHAR DevIdx, UCHAR Depth, TX_DC_METHOD DcMethod);
ATV_ERR ADIAPI_TxSetCSCN (UCHAR DevIdx, TX_CS_MODE InColorSpace, TX_CS_MODE OutColorSpace);
ATV_ERR ADIAPI_TxSetAudioInterfaceN (UCHAR DevIdx, TX_AUD_FORMAT InputFormat, TX_AUD_PKT_TYPE OutType, UCHAR HbrStrmCount);
ATV_ERR ADIAPI_TxSetAudChanMappingN (UCHAR DevIdx, TX_AUD_CHAN InChan, TX_AUD_CHAN OutSample);
ATV_ERR ADIAPI_TxSetAudNValueN (UCHAR DevIdx, UINT32 NValue);
ATV_ERR ADIAPI_TxSetAudCTSN (UCHAR DevIdx, UINT32 CTS);
ATV_ERR ADIAPI_TxSetAudMCLKN (UCHAR DevIdx, TX_MCLK_FREQ MClk);
ATV_ERR ADIAPI_TxSetAudClkPolarityN (UCHAR DevIdx, BOOL RisingEdge);
ATV_ERR ADIAPI_TxSetAudChStatSampFreqN (UCHAR DevIdx, TX_AUD_FS SampFreq);
ATV_ERR ADIAPI_TxSetAudChanStatusN (UCHAR DevIdx, BOOL FromStream, TX_CHAN_STATUS *ChanStat);
ATV_ERR ADIAPI_TxAudInputEnableN (UCHAR DevIdx, TX_AUD_INTERFACE Interface, BOOL Enable);
ATV_ERR ADIAPI_TxSetI2sInputN (UCHAR DevIdx, UCHAR ChanCount, UCHAR ChanAlloc, TX_AUD_PKT_TYPE AudType);
ATV_ERR ADIAPI_TxSetOutputModeN (UCHAR DevIdx, TX_OUTPUT_MODE OutMode);
ATV_ERR ADIAPI_TxHdcpEnableN (UCHAR DevIdx, BOOL EncEnable, BOOL FrameEncEnable);
ATV_ERR ADIAPI_TxGetBksvListN (UCHAR DevIdx, UCHAR *BksvList, UCHAR *NumOfBksvs);
ATV_ERR ADIAPI_TxGetBstatusN (UCHAR DevIdx, UINT16 *Bstatus, UCHAR *Bcaps);
ATV_ERR ADIAPI_TxGetHdcpStateN (UCHAR DevIdx, TX_HDCP_STATE *HdcpState);
ATV_ERR ADIAPI_TxGetLastHdcpErrorN (UCHAR DevIdx, TX_HDCP_ERR *Error);
ATV_ERR ADIAPI_TxGetEdidSegmentN (UCHAR DevIdx, UCHAR SegNum, UCHAR *SegBuf);
ATV_ERR ADIAPI_TxGetHpdMsenStateN (UCHAR DevIdx, BOOL *Hpd, BOOL *Msen);
ATV_ERR ADIAPI_TxGetStatusN (UCHAR DevIdx, TX_STATUS *TxStat);
ATV_ERR ADIAPI_TxMuteAudioN (UCHAR DevIdx, BOOL Mute);
ATV_ERR ADIAPI_TxMuteVideoN (UCHAR DevIdx, BOOL Mute);
ATV_ERR ADIAPI_TxSetAvmuteN (UCHAR DevIdx, TX_AVMUTE State);
ATV_ERR ADIAPI_TxEnablePacketsN (UCHAR DevIdx, UINT16 Packets, BOOL Enable);
ATV_ERR ADIAPI_TxGetEnabledPacketsN (UCHAR DevIdx, UINT16 *Packets);
ATV_ERR ADIAPI_TxSendAVInfoFrameN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size);
ATV_ERR ADIAPI_TxSendAudioInfoFrameN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size);
ATV_ERR ADIAPI_TxSendACPPacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size);
ATV_ERR ADIAPI_TxSendSPDPacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size);
ATV_ERR ADIAPI_TxSendISRC1PacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size);
ATV_ERR ADIAPI_TxSendISRC2PacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size);
ATV_ERR ADIAPI_TxSendMpegPacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size);
ATV_ERR ADIAPI_TxSendSpare1PacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size);
ATV_ERR ADIAPI_TxSendSpare2PacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size);
ATV_ERR ADIAPI_TxSendGMDPacketN (UCHAR DevIdx, UCHAR *Packet, UCHAR Size);

#ifdef __cplusplus
}
#endif

#else

#define ADIAPI_TxInitN(i,a)                         ADIAPI_TxInit(a)
#define ADIAPI_TxShutdownN(i,a)                     ADIAPI_TxShutdown(a)
#define ADIAPI_TxSetConfigN(i,a,b)                  ADIAPI_TxSetConfig(a,b)
#define ADIAPI_TxIsrN(i)                            ADIAPI_TxIsr()
#define ADIAPI_TxSetEnabledEventsN(i,a,b)           ADIAPI_TxSetEnabledEvents(a,b)
#define ADIAPI_TxGetChipRevisionN(i,a)              ADIAPI_TxGetChipRevision(a)
#define ADIAPI_TxOverrideHpdPdN(i,a)                ADIAPI_TxOverrideHpdPd(a)
#define ADIAPI_TxEnableTmdsN(i,a,b)                 ADIAPI_TxEnableTmds(a,b)
#define ADIAPI_TxSetInputPixelFormatN(i,a,b,c,d,e,f) ADIAPI_TxSetInputPixelFormat(a,b,c,d,e,f)
#define ADIAPI_TxSetInputVideoClockN(i,a)           ADIAPI_TxSetInputVideoClock(a)
#define ADIAPI_TxSetOutputPixelFormatN(i,a,b)       ADIAPI_TxSetOutputPixelFormat(a,b)
#define ADIAPI_TxSetManualPixelRepeatN(i,a,b,c)     ADIAPI_TxSetManualPixelRepeat(a,b,c)
#define ADIAPI_TxSetAutoPixelRepeatN(i,a,b,c,d)     ADIAPI_TxSetAutoPixelRepeat(a,b,c,d)
#define ADIAPI_TxSetOutputColorDepthN(i,a,b)        ADIAPI_TxSetOutputColorDepth(a,b)
#define ADIAPI_TxSetCSCN(i,a,b)                     ADIAPI_TxSetCSC(a,b)
#define ADIAPI_TxSetAudioInterfaceN(i,a,b,c)        ADIAPI_TxSetAudioInterface(a,b,c)
#define ADIAPI_TxSetAudChanMappingN(i,a,b)          ADIAPI_TxSetAudChanMapping(a,b)
#define ADIAPI_TxSetAudNValueN(i,a)                 ADIAPI_TxSetAudNValue(a)
#define ADIAPI_TxSetAudCTSN(i,a)                    ADIAPI_TxSetAudCTS(a)
#define ADIAPI_TxSetAudMCLKN(i,a)                   ADIAPI_TxSetAudMCLK(a)
#define ADIAPI_TxSetAudClkPolarityN(i,a)            ADIAPI_TxSetAudClkPolarity(a)
#define ADIAPI_TxSetAudChStatSampFreqN(i,a)         ADIAPI_TxSetAudChStatSampFreq(a)
#define ADIAPI_TxSetAudChanStatusN(i,a,b)           ADIAPI_TxSetAudChanStatus(a,b)
#define ADIAPI_TxAudInputEnableN(i,a,b)             ADIAPI_TxAudInputEnable(a,b)
#define ADIAPI_TxSetI2sInputN(i,a,b,c)              ADIAPI_TxSetI2sInputN(a,b,c)
#define ADIAPI_TxSetOutputModeN(i,a)                ADIAPI_TxSetOutputMode(a)
#define ADIAPI_TxHdcpEnableN(i,a,b)                 ADIAPI_TxHdcpEnable(a,b)
#define ADIAPI_TxGetBksvListN(i,a,b)                ADIAPI_TxGetBksvList(a,b)
#define ADIAPI_TxGetBstatusN(i,a,b)                 ADIAPI_TxGetBstatus(a,b)
#define ADIAPI_TxGetHdcpStateN(i,a)                 ADIAPI_TxGetHdcpState(a)
#define ADIAPI_TxGetLastHdcpErrorN(i,a)             ADIAPI_TxGetLastHdcpError(a)
#define ADIAPI_TxGetEdidSegmentN(i,a,b)             ADIAPI_TxGetEdidSegment(a,b)
#define ADIAPI_TxGetHpdMsenStateN(i,a,b)            ADIAPI_TxGetHpdMsenState(a,b)
#define ADIAPI_TxGetStatusN(i,a)                    ADIAPI_TxGetStatus(a)
#define ADIAPI_TxMuteAudioN(i,a)                    ADIAPI_TxMuteAudio(a)
#define ADIAPI_TxMuteVideoN(i,a)                    ADIAPI_TxMuteVideo(a)
#define ADIAPI_TxSetAvmuteN(i,a)                    ADIAPI_TxSetAvmute(a)
#define ADIAPI_TxEnablePacketsN(i,a,b)              ADIAPI_TxEnablePackets(a,b)
#define ADIAPI_TxGetEnabledPacketsN(i,a)            ADIAPI_TxGetEnabledPackets(a)
#define ADIAPI_TxSendAVInfoFrameN(i,a,b)            ADIAPI_TxSendAVInfoFrame(a,b)
#define ADIAPI_TxSendAudioInfoFrameN(i,a,b)         ADIAPI_TxSendAudioInfoFrame(a,b)
#define ADIAPI_TxSendACPPacketN(i,a,b)              ADIAPI_TxSendACPPacket(a,b)
#define ADIAPI_TxSendSPDPacketN(i,a,b)              ADIAPI_TxSendSPDPacket(a,b)
#define ADIAPI_TxSendISRC1PacketN(i,a,b)            ADIAPI_TxSendISRC1Packet(a,b)
#define ADIAPI_TxSendISRC2PacketN(i,a,b)            ADIAPI_TxSendISRC2Packet(a,b)
#define ADIAPI_TxSendGMDPacketN(i,a,b)              ADIAPI_TxSendGMDPacket(a,b)
#define ADIAPI_TxSendMpegPacketN(i,a,b)             ADIAPI_TxSendMpegPacket(a,b)
#define ADIAPI_TxSendSpare1PacketN(i,a,b)           ADIAPI_TxSendSpare1Packet(a,b)
#define ADIAPI_TxSendSpare2PacketN(i,a,b)           ADIAPI_TxSendSpare2Packet(a,b)

#endif

#endif
