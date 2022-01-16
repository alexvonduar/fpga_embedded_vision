/**********************************************************************************************
*																						      *
* Copyright (c) 2012 Analog Devices, Inc.  All Rights Reserved.                               *
* This software is proprietary and confidential to Analog Devices, Inc. and its licensors.    *
*                                                                                             *
***********************************************************************************************/

#include "tx_hal.h"
#include "tx_isr.h"

/*======================================
 * Defines, Macros and Externals
 *=====================================*/

/*======================================
 * Local Constants
 *=====================================*/
STATIC CONSTANT UCHAR AudioEnTable[] =
{
    (UCHAR)TX_AUD_IN_I2S0, 0x00,    (UCHAR)TX_AUD_IN_I2S1,  0x01,
    (UCHAR)TX_AUD_IN_I2S2, 0x02,    (UCHAR)TX_AUD_IN_I2S3,  0x03,
    (UCHAR)TX_AUD_IN_I2S,  0x0f,    (UCHAR)TX_AUD_IN_SPDIF, 0x10,
    (UCHAR)TX_AUD_IN_DSD0, 0x20,    (UCHAR)TX_AUD_IN_DSD1,  0x21,
    (UCHAR)TX_AUD_IN_DSD2, 0x22,    (UCHAR)TX_AUD_IN_DSD3,  0x23,
    (UCHAR)TX_AUD_IN_DSD4, 0x24,    (UCHAR)TX_AUD_IN_DSD5,  0x25,
    (UCHAR)TX_AUD_IN_DSD6, 0x26,    (UCHAR)TX_AUD_IN_DSD7,  0x27,
    (UCHAR)TX_AUD_IN_DSD,  0x2f,    (UCHAR)TX_AUD_IN_DST,   0x30,
    TX_AUD_IN_ALL,         0xf0,    0xff
};                                             /* high nibble = audio type */

/*======================================
 * Local Variables
 *=====================================*/

/*======================================
 * Shared Variables
 *=====================================*/
TX_LIB_VARS TxLibVars[TX_NUM_OF_INSTANCES];
UCHAR    TxCurrDevIdx = 0;
UCHAR    TxActiveCecIdx = 0;
CONSTANT TX_DEV_ADDR *TxDevAddr = &(TxDeviceAddress[0]); /* I2C base addr of TX device maps */

/*======================================
 * Local Prototypes
 *=====================================*/

