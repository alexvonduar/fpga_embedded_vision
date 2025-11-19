
#include <xil_types.h>
//#include <xiicps.h>
#include "init_camera.h"
int imx219_write(XIIC *IicInstance,u16 addr,u8 data);
int imx219_sensor_init(XIIC *IicInstance);
int imx219_read_register(XIIC *IicInstance,u16 addr);
int imx219_write_register(XIIC *IicInstance,u16 addr,u8 data);
int imx219_write_read_register(XIIC *IicInstance,u16 addr,u8 data);
int imx219_camera_sensor_init(XIIC *IicInstance);

