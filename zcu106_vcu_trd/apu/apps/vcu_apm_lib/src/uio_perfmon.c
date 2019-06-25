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

#include <assert.h>
#include <unistd.h>
#include <stdio.h>
#include "uio_common.h"
#include "uio_perfmon.h"
#include "uio_perfmon_hw.h"

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

static uio_info uPMonInfo;

/****************************************************************************/
/**
 *
 * This function sets the Sample Interval Register
 *
 * @param	InstancePtr is a pointer to the XAxiPmon instance.
 * @param	SampleIntervalHigh is the Sample Interval Register higher
 *		32 bits.
 * @param	SampleIntervalLow is the Sample Interval Register lower
 *		32 bits.
 *
 * @return	None
 *
 * @note		None.
 *
 *****************************************************************************/
void XVCUPmon_SetSampleInterval(const uio_handle *InstancePtr,
		u32 SampleInterval) {

	/*
	 * Assert the arguments.
	 */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/*
	 * Set Sample Interval
	 */
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM0_TIMER, SampleInterval);
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM1_TIMER, SampleInterval);
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM2_TIMER, SampleInterval);
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM3_TIMER, SampleInterval);

}

void XVCUPmon_SetCfg(const uio_handle *InstancePtr, u32 cfg) {

	/*
	 * Assert the arguments.
	 */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/*
	 * Set Sample Interval
	 */
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM0_CFG, cfg);
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM1_CFG, cfg);
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM2_CFG, cfg);
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM3_CFG, cfg);

	/* Controls APM timing window completion interrupt */
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM_INT_GBL_CNTL, 0x0);
}

void XVCUPmon_SetTrg(const uio_handle *InstancePtr, u32 mode) {

	/*
	 * Assert the arguments.
	 */
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	/*
	 * Set Sample Interval
	 */
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM0_TRG, mode);
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM1_TRG, mode);
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM2_TRG, mode);
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,
			APM3_TRG, mode);

}

u32 XVCUPmon_GetInterruptStatus(const uio_handle *InstancePtr) {
	/*
	 * Assert the arguments.
	 */
	u32 RegValue;
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);
	RegValue = XVCUPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,APM_ISR);
	XVCUPmon_WriteReg(InstancePtr->Control_bus_BaseAddress,APM_ISR, RegValue);
	return RegValue;
}

u32 XVCUPmon_GetSampleCounter(const uio_handle *InstancePtr, u32 apm,
		u32 read_write) {

	/*
	 * Assert the arguments.
	 */
	u32 RegValue;
	int result_offset = 0;
	int offset = 0;
	Xil_AssertVoid(InstancePtr != NULL);
	Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

	if (read_write)
		result_offset = 4;

	offset = APM0_RESULT2 + (APM0_CFG * apm) + result_offset;
	RegValue = XVCUPmon_ReadReg(InstancePtr->Control_bus_BaseAddress,offset);

	return RegValue;
}
/*-------------------------------------- interface-------------------------------*/

u32 uPerfMon_Check_SIC_Overflow_Mask() {
	u32 reg = 0;
	uio_handle pmon_handle;

	assert(uPMonInfo.isInitialized == XIL_COMPONENT_IS_READY);
	uio_get_Handler(&uPMonInfo, &pmon_handle, MAP_CNT);
	assert(pmon_handle.IsReady == XIL_COMPONENT_IS_READY);
	if (XVCUPmon_GetInterruptStatus(&pmon_handle) & 0x1)
		reg = 1;

	uio_release_handle(&uPMonInfo, &pmon_handle, MAP_CNT);
	return reg;

}

unsigned long uPerfMon_getCounterValue(int apm, int read_write) {
	uio_handle pmon_handle;
	unsigned long perfCount = 0;

	assert(uPMonInfo.isInitialized == XIL_COMPONENT_IS_READY);
	uio_get_Handler(&uPMonInfo, &pmon_handle, MAP_CNT);

	perfCount = XVCUPmon_GetSampleCounter(&pmon_handle, apm, read_write);
	uio_release_handle(&uPMonInfo, &pmon_handle, MAP_CNT);
	return perfCount;
}

int uPerfMon_Init() {
	uio_handle pmon_handle;

	int ret = uio_Initialize(&uPMonInfo, APM_INSTANCE_NAME);
	if (ret == XST_DEVICE_NOT_FOUND)
		return ret;

	assert(uPMonInfo.isInitialized == XIL_COMPONENT_IS_READY);
	uio_get_Handler(&uPMonInfo, &pmon_handle, MAP_CNT);
	assert(pmon_handle.IsReady == XIL_COMPONENT_IS_READY);

	XVCUPmon_SetSampleInterval(&pmon_handle, APM_SAMPLE_VALUE); // Equals 1 second

	XVCUPmon_SetCfg(&pmon_handle, APM_MODE);

	uio_release_handle(&uPMonInfo, &pmon_handle, MAP_CNT);

	return ret;
}

void uPerfMon_Enable() {
	uio_handle pmon_handle;

	assert(uPMonInfo.isInitialized == XIL_COMPONENT_IS_READY);
	uio_get_Handler(&uPMonInfo, &pmon_handle, MAP_CNT);
	assert(pmon_handle.IsReady == XIL_COMPONENT_IS_READY);

	XVCUPmon_SetTrg(&pmon_handle, 0x1);
	uio_release_handle(&uPMonInfo, &pmon_handle, MAP_CNT);
}

void uPerfMon_Disable() {
	uio_handle pmon_handle;

	assert(uPMonInfo.isInitialized == XIL_COMPONENT_IS_READY);
	uio_get_Handler(&uPMonInfo, &pmon_handle, MAP_CNT);
	assert(pmon_handle.IsReady == XIL_COMPONENT_IS_READY);
	XVCUPmon_SetTrg(&pmon_handle, 0x0);

	uio_release_handle(&uPMonInfo, &pmon_handle, MAP_CNT);
}
