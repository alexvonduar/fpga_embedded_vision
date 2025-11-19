#ifndef __I2C_TRANSECTIONS_H__
#define __I2C_TRANSECTIONS_H__
#include "xil_types.h"
#include "init_camera.h"
//#include "xiicps.h"
int scan_read(XIIC *IicInstance,u16 addr,u8 *read_buf,u16 scan_addr);
int i2c_reg8_write(XIIC *InstancePtr, char IIC_ADDR, char Addr, char Data);
char i2c_reg8_read(XIIC *InstancePtr, u16 IIC_ADDR, char Addr);
int i2c_reg16_write(XIIC *InstancePtr, u16 IIC_ADDR, unsigned short Addr, char Data);
char i2c_reg16_read(XIIC *InstancePtr, u16 IIC_ADDR, unsigned short Addr);
u16 i2c_reg16_2read(XIIC *InstancePtr, u16 IIC_ADDR, unsigned short Addr);
#if !defined(SDT)
int i2c_init(XIIC *Iic,short DeviceID ,u32 IIC_SCLK_RATE);
#else
int i2c_init(XIIC *Iic, UINTPTR DeviceID, u32 IIC_SCLK_RATE);
#endif
int i2c_reg16_write2bytes(XIIC *InstancePtr, u16 IIC_ADDR, unsigned short Addr, unsigned short Data);
#endif