/*============================================================================
 * Set the device index to be used for API calls
 *
 * Entry:   DevIdx  = Index of the TX device to be used for all subsequent
 *                    API calls
 *
 * Return:  ATVERR_OK
 *          ATVERR_FAILED
 *
 * Notes:
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetDeviceIndex (UCHAR DevIdx)
{
    return (TXHAL_SetChipIndex(DevIdx));
}

/*============================================================================
 * Get the index of the TX device currently being processed
 *
 * Entry:   DevIdx  = Pointer to receive the index of the TX device currently
 *                    being processed by the library
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxGetDeviceIndex (UCHAR *DevIdx)
{
    *DevIdx = TxCurrDevIdx;
    return (ATVERR_OK);
}

/*============================================================================
 * Initialize HDMI TX chip
 *
 * Entry:   FullInit  = TRUE to perform cold init (everything is reset)
 *                      FALSE to perform warm start init
 *                      (CEC engine will not be reset)
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxInit (BOOL FullInit)
{
    return TXHAL_TxInit(FullInit);
}

/*============================================================================
 * Power down ALL HDMI TX chips in the system
 *
 * Entry:   PdMode = Power-down mode
 *                   TX_PD_MODE1
 *                      Power-down entire chip except HPD, RX sense, CEC
 *                   TX_PD_MODE2
 *                      Entire chip except CEC engine
 *                   TX_PD_MODE3
 *                      Entire chip is powered down
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxShutdown (TX_PD_MODE PdMode)
{
    TXHAL_Powerdown();

    if ((PdMode == TX_PD_MODE2) || (PdMode == TX_PD_MODE3))
    {
        TXREG_SET_RX_SENSE_PD(1);
        TXREG_SET_RX_SENSE_RESET(1);
        TXREG_SET_IN_CLK_PD(1);
    }
    if (PdMode == TX_PD_MODE3)
    {
        TXREG_SET_CEC_PD(1);
    }
    return (ATVERR_OK);
}

/*============================================================================
 * Configure how TX ISR responds to various events and set other operational
 * parameters
 *
 * Entry:   UserConfig  = TX_INIT_ON_HPD_LOW
 *                        TX_INIT_ON_HPD_HIGH
 *                        TX_INIT_ON_EDID_ERROR
 *                        TX_HDCP_DISABLE_ON_ERROR
 *          Set         = TRUE/FALSE
 *
 * Return:  ATVERR_OK
 *
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxSetConfig (TX_CONFIG UserConfig, BOOL Set)
{
    if (Set)
    {
        TxUsrConfig |= UserConfig;
    }
    else
    {
        TxUsrConfig &= (~UserConfig);
    }
    return (ATVERR_OK);
}

/*===========================================================================
 * Get HDMI TX chip revision
 *
 * Entry:   TxRev = Pointer to receive chip revision
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxGetChipRevision (UINT16 *TxRev)
{
    *TxRev = (UINT16)(TXREG_GET_CHIP_REVISION());
    return (ATVERR_OK);
}

/*===========================================================================
 * Override HDMI TX power-down when HPD goes low
 *
 * Entry:   Override = TRUE to disable power-down when HPD goes low
 *                     FALSE to enable power-down when HPD goes low
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxOverrideHpdPd (BOOL Override)
{
    TXREG_SET_HPD_PD_OVERIDE(Override? 1: 0);
    return (ATVERR_OK);
}

/*===========================================================================
 * Enable/Disable TMDS clock and data lines
 *
 * Entry:   Enable = TRUE/FALSE to Enable/Disable TMDS clock and data lines
 *          SoftOn = TRUE/FALSE to Enable/Disable soft TMDS clock turn-on
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxEnableTmds (BOOL Enable, BOOL SoftOn)
{
    TXHAL_EnableTmds(Enable, SoftOn);
    return (ATVERR_OK);
}

/*===========================================================================
 * Set input pixel data format
 *
 * Entry:   BitsPerColor = Number of bits per color component.
 *                         This can be 8, 10 or 12
 *          Format       = Video input format
 *                            SDR_444_SEP_SYNC
 *                            SDR_422_SEP_SYNC
 *                            SDR_422_EMP_SYNC
 *                            SDR_422_SEP_SYNC_2X_CLK
 *                            SDR_422_EMB_SYNC_2X_CLK
 *                            DDR_444_SEP_SYNC
 *                            DDR_422_SEP_SYNC
 *                            DDR_422_EMB_SYNC
 *          Style        = Three input styles are available: 1, 2 or 3.
 *          Alignment    = Bit alignment of each channel in 4:2:2 modes.
 *                         Three alignment types are available:
 *                            ALIGN_LEFT
 *                            ALIGN_RIGHT
 *                            ALIGN_EVEN
 *          RisingEdge   = This parameter is used only in DDR modes:
 *                         TRUE to clock data in DDR mode on rising edge
 *                         FALSE to clock data in DDR mode on falling edge
 *          BitSwap     = Set to TRUE to swap video pixel data (reverse order)
 *                        MSB with LSB. Set to FALSE to use normal pixel order
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:   Refer to the ADV7510 programming guide for information about input
 *          pin assignments
 *
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetInputPixelFormat (UCHAR BitsPerColor, TX_IN_FORMAT Format,
              UCHAR Style, TX_CHAN_ALIGN Align, BOOL RisingEdge, BOOL BitSwap)
{
    return (TXHAL_SetInputFormat(BitsPerColor, Format, Style, Align, RisingEdge, BitSwap));
}

/*===========================================================================
 * Set relation between Tx input video clock and pixel clock.
 *
 * Entry:   ClkDivide = 1 ---> Pixel clock = Input clock
 *                      2 ---> Pixel clock = Input clock / 2
 *                      4 ---> Pixel clock = Input clock / 4
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:   The input video clock to TX is usually the pixel clock. In cases
 *          where the input clock is NOT equal to the pixel clock, this
 *          function should be used to to divide the input clock to generate
 *          the correct pixel clock
 *
 *==========================================================================*/

ATV_ERR ADIAPI_TxSetInputVideoClock (UCHAR ClkDivide)
{
    return TXHAL_SetInputVideoClock(ClkDivide);

}
/*===========================================================================
 * Set output video format
 *
 * Entry:   OutEnc      = Output encoding format
 *                          OUT_ENC_YUV_422
 *                          OUT_ENC_YUV_444
 *                          OUT_ENC_RGB_444
 *          Interpolate = Used when upconverting from 4:2:2 to 4:4:4
 *                          TRUE to interpolate
 *                          FALSE to use line doubling
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:   None
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetOutputPixelFormat (TX_OUT_ENCODING OutEnc,
                                       BOOL Interpolate)
{
    UCHAR OutForm = 0;
    ATV_ERR RetVal = ATVERR_OK;

    switch (OutEnc)
    {
        case OUT_ENC_YUV_422:
            OutForm = 3;                /* Output 4:2:2 */
            break;
        case OUT_ENC_YUV_444:
            OutForm = 1;                /* Output 4:4:4 */
            break;
        case OUT_ENC_RGB_444:           /* RGB 4:4:4  */
            break;
        default:
            RetVal = ATVERR_INV_PARM;
            break;
    }
    if (RetVal == ATVERR_OK)
    {
        TXREG_SET_OUTPUT_COL_FORMAT(OutForm);
        TXREG_SET_INTERPOLATE_EN(Interpolate? 1: 0);
    }
    return (RetVal);
}

