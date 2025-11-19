#if !defined _INIT_CAMERA_H_
#define _INIT_CAMERA_H_

#include "xil_types.h"
#if defined(OPSERO)
#include <xiic.h>
#define USING_FMC_CAM_AXI_IIC
#define XIIC XIic
#define XIIC_Config XIic_Config
#define XIIC_LookupConfig XIic_LookupConfig
#define XIIC_CfgInitialize XIic_CfgInitialize
#define XIIC_SelfTest XIic_SelfTest
//#define XIIC_SetSClk XIic_SetSClk
//#define XIIC_MasterSendPolled XIic_MasterSendPolled
//#define XIIC_MasterRecvPolled XIic_MasterRecvPolled
//#define XIIC_BusIsBusy XIic_BusIsBusy
#else
#include <xiicps.h>
#define XIIC XIicPs
#define XIIC_Config XIicPs_Config
#define XIIC_LookupConfig XIicPs_LookupConfig
#define XIIC_CfgInitialize XIicPs_CfgInitialize
#define XIIC_SelfTest XIicPs_SelfTest
#define XIIC_SetSClk XIicPs_SetSClk
#define XIIC_MasterSendPolled XIicPs_MasterSendPolled
#define XIIC_MasterRecvPolled XIicPs_MasterRecvPolled
#define XIIC_BusIsBusy XIicPs_BusIsBusy
#endif
struct reginfo
{
    u16 reg;
    u8 val;
};
struct reg2info
{
    u16 reg;
    u16 val;
};
#define SEQUENCE_INIT        0x00
#define SEQUENCE_NORMAL      0x01
#define SEQUENCE_PROPERTY    0xFFFD
#define SEQUENCE_WAIT_MS     0xFFFE
#define SEQUENCE_END	     0xFFFF
int init_camera();
void read_imx477_reg(u16 addr);
void write_imx477_reg(u16 addr,u8 data);
void read_imx519_reg(u16 addr);
void write_imx519_reg(u16 addr,u8 data);
void read_imx219_reg(u16 addr);
void write_imx219_reg(u16 addr,u8 data);
int scan_sensor1(XIIC *IicInstance);
int scan_sensor2(XIIC *IicInstance);
int scan_sensor3(XIIC *IicInstance);

#endif//_INIT_CAMERA_H_
