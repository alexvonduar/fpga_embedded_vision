#include <xstatus.h>
#include "init_camera.h"
#include "I2c_transections.h"
#include "xil_printf.h"

#if defined(USING_FMC_CAM_AXI_IIC)
#include <xiic.h>
#ifdef SDT
#include "xinterrupt_wrap.h"
#else
#include "xscugic.h"
#endif
volatile u8 TransmitComplete;	/* Flag to check completion of Transmission */
volatile u8 ReceiveComplete;	/* Flag to check completion of Reception */
static void SendHandler(XIic *InstancePtr);
static void ReceiveHandler(XIic *InstancePtr);
static void StatusHandler(XIic *InstancePtr, int Event);
#endif

int scan_read(XIIC *IicInstance,u16 addr,u8 *read_buf,u16 scan_addr)
{
    *read_buf=i2c_reg16_read(IicInstance,scan_addr,addr);
    return XST_SUCCESS;
}
int i2c_reg8_write(XIIC *InstancePtr, char IIC_ADDR, char Addr, char Data)
{
    int Status = XST_SUCCESS;
    u8 SendBuffer[2];
    SendBuffer[0] = Addr;
    SendBuffer[1] = Data;
#if defined(USING_FMC_CAM_AXI_IIC)
    /*
     * Set the defaults.
     */
    TransmitComplete = 1;
    InstancePtr->Stats.TxErrors = 0;

    Status = XIic_SetAddress(InstancePtr, XII_ADDR_TO_SEND_TYPE, IIC_ADDR);
    if (Status != XST_SUCCESS) {
        return Status;
    }

    Status = XIic_Start(InstancePtr);
    if (Status != XST_SUCCESS) {
        return Status;
    }

    Status = XIic_MasterSend(InstancePtr, SendBuffer, 2);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    /*
     * Wait till the transmission is completed.
     */
    while ((TransmitComplete) || (XIic_IsIicBusy(InstancePtr) == TRUE)) {
        if (InstancePtr->Stats.TxErrors != 0) {
            XIic_Reset(InstancePtr);
            xil_printf("Transmit Error to device %0x4x\r\n", IIC_ADDR);
            TransmitComplete = 0;
            InstancePtr->Stats.TxErrors = 0;
            return XST_FAILURE;
        }
        usleep(1);
    }

    Status = XIic_Stop(InstancePtr);
    if (Status != XST_SUCCESS) {
        return Status;
    }
#else
    Status = XIicPs_MasterSendPolled(InstancePtr, SendBuffer, 2, IIC_ADDR);
    while (XIicPs_BusIsBusy(InstancePtr));
#endif
    return Status;
}

char i2c_reg8_read(XIIC *InstancePtr, u16 IIC_ADDR, char Addr)
{
    u8 wr_data;
    u8 rd_data = 0;
    wr_data = Addr;
#if defined(USING_FMC_CAM_AXI_IIC)
    int Status = XST_SUCCESS;

    /*
     * Set the defaults.
     */
    TransmitComplete = 1;
    InstancePtr->Stats.TxErrors = 0;

    Status = XIic_SetAddress(InstancePtr, XII_ADDR_TO_SEND_TYPE, IIC_ADDR);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }

    Status = XIic_Start(InstancePtr);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }

    Status = XIic_MasterSend(InstancePtr, &wr_data, 1);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }

    /*
     * Wait till the transmission is completed.
     */
    while ((TransmitComplete) || (XIic_IsIicBusy(InstancePtr) == TRUE)) {
        if (InstancePtr->Stats.TxErrors != 0) {
            XIic_Reset(InstancePtr);
            xil_printf("Transmit Error to device %0x4x\r\n", IIC_ADDR);
            TransmitComplete = 0;
            InstancePtr->Stats.TxErrors = 0;
            return rd_data;
        }
        usleep(1);
    }

#if 1
    /*
     * Stop the IIC device.
     */
    Status = XIic_Stop(InstancePtr);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }

    /*
     * Start the IIC device.
     */
    Status = XIic_Start(InstancePtr);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }
#endif
    ReceiveComplete = 1;

    Status = XIic_MasterRecv(InstancePtr, &rd_data, 1);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }

    /*
     * Wait till all the data is received.
     */
    while ((ReceiveComplete) || (XIic_IsIicBusy(InstancePtr) == TRUE)) {
        usleep(1);
    }

    Status = XIic_Stop(InstancePtr);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }
#else
    XIIC_MasterSendPolled(InstancePtr, &wr_data, 1, IIC_ADDR);
    XIIC_MasterRecvPolled(InstancePtr, &rd_data, 1, IIC_ADDR);
    while (XIIC_BusIsBusy(InstancePtr));
