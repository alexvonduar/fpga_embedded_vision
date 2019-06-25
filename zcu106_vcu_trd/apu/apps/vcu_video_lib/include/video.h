/******************************************************************************
 * (c) Copyright 2017-2019 Xilinx, Inc. All rights reserved.
 *
 * This file contains confidential and proprietary information of Xilinx, Inc.
 * and is protected under U.S. and international copyright and other
 * intellectual property laws.
 *
 * DISCLAIMER
 * This disclaimer is not a license and does not grant any rights to the
 * materials distributed herewith. Except as otherwise provided in a valid
 * license issued to you by Xilinx, and to the maximum extent permitted by
 * applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
 * FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
 * IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
 * MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
 * and (2) Xilinx shall not be liable (whether in contract or tort, including
 * negligence, or under any other theory of liability) for any loss or damage
 * of any kind or nature related to, arising under or in connection with these
 * materials, including for any direct, or any indirect, special, incidental,
 * or consequential loss or damage (including loss of data, profits, goodwill,
 * or any type of loss or damage suffered as a result of any action brought by
 * a third party) even if such damage or loss was reasonably foreseeable or
 * Xilinx had been advised of the possibility of the same.
 *
 * CRITICAL APPLICATIONS
 * Xilinx products are not designed or intended to be fail-safe, or for use in
 * any application requiring fail-safe performance, such as life-support or
 * safety devices or systems, Class III medical devices, nuclear facilities,
 * applications related to the deployment of airbags, or any other applications
 * that could lead to death, personal injury, or severe property or
 * environmental damage (individually and collectively, "Critical
 * Applications"). Customer assumes the sole risk and liability of any use of
 * Xilinx products in Critical Applications, subject only to applicable laws
 * and regulations governing limitations on product liability.
 *
 * THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
 * AT ALL TIMES.
 *******************************************************************************/
#ifndef INCLUDE_VIDEO_H_
#define INCLUDE_VIDEO_H_

#ifdef __cplusplus
extern "C"
{
#endif

#include <stdlib.h>
#include <stdarg.h>
#include <stdint.h>

typedef enum {
    TPG_1 = 1,
    TPG_2,
    HDMI_1,
    HDMI_2,
    HDMI_3,
    HDMI_4,
    HDMI_5,
    HDMI_6,
    HDMI_7,
    CSI,
    SDI,
    SCD,
} vlib_dev_type;

typedef enum {
    NV12,
    NV16,
    XV15,
    XV20,
} vlib_format_type;

typedef enum {
    DP,
    HDMI_Tx,
    SDI_Tx,
} vlib_driver_type;

struct vlib_config_data {
	int width_in;	/* input width */
	int height_in;	/* input height */
	int format;     /* input format */
	int fps;	/* refresh rate */
	unsigned int display_id;	/* display id */
	unsigned int enable_scd; /* scd enable */
};

typedef enum {
	VLIB_SUCCESS = 0,
	VLIB_ERROR_FILE_IO = -4,
	VLIB_ERROR_INVALID_PARAM = -22,
	VLIB_ERROR_INTERNAL = -23,
	VLIB_ERROR_INIT = -50,
	VLIB_ERROR_DEINIT = -51,
	VLIB_ERROR_SRC_CONFIG = -52,
	VLIB_ERROR_HDMIRX_INVALID_STATE = -53,
	VLIB_ERROR_HDMIRX_INVALID_RES = -54,
	VLIB_ERROR_HDMIRX_INVALID_FPS = -55,
	VLIB_ERROR_HDMIRX_INVALID_SEQUENCE = -56,
	VLIB_ERROR_SET_FPS = -57,
	VLIB_ERROR_MIPI_CONFIG_FAILED = -58,
	VLIB_ERROR_INVALID_STATE = -59,
	VLIB_ERROR_MIPI_NOT_CONNECTED = -60,
	VLIB_ERROR_INVALID_RESOLUTION = -61,
	VLIB_ERROR_SET_FORMAT_FAILED = -62,
	VLIB_ERROR_GET_FORMAT_FAILED = -63,
	VLIB_ERROR_HDMIRX_1_NOT_AVAILABLE = -64,
	VLIB_ERROR_HDMIRX_2_NOT_AVAILABLE = -65,
	VLIB_ERROR_HDMIRX_3_NOT_AVAILABLE = -66,
	VLIB_ERROR_TPG_1_NOT_AVAILABLE = -67,
	VLIB_ERROR_TPG_2_NOT_AVAILABLE = -68,
	VLIB_ERROR_SDI_NOT_AVAILABLE = -69,
	VLIB_ERROR_HDMIRX_4_NOT_AVAILABLE = -70,
	VLIB_ERROR_HDMIRX_5_NOT_AVAILABLE = -71,
	VLIB_ERROR_HDMIRX_6_NOT_AVAILABLE = -72,
	VLIB_ERROR_HDMIRX_7_NOT_AVAILABLE = -73,
	VLIB_ERROR_SCD_NOT_AVAILABLE = -74,
	VLIB_NO_MEDIA_SRC = -75,
	VLIB_ERROR_DRM_DEVICE_OPEN_FAIL = -81,
	VLIB_ERROR_DRM_MODE_GET_PLANE_RES_FAIL = -82,
	VLIB_ERROR_DRM_PLANE_NOT_FOUND = -83,
	VLIB_ERROR_INVALID_DRM_DEVICE = -84,
	VLIB_ERROR_OTHER = -99,
} vlib_error;

int vlib_src_init(void);
int vlib_src_uninit(void);
int vlib_src_config(vlib_dev_type dev, struct vlib_config_data *cfg);
const char * vlib_get_devname(vlib_dev_type dev);
int vlib_drm_find_preferred_mode(struct vlib_config_data *cfg);
int vlib_drm_try_mode(unsigned int display_id, int width, int height,
		      size_t *vrefresh);
int vlib_drm_find_preferred_plane(vlib_driver_type driver_type, unsigned int format,
		unsigned int *plane_id);
/* return the string representation of the error code */
const char *vlib_error_name(vlib_error error_code);

#ifdef __cplusplus
}
#endif

#endif /* INCLUDE_VIDEO_H_ */
