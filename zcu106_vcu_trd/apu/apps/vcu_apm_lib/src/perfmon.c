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

#include <perfapm.h>
#include "uio_perfmon.h"

#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

pthread_t perf_count_thread;
static volatile unsigned long vcu_apm_counter[4][2];

static void *thread_perf_counter(void* temp) {

	uPerfMon_Enable();
	while (1) {

		/* Create pthread cancellation point */
		pthread_testcancel();
		if (uPerfMon_Check_SIC_Overflow_Mask()) {
			vcu_apm_counter[E_APM0][E_READ_BYTE_CNT] = uPerfMon_getCounterValue(E_APM0, E_READ_BYTE_CNT);
			vcu_apm_counter[E_APM0][E_WRITE_BYTE_CNT] = uPerfMon_getCounterValue( E_APM0, E_WRITE_BYTE_CNT);
			vcu_apm_counter[E_APM1][E_READ_BYTE_CNT] = uPerfMon_getCounterValue(E_APM1, E_READ_BYTE_CNT);
			vcu_apm_counter[E_APM1][E_WRITE_BYTE_CNT] = uPerfMon_getCounterValue(E_APM1, E_WRITE_BYTE_CNT);
			vcu_apm_counter[E_APM2][E_READ_BYTE_CNT] = uPerfMon_getCounterValue(E_APM2, E_READ_BYTE_CNT);
			vcu_apm_counter[E_APM2][E_WRITE_BYTE_CNT] = uPerfMon_getCounterValue(E_APM2, E_WRITE_BYTE_CNT);

			vcu_apm_counter[E_APM3][E_READ_BYTE_CNT] = uPerfMon_getCounterValue(E_APM3, E_READ_BYTE_CNT);
			vcu_apm_counter[E_APM3][E_WRITE_BYTE_CNT] = uPerfMon_getCounterValue(E_APM3, E_WRITE_BYTE_CNT);
		}
		usleep(POLL_INTERVAL);
	}

	uPerfMon_Disable();
	pthread_exit(NULL);

	return NULL;
}

int perf_monitor_init() {
	int ret = 0;

	ret = uPerfMon_Init();
	if (ret) {
		printf("perf_monitor [error] Initialization failed \n");
		return EXIT_FAIL;
	}

	// spawn a thread to throw out performance numbers
	ret = pthread_create(&perf_count_thread, NULL, &thread_perf_counter, NULL);
	if (ret) {
		printf("perf_monitor [error] pthread_create failed %d\n", ret);
		return EXIT_FAIL;
	}

	return EXIT_SUCCESS;
}

int perf_monitor_deinit(void) {
	int ret = 0;

	ret = pthread_cancel(perf_count_thread);
	ret = pthread_join(perf_count_thread, NULL);

#ifdef DEBUG_MODE
	printf("perf_monitor [info] pthread_join %d \n",ret);
#endif

	return ret;
}

unsigned long perf_monitor_get_rd_wr_cnt(enum Perf_APM port) {
	unsigned long rd,wr,rd_wr_count;

	switch (port) {
	case E_APM0:
		rd = vcu_apm_counter[E_APM0][E_READ_BYTE_CNT];
		wr = vcu_apm_counter[E_APM0][E_WRITE_BYTE_CNT];
		break;
	case E_APM1:
		rd = vcu_apm_counter[E_APM1][E_READ_BYTE_CNT];
		wr = vcu_apm_counter[E_APM1][E_WRITE_BYTE_CNT];
		break;
	case E_APM2:
		rd = vcu_apm_counter[E_APM2][E_READ_BYTE_CNT];
		wr = vcu_apm_counter[E_APM2][E_WRITE_BYTE_CNT];
		break;
	case E_APM3:
		rd = vcu_apm_counter[E_APM3][E_READ_BYTE_CNT];
		wr = vcu_apm_counter[E_APM3][E_WRITE_BYTE_CNT];
		break;

	default:
		return EXIT_FAIL;
	}
	rd_wr_count = rd + wr;
	/* Convert beats to bytes transferred */
	return rd_wr_count = rd_wr_count * 16;
}
