/*
   MODIFICATION HISTORY:
   
   Ver   Who Date     Changes
   ----- -------- -------- -----------------------------------------------
   1.0	 Sakinder 06/01/22 Initial Release
   1.2   Sakinder 06/08/22 Added IMX219 Camera functions.
   1.3   Sakinder 06/14/22 Added IMX477 Camera functions.
   1.4   Sakinder 07/01/22 Added IMX519 Camera functions.
   1.5   Sakinder 07/06/22 Added IMX682 Camera functions.
   -----------------------------------------------------------------------
*/
#include <xiicps.h>
#include <xil_printf.h>
#include <xil_types.h>
#include <xstatus.h>
#include <stdio.h>
#include "I2c_transections.h"
#include "IMX219/imx219.h"
#include "IMX519/imx519.h"
#include "IMX682/imx682.h"
#include "IMX477/imx477.h"
#include "OV5640/ov5640.h"
#include "OV5647/ov5647.h"
#include "init_camera.h"
#include "parameters.h"
XIicPs iic_cam;
#define IIC_DEVICEID        XPAR_XIICPS_0_DEVICE_ID
#define IIC_SCLK_RATE		100000
#define SW_IIC_ADDR         0x74
u8 SendBuffer [10];

int init_camera()
{

	XIicPs_Config *iic_conf;
	int Status;
	iic_conf = XIicPs_LookupConfig(IIC_DEVICEID);
	XIicPs_CfgInitialize(&iic_cam,iic_conf,iic_conf->BaseAddress);
	XIicPs_SetSClk(&iic_cam, IIC_SCLK_RATE);
    i2c_init(&iic_cam, IIC_DEVICEID,IIC_SCLK_RATE);
    SendBuffer[0]= 0x02;
    Status = XIicPs_MasterSendPolled(&iic_cam, SendBuffer, 1, SW_IIC_ADDR);
  	if (Status != XST_SUCCESS) {
  		print("TCA9546 switch channel to IAS1 Failed\n\r");
  		return XST_FAILURE;
  	}
    Status = ar1335_camera_sensor_init(&iic_cam);
    if (Status == 153) {
  		//print("AR1335 Sensor Is Connected\n\r");
  		//return 153;
  	}
    SendBuffer[0]= 0x04;
    Status = XIicPs_MasterSendPolled(&iic_cam, SendBuffer, 1, SW_IIC_ADDR);
  	if (Status != XST_SUCCESS) {
  		print("I2C Write Error\n\r");
  		return XST_FAILURE;
  	}
    Status = imx519_sensor_init(&iic_cam,0);
  	if (Status == 519) {
  		return 519;
  	}
    Status = imx682_sensor_init(&iic_cam,1);
  	if (Status == 682) {
  		return 682;
  	}
    Status = imx219_camera_sensor_init(&iic_cam);
  	if (Status == 219) {
  		return 219;
  	}
    Status = ov5640_camera_sensor_init(&iic_cam);
  	if (Status != XST_SUCCESS) {
  		print("OV5640 Camera Sensor Not connected\n\r");
  	}
#if defined(VIDEO_MODE) && (VIDEO_MODE == VM_4K)
  	Status = imx477_sensor_init(&iic_cam,14);
#else
	Status = imx477_sensor_init(&iic_cam,3);
#endif
  	if (Status == 477) {
  		return 477;
  	}
    Status = ov5647_camera_sensor_init(&iic_cam);
  	if (Status != XST_SUCCESS) {
  		print("OV5647 Camera Sensor Not connected\n\r");
  	}
    return 0;
}
void read_imx477_reg(u16 addr)
{
	int Status;
	print("IMX477 Camera\n\r");
    Status = imx477_sensor_init(&iic_cam,addr);
  	if (Status != 477) {
  		print("IMX477 Camera Sensor Not connected\n\r");
  	}
}
void write_imx477_reg(u16 addr,u8 data)
{
	int Status;
	print("IMX477 Camera\n\r");
    Status = imx477_write_read_register(&iic_cam,addr,data);
  	if (Status != XST_SUCCESS) {
  		print("IMX477 Camera Sensor Not connected\n\r");
  	}
}
void read_imx519_reg(u16 addr)
{
	int Status;
	print("IMX519 Camera\n\r");
    Status = imx519_sensor_init(&iic_cam,addr);
  	if (Status != XST_SUCCESS) {
  		print("Unable to Read IMX519 Camera Sensor\n\r");
  	}
}
void write_imx519_reg(u16 addr,u8 data)
{
	int Status;
	print("IMX519 Camera\n\r");
    Status = imx519_write_read_register(&iic_cam,addr,data);
  	if (Status != XST_SUCCESS) {
  		print("Unable to Write IMX519 Camera Sensor\n\r");
  	}
}
void read_imx682_reg(u16 addr)
{
	int Status;
    Status = imx682_sensor_init(&iic_cam,addr);
  	if (Status != XST_SUCCESS) {
  		print("Unable to Read IMX682 Camera Sensor\n\r");
  	}
}
void write_imx682_reg(u16 addr,u8 data)
{
	int Status;
	print("IMX682 Camera\n\r");
    Status = imx682_write_read_register(&iic_cam,addr,data);
  	if (Status != XST_SUCCESS) {
  		print("Unable to Write IMX682 Camera Sensor\n\r");
  	}
}
void read_imx219_reg(u16 addr)
{
	int Status;
	print("IMX219 Camera\n\r");
    Status = imx219_read_register(&iic_cam,addr);
  	if (Status != XST_SUCCESS) {
  		print("Unable to Read IMX219 Camera Sensor\n\r");
  	}
}
void write_imx219_reg(u16 addr,u8 data)
{
	int Status;
	print("IMX219 Camera\n\r");
    Status = imx219_write_read_register(&iic_cam,addr,data);
  	if (Status != XST_SUCCESS) {
  		print("Unable to Write IMX219 Camera Sensor\n\r");
  	}
}
int scan_sensor1(XIicPs *IicInstance)
{
	u8 sensor_id[2];
	for(int address = 0; address < 256; address++ )
	 {
		if (sensor_id[0] != 0x5 || sensor_id[1] != 0x19)
		{
			scan_read(IicInstance, 0x300A, &sensor_id[0],address);
			scan_read(IicInstance, 0x300B, &sensor_id[1],address);
			printf("Got DEVICE. id, %x %x\r\n", sensor_id[0], sensor_id[1]);
		}
		else
		{
			printf("Got DEVICE.. id, %x %x\r\n", sensor_id[0], sensor_id[1]);
		}
		printf("Id @ address ==== %x is %x %x\r\n",address, sensor_id[0], sensor_id[1]);
	 }
	return 0;
}
int scan_sensor2(XIicPs *IicInstance)
{
	u8 sensor_id[2];
	for(int address = 0; address < 255; address++)
	 {
		scan_read(IicInstance, 0x300a, &sensor_id[0],address);
		scan_read(IicInstance, 0x300b, &sensor_id[1],address);
		printf("%x is %x %x\r\n",address, sensor_id[0], sensor_id[1]);
	 }
	return 0;
}
int scan_sensor3(XIicPs *IicInstance)
{
	u8 sensor_id[2];
	for(int address = 0; address < 256; address++ )
	 {
		if (sensor_id[0] != 0x5 || sensor_id[1] != 0x19)
		{
			scan_read(IicInstance, 0x1A, &sensor_id[0],address);
			scan_read(IicInstance, 0x0A, &sensor_id[1],address);
			printf("Got DEVICE. id, %x %x\r\n", sensor_id[0], sensor_id[1]);
		}
		else
		{
			printf("Got DEVICE.. id, %x %x\r\n", sensor_id[0], sensor_id[1]);
		}
		printf("Id @ address ==== %x is %x %x\r\n",address, sensor_id[0], sensor_id[1]);
	 }
	return 0;
}

