/******************************************************************************
 * (c) Copyright 2019 Xilinx, Inc. All rights reserved.
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
#include "vcap_scd_int.h"
#include "video_int.h"

#define MEDIA_SCD_ENTITY               "xlnx-scdchan."
#define MEDIA_SCALER_NV12_FMT_OUT	   "VYYUYY8"
#define MEDIA_SCALER_NV16_FMT_OUT	   "UYVY"
#define MEDIA_SCALER_XV15_FMT_OUT	   "VYYUYY10"
#define MEDIA_SCALER_XV20_FMT_OUT	   "UYVY10"

#define MEDIA_SCD_PAD                  0

int vcap_scd_set_media_ctrl(const struct vlib_vdev *vdev, struct vlib_config_data *cfg)
{
	int ret;
	size_t nents;
	char fmt_str[100];
	struct media_device *media =  video_get_mdev(vdev);
	struct media_entity_desc *info;
	struct media_entity *entity;

	/* Enumerate entities, pads and links */
	ret = media_device_enumerate(media);
	if (ret < 0) {
		vlib_dbg("Failed to enumerate media: %d \n", ret);
		return VLIB_NO_MEDIA_SRC;
	}

#ifdef VLIB_LOG_LEVEL_DEBUG
	const struct media_device_info *info = media_get_info(media);
	print_media_info(info);
#endif

	nents = media_get_entities_count(media);

	for (size_t i = 0; i < nents; i++) {

		entity = media_get_entity(media, i);
		if (!entity) {
			continue;
		}

		info = (struct media_entity_desc *) media_entity_get_info(entity);
		if (!info) {
			continue;
		}

		if (!strncmp(info->name, MEDIA_SCD_ENTITY, strlen(MEDIA_SCD_ENTITY))) {

			if (cfg->format == NV12) {
				media_set_fmt_str(fmt_str, (char *) info->name, 0,
						MEDIA_SCALER_NV12_FMT_OUT,
						cfg->width_in, cfg->height_in);
			} else if (cfg->format == NV16) {
				media_set_fmt_str(fmt_str, (char *) info->name, 0,
						MEDIA_SCALER_NV16_FMT_OUT,
						cfg->width_in, cfg->height_in);
			} else if (cfg->format == XV15) {
				media_set_fmt_str(fmt_str, (char *) info->name, 0,
						MEDIA_SCALER_XV15_FMT_OUT,
						cfg->width_in, cfg->height_in);
			} else if (cfg->format == XV20) {
				media_set_fmt_str(fmt_str, (char *) info->name, 0,
						MEDIA_SCALER_XV20_FMT_OUT,
						cfg->width_in, cfg->height_in);
			} else {
				vlib_dbg("SCD: Invalid input format\n");
				return VLIB_ERROR_SET_FORMAT_FAILED;
			}

			ret = v4l2_subdev_parse_setup_formats(media, fmt_str);
			if (ret < 0) {
				vlib_dbg("SCD: Unable to set sink format : %s (%d)\n", strerror(-ret), -ret);
				return VLIB_ERROR_SET_FORMAT_FAILED;
			}
		}
	}

	return ret;
}

struct vlib_vdev *vcap_scd_init(const struct matchtable *mte, void *media)
{
	struct vlib_vdev *vd = calloc(1, sizeof(*vd));
	if (!vd) {
		return NULL;
	}

	vd->vsrc_type = VSRC_TYPE_MEDIA;
	vd->mdev = media;
	vd->display_text = "SCD Input";
	vd->entity_name = mte->s;
	vd->priv = NULL;

	if (strcmp(vd->entity_name, "video_cap input 0") == 0) {
		vd->dev_type = SCD;
	}

	return vd;
}
