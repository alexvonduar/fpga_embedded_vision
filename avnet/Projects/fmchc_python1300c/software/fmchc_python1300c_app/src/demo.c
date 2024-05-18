// ----------------------------------------------------------------------------
//
//        ** **        **          **  ****      **  **********  ********** ®
//       **   **        **        **   ** **     **  **              **
//      **     **        **      **    **  **    **  **              **
//     **       **        **    **     **   **   **  *********       **
//    **         **        **  **      **    **  **  **              **
//   **           **        ****       **     ** **  **              **
//  **  .........  **        **        **      ****  **********      **
//     ...........
//                                     Reach Further™
//
// ----------------------------------------------------------------------------
//
// This design is the property of Avnet.  Publication of this
// design is not authorized without written consent from Avnet.
//
// Please direct any questions to the PicoZed community support forum:
//    http://www.zedboard.org/forum
//
// Disclaimer:
//    Avnet, Inc. makes no warranty for the use of this code or design.
//    This code is provided  "As Is". Avnet, Inc assumes no responsibility for
//    any errors, which may appear in this code, nor does it make a commitment
//    to update the information contained herein. Avnet, Inc specifically
//    disclaims any implied warranties of fitness for a particular purpose.
//                     Copyright(c) 2017 Avnet, Inc.
//                             All rights reserved.
//
// ----------------------------------------------------------------------------
//
// Create Date:         Nov 18, 2011
// Design Name:         Demo
// Module Name:         demo.c
// Project Name:        Demo
//
// Tool versions:       Vivado 2016.4
//
// Description:         PYTHON1300-C Getting Started Demo application
//
// Dependencies:
//
// Revision:            Jun 01, 2017: 1.03 Add CFA command to set bayer
//
//----------------------------------------------------------------

#include "xil_cache.h"

#include "demo.h"


#include "tpg_settings.h"

#include "cat9554.h"

#include "wrapper.h"

#include "adv7511_control.h"

