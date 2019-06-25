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

#ifndef INCLUDE_PCIE_ABSTRAINCLUDE_PCIE_SRC_C_CT_H_
#define INCLUDE_PCIE_ABSTRACT_H_

#include <assert.h>
#include <fcntl.h>
#include <getopt.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>

#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <unistd.h>
#define DEVICE_NAME "/dev/pciep0"
#define SIZE_DEFAULT 8388608

typedef struct enc_params {
    bool   enable_l2Cache;
    bool   low_bandwidth;
    bool   filler_data;
    unsigned int      bitrate;
    unsigned int      gop_len;
    unsigned int      b_frame;
    unsigned int      slice;
    unsigned int      qp_mode;
    unsigned int      rc_mode;
    unsigned int      enc_type;
    unsigned int      gop_mode;
    unsigned int      latency_mode;
} enc_params;


int pcie_open();

unsigned int pcie_get_file_length(int fpga_fd);

int pcie_get_enc_params(int fpga_fd, struct enc_params *params);

int pcie_read(int fpga_fd, int size, int offset, char *buff);

int pcie_write(int fpga_fd, int size, int offset, char *buff);

int pcie_set_read_transfer_done(int fpga_fd, int value);

int pcie_set_write_transfer_done(int fpga_fd, int value);

#endif //INCLUDE_PCIE_ABSTRACT_H_