#endif
    return rd_data;
}

int i2c_reg16_write(XIIC *InstancePtr, u16 IIC_ADDR, unsigned short Addr, char Data)
{
    int Status = XST_SUCCESS;
    u8 SendBuffer[3];
    SendBuffer[0] = Addr>>8;
    SendBuffer[1] = Addr;
    SendBuffer[2] = Data;
#if defined(USING_FMC_CAM_AXI_IIC)
    /*
     * Set the defaults.
     */
    TransmitComplete = 1;
    InstancePtr->Stats.TxErrors = 0;

    Status = XIic_SetAddress(InstancePtr, XII_ADDR_TO_SEND_TYPE, IIC_ADDR);
    if (Status != XST_SUCCESS) {
        return Status;
    }

    /*
     * Start the IIC device.
     */
    Status = XIic_Start(InstancePtr);
    if (Status != XST_SUCCESS) {
        return Status;
    }

    /*
     * Send the Data.
     */
    Status = XIic_MasterSend(InstancePtr, SendBuffer, 3);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    /*
     * Wait till the transmission is completed.
     */
    while ((TransmitComplete) || (XIic_IsIicBusy(InstancePtr) == TRUE)) {
        if (InstancePtr->Stats.TxErrors != 0) {
            XIic_Reset(InstancePtr);
            xil_printf("Transmit Error to device %0x4x\r\n", IIC_ADDR);
            TransmitComplete = 0;
            InstancePtr->Stats.TxErrors = 0;
            return XST_FAILURE;
        }
        usleep(1);
    }

    Status = XIic_Stop(InstancePtr);
    if (Status != XST_SUCCESS) {
        return Status;
    }
#else
    Status = XIIC_MasterSendPolled(InstancePtr, SendBuffer, 3, IIC_ADDR);
    while (XIIC_BusIsBusy(InstancePtr));
#endif
    return Status;
}

int i2c_reg16_write2bytes(XIIC *InstancePtr, u16 IIC_ADDR, unsigned short Addr, unsigned short Data)
{
    int Status = XST_SUCCESS;
    u8 SendBuffer[4];
    SendBuffer[0] = Addr>>8;
    SendBuffer[1] = Addr & 0x00FF;
    SendBuffer[2] = Data>>8;
    SendBuffer[3] = Data & 0x00FF;
#if defined(USING_FMC_CAM_AXI_IIC)
    /*
     * Set the defaults.
     */
    TransmitComplete = 1;
    InstancePtr->Stats.TxErrors = 0;

    Status = XIic_SetAddress(InstancePtr, XII_ADDR_TO_SEND_TYPE, IIC_ADDR);
    if (Status != XST_SUCCESS) {
        return Status;
    }

    Status = XIic_Start(InstancePtr);
    if (Status != XST_SUCCESS) {
        return Status;
    }

    Status = XIic_MasterSend(InstancePtr, SendBuffer, 4);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    /*
     * Wait till the transmission is completed.
     */
    while ((TransmitComplete) || (XIic_IsIicBusy(InstancePtr) == TRUE)) {
        if (InstancePtr->Stats.TxErrors != 0) {
            XIic_Reset(InstancePtr);
            xil_printf("Transmit Error to device %0x4x\r\n", IIC_ADDR);
            TransmitComplete = 0;
            InstancePtr->Stats.TxErrors = 0;
            return XST_FAILURE;
        }
        usleep(1);
    }

    Status = XIic_Stop(InstancePtr);
    if (Status != XST_SUCCESS) {
        return Status;
    }
#else
    Status = XIIC_MasterSendPolled(InstancePtr, SendBuffer, 4, IIC_ADDR);
    while (XIIC_BusIsBusy(InstancePtr));
#endif
    return Status;
}

char i2c_reg16_read(XIIC *InstancePtr, u16 IIC_ADDR, unsigned short Addr)
{
    u8 rd_data;
    u8 SendBuffer[2];
    SendBuffer[0] = Addr>>8;
    SendBuffer[1] = Addr;
#if defined(USING_FMC_CAM_AXI_IIC)
    int Status = XST_SUCCESS;

    /*
     * Set the defaults.
     */
    TransmitComplete = 1;
    InstancePtr->Stats.TxErrors = 0;

    Status = XIic_SetAddress(InstancePtr, XII_ADDR_TO_SEND_TYPE, IIC_ADDR);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }

    Status = XIic_Start(InstancePtr);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }

    Status = XIic_MasterSend(InstancePtr, SendBuffer, 2);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }

    /*
     * Wait till the transmission is completed.
     */
    while ((TransmitComplete) || (XIic_IsIicBusy(InstancePtr) == TRUE)) {
        if (InstancePtr->Stats.TxErrors != 0) {
            XIic_Reset(InstancePtr);
            xil_printf("Transmit Error to device %0x4x\r\n", IIC_ADDR);
            TransmitComplete = 0;
            InstancePtr->Stats.TxErrors = 0;
            rd_data = 0;
            return rd_data;
        }
        usleep(1);
    }