int demo_init( demo_t *pdemo )
{
    int status;
    u32 ret;

    pdemo->paxi_vdma_cam = &(pdemo->axi_vdma_cam);
#if defined(XPAR_AXI_VDMA_HDMII_DEVICE_ID)
    pdemo->paxi_vdma_hdmii = &(pdemo->axi_vdma_hdmii);
#endif
    pdemo->ptpg = &(pdemo->tpg);
    pdemo->pmixer = &(pdemo->mixer);
    pdemo->pcfa = &(pdemo->cfa);
    //pdemo->pvtc = &(pdemo->vtc);
    pdemo->pcsc = &(pdemo->csc);
    pdemo->pfmc_hdmi_cam_iic = &(pdemo->fmc_hdmi_cam_iic);
    pdemo->pfmc_hdmi_cam = &(pdemo->fmc_hdmi_cam);
    pdemo->ppython_receiver = &(pdemo->python_receiver);

    // general command settings
    pdemo->bVerbose = 1;

    // fmc-hami-cam commands
    pdemo->adv7611_llc_polarity = 1;
    pdemo->adv7611_llc_delay = 0;

    // cam command settings
    pdemo->cam_aec = 0; // off
    pdemo->cam_again = 0; // 1.0
    pdemo->cam_dgain = 128; // 1.0
    pdemo->cam_exposure = 90; // 90% of frame period

    // start command settings
    pdemo->cam_alpha = 0xFF;
    pdemo->cam_enable = 1;
    pdemo->hdmi_alpha = 0x00;
    pdemo->hdmi_enable = 0;

    // video ip command settings
    pdemo->cam_bayer = 0;//XCFA_RGRG_COMBINATION;

    XAxiVdma_Config *paxivdma_config;
    XV_demosaic_Config *pcfa_config;

    ret = XVidC_SetVideoStream(&pdemo->mixer_stream_in, XVIDC_VM_1080_60_P, XVIDC_CSF_YCRCB_422, XVIDC_BPC_8, XVIDC_PPC_1);
    if (ret != XST_SUCCESS) {
        xil_printf("Set Mixer Video stream In failed\n\r");
    }

    //ret = XVidC_SetVideoStream(&pdemo->mixer_stream1_in, XVIDC_VM_1080_60_P, XVIDC_CSF_YCRCB_422, XVIDC_BPC_8, XVIDC_PPC_1);
    //if (ret != XST_SUCCESS) {
    //	xil_printf("Set Mixer Video 1 stream In failed\n\r");
    //}

    ret = XVidC_SetVideoStream(&pdemo->mixer_stream2_in, XVIDC_VM_1280x1024_60_P, XVIDC_CSF_YCRCB_422, XVIDC_BPC_8, XVIDC_PPC_1);
    if (ret != XST_SUCCESS) {
        xil_printf("Set Mixer Video 2 stream In failed\n\r");
    }

    ret = XVidC_SetVideoStream(&pdemo->csc_stream_in, XVIDC_VM_1280x1024_60_P, XVIDC_CSF_RGB, XVIDC_BPC_8, XVIDC_PPC_1);
    if (ret != XST_SUCCESS) {
        xil_printf("Set Chroma Resample Video stream In failed\n\r");
    }

    xil_printf( "FMC-HDMI-CAM Initialization ...\n\r" );

    //Initialize the Video Test Pattern Generator
    XV_tpg_Config *ptpg_config = XV_tpg_LookupConfig(XPAR_V_TPG_0_DEVICE_ID);
    XV_tpg_CfgInitialize(pdemo->ptpg, ptpg_config, ptpg_config->BaseAddress);

    //Initialize the Video mixer
    XVMix_Initialize(pdemo->pmixer, XPAR_V_MIX_0_DEVICE_ID);

    //Initialize the color space converter
    XVprocSs_Config* pcsc_config = XVprocSs_LookupConfig(XPAR_V_CSC_0_DEVICE_ID);
    /* Start capturing event log. */
    XVprocSs_LogReset(pdemo->pcsc);
    XVprocSs_CfgInitialize(pdemo->pcsc, pcsc_config, pcsc_config->BaseAddress);
    XVprocSs_ReportSubsystemCoreInfo(pdemo->pcsc);

    // Initialize the VTC
    //XVtc_Config *VTC_Config = XVtc_LookupConfig(XPAR_V_TC_0_DEVICE_ID);
    //XVtc_CfgInitialize(pdemo->pvtc, VTC_Config, VTC_Config->BaseAddress);
    //XVtc_ConvVideoMode2Timing(pdemo->pvtc, XVTC_VMODE_1080P, &(pdemo->vtctiming));
    pdemo->pvtiming = XVidC_GetTimingInfo(XVIDC_VM_1080_60_P);

    paxivdma_config = XAxiVdma_LookupConfig(XPAR_AXIVDMA_0_DEVICE_ID);
    XAxiVdma_CfgInitialize(pdemo->paxi_vdma_cam, paxivdma_config,
            paxivdma_config->BaseAddress);

#if defined(XPAR_AXI_VDMA_HDMII_DEVICE_ID)
    paxivdma_config = XAxiVdma_LookupConfig(XPAR_AXIVDMA_1_DEVICE_ID);
    XAxiVdma_CfgInitialize(pdemo->paxi_vdma_hdmii, paxivdma_config,
            paxivdma_config->BaseAddress);
#endif

    pcfa_config = XV_demosaic_LookupConfig(XPAR_V_CFA_0_DEVICE_ID);
    XV_demosaic_CfgInitialize(pdemo->pcfa, pcfa_config, pcfa_config->BaseAddress);
    xil_printf("demosaic initialization done\n\r");

    status = fmc_iic_xps_init(pdemo->pfmc_hdmi_cam_iic,"FMC-HDMI-CAM I2C Controller", XPAR_FMC_HDMI_CAM_IIC_0_BASEADDR );
    if ( !status )
    {
        xil_printf( "ERROR : Failed to open FMC-IIC driver\n\r" );
        exit(0);
    }

    fmc_hdmi_cam_init(pdemo->pfmc_hdmi_cam, "FMC-HDMI-CAM", pdemo->pfmc_hdmi_cam_iic);
    pdemo->pfmc_hdmi_cam->bVerbose = pdemo->bVerbose;

    // Configure Video Clock Synthesizer
    xil_printf( "Video Clock Synthesizer Configuration ...\n\r" );
    fmc_hdmi_cam_vclk_init( pdemo->pfmc_hdmi_cam );
    fmc_hdmi_cam_vclk_config( pdemo->pfmc_hdmi_cam, FMC_HDMI_CAM_VCLK_FREQ_148_500_000);
    sleep(1);

    // Set HDMI output to 1080P60
    pdemo->hdmio_width  = 1920;
    pdemo->hdmio_height = 1080;

    //pDemo->hdmio_timing.IsHDMI        = 1; // HDMI Mode
    pdemo->hdmio_timing.IsHDMI        = 0; // DVI Mode
    pdemo->hdmio_timing.IsEncrypted   = 0;
    pdemo->hdmio_timing.IsInterlaced  = 0;
    pdemo->hdmio_timing.ColorDepth    = 8;

    pdemo->hdmio_timing.HActiveVideo  = pdemo->pvtiming->HActive;//1920;
    xil_printf("HActiveVideo: %d\r\n", pdemo->pvtiming->HActive);
    pdemo->hdmio_timing.HFrontPorch   =   pdemo->pvtiming->HFrontPorch;//88;
    xil_printf("HFrontPorch: %d\r\n", pdemo->pvtiming->HFrontPorch);
    pdemo->hdmio_timing.HSyncWidth    =   pdemo->pvtiming->HSyncWidth;//44;
    xil_printf("HSyncWidth: %d\r\n", pdemo->pvtiming->HSyncWidth);
    pdemo->hdmio_timing.HSyncPolarity =    pdemo->pvtiming->HSyncPolarity;//1;
    xil_printf("HSyncPolarity: %d\r\n", pdemo->pvtiming->HSyncPolarity);
    pdemo->hdmio_timing.HBackPorch    =  pdemo->pvtiming->HBackPorch;//148;
    xil_printf("HBackPorch: %d\r\n", pdemo->pvtiming->HBackPorch);
    pdemo->hdmio_timing.VBackPorch    =   pdemo->pvtiming->F0PVBackPorch;//36;
    xil_printf("F0PVBackPorch: %d\r\n", pdemo->pvtiming->F0PVBackPorch);
    xil_printf("F1VBackPorch: %d\r\n", pdemo->pvtiming->F1VBackPorch);
    pdemo->hdmio_timing.VActiveVideo  = pdemo->pvtiming->VActive;//1080;
    xil_printf("VActiveVideo: %d\r\n", pdemo->pvtiming->VActive);
    pdemo->hdmio_timing.VFrontPorch   =    pdemo->pvtiming->F0PVFrontPorch;//4;
    xil_printf("F0PVFrontPorch: %d\r\n", pdemo->pvtiming->F0PVFrontPorch);
    xil_printf("F1VFrontPorch: %d\r\n", pdemo->pvtiming->F1VFrontPorch);
    pdemo->hdmio_timing.VSyncWidth    =    pdemo->pvtiming->F0PVSyncWidth;//5;
    xil_printf("F0PVSyncWidth: %d\r\n", pdemo->pvtiming->F0PVSyncWidth);
    xil_printf("F1VSyncWidth: %d\r\n", pdemo->pvtiming->F1VSyncWidth);
    pdemo->hdmio_timing.VSyncPolarity =    pdemo->pvtiming->VSyncPolarity;//1;
    xil_printf("VSyncPolarity: %d\r\n", pdemo->pvtiming->VSyncPolarity);

    xil_printf( "HDMI Output Initialization ...\n\r" );
    status = fmc_hdmi_cam_hdmio_init( pdemo->pfmc_hdmi_cam,
                                   1,                      // hdmioEnable = 1
                                   &(pdemo->hdmio_timing), // pTiming
                                   0                       // waitHPD = 0
                                );
    if ( !status )
    {
        xil_printf( "ERROR : Failed to init HDMI Output Interface\n\r" );
        return 0;
    }

    //fmc_hdmi_cam_iic_mux(pdemo->pfmc_hdmi_cam, FMC_HDMI_CAM_I2C_SELECT_HDMI_OUT);
    //HAL_SetI2CHandler(pdemo->pfmc_hdmi_cam_iic);
    //adv7511_hal_init(pdemo);
    //adv7511_hal_chip_rev();
    adv7511_hal_init(pdemo);

    // Default HDMI input resolution
    pdemo->hdmii_width = pdemo->hdmio_width;
    pdemo->hdmii_height = pdemo->hdmio_height;

    //demo_hdmi_out_status(pdemo);

    return 1;
}

