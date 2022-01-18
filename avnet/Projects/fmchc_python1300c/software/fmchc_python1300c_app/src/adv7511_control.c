#include "xil_printf.h"

#include "tx_lib.h"

#include "demo.h"
#include "adv7511_control.h"

TX_STATUS adv7511_status;

void adv7511_hal_init(demo_t * pdemo)
{
    HAL_SetI2CHandler(pdemo->pfmc_hdmi_cam_iic);
}

void adv7511_hal_print_status()
{
    xil_printf("==== ADV7511 status\n\r");
    xil_printf("chip power down: %d\n\r", adv7511_status.ChipPd);
    xil_printf("TMDS power down: %d\n\r", adv7511_status.TmdsPd);
    xil_printf("HPD: %d\n\r", adv7511_status.Hpd);
    xil_printf("Monitor Sense: %d\n\r", adv7511_status.MonSen);
    xil_printf("HDMI mode: %d\n\r", adv7511_status.OutputHdmi);
    xil_printf("PLL locked: %d\n\r", adv7511_status.PllLocked);
    xil_printf("Video Muted: %d\n\r", adv7511_status.VideoMuted);
    xil_printf("Clear AV Mute: %d\n\r", adv7511_status.ClearAVMute);
    xil_printf("Set AV Mute: %d\n\r", adv7511_status.SetAVMute);
    xil_printf("Audio Repeat: %d\n\r", adv7511_status.AudioRep);
    xil_printf("Spdif Enable: %d\n\r", adv7511_status.SpdifEnable);
    xil_printf("I2S Enable: 0x%0xd\n\r", adv7511_status.I2SEnable);
    xil_printf("Detected VIC: %d\n\r", adv7511_status.DetectedVic);
    xil_printf("Last HDCP Errors: %d\n\r", adv7511_status.LastHdcpErr);
}

int adv7511_hal_is_power_down()
{
    return adv7511_status.ChipPd != 0;
}

int adv7511_hal_get_status( demo_t * pdemo )
{
    fmc_hdmi_cam_iic_mux(pdemo->pfmc_hdmi_cam, FMC_HDMI_CAM_I2C_SELECT_HDMI_OUT);
    //HAL_SetI2CHandler(pdemo->pfmc_hdmi_cam_iic);
    //TX_STATUS status;
    ATV_ERR ret =  ADIAPI_TxGetStatus (&adv7511_status);
    if (ret == ATVERR_OK) {
        return XST_SUCCESS;
    } else {
        xil_printf("Get ADV7511 status error: %d\n\r", ret);
        return XST_FAILURE;
    }
}

int adv7511_start(demo_t * pdemo)
{
    int stat;
    //int status = XST_SUCCESS;
    ///fmc_hdmi_cam_iic_mux(pdemo->pfmc_hdmi_cam, FMC_HDMI_CAM_I2C_SELECT_HDMI_OUT);
    if (adv7511_hal_get_status(pdemo) != XST_SUCCESS) {
        //xil_printf("Get ADV7511 status error\n\r");
        ///status = XST_FAILURE;
        return XST_FAILURE;
    }
    if (adv7511_hal_is_power_down()) {
        xil_printf("ADV7511 is in power down state\n\r");
        adv7511_hal_print_status();
        xil_printf( "HDMI Output Initialization ...\n\r" );
        stat = fmc_hdmi_cam_hdmio_init( pdemo->pfmc_hdmi_cam,
                                        1,                      // hdmioEnable = 1
                                        &(pdemo->hdmio_timing), // pTiming
                                        0                       // waitHPD = 0
                                        );
        if ( !stat )
        {
            xil_printf( "ERROR : Failed to init HDMI Output Interface\n\r" );
            return XST_FAILURE;
        }
    } else {
        xil_printf("ADV7511 is in power up state\n\r");
        //return XST_SUCCESS;
    }
    return XST_SUCCESS;
}

void adv7511_hal_print_chip_rev(demo_t * pdemo)
{
	fmc_hdmi_cam_iic_mux(pdemo->pfmc_hdmi_cam, FMC_HDMI_CAM_I2C_SELECT_HDMI_OUT);
    UINT16 TxRev;
    ADIAPI_TxGetChipRevision(&TxRev);
    xil_printf("ADV7511 Chip Revision: %0xd\n\r", TxRev);
}