/*===========================================================================
 * Set manual output pixel repeat
 *
 * Entry:   Vic     = VIC code to be sent in AV infoframe
 *          Factor  = Multiplication factor of input pixel clock
 *                    Possible values are 1 to 4 (multiply by 1, 2, 3 or 4)
 *          PrValue = Pixel repeat value to be sent in AV infoframe
 *                    0=No repition, 1=Repeat two times
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetManualPixelRepeat (UCHAR Vic, UCHAR Factor, UCHAR PrValue)
{
    if ((Factor > 4) || (Factor == 0) || (PrValue > 3))
    {
        return (ATVERR_INV_PARM);
    }
    TXREG_SET_MANUAL_VIC(Vic);
    TXREG_SET_PIXEL_REP_MODE(2);
    TXREG_SET_PIXEL_REP_VAL(PrValue);
    TXREG_SET_PIXEL_REP_PLL(Factor-1);
    return (ATVERR_OK);
}

/*===========================================================================
 * Set automatic output pixel repeat. VIC will be automatically inserted in
 * AV infoframe
 *
 * Entry:   Mode    = 0 for Normal mode
 *                    1 for Maximum possible repeat count
 *          InVic   = VIC code of input video. Set to 0xff if unknown.
 *          RefRate = Used when input VIC is unknown to indicate input video
 *                    refresh rates. Possible values are:
 *                      REFRESH_NORMAL
 *                      REFRESH_LOW         (Below 30 Hz)
 *                      REFRESH_2X          (2x normal rate)
 *                      REFRESH_4X          (4x normal rate)
 *          AspecRatio = Used when input VIC is unknown to indicate input video
 *                       aspect ratio. Possible values are:
 *                          4*3  (=12  for 4x3)
 *                          16*9 (=144 for 16x9)
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetAutoPixelRepeat (UCHAR Mode, UCHAR Vic,
                                     TX_REFR_RATE RefRate, UCHAR AspectRatio)
{
    UINT16 Val;
    UCHAR LFrq=0, HFrq=0;
    ATV_ERR RetVal = ATVERR_OK;

    /*==================================================================
     * HDMI-TX will auto-insert VIC code into AVI info frame
     * For auto detection to work, low freq 1080p modes must be flagged
     *==================================================================*/
    if (Vic == 0xff)
    {
        switch (RefRate)
        {
            case REFRESH_NORMAL:
                break;
            case REFRESH_LOW:
                LFrq = 1;
                break;
            case REFRESH_2X:
                HFrq = 1;
                break;
            case REFRESH_4X:
                HFrq = 2;
                break;
            default:
                RetVal = ATVERR_INV_PARM;
                break;
        }
    }
    else
    {
        if (Vic && (Vic <= MAX_VIC_VALUE))
        {
            Val = Vic;
            if (VicInfo[(Val*4)+3] <= 30)
            {
                LFrq = 1;
            }
        }
        else
        {
            RetVal = ATVERR_INV_PARM;
        }
    }

    if ((AspectRatio != (4*3)) && (AspectRatio != (16*9)))
    {
        RetVal = ATVERR_INV_PARM;
    }

    if (RetVal == ATVERR_OK)
    {
        TXREG_SET_LOW_FRQ_VIDEO(LFrq);
        TXREG_SET_HI_FRQ_VIDEO(HFrq);
        TXREG_SET_ASPECT_16X9(AspectRatio==(16*9)? 1: 0);
        TXREG_SET_PIXEL_REP_MODE(Mode? 1: 0);
    }
    return (RetVal);
}