int demo_start_hdmi_in( demo_t *pdemo )
{
    int status;
    u32 timeout = 100;

    xil_printf("HDMI Input Initialization\r\n");
    status = fmc_hdmi_cam_hdmii_init2( pdemo->pfmc_hdmi_cam,
                                1, // hdmiiEnable = 1
                                1, // editInit = 1
                                fmc_hdmi_cam_hdmii_edid_content,
                                pdemo->adv7611_llc_polarity, //0, //llc_polarity,
                                pdemo->adv7611_llc_delay //0  //llc_delay
                                );
    if ( !status )
    {
        xil_printf( "ERROR : Failed to init HDMI Input Interface\n\r" );
        exit(0);
    }

    xil_printf( "Waiting for ADV7611 to locked on incoming video ...\n\r" );
    pdemo->hdmii_locked = 0;
    timeout = 100;
    while ( !(pdemo->hdmii_locked) && timeout-- )
    {
        usleep(100000); // wait 100msec ...
        pdemo->hdmii_locked = fmc_hdmi_cam_hdmii_get_lock( pdemo->pfmc_hdmi_cam );
    }
    if ( !(pdemo->hdmii_locked) )
    {
        xil_printf( "\tERROR : ADV7611 has NOT locked on incoming video, aborting !\n\r" );
    }
    else
    {
        xil_printf( "\tADV7611 Video Input LOCKED\n\r" );
        usleep(100000); // wait 100msec for timing to stabilize

        // Get Video Input information
        fmc_hdmi_cam_hdmii_get_timing( pdemo->pfmc_hdmi_cam, &(pdemo->hdmii_timing) );
        pdemo->hdmii_width  = pdemo->hdmii_timing.HActiveVideo;
        pdemo->hdmii_height = pdemo->hdmii_timing.VActiveVideo;
        xil_printf( "\tInput resolution = %d X %d\n\r", pdemo->hdmii_width, pdemo->hdmii_height );
    }

    pdemo->hdmi_enable = 1;
    pdemo->hdmi_alpha = 0xff;
    pdemo->cam_enable = 0;
    pdemo->cam_alpha = 0;
    demo_set_video_mixer(pdemo);

    return 0;
}

