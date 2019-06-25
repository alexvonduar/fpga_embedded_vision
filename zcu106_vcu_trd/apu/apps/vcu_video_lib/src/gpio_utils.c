/******************************************************************************
 * (c) Copyright 2012-2019 Xilinx, Inc. All rights reserved.
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

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include "gpio_utils.h"
#include "video.h"

#define GPIO_DIR_IN         0
#define GPIO_DIR_OUT        1

int gpio_export(unsigned int gpio)
{
	int fd, len, ret2, ret = 0;
	char buf[11];

	fd = open("/sys/class/gpio/export", O_WRONLY);
	if (fd < 0) {
		perror("gpio/export");
		return fd;
	}

	len = snprintf(buf, sizeof(buf), "%d", gpio);
	ret2 = write(fd, buf, len);
	if (ret2 != len) {
		ret = VLIB_ERROR_FILE_IO;
	}

	close(fd);

	return ret;
}

int gpio_unexport(unsigned int gpio)
{
	int fd, len, ret2, ret = 0;
	char buf[11];

	fd = open("/sys/class/gpio/unexport", O_WRONLY);
	if (fd < 0) {
		perror("gpio/unexport");
		return fd;
	}

	len = snprintf(buf, sizeof(buf), "%d", gpio);
	ret2 = write(fd, buf, len);
	if (ret2 != len) {
		ret = VLIB_ERROR_FILE_IO;
	}

	close(fd);

	return ret;
}

static int gpio_dir(unsigned int gpio, unsigned int dir)
{
	int fd, len, ret2, ret = 0;
	char buf[60];
	const char *dir_s;

	len = snprintf(buf, sizeof(buf), "/sys/class/gpio/gpio%d/direction",
		       gpio);

	if (len > 60)
		perror("\n***Filename too long in gpio_dir function\n");

	fd = open(buf, O_WRONLY);
	if (fd < 0) {
		perror("gpio/direction");
		return fd;
	}

	if (dir == GPIO_DIR_OUT) {
		dir_s = "out";
	} else {
		dir_s = "in";
	}

	len = strlen(dir_s);
	ret2 = write(fd, dir_s, len);
	if (ret2 != len) {
		ret = VLIB_ERROR_FILE_IO;
	}

	close(fd);

	return ret;
}

int gpio_dir_out(unsigned int gpio)
{
	return gpio_dir(gpio, GPIO_DIR_OUT);
}

int gpio_dir_in(unsigned int gpio)
{
	return gpio_dir(gpio, GPIO_DIR_IN);
}

int gpio_value(unsigned int gpio, unsigned int value)
{
	int fd, len, ret2, ret = 0;
	char buf[60];
	const char *val_s;

	len = snprintf(buf, sizeof(buf), "/sys/class/gpio/gpio%d/value", gpio);

	if (len > 60)
		perror("\n***Filename too long in gpio_dir function\n");

	fd = open(buf, O_WRONLY);
	if (fd < 0) {
		perror("gpio/value");
		return fd;
	}

	if (value) {
		val_s = "1";
	} else {
		val_s = "0";
	}

	len = strlen(val_s);
	ret2 = write(fd, val_s, len);
	if (ret2 != len) {
		ret = VLIB_ERROR_FILE_IO;
	}

	close(fd);

	return ret;
}

static int gpio_active_low(unsigned int gpio, unsigned int act_low)
{
	int fd, len, ret2, ret = 0;
	char buf[60];
	const char *val_s;

	len = snprintf(buf, sizeof(buf), "/sys/class/gpio/gpio%d/active_low",
		       gpio);

	if (len > 60)
		perror("\n***Filename too long in gpio_dir function\n");

	fd = open(buf, O_WRONLY);
	if (fd < 0) {
		perror("gpio/active_low");
		return fd;
	}

	if (act_low) {
		val_s = "1";
	} else {
		val_s = "0";
	}

	len = strlen(val_s);
	ret2 = write(fd, val_s, len);
	if (ret2 != len) {
		ret = VLIB_ERROR_FILE_IO;
	}

	close(fd);

	return ret;
}

int gpio_act_low(unsigned int gpio)
{
	return gpio_active_low(gpio, 1);
}

int gpio_act_high(unsigned int gpio)
{
	return gpio_active_low(gpio, 0);
}