/*===========================================================================
 * Sets the HDMI TX output color depth
 *
 * Entry:   Depth    = Color depth value to be sent in the General control
 *                     packet depth field
 *          DcMethod = Down-conversion method to be used when input color
 *                     depth is larger than output color depth
 *                      TX_DC_TRUNCATE
 *                      TX_DC_ACTIVE_DITHER
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetOutputColorDepth (UCHAR Depth, TX_DC_METHOD DcMethod)
{
    UCHAR Val = 0;

    switch (DcMethod)
    {
        case TX_DC_ACTIVE_DITHER:
            break;
        case TX_DC_TRUNCATE:
            Val = 0x2A;
            break;
        default:
            return (ATVERR_INV_PARM);
    }
    TXREG_SET_DWNCONV_METHOD(Val);
    if (Depth == 24)
    {
        Depth = 4;
    }
    else if (Depth == 30)
    {
        Depth = 5;
    }
    else if (Depth == 36)
    {
        Depth = 6;
    }
    TXREG_SET_COLOR_DEPTH(Depth);
    return (ATVERR_OK);
}

/*===========================================================================
 * Set HDMI TX Color Space Conversion
 *
 * Entry:   InColorSpace = Input Color Space
 *                          TX_CS_RGB
 *                          TX_CS_YUV_601
 *                          TX_CS_YUV_709
 *                          TX_CS_YCC_601
 *                          TX_CS_YCC_709
 *                          TX_CS_AUTO
 *          OutColorSpace= Output Color Space
 *                          TX_CS_RGB
 *                          TX_CS_YUV_601
 *                          TX_CS_YUV_709
 *                          TX_CS_YCC_601
 *                          TX_CS_YCC_709
 *                          TX_CS_AUTO
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetCSC (TX_CS_MODE InColorSpace, TX_CS_MODE OutColorSpace)
{
    return (TXHAL_SetCSC (InColorSpace, OutColorSpace));
}

/*===========================================================================
 * Set input audio interface and output audio packet type
 *
 * Entry:   InputFormat = Define the input audio interface and format:
 *                          TX_I2S_STD
 *                          TX_I2S_RJUST
 *                          TX_I2S_LJUST
 *                          TX_I2S_AES3
 *                          TX_I2S_SPDIF
 *                          TX_SPDIF
 *                          TX_DSD_NORM
 *                          TX_DSD_SDIF3
 *                          TX_DSD_DST
 *                          TX_DSD_DST_SDR
 *                          TX_DSD_DST_DDR
 *          OutType     = Define the output audio type
 *                          AUD_SAMP_PKT
 *                          HI_BIT_RATE
 *                          ONE_BIT_AUD
 *                          DST_AUD
 *          HbrStrmCount= Stream count for HBR audio. Can be 1 or 4.
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetAudioInterface (TX_AUD_FORMAT InputFormat,
                                 TX_AUD_PKT_TYPE OutType, UCHAR HbrStrmCount)
{
    ATV_ERR RetVal;
    RetVal = TXHAL_SetAudInterface(InputFormat, OutType, HbrStrmCount);

    if (RetVal == ATVERR_OK)
    {
        /*======================================
         * Restore parameters changed by HBR
         *======================================*/
        if (OutType != HBR_STRM_PKT)
        {
            ADIAPI_TxSetAudMCLK (TxUsrMClk);
        }
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
 *          ChanAlloc = Channel allocation field from audio info-frame
 *                      Not used if input audio is HBR
 *          AudType   = Input audio type. If set to HBR_STRM_PKT, it will
 *                      enable all I2S inputs regardless of ChanCount and
 *                      ChanAlloc setting
 *
 * Return:  ATVERR_OK
 *
 * Notes:   None
 *
 *=========================================================================*/
ATV_ERR ADIAPI_TxSetI2sInput(UCHAR ChanCount, UCHAR ChanAlloc,
                            TX_AUD_PKT_TYPE AudType)
{
    TXHAL_SetI2SEnable (ChanCount, ChanAlloc, AudType);
    return (ATVERR_OK);
}