int demo_start_cam_in( demo_t *pdemo )
{
    //int status;

    // PYTHON Receiver Initialization
    xil_printf( "PYTHON Receiver Initialization ...\n\r" );
    onsemi_python_init(pdemo->ppython_receiver, "PYTHON-1300-C",
            XPAR_ONSEMI_PYTHON_SPI_0_S00_AXI_BASEADDR,
            XPAR_ONSEMI_PYTHON_CAM_0_S00_AXI_BASEADDR);
    pdemo->ppython_receiver->uManualTap = 25; // IDELAY setting (0-31)
    //xil_printf( "PYTHON SPI Config for 10MHz ...\n\r" );
    // axi4lite_0_clk = 75MHz
    onsemi_python_spi_config( pdemo->ppython_receiver, (75000000/10000000) );

    // PYTHON Sensor Initialization
    xil_printf( "PYTHON Sensor Initialization ...\n\r" );

    // Camera Power Sequence
    fmc_hdmi_cam_iic_mux( pdemo->pfmc_hdmi_cam, FMC_HDMI_CAM_I2C_SELECT_CAM );
    cat9554_initialize(pdemo->pfmc_hdmi_cam_iic);
    usleep(10);

    // Make sure all disable first
    cat9554_vddpix_off(pdemo->pfmc_hdmi_cam_iic);
    usleep(10);
    cat9554_vdd33_off(pdemo->pfmc_hdmi_cam_iic);
    usleep(10);
    cat9554_vdd18_off(pdemo->pfmc_hdmi_cam_iic);
    usleep(1000);

    // Turn them on one by one
    cat9554_vdd18_en(pdemo->pfmc_hdmi_cam_iic);
    usleep(10);
    cat9554_vdd33_en(pdemo->pfmc_hdmi_cam_iic);
    usleep(10);
    cat9554_vddpix_en(pdemo->pfmc_hdmi_cam_iic);
    usleep(10);

    onsemi_python_sensor_initialize(
            pdemo->ppython_receiver, SENSOR_INIT_ENABLE, pdemo->bVerbose);
    onsemi_python_sensor_initialize(
            pdemo->ppython_receiver, SENSOR_INIT_STREAMON, pdemo->bVerbose);
    onsemi_python_sensor_cds(pdemo->ppython_receiver, pdemo->bVerbose);
    onsemi_python_cam_reg_write(pdemo->ppython_receiver,
            ONSEMI_PYTHON_CAM_SYNCGEN_HTIMING1_REG, 0x00300500);

    xil_printf("CFA Initialization\r\n");
    //XCfa_Reset(pdemo->pcfa);
    //XCfa_RegUpdateEnable(pdemo->pcfa);
    //XCfa_Enable(pdemo->pcfa);

    //XCfa_SetBayerPhase(pdemo->pcfa, pdemo->cam_bayer);
    //XCfa_SetActiveSize(pdemo->pcfa, 1280, 1024);

    XV_demosaic_Set_HwReg_width(pdemo->pcfa, 1280);
    XV_demosaic_Set_HwReg_height(pdemo->pcfa, 1024);
    XV_demosaic_Set_HwReg_bayer_phase(pdemo->pcfa, pdemo->cam_bayer);
    XV_demosaic_WriteReg(XPAR_XV_DEMOSAIC_0_S_AXI_CTRL_BASEADDR, XV_DEMOSAIC_CTRL_ADDR_AP_CTRL, 0x81);


    pdemo->hdmi_enable = 0;
    pdemo->hdmi_alpha = 0;
    pdemo->cam_enable = 1;
    pdemo->cam_alpha = 0xff;
    demo_set_video_mixer(pdemo);

    return 1;
}

