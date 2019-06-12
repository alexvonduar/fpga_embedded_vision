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
#include <glib.h>
#include <glob.h>
#include <mediactl/mediactl.h>
#include <linux/videodev2.h>
#include <stdbool.h>

#include "mediactl_helper.h"
#include "vcap_hdmi_int.h"
#include "vcap_tpg_int.h"
#include "vcap_csi_int.h"
#include "vcap_sdi_int.h"
#include "vcap_scd_int.h"
#include "helper.h"
#include "video_int.h"
#include "gpio_utils.c"

static GPtrArray *video_srcs;
static bool hdmi_1_pipeline;
static bool scd_configured;

struct media_device * video_get_mdev(const struct vlib_vdev *vdev)
{
	if (!vdev)
		return NULL;

	if (vdev->vsrc_type != VSRC_TYPE_MEDIA) {
		return NULL;
	}

	return vdev->mdev;
}

static void vlib_vsrc_vdev_free(struct vlib_vdev *vd)
{
	switch (vd->vsrc_type) {
	case VSRC_TYPE_MEDIA:
		media_device_unref(vd->mdev);
		break;
	default:
		break;
	}
	free(vd->priv);
	free(vd);
}

static void vlib_vsrc_table_free_func(void *e)
{
	struct vlib_vdev *vd = e;

	vlib_vsrc_vdev_free(vd);
}

static const struct matchtable mt_entities[] = {
		{
				.s = "vcap_tp0 output 0", .init = vcap_tpg_init,
		},
		{
				.s = "vcap_tpg1 output 0", .init = vcap_tpg_init,
		},
		{
				.s = "vcap_hdmi output 0", .init = vcap_hdmi_init,
		},
		{
				.s = "vcap_hdmi_2 output 0", .init = vcap_hdmi_init,
		},
		{
				.s = "vcap_hdmi_3 output 0", .init = vcap_hdmi_init,
		},
		{
				.s = "vcap_hdmi_4 output 0", .init = vcap_hdmi_init,
		},
		{
				.s = "vcap_hdmi_5 output 0", .init = vcap_hdmi_init,
		},
		{
				.s = "vcap_hdmi_6 output 0", .init = vcap_hdmi_init,
		},
		{
				.s = "vcap_hdmi_7 output 0", .init = vcap_hdmi_init,
		},
		{
				.s = "vcap_csi output 0", .init = vcap_csi_init,
		},
		{
				.s = "vcap_sdi output 0", .init = vcap_sdi_init,
		},
		{
				.s = "video_cap input 0", .init = vcap_scd_init,
		},
};

static struct vlib_vdev *init_xvideo(const struct matchtable *mte, void *media)
{
	struct vlib_vdev *vd = NULL;
	size_t nents = media_get_entities_count(media);

	for (size_t i = 0; i < nents; i++) {
		const struct media_entity_desc *info;
		struct media_entity *entity = media_get_entity(media, i);

		if (!entity) {
			printf("failed to get entity %zu\n", i);
			continue;
		}

		info = media_entity_get_info(entity);
		for (size_t j = 0; j < ARRAY_SIZE(mt_entities); j++) {
			if (!strcmp(mt_entities[j].s, info->name)) {
				vd = mt_entities[j].init(&mt_entities[j], media);
				break;
			}
		}
	}

	return vd;
}

static const struct matchtable mt_drivers_media[] = {
		{
				.s = "xilinx-video", .init = init_xvideo,
		},
};