/*===========================================================================
 * Map I2S input channels to output packets
 *
 * Entry:   InChan      = Input I2S Channel number
 *          OutSample   = Output sample position for Input channel
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetAudChanMapping (TX_AUD_CHAN InChan, TX_AUD_CHAN OutSample)
{
    ATV_ERR RetVal = ATVERR_OK;

    switch (OutSample)
    {
        case CH0_LEFT:
            TXREG_SET_SB0_LEFT_CHAN((UCHAR)InChan);
            break;
        case CH0_RIGHT:
            TXREG_SET_SB0_RIGHT_CHAN((UCHAR)InChan);
            break;
        case CH1_LEFT:
            TXREG_SET_SB1_LEFT_CHAN((UCHAR)InChan);
            break;
        case CH1_RIGHT:
            TXREG_SET_SB1_RIGHT_CHAN((UCHAR)InChan);
            break;
        case CH2_LEFT:
            TXREG_SET_SB2_LEFT_CHAN((UCHAR)InChan);
            break;
        case CH2_RIGHT:
            TXREG_SET_SB2_RIGHT_CHAN((UCHAR)InChan);
            break;
        case CH3_LEFT:
            TXREG_SET_SB3_LEFT_CHAN((UCHAR)InChan);
            break;
        case CH3_RIGHT:
            TXREG_SET_SB3_RIGHT_CHAN((UCHAR)InChan);
            break;
        default:
            RetVal = ATVERR_INV_PARM;
            break;
    }
    return (RetVal);
}

/*===========================================================================
 * Set audio N value
 *
 * Entry:   NValue = Audio N value. Set to 0 to automatically calculate N
 *                   from audio infoframe and/or channel status
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetAudNValue (UINT32 NValue)
{
    TxUsrNVal = NValue;
    if (TxUsrNVal == 0)
    {
        NValue = TXHAL_CalculateNValue();
    }
    TXREG_SET_N_VALUE(NValue);
    return (ATVERR_OK);
}

/*===========================================================================
 * Set Audio CTS
 *
 * Entry:   CTS = Audio Cycle Time Stamp. Set to 0 for automatic CTS.
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetAudCTS (UINT32 CTS)
{
    if (CTS)
    {
        TXREG_SET_CTS(CTS);
        TXREG_SET_USER_CTS_SELECT(1);
    }
    else
    {
        TXREG_SET_USER_CTS_SELECT(0);
    }
    return (ATVERR_OK);
}

/*===========================================================================
 * Set MCLK
 *
 * Entry:   Mclk = MCLK value
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetAudMCLK (TX_MCLK_FREQ MClk)
{
    UCHAR Ratio = 0;
    UCHAR Sel = 1;

    switch (MClk)
    {
        case TX_MCLK_128FS:
        case TX_MCLK_HBR:
            break;
        case TX_MCLK_256FS:
            Ratio = 1;
            break;
        case TX_MCLK_384FS:
            Ratio = 2;
            break;
        case TX_MCLK_512FS:
            Ratio = 3;
            break;
        case TX_MCLK_AUTO:
            Sel = 0;
            break;
        default:
            return (ATVERR_INV_PARM);
    }
    TxUsrMClk = MClk;
    TXREG_SET_MCLK_RATIO(Ratio);
    TXREG_SET_USER_MCLK_SELECT(Sel);
    return (ATVERR_OK);
}

/*===========================================================================
 * Set audio clock polarity
 *
 * Entry:   RisingEdge = TRUE for rising edge
 *                       FALSE for falling edge
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetAudClkPolarity (BOOL RisingEdge)
{
    TXREG_SET_MCLK_POLARITY(RisingEdge? 0: 1);
    return (ATVERR_OK);
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
ATV_ERR ADIAPI_TxSetAudChStatSampFreq (TX_AUD_FS SampFreq)
{
    ATV_ERR RetVal;

    RetVal = TXHAL_SetChStatSF(SampFreq);
    if (TxUsrNVal == 0)
    {
        ADIAPI_TxSetAudNValue(TxUsrNVal);
    }
    return (RetVal);
}

/*===========================================================================
 * Set audio channel status data and source
 *
 * Entry:   FromStream = FALSE to instruct HDMI TX to use user-defined channel
 *                       status provided in the ChanStat parameter
 *                       TRUE to instruct HDMI TX to use channel status data
 *                       extracted from input audio stream.
 *          ChanStat   = Pointer to channel status data to be used when
 *                       FromStream parameter is set to TRUE
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetAudChanStatus (BOOL FromStream, TX_CHAN_STATUS *ChanStat)
{
    UCHAR FromReg = 0;

    if (!FromStream)
    {
        TXHAL_SetChanStatusBits(ChanStat);
        TXHAL_SetRJI2SSampSize();
        FromReg = 1;
    }
    if (FromReg && (ChanStat->CsSampFreq != 0xff))
    {
        TXREG_SET_AUD_SF_FROM_REG(FromReg);
    }
    TXREG_SET_CS_FROM_REG(FromReg);
    if (TxUsrNVal == 0)
    {
        ADIAPI_TxSetAudNValue(TxUsrNVal);
    }
    return (ATVERR_OK);
}

/*===========================================================================
 * Enable/Disable audio interface
 *
 * Entry:   Interface = Audio interface to enable/disable
 *                          TX_AUD_IN_I2S0
 *                          TX_AUD_IN_I2S1
 *                          TX_AUD_IN_I2S2
 *                          TX_AUD_IN_I2S3
 *                          TX_AUD_IN_I2S
 *                          TX_AUD_IN_SPDIF
 *                          TX_AUD_IN_DSD0
 *                          TX_AUD_IN_DSD1
 *                          TX_AUD_IN_DSD2
 *                          TX_AUD_IN_DSD3
 *                          TX_AUD_IN_DSD4
 *                          TX_AUD_IN_DSD5
 *                          TX_AUD_IN_DSD6
 *                          TX_AUD_IN_DSD7
 *                          TX_AUD_IN_DSD
 *                          TX_AUD_IN_DST
 *                          TX_AUD_IN_ALL
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxAudInputEnable (TX_AUD_INTERFACE Interface, BOOL Enable)
{
    UCHAR j, Byte, Mask;
    UINT16 i;

    i = ATV_LookupValue8 ((UCHAR *)AudioEnTable, (UCHAR)Interface, 0xff, 2);

    if (AudioEnTable[i] != 0xff)
    {
        j = AudioEnTable[i+1];
        switch ((j & 0xf0) >> 4)                        /* hi nibble = type */
        {
            case 0x00:                                  /* I2S */
                Byte = Mask = 0x0f;
                if (j != 0x0f)
                {
                    Byte = TXREG_GET_I2S_ENABLE();
                    Mask = 1 << (j & 0x0f);
                }
                Byte &= (~Mask);
                if (Enable)
                {
                    Byte |= Mask;
                }
                TXREG_SET_I2S_ENABLE(Byte);
                break;

            case 0x01:                                  /* SPDIF */
                TXREG_SET_SPDIF_ENABLE(Enable? 1: 0);
                break;

            case 0x02:                                  /* DSD  */
                Byte = Mask = 0xff;
                if (j != 0x2f)
                {
                    Byte = TXREG_GET_DSD_ENABLE();
                    Mask = 1 << (j & 0x0f);
                }
                Byte &= (~Mask);
                if (Enable)
                {
                    Byte |= Mask;
                }
                TXREG_SET_DSD_ENABLE(Byte);
                break;

            case 0x03:
                Mask = 0x30;
                Byte = TXREG_GET_DSD_ENABLE();
                Byte &= (~Mask);
                if (Enable)
                {
                    Byte |= Mask;
                }
                TXREG_SET_DSD_ENABLE(Byte);
                break;

            case 0x0f:                                  /* All */
                TXREG_SET_SPDIF_ENABLE(Enable? 1: 0);
                TXREG_SET_I2S_ENABLE(Enable? 0x0f: 0);
                TXREG_SET_DSD_ENABLE(Enable? 0xff: 0);
                break;
        }
        return (ATVERR_OK);
    }
    else
    {
        return (ATVERR_INV_PARM);
    }
}