int demo_init_frame_buffer( demo_t *pdemo )
{
    // Clear frame stores
    if ( pdemo->bVerbose )
    {
        xil_printf( "Video Frame Buffer Initialization ...\n\r" );
    }
    u32 frame, row, col;
    u16 pixel;
    volatile u16 *pStorageMem;

    // Fill HDMI frame buffer with Gray ramps
    pStorageMem = (u16 *)0x10000000;
    //volatile u16 *pStorageMem2 = (u16 *)0x18000000;
    for ( frame = 0; frame < 3; frame++ )
    {
        //for ( row = 0; row < pdemo->hdmio_height; row++ )
        for ( row = 0; row < 2048; row++ )
        {
            //for ( col = 0; col < pdemo->hdmio_width; col++ )
            for ( col = 0; col < 2048; col++ )
            {
                pixel = 0x8000 | (col & 0x00FF); // Grey ramp
                *pStorageMem++ = pixel;
            }
        }
    }

    // Fill Camera frame buffer with green screen
    pStorageMem = (u16 *)0x18000000;
    for ( frame = 0; frame < 3; frame++ )
    {
        //for ( row = 0; row < pdemo->hdmio_height; row++ )
        for ( row = 0; row < 2048; row++ )
        {
            //for ( col = 0; col < pdemo->hdmio_width; col++ )
            for ( col = 0; col < 2048; col++ )
            {
                pixel = 0x0000; // Green
                *pStorageMem++ = pixel;
            }
        }
    }

    // Wait for DMA to synchronize
    Xil_DCacheFlush();

    return 1;
}

int demo_stop_frame_buffer( demo_t *pdemo )
{
    StopTransfer(pdemo->paxi_vdma_cam);
#if defined(XPAR_AXI_VDMA_HDMII_DEVICE_ID)
    StopTransfer(pdemo->paxi_vdma_hdmii);
#endif

    return 1;
}