#if 1
    /*
     * Stop the IIC device.
     */
    Status = XIic_Stop(InstancePtr);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }

    /*
     * Start the IIC device.
     */
    Status = XIic_Start(InstancePtr);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }
#endif
    ReceiveComplete=1;

    Status = XIic_MasterRecv(InstancePtr, &rd_data, 1);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }

    /*
     * Wait till all the data is received.
     */
    while ((ReceiveComplete) || (XIic_IsIicBusy(InstancePtr) == TRUE)) {
        usleep(1);
    }

    /*
     * Stop the IIC device.
     */
    Status = XIic_Stop(InstancePtr);
    if (Status != XST_SUCCESS) {
        return rd_data;
    }
#else
    XIIC_MasterSendPolled(InstancePtr, SendBuffer, 2, IIC_ADDR);
    XIIC_MasterRecvPolled(InstancePtr, &rd_data, 1, IIC_ADDR);
    while (XIIC_BusIsBusy(InstancePtr));
#endif
    return rd_data;
}

u16 i2c_reg16_2read(XIIC *InstancePtr, u16 IIC_ADDR, unsigned short Addr)
{
    u8 SendBuffer[2];
    u8 RxBuffer[2] = {0};
    SendBuffer[0] = Addr>>8;
    SendBuffer[1] = Addr;
#if defined(USING_FMC_CAM_AXI_IIC)
    int Status = XST_SUCCESS;

    /*
     * Set the defaults.
     */
    TransmitComplete = 1;
    InstancePtr->Stats.TxErrors = 0;

    Status = XIic_SetAddress(InstancePtr, XII_ADDR_TO_SEND_TYPE, IIC_ADDR);
    if (Status != XST_SUCCESS) {
        return (RxBuffer[0] << 8) | RxBuffer[1];
    }

    Status = XIic_Start(InstancePtr);
    if (Status != XST_SUCCESS) {
        return (RxBuffer[0] << 8) | RxBuffer[1];
    }

    Status = XIic_MasterSend(InstancePtr, SendBuffer, 2);
    if (Status != XST_SUCCESS) {
        return (RxBuffer[0] << 8) | RxBuffer[1];
    }

    /*
     * Wait till the transmission is completed.
     */
    while ((TransmitComplete) || (XIic_IsIicBusy(InstancePtr) == TRUE)) {
        if (InstancePtr->Stats.TxErrors != 0) {
            XIic_Reset(InstancePtr);
            xil_printf("Transmit Error to device %0x4x\r\n", IIC_ADDR);
            TransmitComplete = 0;
            InstancePtr->Stats.TxErrors = 0;
            return (RxBuffer[0] << 8) | RxBuffer[1];
        }
        usleep(1);
    }

#if 1
    /*
     * Stop the IIC device.
     */
    Status = XIic_Stop(InstancePtr);
    if (Status != XST_SUCCESS) {
        return (RxBuffer[0] << 8) | RxBuffer[1];
    }

    /*
     * Start the IIC device.
     */
    Status = XIic_Start(InstancePtr);
    if (Status != XST_SUCCESS) {
        return (RxBuffer[0] << 8) | RxBuffer[1];
    }
#endif
    ReceiveComplete=1;

    Status = XIic_MasterRecv(InstancePtr, RxBuffer, 2);
    if (Status != XST_SUCCESS) {
        return (RxBuffer[0] << 8) | RxBuffer[1];
    }

    /*
     * Wait till all the data is received.
     */
    while ((ReceiveComplete) || (XIic_IsIicBusy(InstancePtr) == TRUE)) {
        usleep(1);
    }

    Status = XIic_Stop(InstancePtr);
    if (Status != XST_SUCCESS) {
        return (RxBuffer[0] << 8) | RxBuffer[1];
    }
#else
    XIIC_MasterSendPolled(InstancePtr, SendBuffer, 2, IIC_ADDR);
    XIIC_MasterRecvPolled(InstancePtr, RxBuffer, 2, IIC_ADDR);
    while (XIIC_BusIsBusy(InstancePtr));
#endif
    xil_printf("ID %x : %x %x\r\n",IIC_ADDR, RxBuffer[0], RxBuffer[1]);
    return (RxBuffer[0] << 8) | RxBuffer[1];
}

