
#include <xil_types.h>
//#include <xiicps.h>
#include "init_camera.h"
int ar1335_write(XIIC *IicInstance,u16 addr,u16 data);
int ar1335_sensor_init(XIIC *IicInstance);
int ar1335_read_register(XIIC *IicInstance,u16 addr);
int ar1335_write_register(XIIC *IicInstance,u16 addr,u8 data);
int ar1335_write_read_register(XIIC *IicInstance,u16 addr,u8 data);
int ar1335_camera_sensor_init(XIIC *IicInstance);