int demo_start_frame_buffer( demo_t *pdemo )
{
    u32 ret;

    /* VTC Configuration */
    //XVtc_Timing XVtc_Timingconf;
    //XVtc_ConvVideoMode2Timing(pdemo->pvtc, XVTC_VMODE_1080P,&XVtc_Timingconf);
    //XVtc_SetGeneratorTiming(pdemo->pvtc, &(pdemo->vtctiming));
    //XVtc_RegUpdate(pdemo->pvtc);

    /* End of VTC Configuration */

    //Start the VTC generator
    //XVtc_EnableGenerator(pdemo->pvtc);

    //xil_printf("VTC started\r\n");


#if defined(XPAR_AXI_VDMA_HDMII_DEVICE_ID)
    xil_printf("HDMI in VDMA Initialization\r\n");
    XAxiVdma_Reset(pdemo->paxi_vdma_hdmii, XAXIVDMA_WRITE);
    XAxiVdma_Reset(pdemo->paxi_vdma_hdmii, XAXIVDMA_READ);
    WriteSetup(pdemo->paxi_vdma_hdmii, 0x18000000, 0, 1, 1, 0, 0, pdemo->hdmii_width, pdemo->hdmii_height, 2048, 2048);
    ReadSetup(pdemo->paxi_vdma_hdmii, 0x18000000, 0, 1, 1, 0, 0, pdemo->hdmio_width, pdemo->hdmio_height, 2048, 2048);
    StartTransfer(pdemo->paxi_vdma_hdmii);
#endif

    xil_printf("CAM in VDMA Initialization\r\n");
    XAxiVdma_Reset(pdemo->paxi_vdma_cam, XAXIVDMA_WRITE);
    XAxiVdma_Reset(pdemo->paxi_vdma_cam, XAXIVDMA_READ);
    WriteSetup(pdemo->paxi_vdma_cam, 0x10000000, 0, 1, 1, 0, 0, 1280, 1024, 2048, 2048);
    ReadSetup(pdemo->paxi_vdma_cam, 0x10000000, 0, 1, 1, 0, 0, 1280, 1024, 2048, 2048);
    StartTransfer(pdemo->paxi_vdma_cam);

    demo_set_video_mixer(pdemo);

    //Configure the Chroma Resample
    //XVprocSs_Stop(pdemo->pcresample);
    //XVprocSs_Reset(pdemo->pcresample);
    //XVprocSs_SetVidStreamIn(pdemo->pcresample, &(pdemo->cresample_stream_in));
    //XVprocSs_SetVidStreamOut(pdemo->pcresample, &(pdemo->mixer_stream1_in));
    //ret = XVprocSs_SetSubsystemConfig(pdemo->pcresample);
    //if (ret != XST_SUCCESS) {
    //	xil_printf("chroma resample failed\n\r");
    //	XVprocSs_ReportSubsystemConfig(pdemo->pcresample);
    //	XVprocSs_ReportSubsystemCoreInfo(pdemo->pcresample);
    //	XVprocSs_ReportSubcoreStatus(pdemo->pcresample, XVPROCSS_SUBCORE_CR_H);
    //	XVprocSs_LogDisplay(pdemo->pcresample);
    //}
    //XVprocSs_Start(pdemo->pcresample);
    //xil_printf("Chroma Resample started\n\r");

    //Configure the Color space convert
    XVprocSs_Stop(pdemo->pcsc);
    XVprocSs_Reset(pdemo->pcsc);
    XVprocSs_SetVidStreamIn(pdemo->pcsc, &(pdemo->csc_stream_in));
    XVprocSs_SetVidStreamOut(pdemo->pcsc, &(pdemo->mixer_stream2_in));
    XVprocSs_SetSubsystemConfig(pdemo->pcsc);
    ret = XVprocSs_SetSubsystemConfig(pdemo->pcsc);
    if (ret != XST_SUCCESS) {
        xil_printf("color space converter failed\n\r");
        XVprocSs_ReportSubsystemConfig(pdemo->pcsc);
        XVprocSs_ReportSubsystemCoreInfo(pdemo->pcsc);
        XVprocSs_ReportSubcoreStatus(pdemo->pcsc, XVPROCSS_SUBCORE_CSC);
        XVprocSs_LogDisplay(pdemo->pcsc);
    }
    XVprocSs_Start(pdemo->pcsc);
    xil_printf("Color Spece Converter started\n\r");

    xil_printf("Video Test Pattern Initialization\r\n");
    //Configure the TPG
    tpg_set(pdemo->ptpg, 1080, 1920, XVIDC_CSF_YCRCB_422, XTPG_BKGND_COLOR_BARS);

    //Configure the moving box of the TPG
    tpg_set_box(pdemo->ptpg, 100, 3);

    //Start the TPG
    XV_tpg_EnableAutoRestart(pdemo->ptpg);
    XV_tpg_Start(pdemo->ptpg);
    xil_printf("TPG started!\r\n");

    return 1;
}

