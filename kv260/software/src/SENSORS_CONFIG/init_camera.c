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
#include "init_camera.h"
#include <xiltimer.h>
#include <xil_printf.h>
#include <xil_types.h>
#include <xstatus.h>
#include <stdio.h>
#include "I2c_transections.h"
#include "IMX219/imx219.h"
#include "IMX519/imx519.h"
#include "IMX682/imx682.h"
#include "IMX477/imx477.h"
#include "AR1335/ar1335.h"
#include "OV5640/ov5640.h"
#include "OV5647/ov5647.h"
#include "parameters.h"

XIIC iic_cam;

#if defined(BOARD) && (BOARD == KV260)
#if !defined(SDT)
#define IIC_DEVICEID        XPAR_XIICPS_0_DEVICE_ID
#else
#define IIC_DEVICEID        XPAR_XIICPS_0_BASEADDR
#endif
#elif defined(BOARD) && (BOARD == ME_XU6_ST1)
#if defined(OPSERO)
#if !defined(SDT)
#define IIC_DEVICEID        XPAR_FMC_CAM_IIC_DEVICE_ID
#define FMC_CAM_IO_DEVICEID XPAR_FMC_CAM_IO_DEVICE_ID
#define LED_GPIO_DEVICEID   XPAR_LED_DEVICE_ID
#else
#define IIC_DEVICEID        XPAR_FMC_CAM_IIC_BASEADDR
#define FMC_CAM_IO_DEVICEID XPAR_FMC_CAM_IO_BASEADDR
#define LED_GPIO_DEVICEID   XPAR_LED_BASEADDR
#endif
#define RPI_CAM_POW_ON      0
#define RPI_CAM_IO1         1
#else
#if !defined(SDT)
#define IIC_DEVICEID        XPAR_XIICPS_1_DEVICE_ID
#else
#define IIC_DEVICEID        XPAR_XIICPS_1_BASEADDR
#endif
#endif
#else
#error "Please define BOARD in parameters.h"
#endif

#if defined(OPSERO)
#include "xgpio.h"
XGpio fmc_cam_gpio;
#endif

#define IIC_SCLK_RATE		400000
#define SW_IIC_ADDR         0x74
u8 SendBuffer [10];

int init_camera()
{
    int Status;

#if defined(BOARD) && (BOARD == ME_XU6_ST1)
#if 0
    XGpio_Config * led_config = XGpio_LookupConfig(LED_GPIO_DEVICEID);
    if (led_config == NULL) {
        xil_printf("XGpioPs_LookupConfig() failed\r\n");
        return XST_FAILURE;
    }
    if (XGpio_CfgInitialize(&fmc_cam_gpio, led_config, led_config->BaseAddress)) {
        xil_printf("XGpioPs_CfgInitialize() failed\r\n");
        return XST_FAILURE;
    }

    // Set all LEDs to output
    XGpio_SetDataDirection(&fmc_cam_gpio, 1, 0x00);
    // Turn off all LEDs
    XGpio_DiscreteClear(&fmc_cam_gpio, 1, 0xFF);
    usleep(100000);
    // Turn on LED 0 to indicate camera init start
    XGpio_DiscreteSet(&fmc_cam_gpio, 1, 0x07);
    usleep(100000);
    // Turn off all LEDs
    XGpio_DiscreteClear(&fmc_cam_gpio, 1, 0xFF);
    usleep(100000);
    // Turn on LED 1 to indicate camera init in progress
    XGpio_DiscreteSet(&fmc_cam_gpio, 1, 0x02);
    usleep(100000);
#endif
#endif

#if defined(FMC_CAM_IO_DEVICEID)
    // power off and power on the camera via FMC_CAM_IO
    XGpio_Config *gpio_config = XGpio_LookupConfig(FMC_CAM_IO_DEVICEID);
    if (gpio_config == NULL) {
        xil_printf("XGpioPs_LookupConfig() failed\r\n");
        return XST_FAILURE;
    }
    if (XGpio_CfgInitialize(&fmc_cam_gpio, gpio_config, gpio_config->BaseAddress)) {
        xil_printf("XGpioPs_CfgInitialize() failed\r\n");
        return XST_FAILURE;
    }

    // Reset and enable RPI power supplies
    XGpio_SetDataDirection(&fmc_cam_gpio, 1, 0);
    XGpio_DiscreteClear(&fmc_cam_gpio, 1, 1);
    usleep(100000);
    XGpio_DiscreteSet(&fmc_cam_gpio, 1, 1);
    usleep(100000);

    xil_printf("Reset and enabled RPI Camera power supplies\r\n");
#endif

    i2c_init(&iic_cam, IIC_DEVICEID, IIC_SCLK_RATE);
#if defined(BOARD) && (BOARD == KV260)
    SendBuffer[0]= 0x02;
    Status = XIIC_MasterSendPolled(&iic_cam, SendBuffer, 1, SW_IIC_ADDR);
    if (Status != XST_SUCCESS) {
        print("TCA9546 switch channel to IAS1 Failed\n\r");
        return XST_FAILURE;
    }
    Status = ar1335_camera_sensor_init(&iic_cam);
    if (Status == 153) {
        print("AR1335 Sensor Is Connected\n\r");
        //return 153;
    }
    SendBuffer[0]= 0x04;
    Status = XIIC_MasterSendPolled(&iic_cam, SendBuffer, 1, SW_IIC_ADDR);
    if (Status != XST_SUCCESS) {
        print("I2C Write Error\n\r");
        return XST_FAILURE;
    }
#endif
    xil_printf("Test imx519\r\n");
    Status = imx519_sensor_init(&iic_cam,0);
    if (Status == 519) {
        return 519;
    }
    xil_printf("Test imx682\r\n");
    Status = imx682_sensor_init(&iic_cam,1);
    if (Status == 682) {
        return 682;
    }
    xil_printf("Test imx219\r\n");
    Status = imx219_camera_sensor_init(&iic_cam);
    if (Status == 219) {
        return 219;
    }
    xil_printf("Test ov5640\r\n");
    Status = ov5640_camera_sensor_init(&iic_cam);
    if (Status != XST_SUCCESS) {
        print("OV5640 Camera Sensor Not connected\n\r");
    }

#if (APP_VIDEO_MODE == VM_4K)
    xil_printf("Test imx477 4k\r\n");
    Status = imx477_sensor_init(&iic_cam,14);
#else
    xil_printf("Test imx477 1080p\r\n");
    Status = imx477_sensor_init(&iic_cam,3);
#endif
    if (Status == 477) {
        return 477;
    }
    xil_printf("Test ov5467\r\n");
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
int scan_sensor1(XIIC *IicInstance)
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
int scan_sensor2(XIIC *IicInstance)
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
int scan_sensor3(XIIC *IicInstance)
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
