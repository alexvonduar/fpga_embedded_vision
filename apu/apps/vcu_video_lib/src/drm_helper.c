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
#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <linux/videodev2.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>

#include "helper.h"
#include "drm_helper.h"

const struct {
	unsigned int drm_format;
	vlib_format_type vlib_format;
} formats[] = {
	{ DRM_FORMAT_NV12, NV12 },
	{ DRM_FORMAT_NV16, NV16 },
	{ DRM_FORMAT_XV15, XV15 },
	{ DRM_FORMAT_XV20, XV20 },
};

unsigned int vlib_format_to_drm_format(vlib_format_type vlib_format) {
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(formats); i++) {
		if (formats[i].vlib_format == vlib_format)
			return formats[i].drm_format;
	}

	return 0;
}

/* Find available CRTC and connector for scanout */
static int drm_find_crtc(struct drm_device *dev)
{
	int ret = -1;

	drmModeRes *res = drmModeGetResources(dev->fd);
	if (!res) {
		vlib_err("drmModeGetResources failed: %s",
				strerror(errno));
		return VLIB_ERROR_INTERNAL;
	}

	if (res->count_crtcs <= 0) {
		vlib_err("drm: no crts");
		goto done;
	}

	/* Assume first crtc id is ok */
	dev->crtc_index = 0 ;
	dev->crtc_id = res->crtcs[0] ;

	if (res->count_connectors <= 0) {
		vlib_err("drm: no connectors");
		goto done;
	}

	/* Assume first connector is ok */
	dev->con_id = res->connectors[0];

	dev->connector = drmModeGetConnector(dev->fd, dev->con_id);
	if (!dev->connector) {
		vlib_err("drmModeGetConnector failed: %s",
				strerror(errno));
		goto done;
	}

	ret = VLIB_SUCCESS;

done:
	drmModeFreeResources(res);
	return ret;
}

/* Find DRM preferred mode */
int drm_find_preferred_mode(struct drm_device *dev)
{
	int ret;

	dev->fd = open(dev->dri_card, O_RDWR, 0);
	ASSERT2(dev->fd >= 0, "open DRM device %s failed: %s\n", dev->dri_card,
		ERRSTR);

	ret = drm_find_crtc(dev);
	ASSERT2(!ret, "Failed to find CRTC and/or connector\n");

	drmModeConnector *connector = dev->connector;

	if (!connector->count_modes) {
		vlib_err("connector supports no mode");
		return VLIB_ERROR_INTERNAL;
	}

	/* First advertised mode is preferred mode */
	dev->preferred_mode = connector->modes;

	drmModeFreeConnector(dev->connector);
	drmClose(dev->fd);

	return ret;
}

/**
 * drm_try_mode - Check if a mode with matching resolution is valid
 * @dev: Pointer to DRM data structure
 * @width: Desired mode width
 * @height: Desired mode heigh
 * @vrefresh: Refresh rate of found mode
 *
 * Search for a mode that supports the desired @widthx@height. If a matching
 * mode is found @vrefresh is populated with the refresh rate for that mode.
 *
 * Return: 0 on success, error code otherwise.
 */

int drm_try_mode(struct drm_device *dev, int width, int height, size_t *vrefresh)
{
	int ret;
	dev->fd = open(dev->dri_card, O_RDWR, 0);
	ASSERT2(dev->fd >= 0, "open DRM device %s failed: %s\n", dev->dri_card,
		ERRSTR);

	ret = drm_find_crtc(dev);
	ASSERT2(!ret, "Failed to find CRTC and/or connector\n");

	drmModeConnector *connector = dev->connector;
	ret = VLIB_ERROR_INVALID_PARAM;

	for (size_t j = 0; j < connector->count_modes; j++) {
		/* Iterate through all the supported modes */
		if (connector->modes[j].hdisplay == width &&
			connector->modes[j].vdisplay == height) {
			if (vrefresh) {
				*vrefresh = connector->modes[j].vrefresh;
			}
			ret = VLIB_SUCCESS;
			break;
		}
	}

	drmModeFreeConnector(dev->connector);
	drmClose(dev->fd);

	return ret;
}

/**
 * drm_find_preferred_plane - Find DRM plane which supports input format
 * @dev: Pointer to DRM data structure
 * @format: Input format
 * @plane_id: Plane id of DRM plane which supports input format
 *
 * Find DRM plane that supports the desired input format. If a matching
 * input format is found in any of DRM plane then plane id of that plane
 * is returned
 *
 * Return: 0 on success, error code otherwise.
 */
int drm_find_preferred_plane(struct drm_device *dev, unsigned int format,
		unsigned int *plane_id) {

	unsigned int i, j;
	drmModePlaneRes *plane_resources;
	drmModePlane *plane;

	dev->fd = open(dev->dri_card, O_RDWR, 0);
	if (dev->fd < 0) {
		vlib_err("Open DRM device %s failed: %s", dev->dri_card, strerror(errno));
		return VLIB_ERROR_DRM_DEVICE_OPEN_FAIL;
	}

	plane_resources = drmModeGetPlaneResources(dev->fd);
	if (!plane_resources) {
		vlib_err("drmModeGetPlaneResources failed: %s", strerror(errno));
		drmClose(dev->fd);
		return VLIB_ERROR_DRM_MODE_GET_PLANE_RES_FAIL;
	}

	for (i = 0; i < plane_resources->count_planes; i++) {
		plane = drmModeGetPlane(dev->fd, plane_resources->planes[i]);
		if (!plane) {
			vlib_err("drmModeGetPlane failed: %s", strerror(errno));
			continue;
		}

		for (j = 0; j < plane->count_formats; j++) {
			if (plane->formats[j] == vlib_format_to_drm_format(format)) {
				*plane_id = plane->plane_id;
				drmModeFreePlane(plane);
				drmModeFreePlaneResources(plane_resources);
				drmClose(dev->fd);
				return VLIB_SUCCESS;
			}
		}

		drmModeFreePlane(plane);
	}

	drmModeFreePlaneResources(plane_resources);
	drmClose(dev->fd);

	return VLIB_ERROR_DRM_PLANE_NOT_FOUND;
}
