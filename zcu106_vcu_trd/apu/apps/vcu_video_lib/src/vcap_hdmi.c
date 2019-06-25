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
#include "vcap_hdmi_int.h"
#include "video_int.h"


#define MEDIA_HDMI_ENTITY_1	"a0000000.v_hdmi_rx_ss"
#define MEDIA_HDMI_ENTITY_2	"a02f0000.dummy"
#define MEDIA_HDMI_ENTITY_3	"a02f0100.dummy_2"
#define MEDIA_HDMI_ENTITY_4	"a02f0200.dummy_3"
#define MEDIA_HDMI_ENTITY_5	"a02f0300.dummy_4"
#define MEDIA_HDMI_ENTITY_6	"a02f0400.dummy_5"
#define MEDIA_HDMI_ENTITY_7	"a02f0500.dummy_6"
#define MEDIA_SCALER_ENTITY	"a0080000.v_proc_ss"
#define VCAP_HDMI_HAS_SCALER 1
#define MEDIA_SCALER_NV12_FMT_OUT	"VYYUYY8"
#define MEDIA_SCALER_NV16_FMT_OUT	"UYVY"
#define MEDIA_SCALER_XV15_FMT_OUT	"VYYUYY10"
#define MEDIA_SCALER_XV20_FMT_OUT	"UYVY10"
#define MEDIA_HDMI_PAD		0
#define VCAP_HDMI_FLAG_HAS_SCALER	BIT(0)

struct vcap_hdmi_data {
	size_t in_width;
	size_t in_height;
	unsigned int flags;
};

const struct {
	const char *name;
	enum v4l2_mbus_pixelcode code;
} mbus_formats[] = {
	{ "Y8", MEDIA_BUS_FMT_Y8_1X8},
	{ "Y10", MEDIA_BUS_FMT_Y10_1X10 },
	{ "Y12", MEDIA_BUS_FMT_Y12_1X12 },
	{ "YUYV", MEDIA_BUS_FMT_YUYV8_1X16 },
	{ "YUYV1_5X8", MEDIA_BUS_FMT_YUYV8_1_5X8 },
	{ "YUYV2X8", MEDIA_BUS_FMT_YUYV8_2X8 },
    { "UYVY", MEDIA_BUS_FMT_UYVY8_1X16 },
	{ "UYVY1_5X8", MEDIA_BUS_FMT_UYVY8_1_5X8 },
	{ "UYVY2X8", MEDIA_BUS_FMT_UYVY8_2X8 },
	{ "VUY24", MEDIA_BUS_FMT_VUY8_1X24 },
	{ "SBGGR8", MEDIA_BUS_FMT_SBGGR8_1X8 },
	{ "SGBRG8", MEDIA_BUS_FMT_SGBRG8_1X8 },
	{ "SGRBG8", MEDIA_BUS_FMT_SGRBG8_1X8 },
	{ "SRGGB8", MEDIA_BUS_FMT_SRGGB8_1X8 },
	{ "SBGGR10", MEDIA_BUS_FMT_SBGGR10_1X10 },
	{ "SGBRG10", MEDIA_BUS_FMT_SGBRG10_1X10 },
	{ "SGRBG10", MEDIA_BUS_FMT_SGRBG10_1X10 },
	{ "SRGGB10", MEDIA_BUS_FMT_SRGGB10_1X10 },
	{ "SBGGR10_DPCM8", MEDIA_BUS_FMT_SBGGR10_DPCM8_1X8 },
	{ "SGBRG10_DPCM8", MEDIA_BUS_FMT_SGBRG10_DPCM8_1X8 },
	{ "SGRBG10_DPCM8", MEDIA_BUS_FMT_SGRBG10_DPCM8_1X8 },
	{ "SRGGB10_DPCM8", MEDIA_BUS_FMT_SRGGB10_DPCM8_1X8 },
	{ "SBGGR12", MEDIA_BUS_FMT_SBGGR12_1X12 },
	{ "SGBRG12", MEDIA_BUS_FMT_SGBRG12_1X12 },
	{ "SGRBG12", MEDIA_BUS_FMT_SGRBG12_1X12 },
	{ "SRGGB12", MEDIA_BUS_FMT_SRGGB12_1X12 },
	{ "AYUV32", MEDIA_BUS_FMT_AYUV8_1X32 },
	{ "RBG24", MEDIA_BUS_FMT_RBG888_1X24 },
	{ "RGB32", MEDIA_BUS_FMT_RGB888_1X32_PADHI },
	{ "ARGB32", MEDIA_BUS_FMT_ARGB8888_1X32 },
	{ "VYYUYY8", MEDIA_BUS_FMT_VYYUYY8_1X24},
	{ "VYYUYY10", MEDIA_BUS_FMT_VYYUYY10_4X20},
	{ "UYVY10", MEDIA_BUS_FMT_UYVY10_1X20},
};

