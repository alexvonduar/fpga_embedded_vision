/*
FILENAME: mix.c
AUTHOR: Greg Taylor     CREATION DATE: 12 Aug 2019

DESCRIPTION:

CHANGE HISTORY:
12 Aug 2019		Greg Taylor
	Initial version

MIT License

Copyright (c) 2019 Greg Taylor <gtaylor@sonic.net>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */
#include "xv_mix_l2.h"
#include "xvidc.h"
#include "parameters.h"

int mix_init() {
	XVidC_VideoStream video_stream;
	XV_Mix_l2 mix;

    if (XVMix_Initialize(&mix, XPAR_XV_MIX_0_DEVICE_ID) != XST_SUCCESS) {
    	xil_printf("XVMix_Initialize() failed\r\n");
    	return XST_FAILURE;
    }

    XVidC_SetVideoStream(&video_stream, XVIDC_VM_1080_30_P, XVIDC_CSF_RGB, XVIDC_BPC_10, XVIDC_PPC_1);

    XVMix_Stop(&mix);
    //XVMix_LayerDisable(&mix, XVMIX_LAYER_MASTER);
    XVMix_LayerDisable(&mix, XVMIX_LAYER_ALL);

    int NumLayers, Status;

    /* Setup default config after reset */

    XVMix_SetVidStream(&mix, &video_stream);

    NumLayers = XVMix_GetNumLayers(&mix);
    xil_printf("mixer %d layers\n\r", NumLayers);
    XVidC_ColorFormat cfmt;
    XVMix_GetLayerColorFormat(&mix, XVMIX_LAYER_1, &cfmt);
    int isStream = XVMix_IsLayerInterfaceStream(&mix, XVMIX_LAYER_1);
    xil_printf("mixer layer 1 : is tream %d color format %s\n\r", isStream, XVidC_GetColorFormatStr(cfmt));
    //XVMix_SetLayerAlpha(&mix, XVMIX_LAYER_1, pdemo->hdmi_alpha);

    XVidC_VideoWindow Win = {0,  0,  1920, 1080};
    u32 Stride = 4; //BytesPerPixel
    Stride *= Win.Width;

    xil_printf("Set camera Layer Window (%3d, %3d, %3d, %3d): ",
            Win.StartX, Win.StartY, Win.Width, Win.Height);
    Status = XVMix_SetLayerWindow(&mix, XVMIX_LAYER_1, &Win, Stride);
    if(Status != XST_SUCCESS) {
        xil_printf("<ERROR:: Command Failed>\r\n");
        //++ErrorCount;
    } else {
        xil_printf("Done\r\n");
    }

    if(!XVMix_IsLogoEnabled(&mix)) {
        xil_printf("INFO: Logo Layer Disabled in HW \r\n");
    }
    //XVMix_SetBackgndColor(&mix, XVMIX_BKGND_BLUE, stream.ColorDepth);

    xil_printf("enable camera layer\n\r");
    Status = XVMix_LayerEnable(&mix, XVMIX_LAYER_1);
    if(Status != XST_SUCCESS) {
        xil_printf("<ERROR:: Command Failed>\r\n");
    } else {
        xil_printf("Done\r\n");
    }

    XVMix_LayerEnable(&mix, XVMIX_LAYER_MASTER);
    XVMix_InterruptDisable(&mix);
    XVMix_Start(&mix);
    XVMix_DbgReportStatus(&mix);
    xil_printf("Video mixer configured\r\n");

	return XST_SUCCESS;
}