/*===========================================================================
 * Set output mode to HDMI or DVI
 *
 * Entry:   OutMode = Required output mode
 *                      TX_OUT_MODE_HDMI
 *                      TX_OUT_MODE_DVI
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetOutputMode (TX_OUTPUT_MODE OutMode)
{
    switch (OutMode)
    {
        case TX_OUT_MODE_HDMI:
            TXREG_SET_EXT_HDMI_MODE(1);
            break;
        case TX_OUT_MODE_DVI:
            TXREG_SET_EXT_HDMI_MODE(0);
            TXREG_SET_OUTPUT_CS_YUV(0);
            break;
        default:
            return (ATVERR_INV_PARM);
    }
    return (ATVERR_OK);
}

/*===========================================================================
 * Enable/Disable HDCP
 *
 * Entry:   EncEnable = TRUE to enable HDCP encryption
 *          FrameEncEnable = TRUE to enable frame encryption
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxHdcpEnable (BOOL EncEnable, BOOL FrameEncEnable)
{
    ATV_ERR RetVal;

    if (!(EncEnable && FrameEncEnable))
    {
        Tx_ResetHdcpVars();
    }
    RetVal = TXHAL_HdcpEnable(EncEnable, FrameEncEnable);

    return (RetVal);
}

/*===========================================================================
 *
 *
 * Entry:   HdcpState
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxGetHdcpState (TX_HDCP_STATE *HdcpState)
{
    return (ATVERR_OK);
}

/*===========================================================================
 * Get HDMI TX HPD and MSEN state
 *
 * Entry:   Hpd = pointer to receive HPD state can be NULL if not required
 *          Msen= pointer to receive MSEN state can be NULL if not required
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxGetHpdMsenState (BOOL *Hpd, BOOL *Msen)
{
    if (Hpd)
    {
        *Hpd = (BOOL)(TXREG_GET_HPD_STATE());
    }
    if (Msen)
    {
        *Msen = (BOOL)(TXREG_GET_MSEN_STATE());
    }
    return (ATVERR_OK);
}

/*============================================================================
 * Get EDID/HDCP controller state
 *
 * Entry:   State = Pointer to receive controller satate
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxGetEdidControllerState (TX_EDID_CTRL_STATE *State)
{
    *State = (TX_EDID_CTRL_STATE)(TXREG_GET_HDCP_STATE());
    return (ATVERR_OK);
}

/*============================================================================
 * Get output mode
 *
 * Entry:   IsHdmi = Pointer to receive output mode
 *                   Will be set to TRUE if the output mode is HDMI and FASLE
 *                   if the output mode is DVI
 *                   Can be set to NULL if not required
 *
 * Return:  ATVERR_OK
 *          ATVERR_TRUE
 *          ATVERR_FALSE
 *
 * Notes:
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxOutputModeHdmi (BOOL *IsHdmi)
{
    BOOL ModeHdmi = FALSE;

    if (TXREG_GET_EXT_HDMI_MODE())
    {
        ModeHdmi = TRUE;
    }
    if (IsHdmi)
    {
        *IsHdmi = ModeHdmi;
    }
    return (ModeHdmi? ATVERR_TRUE: ATVERR_FALSE);
}

/*============================================================================
 * Check if HDCP is enabled
 *
 * Entry:   HdcpOn = Pointer to receive HDCP enable/disable state
 *                   Will be set to TRUE if HDCP is enabled
 *                   Will be set to FALSE if HDCP is disable
 *                   Can be set to NULL if not required
 *
 * Return:  ATVERR_OK
 *          ATVERR_TRUE
 *          ATVERR_FALSE
 *
 * Notes:
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxHdcpEnabled (BOOL *HdcpOn)
{
    BOOL EncOn = FALSE;

    if (TXREG_GET_HDCP_ENABLE() && TXREG_GET_HDCP_FRAME_ENABLE())
    {
        EncOn = TRUE;
    }
    if (HdcpOn)
    {
        *HdcpOn = EncOn;
    }
    return (EncOn? ATVERR_TRUE: ATVERR_FALSE);
}

/*============================================================================
 * Check if the output is encrypted
 *
 * Entry:   Encrypted = Pointer to receive encryption state
 *                      Will be set to TRUE if the output is encrypted and
 *                      FALSE if the output is not encrypted
 *                      Can be set to NULL if not required
 *
 * Return:  ATVERR_OK
 *          ATVERR_TRUE
 *          ATVERR_FALSE
 *
 * Notes:
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxOutputEncrypted (BOOL *Encrypted)
{
    BOOL IsEnc = FALSE;

    if (TXREG_GET_ENC_ON())
    {
        IsEnc = TRUE;
    }
    if (Encrypted)
    {
        *Encrypted = IsEnc;
    }
    return (IsEnc? ATVERR_TRUE: ATVERR_FALSE);
}

/*============================================================================
 * Check if the the PLL is locked
 *
 * Entry:   Locked = Pointer to receive PLL lock state
 *                   Will be set to TRUE if the PLL is locked
 *                   Will be set to FALSE if the PLL is not locked
 *                   Can be set to NULL if not required
 *
 * Return:  ATVERR_OK
 *          ATVERR_TRUE
 *          ATVERR_FALSE
 *
 * Notes:
 *
 *===========================================================================*/