const char *v4l2_subdev_pixelcode_to_string(enum v4l2_mbus_pixelcode code)
{
	unsigned int i;

	for (i = 0; i < ARRAY_SIZE(mbus_formats); ++i) {
		if (mbus_formats[i].code == code)
			return mbus_formats[i].name;
	}

	return "unknown";
}

enum v4l2_mbus_pixelcode v4l2_subdev_string_to_pixelcode(const char *string)
{
    unsigned int i;

	for (i = 0; i < ARRAY_SIZE(mbus_formats); ++i) {
		if (strcmp(mbus_formats[i].name, string) == 0)
			break;
	}

	if (i == ARRAY_SIZE(mbus_formats))
		return (enum v4l2_mbus_pixelcode)-1;

	return mbus_formats[i].code;
}

static int vcap_hdmi_has_scaler(const struct vlib_vdev *vd)
{
	const struct vcap_hdmi_data *data = vd->priv;
	ASSERT2(data, "no private data found\n");

	return !!(data->flags & VCAP_HDMI_HAS_SCALER);
}

static int width_in;
static int height_in;

int vcap_hdmi_set_media_ctrl(const struct vlib_vdev *vdev, struct vlib_config_data *cfg)
{
	int ret;
	struct media_pad *pad;
	struct v4l2_dv_timings timings;
	char fmt_str[100];
	struct media_device *media =  video_get_mdev(vdev);
	struct v4l2_mbus_framefmt format;
	const char* fmt_code;
	struct vcap_hdmi_data *data = vdev->priv;
	char *media_hdmi_entity;

	ASSERT2(data, "no private data found\n");

	/* Enumerate entities, pads and links */
	ret = media_device_enumerate(media);
	ASSERT2(!(ret), "Failed to enumerate media \n");

#ifdef VLIB_LOG_LEVEL_DEBUG
	const struct media_device_info *info = media_get_info(media);
	print_media_info(info);
#endif

	if (vdev->dev_type == HDMI_1)
		media_hdmi_entity = MEDIA_HDMI_ENTITY_1;
	else if (vdev->dev_type == HDMI_2)
		media_hdmi_entity = MEDIA_HDMI_ENTITY_2;
	else if (vdev->dev_type == HDMI_3)
		media_hdmi_entity = MEDIA_HDMI_ENTITY_3;
	else if (vdev->dev_type == HDMI_4)
		media_hdmi_entity = MEDIA_HDMI_ENTITY_4;
	else if (vdev->dev_type == HDMI_5)
		media_hdmi_entity = MEDIA_HDMI_ENTITY_5;
	else if (vdev->dev_type == HDMI_6)
		media_hdmi_entity = MEDIA_HDMI_ENTITY_6;
	else if (vdev->dev_type == HDMI_7)
		media_hdmi_entity = MEDIA_HDMI_ENTITY_7;

	/* Get HDMI Rx pad */
	memset(fmt_str, 0, sizeof(fmt_str));
	media_set_pad_str(fmt_str, media_hdmi_entity, MEDIA_HDMI_PAD);
	pad = media_parse_pad(media, fmt_str, NULL);
	ASSERT2(pad, "Pad '%s' not found\n", fmt_str);

	if (vdev->dev_type == HDMI_1) {
		ret = v4l2_subdev_query_dv_timings(pad->entity, &timings);
		if (ret < 0 ) {
			/* Delay dv_timings query in-case of failure */
			vlib_warn("Failed to query DV timings: %s\n", strerror(-ret));
			return VLIB_ERROR_HDMIRX_INVALID_STATE;
		}
	}

	/* Retrieve HDMI Rx pad format */
	ret = v4l2_subdev_get_format(pad->entity, &format, MEDIA_HDMI_PAD,
				     V4L2_SUBDEV_FORMAT_ACTIVE);
	ASSERT2(!(ret), "Failed to get HDMI Rx pad format: %s\n",
		strerror(-ret));
	fmt_code = v4l2_subdev_pixelcode_to_string(format.code);
	vlib_dbg("HDMI Rx source pad format: %s, %ux%u\n", fmt_code,
		 format.width, format.height);

	if (vdev->dev_type == HDMI_1) {
		/* Set Scaler resolution */
		if (vcap_hdmi_has_scaler(vdev)) {
			memset(fmt_str, 0, sizeof(fmt_str));
			media_set_fmt_str(fmt_str, MEDIA_SCALER_ENTITY, 0, fmt_code,
					timings.bt.width, timings.bt.height);

			width_in = timings.bt.width;
			height_in = timings.bt.height;

			ret = v4l2_subdev_parse_setup_formats(media, fmt_str);
			ASSERT2(!(ret), "Unable to setup formats: %s (%d)\n",
				strerror(-ret), -ret);

			memset(fmt_str, 0, sizeof(fmt_str));
			if (cfg->format == NV12) {
				media_set_fmt_str(fmt_str, MEDIA_SCALER_ENTITY, 1,
						MEDIA_SCALER_NV12_FMT_OUT,
						timings.bt.width,
						timings.bt.height);
			} else if (cfg->format == NV16) {
				media_set_fmt_str(fmt_str, MEDIA_SCALER_ENTITY, 1,
						MEDIA_SCALER_NV16_FMT_OUT,
						timings.bt.width,
						timings.bt.height);
			} else if (cfg->format == XV15) {
				media_set_fmt_str(fmt_str, MEDIA_SCALER_ENTITY, 1,
						MEDIA_SCALER_XV15_FMT_OUT,
						timings.bt.width,
						timings.bt.height);
			} else if (cfg->format == XV20) {
				media_set_fmt_str(fmt_str, MEDIA_SCALER_ENTITY, 1,
						MEDIA_SCALER_XV20_FMT_OUT,
						timings.bt.width,
						timings.bt.height);
			} else {
				vlib_dbg("HDMI Rx: Scaler: Invalid input format\n");
				return VLIB_ERROR_SET_FORMAT_FAILED;
			}

			ret = v4l2_subdev_parse_setup_formats(media, fmt_str);
			ASSERT2(!(ret), "Unable to setup formats: %s (%d)\n",
				strerror(-ret), -ret);
		}
	} else {
		/* Set HDMI-Dummy input resolution */
		memset(fmt_str, 0, sizeof (fmt_str));
		if (cfg->format == NV12) {
			media_set_fmt_str(fmt_str, media_hdmi_entity, 0, MEDIA_SCALER_NV12_FMT_OUT,
					width_in, height_in);
		} else if (cfg->format == NV16) {
			media_set_fmt_str(fmt_str, media_hdmi_entity, 0, MEDIA_SCALER_NV16_FMT_OUT,
					width_in, height_in);
		} else if (cfg->format == XV15) {
			media_set_fmt_str(fmt_str, media_hdmi_entity, 0, MEDIA_SCALER_XV15_FMT_OUT,
					width_in, height_in);
		} else if (cfg->format == XV20) {
			media_set_fmt_str(fmt_str, media_hdmi_entity, 0, MEDIA_SCALER_XV20_FMT_OUT,
					width_in, height_in);
		} else {
			vlib_dbg("HDMI-Rx Dummy: Invalid input format\n");
			return VLIB_ERROR_SET_FORMAT_FAILED;
		}
		ret = v4l2_subdev_parse_setup_formats(media, fmt_str);
		ASSERT2(!ret, "Unable to setup formats: %s (%d)\n", strerror(-ret),
			-ret);
	}

	return ret;
}

