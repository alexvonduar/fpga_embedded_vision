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

#ifndef VCAP_CSI_H
#define VCAP_CSI_H

#ifdef __cplusplus
extern "C"
{
#endif

#define IMX274_TEST_PATTERN_CNT	13

struct vlib_vdev;

void gamma_set_blue_correction(const struct vlib_vdev *vd, unsigned int blue);
void gamma_set_green_correction(const struct vlib_vdev *vd, unsigned int green);
void gamma_set_red_correction(const struct vlib_vdev *vd, unsigned int red);

void csc_set_brightness(const struct vlib_vdev *vd, unsigned int bright);
void csc_set_contrast(const struct vlib_vdev *vd, unsigned int cont);
void csc_set_blue_gain(const struct vlib_vdev *vd, unsigned int blue);
void csc_set_green_gain(const struct vlib_vdev *vd, unsigned int green);
void csc_set_red_gain(const struct vlib_vdev *vd, unsigned int red);

void imx274_set_exposure(const struct vlib_vdev *vd, unsigned int exp);
void imx274_set_gain(const struct vlib_vdev *vd, unsigned int gn);
void imx274_set_vertical_flip(const struct vlib_vdev *vd, unsigned int vflip);
void imx274_set_test_pattern(const struct vlib_vdev *vd, unsigned int tp);
int imx274_set_frame_interval(const struct vlib_vdev *vdev, unsigned int fps);
const char *imx274_get_test_pattern_name(unsigned int idx);

int vcap_csi_set_config(const struct vlib_vdev *vd);

#ifdef __cplusplus
}
#endif

#endif /* VCAP_CSI_H */
