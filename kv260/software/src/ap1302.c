/*
FILENAME: imx219.c
AUTHOR: Greg Taylor     CREATION DATE: 12 Aug 2019

DESCRIPTION:

CHANGE HISTORY:
12 Aug 2019		Greg Taylor
	Initial version

MIT License

Copyright (c) 2019 Greg Taylor <gtaylor@sonic.net>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */
#include "sleep.h"
#include "platform.h"
//#include "xgpiops.h"
#include "xiicps.h"
#include "ap1302.h"
#include "parameters.h"
#include "xgpiops.h"

static XGpioPs gpio;
static XIicPs iic;

static int ap1302_detect_chip()
{
	unsigned int version;
	unsigned int revision;

	if (ap1302_read(AP1302_CHIP_VERSION, &version) != XST_SUCCESS) {
		return XST_FAILURE;
	}


	if (ap1302_read(AP1302_CHIP_REV, &revision) != XST_SUCCESS) {
		return XST_FAILURE;
	}

	if (version != AP1302_CHIP_ID) {
		xil_printf("Invalid chip version, expected 0x%04x, got 0x%04x\r\n", AP1302_CHIP_ID, version);
		return XST_FAILURE;
	}

	xil_printf("AP1302 revision %u.%u.%u detected\r\n",
		 (revision & 0xf000) >> 12, (revision & 0x0f00) >> 8,
		 revision & 0x00ff);

	return XST_SUCCESS;
}

int ap1302_init() {
	XGpioPs_Config *gpio_config;
	XIicPs_Config *iic_config;
	u8 bit_mask;
	u8 i2c_expander_slave_addr;
	u8 i2c_expander_control_bitmask;
	u8 addr[2];
	u8 camera_model_id[2];

	/*
	 * For KV260, IMX219 power supply is enabled by FPGA pin tied high,
	 * i2c expander reset_b is tied high on board
	 */
#if !defined(SDT)
    gpio_config = XGpioPs_LookupConfig(XPAR_PSU_GPIO_0_DEVICE_ID);
#else
    gpio_config = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_BASEADDR);
#endif
	if (gpio_config == NULL) {
		xil_printf("XGpioPs_LookupConfig() failed\r\n");
		return XST_FAILURE;
	}
	if (XGpioPs_CfgInitialize(&gpio, gpio_config, gpio_config->BaseAddr) != XST_SUCCESS) {
		xil_printf("XGpioPs_CfgInitialize() failed\r\n");
		return XST_FAILURE;
	}

	if (XGpioPs_SelfTest(&gpio) != XST_SUCCESS) {
		xil_printf("XGpio_Selftest() failed\r\n");
		return XST_FAILURE;
	}

	XGpioPs_SetDirectionPin(&gpio, 0, 1);
    XGpioPs_SetOutputEnablePin(&gpio, 0, 1);
    XGpioPs_WritePin(&gpio, 0, 1);
    usleep(100000);
    XGpioPs_WritePin(&gpio, 0, 0);
    usleep(100000);

#if !defined(SDT)
	iic_config = XIicPs_LookupConfig(XPAR_PSU_I2C_1_DEVICE_ID);
#else
	iic_config = XIicPs_LookupConfig(XPAR_XIICPS_0_BASEADDR);
#endif
	if (iic_config == NULL) {
		xil_printf("XIicPs_LookupConfig() failed\r\n");
		return XST_FAILURE;
	}
	if (XIicPs_CfgInitialize(&iic, iic_config, iic_config->BaseAddress) != XST_SUCCESS) {
		xil_printf("XIicPs_CfgInitialize() failed\r\n");
		return XST_FAILURE;
	}

	if (XIicPs_SelfTest(&iic) != XST_SUCCESS) {
		xil_printf("XIicPs_SelfTest() failed\r\n");
		return XST_FAILURE;
	}

	if (XIicPs_SetSClk(&iic, I2C_BUS_FREQ) != XST_SUCCESS) {
		xil_printf("XIicPs_SetSClk failed\r\n");
		return XST_FAILURE;
	}

	i2c_expander_slave_addr = KV260_I2C_EXPANDER_SLAVE_ADDR;
	i2c_expander_control_bitmask = KV260_I2C_EXPANDER_AP1302_BIT_MASK;

	// Read i2c expander chip control reg
	if (XIicPs_MasterRecvPolled(&iic, &bit_mask, 1, i2c_expander_slave_addr) != XST_SUCCESS) {
		xil_printf("i2c expander receive failed\r\n");
		return XST_FAILURE;
	}
	usleep(1000); // chip needs some delay for some reason
	bit_mask |= i2c_expander_control_bitmask;
	if (XIicPs_MasterSendPolled(&iic, &bit_mask, 1, i2c_expander_slave_addr) != XST_SUCCESS) {
		xil_printf("i2c expander send failed\r\n");
		return XST_FAILURE;
	}

    if (ap1302_detect_chip() != XST_SUCCESS) {
    	return XST_FAILURE;
    }

	return XST_SUCCESS;
}

int ap1302_write(u32 reg, u8 data) {
	u8 buf[3];
	unsigned int size = AP1302_REG_SIZE(reg);
	u16 addr = AP1302_REG_ADDR(reg);

	buf[0] = addr >> 8;
	buf[1] = addr & 0xff;
	buf[2] = data;

	while (TransmitFifoFill(&iic) || XIicPs_BusIsBusy(&iic)) { //while (XIicPs_BusIsBusy(&iic)) {
		usleep(1);
		xil_printf("waiting for transmit...\r\n");
	}

	if (XIicPs_MasterSendPolled(&iic, buf, 3, AP1302_I2C_SLAVE_ADDR) != XST_SUCCESS) {
		xil_printf("ap1302 write failed, addr: %x\r\n", addr);
		return XST_FAILURE;
	}
	usleep(1000);

	return XST_SUCCESS;
}

int ap1302_read(u32 reg, u8 *data) {
	unsigned int size = AP1302_REG_SIZE(reg);
	u16 addr = AP1302_REG_ADDR(reg);
	xil_printf("reg %04x size %d\r\n", addr, size);
	u8 buf[2];

	buf[0] = addr >> 8;
	buf[1] = addr & 0xff;

	if (XIicPs_MasterSendPolled(&iic, buf, 2, AP1302_I2C_SLAVE_ADDR) != XST_SUCCESS) {
		xil_printf("ap1302 write failed\r\n");
		return XST_FAILURE;
	}
	if (XIicPs_MasterRecvPolled(&iic, data, 1, AP1302_I2C_SLAVE_ADDR) != XST_SUCCESS) {
		xil_printf("ap1302 receive failed\r\n");
		return XST_FAILURE;
	}
	return XST_SUCCESS;
}

