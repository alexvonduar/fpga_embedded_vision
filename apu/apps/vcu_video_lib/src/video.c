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
#include <glob.h>
#include <stdio.h>
#include "video_int.h"


/** This function returns a constant NULL-terminated string with the ASCII name of a vlib
 *  error. The caller must not free() the returned string.
 *
 *  \param error_code The \ref vlib_error to return the name of.
 *  \returns The error name, or the string **UNKNOWN** if the value of
 *  error_code is not a known error.
 */
const char *vlib_error_name(vlib_error error_code)
{
	switch (error_code) {
	case VLIB_ERROR_INTERNAL:
		return "VLIB Internal Error";
	case VLIB_ERROR_INVALID_PARAM:
		return "VLIB Invalid Parameter Error";
	case VLIB_ERROR_INIT:
		return "VLIB Source Init Error";
	case VLIB_ERROR_INVALID_DRM_DEVICE:
		return "VLIB Invalid DRM Device Error";
	case VLIB_ERROR_DEINIT:
		return "VLIB Source Un-init Error";
	case VLIB_ERROR_SRC_CONFIG:
		return "VLIB Source Config Error";
	case VLIB_ERROR_HDMIRX_INVALID_STATE:
		return "VLIB HDMI-RX Invalid State \nCheck Link/Resolution";
	case VLIB_ERROR_HDMIRX_INVALID_RES:
		return "VLIB HDMI-RX Invalid Resolution \nSupported Input Resolutions are 1080p and 4K";
	case VLIB_ERROR_HDMIRX_INVALID_FPS:
		return "VLIB HDMI-RX Invalid FPS \nSupported Max Input Frame Rate is 30fps";
	case VLIB_ERROR_HDMIRX_INVALID_SEQUENCE:
		return "VLIB HDMI-RX Invalid Sequence \nDerived HDMI can't run independently \n\
HDMI source should run in parallel to derived HDMI";
	case VLIB_ERROR_OTHER:
		return "VLIB Other Error";
	case VLIB_ERROR_SET_FPS :
		return "VLIB TPG set fps failed";
	case VLIB_ERROR_MIPI_CONFIG_FAILED :
		return "VLIB MIPI Invalid State \n Check MIPI Sensor Connection";
	case VLIB_ERROR_MIPI_NOT_CONNECTED :
		return "VLIB MIPI Not Connected";
	case VLIB_ERROR_INVALID_STATE:
		return "VLIB  Source is in invalid state \nCheck Link/Resolution";
	case VLIB_ERROR_INVALID_RESOLUTION:
		return "VLIB set and get resolution mismatch";
	case VLIB_ERROR_SET_FORMAT_FAILED:
		return "VLIB unable to set format";
	case VLIB_ERROR_GET_FORMAT_FAILED:
		return "VLIB unable to get format";
	case VLIB_ERROR_HDMIRX_1_NOT_AVAILABLE:
		return "VLIB HDMI-RX1 Src is not Available";
	case VLIB_ERROR_HDMIRX_2_NOT_AVAILABLE:
		return "VLIB HDMI-RX2 Src is not Available";
	case VLIB_ERROR_HDMIRX_3_NOT_AVAILABLE:
		return "VLIB HDMI-RX3 Src is not Available";
	case VLIB_ERROR_HDMIRX_4_NOT_AVAILABLE:
		return "VLIB HDMI-RX4 Src is not Available";
	case VLIB_ERROR_HDMIRX_5_NOT_AVAILABLE:
		return "VLIB HDMI-RX5 Src is not Available";
	case VLIB_ERROR_HDMIRX_6_NOT_AVAILABLE:
		return "VLIB HDMI-RX6 Src is not Available";
	case VLIB_ERROR_HDMIRX_7_NOT_AVAILABLE:
		return "VLIB HDMI-RX7 Src is not Available";
	case VLIB_ERROR_TPG_1_NOT_AVAILABLE:
		return "VLIB TPG 1 Src is not Available";
	case VLIB_ERROR_TPG_2_NOT_AVAILABLE:
		return "VLIB TPG 2 Src is not Available";
	case VLIB_ERROR_SDI_NOT_AVAILABLE:
		return "VLIB SDI Src is not Available";
	case VLIB_ERROR_SCD_NOT_AVAILABLE:
		return "VLIB SCD media node not Available";
	case VLIB_NO_MEDIA_SRC:
		return "VLIB No media source Available";
	case VLIB_ERROR_DRM_DEVICE_OPEN_FAIL:
		return "VLIB Open DRM device Fail";
	case VLIB_ERROR_DRM_MODE_GET_PLANE_RES_FAIL:
		return "VLIB DRM Mode Get Plane Resource Fail";
	case VLIB_ERROR_DRM_PLANE_NOT_FOUND:
		return "VLIB DRM Plane Not Found";
	case VLIB_SUCCESS:
		return "VLIB Success";
	default:
		return "VLIB Unknown Error";
	}
}

