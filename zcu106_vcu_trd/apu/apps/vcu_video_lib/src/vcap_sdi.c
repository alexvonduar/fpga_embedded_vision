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
#include <stdlib.h>
#include <mediactl/mediactl.h>
#include <mediactl/v4l2subdev.h>
#include "v4l2_subdev_helper.h"
#include "helper.h"
#include "mediactl_helper.h"
#include "vcap_sdi_int.h"
#include "video_int.h"

#define MEDIA_SDI_ENTITY	"a0030000.v_smpte_uhdsdi_rx_ss"
#define MEDIA_SCALER_ENTITY	"a0080000.v_proc_ss"
#define MEDIA_SCALER_NV12_FMT_OUT	"VYYUYY8"
#define MEDIA_SCALER_NV16_FMT_OUT	"UYVY"
#define MEDIA_SCALER_XV15_FMT_OUT	"VYYUYY10"
#define MEDIA_SCALER_XV20_FMT_OUT	"UYVY10"
#define MEDIA_SDI_PAD		0

int vcap_sdi_set_media_ctrl(const struct vlib_vdev *vdev, struct vlib_config_data *cfg)
{
	int ret;
	struct media_pad *pad;
	char fmt_str[100];
	struct media_device *media =  video_get_mdev(vdev);
	struct v4l2_mbus_framefmt format;
	const char* fmt_code;

	/* Enumerate entities, pads and links */
	ret = media_device_enumerate(media);
	ASSERT2(!(ret), "Failed to enumerate media \n");

#ifdef VLIB_LOG_LEVEL_DEBUG
	const struct media_device_info *info = media_get_info(media);
	print_media_info(info);
#endif

	/* Get SDI Rx pad */
	memset(fmt_str, 0, sizeof(fmt_str));
	media_set_pad_str(fmt_str, MEDIA_SDI_ENTITY, MEDIA_SDI_PAD);
	pad = media_parse_pad(media, fmt_str, NULL);
	ASSERT2(pad, "Pad '%s' not found\n", fmt_str);

	/* Retrieve SDI  Rx pad format */
	ret = v4l2_subdev_get_format(pad->entity, &format, MEDIA_SDI_PAD,
				     V4L2_SUBDEV_FORMAT_ACTIVE);
	if (ret < 0 ) {
		vlib_dbg("Failed to get SDI Rx pad format: %s\n", strerror(-ret));
		return VLIB_ERROR_GET_FORMAT_FAILED;
	}

	fmt_code = v4l2_subdev_pixelcode_to_string(format.code);
	vlib_dbg("SDI Rx source pad format: %s, %ux%u\n", fmt_code,
		 format.width, format.height);
	if((format.width != cfg->width_in) && (format.height != cfg->height_in)) {
		vlib_dbg("SDI Rx: set and get resolution mismatch\n");
		return VLIB_ERROR_INVALID_RESOLUTION;
	}

	memset(fmt_str, 0, sizeof(fmt_str));
	media_set_fmt_str(fmt_str, MEDIA_SCALER_ENTITY, 0, fmt_code,
			 format.width, format.height);
	ret = v4l2_subdev_parse_setup_formats(media, fmt_str);
	if (ret < 0 ) {
		vlib_dbg("SDI Rx: Scaler: Unable to set input format : %s (%d)\n", strerror(-ret), -ret);
		return VLIB_ERROR_SET_FORMAT_FAILED;
	}

	memset(fmt_str, 0, sizeof(fmt_str));
	if (cfg->format == NV12) {
		media_set_fmt_str(fmt_str, MEDIA_SCALER_ENTITY, 1,
			MEDIA_SCALER_NV12_FMT_OUT, format.width, format.height);
	} else if (cfg->format == XV15) {
		media_set_fmt_str(fmt_str, MEDIA_SCALER_ENTITY, 1,
			MEDIA_SCALER_XV15_FMT_OUT, format.width, format.height);
	} else if (cfg->format == NV16) {
		media_set_fmt_str(fmt_str, MEDIA_SCALER_ENTITY, 1,
			MEDIA_SCALER_NV16_FMT_OUT, format.width, format.height);
	} else if (cfg->format == XV20) {
		media_set_fmt_str(fmt_str, MEDIA_SCALER_ENTITY, 1,
			MEDIA_SCALER_XV20_FMT_OUT, format.width, format.height);
	} else {
		vlib_dbg("SDI Rx: Scaler: Invalid input format\n");
		return VLIB_ERROR_SET_FORMAT_FAILED;
	}

	ret = v4l2_subdev_parse_setup_formats(media, fmt_str);
	if (ret < 0 ) {
		vlib_dbg("SDI Rx: Scaler: Unable to set output format : %s (%d)\n", strerror(-ret), -ret);
		return VLIB_ERROR_SET_FORMAT_FAILED;
	}

	return ret;
}

struct vlib_vdev *vcap_sdi_init(const struct matchtable *mte, void *media)
{
	struct vlib_vdev *vd = calloc(1, sizeof(*vd));
	if (!vd) {
		return NULL;
	}

	vd->vsrc_type = VSRC_TYPE_MEDIA;
	vd->dev_type = SDI;
	vd->mdev = media;
	vd->display_text = "SDI Input";
	vd->entity_name = mte->s;
	vd->priv = NULL;

	return vd;
}