struct vlib_vdev *vcap_hdmi_init(const struct matchtable *mte, void *media)
{
	struct vlib_vdev *vd = calloc(1, sizeof(*vd));

	if (!vd) {
		return NULL;
	}

	struct vcap_hdmi_data *data = calloc(1, sizeof(*data));
	if (!data) {
		free(vd);
		return NULL;
	}

	if (VCAP_HDMI_HAS_SCALER) {
		data->flags |= VCAP_HDMI_FLAG_HAS_SCALER;
	}

	vd->vsrc_type = VSRC_TYPE_MEDIA;
	vd->mdev = media;
	vd->display_text = "HDMI Input";
	vd->entity_name = mte->s;
	vd->priv = data;

	if (strcmp(vd->entity_name, "vcap_hdmi output 0") == 0)
		vd->dev_type = HDMI_1;
	else if (strcmp(vd->entity_name, "vcap_hdmi_2 output 0") == 0)
		vd->dev_type = HDMI_2;
	else if (strcmp(vd->entity_name, "vcap_hdmi_3 output 0") == 0)
		vd->dev_type = HDMI_3;
	else if (strcmp(vd->entity_name, "vcap_hdmi_4 output 0") == 0)
		vd->dev_type = HDMI_4;
	else if (strcmp(vd->entity_name, "vcap_hdmi_5 output 0") == 0)
		vd->dev_type = HDMI_5;
	else if (strcmp(vd->entity_name, "vcap_hdmi_6 output 0") == 0)
		vd->dev_type = HDMI_6;
	else if (strcmp(vd->entity_name, "vcap_hdmi_7 output 0") == 0)
		vd->dev_type = HDMI_7;

	return vd;
}