int demo_set_video_mixer(demo_t * pdemo)
{
    xil_printf("Video Mixer Initialization (hdmi = %d(0x%02X), cam = %d(0x%02X))\r\n", pdemo->hdmi_enable, pdemo->hdmi_alpha, pdemo->cam_enable, pdemo->cam_alpha);
    XVMix_Stop(pdemo->pmixer);
    //XVMix_LayerDisable(pdemo->pmixer, XVMIX_LAYER_MASTER);

    int NumLayers, Status;

    /* Setup default config after reset */
    XVMix_LayerDisable(pdemo->pmixer, XVMIX_LAYER_ALL);
    XVMix_SetVidStream(pdemo->pmixer, &pdemo->mixer_stream_in);

    NumLayers = XVMix_GetNumLayers(pdemo->pmixer);
    xil_printf("mixer %d layers\n\r", NumLayers);
    XVidC_ColorFormat cfmt;
    XVMix_GetLayerColorFormat(pdemo->pmixer, XVMIX_LAYER_1, &cfmt);
    int isStream = XVMix_IsLayerInterfaceStream(pdemo->pmixer, XVMIX_LAYER_1);
    xil_printf("mixer layer 1 : is tream %d color format %d\n\r", isStream, cfmt);
    XVMix_SetLayerAlpha(pdemo->pmixer, XVMIX_LAYER_1, pdemo->hdmi_alpha);

    XVidC_VideoWindow Win = {0,  0,  pdemo->hdmio_width, pdemo->hdmio_height};
    u32 Stride = ((cfmt == XVIDC_CSF_YCRCB_422) ? 2: 4); //BytesPerPixel
    Stride *= Win.Width;

    xil_printf("Set HDMI IN Layer Window (%3d, %3d, %3d, %3d): ",
            Win.StartX, Win.StartY, Win.Width, Win.Height);
    Status = XVMix_SetLayerWindow(pdemo->pmixer, XVMIX_LAYER_1, &Win, Stride);
    if(Status != XST_SUCCESS) {
        xil_printf("<ERROR:: Command Failed>\r\n");
        //++ErrorCount;
    } else {
        xil_printf("Done\r\n");
    }


    XVMix_GetLayerColorFormat(pdemo->pmixer, XVMIX_LAYER_2, &cfmt);
    isStream = XVMix_IsLayerInterfaceStream(pdemo->pmixer, XVMIX_LAYER_2);
    xil_printf("mixer layer 2 : is tream %d color format %d\n\r", isStream, cfmt);
    XVMix_SetLayerAlpha(pdemo->pmixer, XVMIX_LAYER_2, pdemo->cam_alpha);

    //Win = {0,  0,  1280/*pdemo->hdmio_width*/, 1024/*pdemo->hdmio_height*/};
    Win.StartX = 0;
    Win.StartY = 0;
    Win.Height = 1024;
    Win.Width = 1280;
    Stride = ((cfmt == XVIDC_CSF_YCRCB_422) ? 2: 4); //BytesPerPixel
    Stride *= Win.Width;

    xil_printf("   Set CAM IN Layer Window (%3d, %3d, %3d, %3d): ",
            Win.StartX, Win.StartY, Win.Width, Win.Height);
    Status = XVMix_SetLayerWindow(pdemo->pmixer, XVMIX_LAYER_2, &Win, Stride);
    if(Status != XST_SUCCESS) {
        xil_printf("<ERROR:: Command Failed>\r\n");
        //++ErrorCount;
    } else {
        xil_printf("Done\r\n");
    }


    if(!XVMix_IsLogoEnabled(pdemo->pmixer)) {
        xil_printf("INFO: Logo Layer Disabled in HW \r\n");
    }
    //XVMix_SetBackgndColor(pdemo->pmixer, XVMIX_BKGND_BLUE, stream.ColorDepth);

    if (pdemo->hdmi_enable) {
        xil_printf("enable hdmi layer\n\r");
        Status = XVMix_LayerEnable(pdemo->pmixer, XVMIX_LAYER_1);
        if(Status != XST_SUCCESS) {
            xil_printf("<ERROR:: Command Failed>\r\n");
        } else {
            xil_printf("Done\r\n");
        }
    }
    if (pdemo->cam_enable) {
        xil_printf("enable cam layer\n\r");
        Status = XVMix_LayerEnable(pdemo->pmixer, XVMIX_LAYER_2);
        if(Status != XST_SUCCESS) {
            xil_printf("<ERROR:: Command Failed>\r\n");
        } else {
            xil_printf("Done\r\n");
        }
    }
    XVMix_LayerEnable(pdemo->pmixer, XVMIX_LAYER_MASTER);
    XVMix_InterruptDisable(pdemo->pmixer);
    XVMix_Start(pdemo->pmixer);
    XVMix_DbgReportStatus(pdemo->pmixer);
    xil_printf("INFO: Mixer configured\r\n");
    return 1;
}
