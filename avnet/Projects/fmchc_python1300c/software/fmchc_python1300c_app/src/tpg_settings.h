// SPDX-License-Identifier: GPL-2.0
/*
 * app_hdmi.h
 *
 *  Created on: 07 Jan 2019
 *      Author: florentw
 */

#ifndef TPG_SETTINGS_H_
#define TPG_SETTINGS_H_

#include "xv_tpg.h"
//#include "xclk_wiz.h"
//#include "xvtc.h"
	
void tpg_set(XV_tpg *InstancePtr, u32 height, u32 width, u32 colorFormat, u32 bckgndId);
void tpg_set_box(XV_tpg *InstancePtr, u32 boxSize, u32 motionSpeed);

#endif /* TPG_SETTINGS_H_ */