const char * vlib_get_devname(vlib_dev_type dev)
{
	return video_get_devname(dev);
}

static int vlib_drm_id2card(struct drm_device *dev, unsigned int dri_card_id)
{
	int ret;
	glob_t pglob;
	unsigned int dri_card;

	switch (dri_card_id) {
	case DP:
		ret = glob("/sys/class/drm/card*-DP-1", 0, NULL, &pglob);
		break;
	case HDMI_Tx:
		ret = glob("/sys/class/drm/card*-HDMI-A-1", 0, NULL, &pglob);
		break;
	case SDI_Tx:
		ret = glob("/sys/class/drm/card*-Unknown-1", 0, NULL, &pglob);
		break;
	default:
		vlib_err("No valid DRM device found");
		ret = VLIB_ERROR_INVALID_PARAM;
		goto error;
	}

	if (ret != VLIB_SUCCESS) {
		vlib_err("Invalid DRM device Error");
		ret = VLIB_ERROR_INVALID_DRM_DEVICE;
		goto error;
	}

	sscanf(pglob.gl_pathv[0], "/sys/class/drm/card%u-*", &dri_card);
	snprintf(dev->dri_card, sizeof(dev->dri_card), "/dev/dri/card%u",
		dri_card);
	vlib_info("DRM device found at %s\n", dev->dri_card);

error:
	globfree(&pglob);

	return ret;
}

int vlib_drm_find_preferred_mode(struct vlib_config_data *cfg)
{
	int ret;
	struct drm_device *drm_dev = &drm;

	ret = vlib_drm_id2card(drm_dev, cfg->display_id);
	if (ret)
		return ret;

	/* find preferred mode */
	ret = drm_find_preferred_mode(drm_dev);
	if (ret)
		return ret;

	return VLIB_SUCCESS;
}

/**
 * vlib_drm_try_mode - Check if a mode with matching resolution is valid
 *  @display_id: Display ID
 *  @width: Desired mode width
 *  @height: Desired mode height
 *  @vrefresh: Refresh rate of found mode
 *
 *  Search for a mode that supports the desired @widthx@height. If a matching
 *  mode is found @vrefresh is populated with the refresh rate for that mode.
 *
 *  Return: 0 on success, error code otherwise.
 */
int vlib_drm_try_mode(unsigned int display_id, int width, int height,
		      size_t *vrefresh)
{
	int ret;
	size_t vr;
	struct drm_device drm_dev;

	ret = vlib_drm_id2card(&drm_dev, display_id);
	if (ret)
		return ret;

	ret = drm_try_mode(&drm_dev, width, height, &vr);
	if (vrefresh)
		*vrefresh = vr;

	return ret;
}

/**
 * vlib_drm_find_preferred_plane - Find DRM plane which supports input format
 * @driver_type: Driver Type
 * @format: Input format
 * @plane_id: Plane id of DRM plane which supports input format
 *
 * Find DRM plane that supports the desired input format. If a matching
 * input format is found in any of DRM plane then plane id of that plane
 * is returned
 *
 * Return: 0 on success, error code otherwise.
 */
int vlib_drm_find_preferred_plane(vlib_driver_type driver_type, unsigned int format,
		unsigned int *plane_id) {
	int ret;
	struct drm_device drm_dev;

	ret = vlib_drm_id2card(&drm_dev, driver_type);
	if (ret)
		return ret;

	ret = drm_find_preferred_plane(&drm_dev, format, plane_id);
	if (ret)
		return ret;

	return VLIB_SUCCESS;
}
