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


#include "helper.h"
#include "mediactl_helper.h"
#include "v4l2_subdev_helper.h"
#include "vcap_tpg_int.h"
#include "video_int.h"

#define MEDIA_TPG_ENTITY_1 "a00e0000.v_tpg"
#define MEDIA_TPG_ENTITY_2 "a02a0000.v_tpg1"
#define MEDIA_TPG_FMT_IN "VYYUYY8"
#define TPG_BG_PATTERN_DEFAULT 9
#define TPG_FG_DEFAULT 0
#define TPG_PPC_DEFAULT 1
#define TPG_4K_HOR_BLANKING 560
#define TPG_4K_VER_BLANKING 90

static unsigned int bg_pattern = TPG_BG_PATTERN_DEFAULT;
static unsigned int fg_pattern = TPG_FG_DEFAULT;
static unsigned int ppc_set = TPG_PPC_DEFAULT;

static int v4l2_tpg_set_ctrl(const struct vlib_vdev *vd, int id, int value)
{
	char *media_tpg_entity;

	if (vd->dev_type == TPG_1)
		media_tpg_entity = MEDIA_TPG_ENTITY_1;
	else
		media_tpg_entity = MEDIA_TPG_ENTITY_2;

	return v4l2_set_ctrl(vd, media_tpg_entity, id, value);
}

void tpg_set_blanking(const struct vlib_vdev *vd, unsigned int vblank,
		      unsigned int hblank)
{
	v4l2_tpg_set_ctrl(vd, V4L2_CID_VBLANK, vblank);
	v4l2_tpg_set_ctrl(vd, V4L2_CID_HBLANK, hblank);
}

void tpg_set_bg_pattern(const struct vlib_vdev *vd, unsigned int bg)
{
	v4l2_tpg_set_ctrl(vd, V4L2_CID_TEST_PATTERN, bg);
	bg_pattern = bg;
}

void tpg_set_fg_pattern(const struct vlib_vdev *vd, unsigned int fg)
{
	v4l2_tpg_set_ctrl(vd, V4L2_CID_XILINX_TPG_HLS_FG_PATTERN, fg);
	fg_pattern = fg;
}

void tpg_set_ppc(const struct vlib_vdev *vd, unsigned int ppc)
{
	v4l2_tpg_set_ctrl(vd, V4L2_CID_XILINX_PPC, ppc);
	 ppc_set = ppc;
}


static void tpg_set_cur_config(const struct vlib_vdev *vd)
{
	/* Set current TPG config */
	tpg_set_bg_pattern(vd, bg_pattern);
	/* Box overlay is disabled i.e no foreground pattern */
	tpg_set_fg_pattern(vd, fg_pattern);

	/* TODO: Need to fix this by giving hblank and vblank as per input resolution.
	 * It will be fixed when we add support to dynamically detect the native resolution
	 * of the monitor.
	 */
	tpg_set_blanking(vd, TPG_4K_HOR_BLANKING, TPG_4K_VER_BLANKING);
}

int vcap_tpg_set_media_ctrl(const struct vlib_vdev *vdev,
				   struct vlib_config_data *cfg)
{
	int ret;
	char fmt_str[100];
	struct media_device *media =  video_get_mdev(vdev);
	char *media_tpg_entity;

	/* Enumerate entities, pads and links */
	ret = media_device_enumerate(media);
	ASSERT2(!(ret), "Failed to enumerate media \n");

#ifdef VLIB_LOG_LEVEL_DEBUG
	const struct media_device_info *info = media_get_info(media);
	print_media_info(info);
#endif

        if (vdev->dev_type == TPG_1)
                media_tpg_entity = MEDIA_TPG_ENTITY_1;
        else
                media_tpg_entity = MEDIA_TPG_ENTITY_2;

	/* Set TPG input resolution */
	memset(fmt_str, 0, sizeof (fmt_str));
	media_set_fmt_str(fmt_str, media_tpg_entity, 0, MEDIA_TPG_FMT_IN,
			cfg->width_in, cfg->height_in);
	ret = v4l2_subdev_parse_setup_formats(media, fmt_str);
	ASSERT2(!ret, "Unable to setup formats: %s (%d)\n", strerror(-ret),
		-ret);

	return ret;
}

struct vlib_vdev *vcap_tpg_init(const struct matchtable *mte, void *media)
{
	struct vlib_vdev *vd = calloc(1, sizeof(*vd));

	if (!vd) {
		return NULL;
	}

	vd->vsrc_type = VSRC_TYPE_MEDIA;
	vd->mdev = media;
	vd->display_text = "Test Pattern Generator";
	vd->entity_name = mte->s;

	if (strcmp(vd->entity_name, "vcap_tp0 output 0") == 0)
		vd->dev_type = TPG_1;
	else
		vd->dev_type = TPG_2;

	tpg_set_cur_config(vd);

	return vd;
}
