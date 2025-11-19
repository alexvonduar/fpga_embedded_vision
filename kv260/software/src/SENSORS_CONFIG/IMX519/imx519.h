#ifndef __IMX519_H__
#define __IMX519_H__
#include <xil_types.h>
//#include <xiicps.h>
#include "init_camera.h"
int imx519_write(XIIC *IicInstance,u16 addr,u8 data);
int imx519_sensor_init(XIIC *IicInstance,u16 config_number);
int imx519_read_register(XIIC *IicInstance,u16 addr);
int imx519_write_register(XIIC *IicInstance,u16 addr,u8 data);
int imx519_write_read_register(XIIC *IicInstance,u16 addr,u8 data);
#endif