int vlib_src_init()
{
	int ret;
	glob_t pglob;

	video_srcs = g_ptr_array_new_with_free_func(vlib_vsrc_table_free_func);
	if (!video_srcs) {
		return VLIB_ERROR_INIT;
	}

	ret = glob("/dev/media*", 0, NULL, &pglob);
	if (ret != VLIB_SUCCESS){
                if (ret == GLOB_NOMATCH) {
                        ret = VLIB_NO_MEDIA_SRC; /* FIX ME */
                } else
                        ret = VLIB_ERROR_INIT; /* FIX ME */
                goto error;
        }

	for (size_t i = 0; i < pglob.gl_pathc; i++) {
		struct media_device *media = media_device_new(pglob.gl_pathv[i]);

		if (!media) {
			printf("failed to create media device from '%s'\n",
					pglob.gl_pathv[i]);
			continue;
		}

		ret = media_device_enumerate(media);
		if (ret < 0) {
			vlib_dbg("failed to enumerate '%s'\n",
					pglob.gl_pathv[i]);
			ret = VLIB_ERROR_INIT;
			media_device_unref(media);
			continue;
		}

		const struct media_device_info *info = media_get_info(media);

		size_t j;
		for (j = 0; j < ARRAY_SIZE(mt_drivers_media); j++) {
			if (strcmp(mt_drivers_media[j].s, info->driver)) {
				continue;
			}

			struct vlib_vdev *vd =
					mt_drivers_media[j].init(&mt_drivers_media[j],
							media);
			if (vd) {
				vlib_dbg("found video source '%s (%s)'\n",
						vd->display_text, pglob.gl_pathv[i]);
				g_ptr_array_add(video_srcs, vd);
				break;
			}

		}

		if (j == ARRAY_SIZE(mt_drivers_media)) {
			media_device_unref(media);
		}
	}

	error:
	globfree(&pglob);
	vlib_dbg("%s :: %d \n", __func__, ret);

	return ret;
}

static const char *vgst_video_src_mdev2vdev(struct media_device *media)
{
	struct media_entity *ent = media_get_entity(media, 0);
	if (!ent) {
		return NULL;
	}

	return media_entity_get_devname(ent);
}


const char * video_get_devname(vlib_dev_type dev)
{
	for (size_t i = video_srcs->len; i > 0; i--) {
		struct vlib_vdev *vd = g_ptr_array_index(video_srcs, i - 1);

		if (vd->dev_type  == dev) {
			return vgst_video_src_mdev2vdev(vd->mdev);
		}
	}

	return NULL;
}

static const struct vlib_vdev * video_get_vdev(vlib_dev_type dev)
{
	for (size_t i = video_srcs->len; i > 0; i--) {
			struct vlib_vdev *vd = g_ptr_array_index(video_srcs, i - 1);

			if (vd->dev_type  == dev) {
				return vd;
			}
		}

		return NULL;
}

int  vlib_src_uninit(void)
{
	int ret = VLIB_SUCCESS;
	hdmi_1_pipeline = false;
	scd_configured = false;
	g_ptr_array_free(video_srcs, TRUE);
	vlib_dbg("%s :: %d \n", __func__, ret);

	return ret;
}