ATV_ERR ADIAPI_TxPllLocked (BOOL *Locked)
{
    BOOL IsLocked = FALSE;

    if (TXREG_GET_PLL_STATE())
    {
        IsLocked = TRUE;
    }
    if (Locked)
    {
        *Locked = IsLocked;
    }
    return (IsLocked? ATVERR_TRUE: ATVERR_FALSE);
}

/*===========================================================================
 * Get HDMI TX chip status
 *
 * Entry:   TxStat  = Pointer to receive chip status
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxGetStatus (TX_STATUS *TxStat)
{
    TXHAL_GetChipStatus(TxStat);
    return (ATVERR_OK);
}

/*===========================================================================
 *
 *
 * Entry:   Mute = TRUE to disable Audio Sample Packet output
 *                 FALSE to enable Audio Sample Packet output
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxMuteAudio (BOOL Mute)
{
    TXREG_SET_AUD_SAMPLE_PKT_EN(Mute? 0: 1);
    return (ATVERR_OK);
}

/*===========================================================================
 * Mute/Unmute video output by sending black level on all TMDS channels.
 * This method requires a stable pixel clock input to the device.
 * The color space of the black level will be set according to the AV
 * info-frame color space field (Y1Y0) if AV info-frame is enabled in HDMI
 * mode, otherwise it will be set to RGB
 *
 * Entry:   Mute = TRUE to send black level on all TMDS channels
 *                 FALSE to disable black level output
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxMuteVideo (BOOL Mute)
{
    UCHAR Yuv=0;

    if (Mute)
    {
        /*===========================================
         * If HDMI mode and AV IF is enabled
         *==========================================*/
        if (TXREG_GET_EXT_HDMI_MODE() && TXREG_GET_AVIIF_PKT_EN())
        {
            Yuv = (TXREG_GET_Y1Y0()==0)? 0: 1;
        }
        TXREG_SET_OUTPUT_CS_YUV(Yuv);
    }
    TXREG_SET_BLACK_LEVEL_OUTPUT(Mute? 1: 0);
    return (ATVERR_OK);
}

