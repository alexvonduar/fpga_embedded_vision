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

#include <pcie_abstract.h>

#define GET_FILE_LENGTH           0x0
#define GET_ENC_PARAMS            0x1
#define SET_READ_OFFSET           0x2
#define SET_WRITE_OFFSET          0x3
#define SET_READ_TRANSFER_DONE    0x5
#define CLR_READ_TRANSFER_DONE    0x6
#define SET_WRITE_TRANSFER_DONE   0x7
#define CLR_WRITE_TRANSFER_DONE   0x8

int pcie_open()
{
    int fpga_fd;

    fpga_fd = open(DEVICE_NAME, O_RDWR);
    if (fpga_fd < 0) {
        printf("unable to open device %d.\n", fpga_fd);
        return -EINVAL;
    }

    return fpga_fd;
}

unsigned int pcie_get_file_length(int fpga_fd)
{
    unsigned int file_length;
    int ret;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_FILE_LENGTH, &file_length);
        if (ret < 0)
            printf("unable to run ioctl for file_length.\n");
        else
            printf("file_length is %u.\n", file_length);
    }
    return file_length;

}

int pcie_get_enc_params(int fpga_fd, struct enc_params *params )
{
    int ret = 0 ;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, GET_ENC_PARAMS, params);
        if (ret < 0)
            printf("unable to run ioctl for encoder params.\n");
    }
    return ret;

}

int pcie_set_read_transfer_done(int fpga_fd, int value)
{
    int ret = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, SET_READ_TRANSFER_DONE, &value);
        if (ret < 0) {
            printf("unable to run ioctl for read transfer done.\n");
            return ret;
        }
        else {
            printf("successfully set read transfer done\n");
            return ret;
        }
    }
    return ret;
}

int pcie_set_write_transfer_done(int fpga_fd, int value)
{
    int ret = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, SET_WRITE_TRANSFER_DONE, &value);
        if (ret < 0) {
            printf("unable to run ioctl for write transfer done.\n");
            return ret;
        }
        else {
            printf("successfully set write transfer done\n");
            return ret;
        }
    }
    return ret;
}

int pcie_clr_read_transfer_done(int fpga_fd, int value)
{
    int ret = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, CLR_READ_TRANSFER_DONE, &value);
        if (ret < 0) {
            printf("unable to run ioctl for read transfer done.\n");
            return ret;
        }
        else {
            printf("successfully set read transfer done\n");
            return ret;
        }
    }
    return ret;
}

int pcie_clr_write_transfer_done(int fpga_fd, int value)
{
    int ret = 0;

    if (fpga_fd > 0) {
        ret = ioctl(fpga_fd, CLR_WRITE_TRANSFER_DONE, &value);
        if (ret < 0) {
            printf("unable to run ioctl for write transfer done.\n");
            return ret;
        }
        else {
            printf("successfully set write transfer done\n");
            return ret;
        }
    }
    return ret;
}


int pcie_read(int fpga_fd, int size, int offset, char *buff)
{
    long int rc = 0;

    if (fpga_fd >= 0) {
        if (offset) {
            rc = lseek(fpga_fd, offset, SEEK_SET);
            if (rc != offset) {
                printf("seek off 0x%lx != 0x%x.\n",rc, offset);
                return -EIO;
            }
        }
        rc = read(fpga_fd, buff, size);
        if (rc < 0) {
            printf("read size = 0x%lx 0x%lx 0x%x 0x%x.\n",rc, rc, size, size);
                perror("read file");
            return -EIO;
        }

    }

    return rc;
}

int pcie_write(int fpga_fd, int size, int offset, char *buff)
{
    long int rc = 0;


    if (fpga_fd >= 0) {
        rc = write(fpga_fd, buff, size);
        if (rc < 0) {
            printf("write size = 0x%lx 0x%lx 0x%x 0x%x.\n",rc, rc, size, size);
            perror("write file");
            return -EIO;
        }
    }
    return rc;
}

void pcie_close(int fpga_fd)
{
    close(fpga_fd);
}
