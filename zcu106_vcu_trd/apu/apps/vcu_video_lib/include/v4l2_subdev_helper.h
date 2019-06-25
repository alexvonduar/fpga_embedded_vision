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
#ifndef V4L2_HELPER_H
#define V4L2_HELPER_H

#include <linux/videodev2.h>
#include <xilinx-v4l2-controls.h>

#define DEV_NAME_LEN  32

/* A few useful defines to calculate the total blanking and frame sizes */
#define VCAP_BLANKING_WIDTH(t) \
        ((t)->hfrontporch + (t)->hsync + (t)->hbackporch)
#define VCAP_FRAME_WIDTH(t) \
        ((t)->width + V4L2_DV_BT_BLANKING_WIDTH(t))
#define VCAP_BLANKING_HEIGHT(t) \
        ((t)->vfrontporch + (t)->vsync + (t)->vbackporch + \
         (t)->il_vfrontporch + (t)->il_vsync + (t)->il_vbackporch)
#define VCAP_FRAME_HEIGHT(t) \
        ((t)->height + V4L2_DV_BT_BLANKING_HEIGHT(t))

#define DIV_ROUND_CLOSEST(x, divisor)(                  \
{                                                       \
        typeof(x) __x = x;                              \
        typeof(divisor) __d = divisor;                  \
        (((typeof(x))-1) > 0 ||                         \
         ((typeof(divisor))-1) > 0 || (__x) > 0) ?      \
                (((__x) + ((__d) / 2)) / (__d)) :       \
                (((__x) - ((__d) / 2)) / (__d));        \
}                                                       \
)

struct vlib_vdev;
/* Set subdevice control */
int v4l2_set_ctrl(const struct vlib_vdev *vsrc, char *name, int id, int value);

unsigned int vcap_get_fps(struct v4l2_bt_timings *t);
#endif /* V4L2_HELPER_H */
