#ifndef __I2C_TRANSECTIONS_H__
#define __I2C_TRANSECTIONS_H__
#include "xil_types.h"
#include "xiicps.h"
int i2c_reg8_write(XIicPs *InstancePtr, char IIC_ADDR, char Addr, char Data);
char i2c_reg8_read(XIicPs *InstancePtr, u16 IIC_ADDR, char Addr);
int i2c_reg16_write(XIicPs *InstancePtr, u16 IIC_ADDR, unsigned short Addr, char Data);
char i2c_reg16_read(XIicPs *InstancePtr, u16 IIC_ADDR, unsigned short Addr);
int i2c_init(XIicPs *Iic,short DeviceID ,u32 IIC_SCLK_RATE);
int i2c_reg16_write2bytes(XIicPs *InstancePtr, u16 IIC_ADDR, unsigned short Addr, unsigned short Data);
#endif