#if !defined(SDT)
int i2c_init(XIIC *Iic,short DeviceID ,u32 IIC_SCLK_RATE)
#else
int i2c_init(XIIC *Iic,UINTPTR DeviceID ,u32 IIC_SCLK_RATE)
#endif
{
    XIIC_Config *Config;
    int Status = XST_SUCCESS;
    Config = XIIC_LookupConfig(DeviceID);
    if (NULL == Config) {
        xil_printf("XIIC_LookupConfig failure\r\n");
        return XST_FAILURE;
    }
    Status = XIIC_CfgInitialize(Iic, Config, Config->BaseAddress);
    if (Status != XST_SUCCESS) {
        xil_printf("XIIC_CfgInitialize failure\r\n");
        return XST_FAILURE;
    }

    Status = XIIC_SelfTest(Iic);
    if (Status != XST_SUCCESS) {
        xil_printf("XIIC_SelfTest failure\r\n");
        return XST_FAILURE;
    }

    //handle iic interrupts
#if defined(USING_FMC_CAM_AXI_IIC)
#if defined(SDT)
    Status = XSetupInterruptSystem(Iic, &XIic_InterruptHandler, Config->IntrId, Config->IntrParent, XINTERRUPT_DEFAULT_PRIORITY);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    /*
     * Set the Handlers for transmit and reception.
     */
    XIic_SetSendHandler(Iic,   Iic, (XIic_Handler) SendHandler);
    XIic_SetRecvHandler(Iic,   Iic, (XIic_Handler) ReceiveHandler);
    XIic_SetStatusHandler(Iic, Iic, (XIic_StatusHandler) StatusHandler);
#else
#error "interrupt handling for XIIC not implemented right now for non-SDT"
#endif
#endif

#if !defined(USING_FMC_CAM_AXI_IIC)
    XIIC_SetSClk(Iic, IIC_SCLK_RATE);
    while (XIIC_BusIsBusy(Iic));
#endif
    return XST_SUCCESS;
}

#if defined(USING_FMC_CAM_AXI_IIC)
/*****************************************************************************/
/**
* This Send handler is called asynchronously from an interrupt
* context and indicates that data in the specified buffer has been sent.
*
* @param	InstancePtr is not used, but contains a pointer to the IIC
*		device driver instance which the handler is being called for.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
static void SendHandler(XIic *InstancePtr)
{
    //xil_printf("iic send complete\r\n");
    TransmitComplete = 0;
}

/*****************************************************************************/
/**
* This Receive handler is called asynchronously from an interrupt
* context and indicates that data in the specified buffer has been Received.
*
* @param	InstancePtr is not used, but contains a pointer to the IIC
*		device driver instance which the handler is being called for.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
static void ReceiveHandler(XIic *InstancePtr)
{
    //xil_printf("iic receive complete\r\n");
    ReceiveComplete = 0;
}

/*****************************************************************************/
/**
* This Status handler is called asynchronously from an interrupt
* context and indicates the events that have occurred.
*
* @param	InstancePtr is a pointer to the IIC driver instance for which
*		the handler is being called for.
* @param	Event indicates the condition that has occurred.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
static void StatusHandler(XIic *InstancePtr, int Event)
{

}
#endif

#if 0
unsigned EepromWriteByte(AddressType Address, u8 *BufferPtr, u16 ByteCount)
{
    volatile unsigned SentByteCount;
    volatile unsigned AckByteCount;
    u8 WriteBuffer[sizeof(Address) + PAGE_SIZE];
    int Index;
    u32 CntlReg;

    /*
     * A temporary write buffer must be used which contains both the address
     * and the data to be written, put the address in first based upon the
     * size of the address for the EEPROM.
     */
    if (sizeof(AddressType) == 2) {
        WriteBuffer[0] = (u8)(Address >> 8);
        WriteBuffer[1] = (u8)(Address);
    } else if (sizeof(AddressType) == 1) {
        WriteBuffer[0] = (u8)(Address);
        EepromIicAddr |= (EEPROM_TEST_START_ADDRESS >> 8) & 0x7;
    }

    /*
     * Put the data in the write buffer following the address.
     */
    for (Index = 0; Index < ByteCount; Index++) {
        WriteBuffer[sizeof(Address) + Index] = BufferPtr[Index];
    }

    /*
     * Set the address register to the specified address by writing
     * the address to the device, this must be tried until it succeeds
     * because a previous write to the device could be pending and it
     * will not ack until that write is complete.
     */
    do {
        SentByteCount = XIic_Send(IIC_BASE_ADDRESS,
                      EepromIicAddr,
                      (u8 *)&Address, sizeof(Address),
                      XIIC_STOP);
        if (SentByteCount != sizeof(Address)) {

            /* Send is aborted so reset Tx FIFO */
            CntlReg = XIic_ReadReg(IIC_BASE_ADDRESS,
                           XIIC_CR_REG_OFFSET);
            XIic_WriteReg(IIC_BASE_ADDRESS, XIIC_CR_REG_OFFSET,
                      CntlReg | XIIC_CR_TX_FIFO_RESET_MASK);
            XIic_WriteReg(IIC_BASE_ADDRESS, XIIC_CR_REG_OFFSET,
                      XIIC_CR_ENABLE_DEVICE_MASK);
        }

    } while (SentByteCount != sizeof(Address));

    /*
     * Write a page of data at the specified address to the EEPROM.
     */
    SentByteCount = XIic_Send(IIC_BASE_ADDRESS, EepromIicAddr,
                  WriteBuffer, sizeof(Address) + PAGE_SIZE,
                  XIIC_STOP);

    /*
     * Wait for the write to be complete by trying to do a write and
     * the device will not ack if the write is still active.
     */
    do {
        AckByteCount = XIic_Send(IIC_BASE_ADDRESS, EepromIicAddr,
                     (u8 *)&Address, sizeof(Address),
                     XIIC_STOP);
        if (AckByteCount != sizeof(Address)) {

            /* Send is aborted so reset Tx FIFO */
            CntlReg = XIic_ReadReg(IIC_BASE_ADDRESS,
                           XIIC_CR_REG_OFFSET);
            XIic_WriteReg(IIC_BASE_ADDRESS, XIIC_CR_REG_OFFSET,
                      CntlReg | XIIC_CR_TX_FIFO_RESET_MASK);
            XIic_WriteReg(IIC_BASE_ADDRESS, XIIC_CR_REG_OFFSET,
                      XIIC_CR_ENABLE_DEVICE_MASK);
        }

    } while (AckByteCount != sizeof(Address));


    /*
     * Return the number of bytes written to the EEPROM
     */
    return SentByteCount - sizeof(Address);
}