int vlib_src_config(vlib_dev_type dev, struct vlib_config_data *cfg)
{
	int ret = VLIB_SUCCESS;
	const struct vlib_vdev *vdev;

	switch (dev) {

	case HDMI_1:
		hdmi_1_pipeline = true;

		vdev = video_get_vdev(dev);
		if (!vdev) {
			ret = VLIB_ERROR_HDMIRX_1_NOT_AVAILABLE;
			break;
		}

		ret = vcap_hdmi_set_media_ctrl(vdev, cfg);
		break;

	case HDMI_2:
		if (!hdmi_1_pipeline)
			return VLIB_ERROR_HDMIRX_INVALID_SEQUENCE;

		vdev = video_get_vdev(dev);
		if (!vdev) {
			ret = VLIB_ERROR_HDMIRX_2_NOT_AVAILABLE;
			break;
		}

		ret = vcap_hdmi_set_media_ctrl(vdev, cfg);
		break;

	case HDMI_3:
		if (!hdmi_1_pipeline)
			return VLIB_ERROR_HDMIRX_INVALID_SEQUENCE;

		vdev = video_get_vdev(dev);
		if (!vdev) {
			ret = VLIB_ERROR_HDMIRX_3_NOT_AVAILABLE;
			break;
		}

		ret = vcap_hdmi_set_media_ctrl(vdev, cfg);
		break;

	case HDMI_4:
		if (!hdmi_1_pipeline)
			return VLIB_ERROR_HDMIRX_INVALID_SEQUENCE;

		vdev = video_get_vdev(dev);
		if (!vdev) {
			ret = VLIB_ERROR_HDMIRX_4_NOT_AVAILABLE;
			break;
		}

		ret = vcap_hdmi_set_media_ctrl(vdev, cfg);
		break;

	case HDMI_5:
		if (!hdmi_1_pipeline)
			return VLIB_ERROR_HDMIRX_INVALID_SEQUENCE;

		vdev = video_get_vdev(dev);
		if (!vdev) {
			ret = VLIB_ERROR_HDMIRX_5_NOT_AVAILABLE;
			break;
		}

		ret = vcap_hdmi_set_media_ctrl(vdev, cfg);
		break;

	case HDMI_6:
		if (!hdmi_1_pipeline)
			return VLIB_ERROR_HDMIRX_INVALID_SEQUENCE;

		vdev = video_get_vdev(dev);
		if (!vdev) {
			ret = VLIB_ERROR_HDMIRX_6_NOT_AVAILABLE;
			break;
		}

		ret = vcap_hdmi_set_media_ctrl(vdev, cfg);
		break;

	case HDMI_7:
		if (!hdmi_1_pipeline)
			return VLIB_ERROR_HDMIRX_INVALID_SEQUENCE;

		vdev = video_get_vdev(dev);
		if (!vdev) {
			ret = VLIB_ERROR_HDMIRX_7_NOT_AVAILABLE;
			break;
		}

		ret = vcap_hdmi_set_media_ctrl(vdev, cfg);
		break;

	case TPG_1:
		vdev = video_get_vdev(dev);
		if (!vdev) {
			ret = VLIB_ERROR_TPG_1_NOT_AVAILABLE;
			break;
		}

		if (cfg->fps == 30)
			tpg_set_ppc(vdev, 1);

		else if (cfg->fps == 60)
			tpg_set_ppc(vdev, 2);

		ret = vcap_tpg_set_media_ctrl(vdev, cfg);
		gpio_export(458);
		gpio_dir_out(458);
		if (cfg->width_in == 3840 && cfg->height_in == 2160)
			gpio_value(458,0);
		else if  (cfg->width_in == 1920 && cfg->height_in  == 1080)
			gpio_value(458,1);
		break;

	case TPG_2:
		vdev = video_get_vdev(dev);
		if (!vdev) {
			ret = VLIB_ERROR_TPG_2_NOT_AVAILABLE;
			break;
		}

		if (cfg->fps == 30)
			tpg_set_ppc(vdev, 1);

		else if (cfg->fps == 60)
			tpg_set_ppc(vdev, 2);

		ret = vcap_tpg_set_media_ctrl(vdev, cfg);
		break;

	case CSI:
		vdev = video_get_vdev(dev);
		if (!vdev) {
			ret = VLIB_ERROR_MIPI_NOT_CONNECTED;
			break;
		}
		ret = vcap_csi_ops_set_media_ctrl(vdev, cfg);
		imx274_set_frame_interval(vdev, cfg->fps);
		vcap_csi_set_config(vdev);
		break;

	case SDI:
		vdev = video_get_vdev(dev);
		if (!vdev) {
			ret = VLIB_ERROR_SDI_NOT_AVAILABLE;
			break;
		}
		ret = vcap_sdi_set_media_ctrl(vdev, cfg);
		break;
	case SCD:
		/* Do nothing, added to remove compiler warning */
		break;
	}

	if (cfg->enable_scd && !scd_configured) {
		vdev = video_get_vdev(SCD);
		if (vdev) {
			ret = vcap_scd_set_media_ctrl(vdev, cfg);
		} else {
			ret = VLIB_ERROR_SCD_NOT_AVAILABLE;
		}
		scd_configured = true;
	}

	vlib_dbg("%s :: %d \n", __func__, ret);

	return ret;
}