/*===========================================================================
 *
 *
 * Entry:   State = One of TX_AVMUTE values
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetAvmute (TX_AVMUTE State)
{
    TXHAL_SetAvMute(State);
    return (ATVERR_OK);
}

/*===========================================================================
 * Get Set/Clear AVMUTE state
 *
 * Entry:   State = Pointer to receive AV mute state
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxGetAvmute (TX_AVMUTE *State)
{
    BOOL Set, Clr;

    Set = TXREG_GET_SET_AVMUTE();
    Clr = TXREG_GET_CLEAR_AVMUTE();
    if (Set && !Clr)
    {
        *State = TX_AVMUTE_ON;
    }
    else if (!Set && Clr)
    {
        *State = TX_AVMUTE_OFF;
    }
    else if (!Set && !Clr)
    {
        *State = TX_AVMUTE_NONE;
    }
    else
    {
        *State = TX_AVMUTE_BOTH;
    }
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
ATV_ERR ADIAPI_TxEnablePackets (UINT16 Packets, BOOL Enable)
{
    TXHAL_EnableInfoFrames (Packets, Enable);
    return (ATVERR_OK);
}

/*===========================================================================
 *
 *
 * Entry:   Pakctes
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxGetEnabledPackets (UINT16 *Packets)
{
    TXHAL_GetEnabledPackets(Packets);
    return (ATVERR_OK);
}

/*===========================================================================
 * Send AV infoframe to sink device
 *
 * Entry:   Packet = Pointer to AV infoframe header byte 0
 *          Size   = Packet size including header bytes (not to exceed 30)
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSendAVInfoFrame (UCHAR *Packet, UCHAR Size)
{
    return (TXHAL_WriteAvIfPacket(Packet, Size));
}

/*===========================================================================
 * Send audio infoframe to sink device
 *
 * Entry:   Packet = Pointer to audio infoframe header byte 0
 *          Size   = Packet size including header bytes (must be 13)
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSendAudioInfoFrame (UCHAR *Packet, UCHAR Size)
{
    ATV_ERR RetVal;

    RetVal = TXHAL_WriteAudIfPacket(Packet, Size);
    if (TxUsrNVal == 0)
    {
        ADIAPI_TxSetAudNValue(TxUsrNVal);
    }
    return (RetVal);
}

/*===========================================================================
 * Send ACP packet to sink device
 *
 * Entry:   Packet = Pointer to ACP header byte 0
 *          Size   = Packet size including header bytes (not to exceed 31)
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSendACPPacket (UCHAR *Packet, UCHAR Size)
{
    return (TXHAL_WriteAcpPacket(Packet, Size));
}

/*===========================================================================
 * Send SPD packet to sink device
 *
 * Entry:   Packet = Pointer to SPD header byte 0
 *          Size   = Packet size including header bytes (not to exceed 31)
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSendSPDPacket (UCHAR *Packet, UCHAR Size)
{
    return (TXHAL_WriteSpdPacket(Packet, Size));
}

/*===========================================================================
 * Send ISRC1 packet to sink device
 *
 * Entry:   Packet = Pointer to ISRC1 header byte 0
 *          Size   = Packet size including header bytes (not to exceed 31)
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSendISRC1Packet (UCHAR *Packet, UCHAR Size)
{
    return (TXHAL_WriteIsrc1Packet(Packet, Size));
}

/*===========================================================================
 * Send ISRC2 packet to sink device
 *
 * Entry:   Packet = Pointer to ISRC2 header byte 0
 *          Size   = Packet size including header bytes (not to exceed 31)
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSendISRC2Packet (UCHAR *Packet, UCHAR Size)
{
    return (TXHAL_WriteIsrc2Packet(Packet, Size));
}

/*===========================================================================
 * Send Gamut Metadata to sink device
 *
 * Entry:   Packet = Pointer to GMD header byte 0
 *          Size   = Packet size including header bytes (not to exceed 31)
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSendGMDPacket (UCHAR *Packet, UCHAR Size)
{
    return (TXHAL_WriteGmdPacket(Packet, Size));
}

/*===========================================================================
 * Send MPEG packet to sink device
 *
 * Entry:   Packet = Pointer to MPEG header byte 0
 *          Size   = Packet size including header bytes (not to exceed 31)
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSendMpegPacket (UCHAR *Packet, UCHAR Size)
{
    return (TXHAL_WriteMpegPacket(Packet, Size));
}

/*===========================================================================
 * Send Spare1 packet to sink device
 *
 * Entry:   Packet = Pointer to packet header byte 0
 *          Size   = Packet size including header bytes (not to exceed 31)
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSendSpare1Packet (UCHAR *Packet, UCHAR Size)
{
    return (TXHAL_WriteSpare1Packet(Packet, Size));
}

/*===========================================================================
 * Send Spare2 packet to sink device
 *
 * Entry:   Packet = Pointer to packet header byte 0
 *          Size   = Packet size including header bytes (not to exceed 31)
 *
 * Return:  ATVERR_OK
 *          ATVERR_INV_PARM
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSendSpare2Packet (UCHAR *Packet, UCHAR Size)
{
    return (TXHAL_WriteSpare2Packet(Packet, Size));
}

/*===========================================================================
 * Set ARC mode
 *
 * Entry:   ArcMode = TX_ARC_OFF:    Disable ARC
 *                  = TX_ARC_SINGLE: Enable ARC in Single Ended mode
 *                  = TX_ARC_COMMON: Enable ARC in Common mode
 *
 *
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxArcSetMode (TX_ARC_MODE ArcMode)
{
   return (TXHAL_ArcSetMode(ArcMode));
}

/*===========================================================================
 * Set input video clock delay
 *
 * Entry:   Delay format
 *          TX_VIDEO_CLK_DELAY_M_1200PS
 *          TX_VIDEO_CLK_DELAY_M_800PS
 *          TX_VIDEO_CLK_DELAY_M_400PS,
 *          TX_VIDEO_CLK_DELAY_NULL,
 *          TX_VIDEO_CLK_DELAY_P_400PS,
 *          TX_VIDEO_CLK_DELAY_P_800PS,
 *          TX_VIDEO_CLK_DELAY_P_1600PS
 *
 *
 *
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxSetVideoClkDelay (TX_VIDEO_CLK_DELAY Delay)
{
    TXREG_SET_INP_CLK_DELAY_SEL(Delay);
    return (ATVERR_OK);
}

/*===========================================================================
 * Adjust frequency range for TX based on detected VIC
 *
 * Entry:   Vic = VIC number, 1 ~ 64
 *
 * Return:  ATVERR_OK
 *
 * Notes:
 *
 *==========================================================================*/
ATV_ERR ADIAPI_TxAdjustFreqRange (UINT16 FreqMHz)
{

    return (TXHAL_AdjustFreqRange(FreqMHz));
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
ATV_ERR ADIAPI_TxDisableAutoPjCheck (BOOL Disable)
{
   return (TXHAL_DisableAutoPjCheck(Disable));

}
