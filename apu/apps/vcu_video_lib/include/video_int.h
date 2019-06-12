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
#ifndef VIDEO_INT_H
#define VIDEO_INT_H

#include "video.h"
#include "drm_helper.h"

#ifdef __cplusplus
extern "C"
{
#endif

#define RES_1080P_WIDTH 1920
#define RES_1080P_HEIGHT 1080
#define RES_4KP_WIDTH 3840
#define RES_4KP_HEIGHT 2160

struct drm_device drm;

/**
 * struct matchtable:
 * @s: String to match compatible items against
 * @init: Init function
 * @mte: Match table entry that matched @s.
 * @data: Custom data pointer.
 *	Return: struct vlib_vdev on success,
 *	NULL for unsupported/invalid input
 */
struct matchtable {
	char *s;
	struct vlib_vdev *(*init)(const struct matchtable *mte, void *data);
};

struct vlib_vdev {
	vlib_dev_type dev_type;
	const char *display_text;
	const char *entity_name;
	struct media_device *mdev;
	enum {
		VSRC_TYPE_INVALID,
		VSRC_TYPE_MEDIA,
	} vsrc_type;
	void *priv;
};

const char * video_get_devname(vlib_dev_type dev);
struct media_device * video_get_mdev(const struct vlib_vdev *vdev);

#ifdef DEBUG_MODE
#define INFO_MODE
#define WARN_MODE
#define ERROR_MODE
#define vlib_dbg(...) printf( __VA_ARGS__)
#else
#define vlib_dbg(...) do {} while(0)
#endif

#ifdef INFO_MODE
#define WARN_MODE
#define ERROR_MODE
#define vlib_info(...) printf( __VA_ARGS__)
#else
#define vlib_info(...) do {} while(0)
#endif

#ifdef WARN_MODE
#define ERROR_MODE
#define vlib_warn(...) printf( __VA_ARGS__)
#else
#define vlib_warn(...) do {} while(0)
#endif

#ifdef ERROR_MODE
#define vlib_err(...) printf( __VA_ARGS__)
#else
#define vlib_err(...) do {} while(0)
#endif

#ifdef __cplusplus
}
#endif
#endif /* VIDEO_INT_H */
