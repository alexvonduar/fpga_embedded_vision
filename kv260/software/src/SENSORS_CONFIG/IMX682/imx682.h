
#include <xil_types.h>
//#include <xiicps.h>
#include "init_camera.h"
int imx682_write(XIIC *IicInstance,u16 addr,u8 data);
int imx682_sensor_init(XIIC *IicInstance,u16 config_number);
int imx682_read_register(XIIC *IicInstance,u16 addr);
int imx682_write_register(XIIC *IicInstance,u16 addr,u8 data);
int imx682_write_read_register(XIIC *IicInstance,u16 addr,u8 data);
int imx682_config1(XIIC *IicInstance);