/*****************************************************************************/
/**
* This function reads a number of bytes from the IIC serial EEPROM into a
* specified buffer.
*
* @param	Address contains the address in the EEPROM to read from.
* @param	BufferPtr contains the address of the data buffer to be filled.
* @param	ByteCount contains the number of bytes in the buffer to be read.
*		This value is not constrained by the page size of the device
*		such that up to 64K may be read in one call.
*
* @return	The number of bytes read. A value less than the specified input
*		value indicates an error.
*
* @note		None.
*
****************************************************************************/
unsigned EepromReadByte(AddressType Address, u8 *BufferPtr, u16 ByteCount)
{
    volatile unsigned ReceivedByteCount;
    u16 StatusReg;
    u32 CntlReg;

    /*
     * Set the address register to the specified address by writing
     * the address to the device, this must be tried until it succeeds
     * because a previous write to the device could be pending and it
     * will not ack until that write is complete.
     */
    do {
        StatusReg = XIic_ReadReg(IIC_BASE_ADDRESS, XIIC_SR_REG_OFFSET);
        if (!(StatusReg & XIIC_SR_BUS_BUSY_MASK)) {
            ReceivedByteCount = XIic_Send(IIC_BASE_ADDRESS,
                              EepromIicAddr,
                              (u8 *)&Address,
                              sizeof(Address),
                              XIIC_STOP);

            if (ReceivedByteCount != sizeof(Address)) {

                /* Send is aborted so reset Tx FIFO */
                CntlReg = XIic_ReadReg(IIC_BASE_ADDRESS,
                               XIIC_CR_REG_OFFSET);
                XIic_WriteReg(IIC_BASE_ADDRESS, XIIC_CR_REG_OFFSET,
                          CntlReg | XIIC_CR_TX_FIFO_RESET_MASK);
                XIic_WriteReg(IIC_BASE_ADDRESS,
                          XIIC_CR_REG_OFFSET,
                          XIIC_CR_ENABLE_DEVICE_MASK);
            }
        }

    } while (ReceivedByteCount != sizeof(Address));

    /*
     * Read the number of bytes at the specified address from the EEPROM.
     */
    ReceivedByteCount = XIic_Recv(IIC_BASE_ADDRESS, EepromIicAddr,
                      BufferPtr, ByteCount, XIIC_STOP);

    /*
     * Return the number of bytes read from the EEPROM.
     */
    return ReceivedByteCount;
}
#endif
