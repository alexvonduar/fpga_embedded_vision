#ifndef __IMX477_H__
#define __IMX477_H__
#include <xil_types.h>
//#include <xiicps.h>
#include "init_camera.h"
int imx477_write(XIIC *IicInstance,u16 addr,u8 data);
int imx477_sensor_init(XIIC *IicInstance,u16 config_number);
int imx477_read_register(XIIC *IicInstance,u16 addr);
int imx477_write_register(XIIC *IicInstance,u16 addr,u8 data);
int imx477_write_read_register(XIIC *IicInstance,u16 addr,u8 data);
#endif
