#include "ipmi.h"

#include <malloc.h>
#include "xparameters.h"
#include "xgpiops.h"
#include "ipmi-fru.h"

#if defined(XPAR_XIICPS_NUM_INSTANCES) && (XPAR_XIICPS_NUM_INSTANCES > 0)
#include "xiicps.h"


/*
 * The following constant defines the address of the IIC Slave device on the
 * IIC bus. Note that since the address is only 7 bits, this constant is the
 * address divided by 2.
 */
#if !defined(SDT)
#define IIC_DEVICE_ID			XPAR_XIICPS_0_DEVICE_ID
#else
#define IIC_DEVICE_ID			XPAR_XIICPS_0_BASEADDR
#endif
#define IIC_SLAVE_ADDR			0x50
#define IIC_SCLK_RATE			100000
#endif

#if !defined(SDT)
#define GPIO_DEVICE_ID			XPAR_PS7_GPIO_0_DEVICE_ID
#else
#define GPIO_DEVICE_ID			XPAR_XGPIOPS_0_BASEADDR
#endif
#define FMC_PRSNT_L_PIN			54

/*
 * The page size determines how much data should be written at a time.
 * The write function should be called with this as a maximum byte count.
 */
#define PAGE_SIZE				16

/*
 * The Starting address in the IIC EEPROM on which this test is performed.
 */
#define EEPROM_START_ADDRESS	0

/**************************** Type Definitions *******************************/
/*
 * The AddressType should be u8 as the address pointer in the on-board
 * EEPROM is 1 bytes.
 */
typedef u8 AddressType;

/************************** Variable Definitions *****************************/
#if defined(XPAR_XIICPS_NUM_INSTANCES) && (XPAR_XIICPS_NUM_INSTANCES > 0)
XIicPs IicInstance;		/* The instance of the IIC device. */
#endif
XGpioPs GpioInstance;		/* The instance of the IIC device. */

extern unsigned char verbose;

/*
 * Rule 5.75: The EEPROM shall include the BOARD_INFO area for
identification of the mezzanine module.
 */

/*
 * Rule 5.77: For FMC-specific MultiRecords, the MultiRecord's header (see
ISD section 16.1) shall specify OEM record type 0xFA (see ISD section
16.2.1). The Manufacturer ID field of the Multirecord's data portion (see
ISD section 18.7) shall specify VITA's Organizationally Unique Identifier
(OUI), 0x0012A2
 */

/*
 * Rule 5.78: A multi-record 'DC Output' shall be included for the
VIO_B_M2C, VREF_A_M2C, VREF_B_M2C power supplies
Rule 5.79: A multi-record 'DC Load' shall be included for the VADJ,
3P3V, 12P0V, VIO_B_M2C power supplies
Rule 5.80: When the VADJ can support a range of voltage levels, then the
VADJ 'DC Load' multi-record shall use the minimum and maximum fields
to indicate the voltage ranges supported and the 'Voltage Required' field
shall indicate the preferred voltage.
 */

#define MANDATE_POS 11
#define SN_POS 33

#define COMMON_HEADER_BOARD_AREA_OFFSET 3
#define BOARD_AREA_LENGTH_OFFSET 1

/* The FRU ID of the following FRU image; Used for versioning */
#define FRU_ID 0x02
static const uint8_t kFRU_ID = FRU_ID;

Xuint8 rgbDigilentIpmi[] = {
/* [  0] */ 0x01, // 0000.0001 <--- Common Header Format Version
/* [  1] */ 0x00, // 0000.0000 <--- Internal Use Area Starting Offset 0x00=N/A
/* [  2] */ 0x00, // 0000.0000 <--- Chassis Info Area Starting Offset 0x00=N/A
/* [  3] */ 0x01, // 0000.0001 <--- Board Area Starting Offset (in multiples of 8B) 0x01=8
/* [  4] */ 0x00, // 0000.0000 <--- Product Info Area Starting Offset 0x00=N/A
/* [  5] */ 0x06, // 0000.0110 <--- MultiRecord Area Starting Offset (in multiples of 8B) 0x06=48
/* [  6] */ 0x00, // 0000.0000 <--- PAD
/* [  7] */ 0xF8, // 1111.1000 <--- Common Header Checksum

/* [  8] */ 0x01, // 0000.0001 <--- Board Area Format Version
/* [  9] */ 0x05, // 0000.0101 <--- Board Area Length (in multiples of 8B) 0x05=40
/* [ 10] */ 0x00, // 0000.0000 <--- Language Code (0=English); affects type/length fields below
/* [ 11] */ 0x00, // 0000.0000 <--- |
/* [ 12] */ 0x00, // 0000.0000 <---  } Mfg. Date/Time Number of minutes from 0:00 hrs 1/1/96; to be filled in later
/* [ 13] */ 0x00, // 0000.0000 <--- |
/* [ 14] */ 0xC8, // 1100.1000 <--- Board Manufacturer Type/Length Byte (8-bit ASCII + Latin 1 (Language Code 0), 8 data bytes)
/* [ 15] */ 0x44, // 0100.0100 <--- D
/* [ 16] */ 0x69, // 0110.1001 <--- i
/* [ 17] */ 0x67, // 0110.0111 <--- g
/* [ 18] */ 0x69, // 0110.1001 <--- i
/* [ 19] */ 0x6C, // 0110.1100 <--- l
/* [ 20] */ 0x65, // 0110.0101 <--- e
/* [ 21] */ 0x6E, // 0110.1110 <--- n
/* [ 22] */ 0x74, // 0111.0100 <--- t
/* [ 23] */ 0xC8, // 1100.1000 <--- Board Product Name Type/Length Byte (8-bit ASCII + Latin 1 (Language Code 0), 8 data bytes)
/* [ 24] */ 0x46, // 0100.0110 <--- F
/* [ 25] */ 0x4D, // 0100.1101 <--- M
/* [ 26] */ 0x43, // 0100.0011 <--- C
/* [ 27] */ 0x2D, // 0010.1101 <--- -
/* [ 28] */ 0x48, // 0100.1000 <--- H
/* [ 29] */ 0x44, // 0100.0100 <--- D
/* [ 30] */ 0x4D, // 0100.1101 <--- M
/* [ 31] */ 0x49, // 0100.1001 <--- I
/* [ 32] */ 0x03, // 0000.0011 <--- Board Serial Number Type/Length Byte (Binary, 3 data bytes)
/* [ 33] */ 0x00, // 0000.0000 <--- | MSB
/* [ 34] */ 0x00, // 0000.0000 <---  } Board Serial Number (6 hex numbers after letter D); to be filled in later
/* [ 35] */ 0x00, // 0000.0000 <--- | LSB
/* [ 36] */ 0xC7, // 1100.0111 <--- Board Part Number Type/Length Byte (8-bit ASCII + Latin 1 (forced Language Code 0), 7 data bytes)
/* [ 37] */ 0x32, // 0011.0010 <--- 2
/* [ 38] */ 0x30, // 0011.0000 <--- 0
/* [ 39] */ 0x30, // 0011.0000 <--- 0
/* [ 40] */ 0x2D, // 0010.1101 <--- -
/* [ 41] */ 0x32, // 0011.0010 <--- 2
/* [ 42] */ 0x36, // 0011.0110 <--- 6
/* [ 43] */ 0x34, // 0011.0100 <--- 4
/* [ 44] */ 0x01, // 0000.0001 <--- FRU File ID Type/Length Byte (Binary, 1 byte)
/* [ 45] */ FRU_ID, // 0000.0001 <--- FRU file revision 1
/* [ 46] */ 0xC1, // 1100.0001 <--- Type/Length byte encoded to indicate no more info fields (0xC1)
/* Padding not necessary here, since already multiple of 8 bytes */
/* [ 47] */ 0x00, // 0000.0000 <--- Board Area Checksum; (to be filled in later)


/* [ 48] */ 0x02, // 0000.0010 <--- Multirecord Header: DC Load type (0x02)
/* [ 49] */ 0x02, // 0000.0010 <--- Multirecord Header: Record Format Version 2
/* [ 50] */ 0x0D, // 0000.1101 <--- Multirecord Header: Record Length (13 bytes)
/* [ 51] */ 0x26, // 0010.0110 <--- Multirecord Header: Record Checksum
/* [ 52] */ 0xC9, // 1100.1001 <--- Multirecord Header: Header Checksum
/* [ 53] */ 0x00, // 0000.0000 <--- Voltage Required (Output Number 0 = VADJ)
/* [ 54] */ 0x4A, // 0100.1010 <--- Nominal Voltage LSB (0x14A = 330*10mV = +3.30V)
/* [ 55] */ 0x01, // 0000.0001 <--- Nominal Voltage MSB
/* [ 56] */ 0xAA, // 1010.1010 <--- Spec'd minimum voltage LSB (0xAA = 170*10mV = +1.70V)
/* [ 57] */ 0x00, // 0000.0000 <--- Spec'd minimum voltage MSB
/* [ 58] */ 0x54, // 0101.0100 <--- Spec'd maximum voltage LSB (0x154 = 340*10mV = +3.40V)
/* [ 59] */ 0x01, // 0000.0001 <--- Spec'd maximum voltage MSB
/* [ 60] */ 0x64, // 0110.0100 <--- Spec'd Ripple and Noise pk-pk 10Hz to 30MHz LSB
/* [ 61] */ 0x00, // 0000.0000 <--- Spec'd Ripple and Noise pk-pk 10Hz to 30MHz MSB (0x64 = 100mV)
/* [ 62] */ 0x32, // 0011.0010 <--- Minimum current load LSB
/* [ 63] */ 0x00, // 0000.0000 <--- Minimum current load MSB (0x32 = +50mA)
/* [ 64] */ 0xFA, // 1111.1010 <--- Maximum current load LSB
/* [ 65] */ 0x00, // 0000.0000 <--- Maximum current load MSB (0xFA = +250mA)


/* [ 66] */ 0x02, // 0000.0010 <--- Multirecord Header: DC Load type (0x02)
/* [ 67] */ 0x02, // 0000.0010 <--- Multirecord Header: Record Format Version 2
/* [ 68] */ 0x0D, // 0000.1101 <--- Multirecord Header: Record Length (13 bytes)
/* [ 69] */ 0x65, // 0110.0101 <--- Multirecord Header: Record Checksum
/* [ 70] */ 0x8A, // 1000.1010 <--- Multirecord Header: Header Checksum
/* [ 71] */ 0x01, // 0000.0001 <--- Voltage Required (Output Number 1 = 3P3V)
/* [ 72] */ 0x4A, // 0100.1010 <--- Nominal Voltage LSB
/* [ 73] */ 0x01, // 0000.0001 <--- Nominal Voltage MSB (0x14A = 330*10mV = +3.30V)
/* [ 74] */ 0x3A, // 0011.1010 <--- Spec'd minimum voltage LSB
/* [ 75] */ 0x01, // 0000.0001 <--- Spec'd minimum voltage MSB (0x13A = 314*10mV = +3.14V)
/* [ 76] */ 0x5A, // 0101.1010 <--- Spec'd maximum voltage LSB
/* [ 77] */ 0x01, // 0000.0001 <--- Spec'd maximum voltage MSB (+3.46V)
/* [ 78] */ 0x64, // 0110.0100 <--- Spec'd Ripple and Noise pk-pk 10Hz to 30MHz LSB
/* [ 79] */ 0x00, // 0000.0000 <--- Spec'd Ripple and Noise pk-pk 10Hz to 30MHz MSB (0x64 = 100mV)
/* [ 80] */ 0x32, // 0011.0010 <--- Minimum current load LSB
/* [ 81] */ 0x00, // 0000.0000 <--- Minimum current load MSB (0x32 = +50mA)
/* [ 82] */ 0x20, // 0010.0000 <--- Maximum current load LSB
/* [ 83] */ 0x03, // 0000.0011 <--- Maximum current load MSB (0x320 = +800mA)

/* [ 84] */ 0x02, // 0000.0010 <--- Multirecord Header: DC Load type (0x02)
/* [ 85] */ 0x02, // 0000.0010 <--- Multirecord Header: Record Format Version 2
/* [ 86] */ 0x0D, // 0000.1101 <--- Multirecord Header: Record Length (13 bytes)
/* [ 87] */ 0x7E, // 0111.1110 <--- Multirecord Header: Record Checksum
/* [ 88] */ 0x71, // 0111.0001 <--- Multirecord Header: Header Checksum
/* [ 89] */ 0x02, // 0000.0010 <--- Voltage Required (Output Number 2 = 12P0V)
/* [ 90] */ 0xB0, // 1011.0000 <--- Nominal Voltage LSB
/* [ 91] */ 0x04, // 0000.0100 <--- Nominal Voltage MSB (0x4B0 = 1200*10mV = +12.0V)
/* [ 92] */ 0x74, // 0111.0100 <--- Spec'd minimum voltage LSB
/* [ 93] */ 0x04, // 0000.0100 <--- Spec'd minimum voltage MSB (0x474 = 1140*10mV = +11.4V)
/* [ 94] */ 0xEC, // 1110.1100 <--- Spec'd maximum voltage LSB
/* [ 95] */ 0x04, // 0000.0100 <--- Spec'd maximum voltage MSB (0x474 = 1260*10mV = +12.6V)
/* [ 96] */ 0x00, // 0110.0100 <--- Spec'd Ripple and Noise pk-pk 10Hz to 30MHz LSB
/* [ 97] */ 0x00, // 0000.0000 <--- Spec'd Ripple and Noise pk-pk 10Hz to 30MHz MSB
/* [ 98] */ 0x00, // 0000.0000 <--- Minimum current load LSB
/* [ 99] */ 0x00, // 0000.0000 <--- Minimum current load MSB 0
/* [100] */ 0x64, // 0110.0100 <--- Maximum current load LSB
/* [101] */ 0x00, // 0000.0000 <--- Maximum current load MSB (0x64 = +100mA)

/* [102] */ 0x01, // 0000.0001 <--- Multirecord Header: DC Output type (0x01)
/* [103] */ 0x02, // 0000.0010 <--- Multirecord Header: Record Format Version 2
/* [104] */ 0x0D, // 0000.1101 <--- Multirecord Header: Record Length (13 bytes)
/* [105] */ 0xFD, // 1111.1101 <--- Multirecord Header: Record Checksum
/* [106] */ 0xF3, // 1111.0011 <--- Multirecord Header: Header Checksum
/* [107] */ 0x03, // 0000.0011 <--- Voltage Required (Output Number 3 = VIO_B_M2C)
/* [108] */ 0x00, // 0000.0000 <--- Nominal Voltage LSB
/* [109] */ 0x00, // 0000.0000 <--- Nominal Voltage MSB (0x00 = unused)
/* [110] */ 0x00, // 0000.0000 <--- Spec'd minimum voltage LSB
/* [111] */ 0x00, // 0000.0000 <--- Spec'd minimum voltage MSB
/* [112] */ 0x00, // 0000.0000 <--- Spec'd maximum voltage LSB
/* [113] */ 0x00, // 0000.0000 <--- Spec'd maximum voltage MSB
/* [114] */ 0x00, // 0000.0000 <--- Spec'd Ripple and Noise pk-pk 10Hz to 30MHz LSB
/* [115] */ 0x00, // 0000.0000 <--- Spec'd Ripple and Noise pk-pk 10Hz to 30MHz MSB
/* [116] */ 0x00, // 0000.0000 <--- Minimum current load LSB
/* [117] */ 0x00, // 0000.0000 <--- Minimum current load MSB
/* [118] */ 0x00, // 0000.0000 <--- Maximum current load LSB
/* [119] */ 0x00, // 0000.0000 <--- Maximum current load MSB

/* [120] */ 0x01, // 0000.0001 <--- Multirecord Header: DC Output type (0x01)
/* [121] */ 0x02, // 0000.0010 <--- Multirecord Header: Record Format Version 2
/* [122] */ 0x0D, // 0000.1101 <--- Multirecord Header: Record Length (13 bytes)
/* [123] */ 0xFC, // 1111.1100 <--- Multirecord Header: Record Checksum
/* [124] */ 0xF4, // 1111.0100 <--- Multirecord Header: Header Checksum
/* [125] */ 0x04, // 0000.0100 <--- Voltage Required (Output Number 4 = VREF_A_M2C)
/* [126] */ 0x00, // 0000.0000 <--- Nominal Voltage LSB
/* [127] */ 0x00, // 0000.0000 <--- Nominal Voltage MSB (0x00 = unused)
/* [128] */ 0x00, // 0000.0000 <--- Spec'd minimum voltage LSB
/* [129] */ 0x00, // 0000.0000 <--- Spec'd minimum voltage MSB
/* [130] */ 0x00, // 0000.0000 <--- Spec'd maximum voltage LSB
/* [131] */ 0x00, // 0000.0000 <--- Spec'd maximum voltage MSB
/* [132] */ 0x00, // 0000.0000 <--- Spec'd Ripple and Noise pk-pk 10Hz to 30MHz LSB
/* [133] */ 0x00, // 0000.0000 <--- Spec'd Ripple and Noise pk-pk 10Hz to 30MHz MSB
/* [134] */ 0x00, // 0000.0000 <--- Minimum current load LSB
/* [135] */ 0x00, // 0000.0000 <--- Minimum current load MSB
/* [136] */ 0x00, // 0000.0000 <--- Maximum current load LSB
/* [137] */ 0x00, // 0000.0000 <--- Maximum current load MSB

/* [138] */ 0x01, // 0000.0001 <--- Multirecord Header: DC Output type (0x01)
/* [   ] */ 0x02, // 0000.0010 <--- Multirecord Header: Record Format Version 2
/* [   ] */ 0x0D, // 0000.1101 <--- Multirecord Header: Record Length (13 bytes)
/* [   ] */ 0xFB, // 1111.1011 <--- Multirecord Header: Record Checksum
/* [   ] */ 0xF5, // 1111.0101 <--- Multirecord Header: Header Checksum
/* [   ] */ 0x05, // 0000.0101 <--- Voltage Required (Output Number 5 = VREF_B_M2C)
/* [   ] */ 0x00, // 0000.0000 <--- Nominal Voltage LSB
/* [   ] */ 0x00, // 0000.0000 <--- Nominal Voltage MSB (0x00 = unused)
/* [   ] */ 0x00, // 0000.0000 <--- Spec'd minimum voltage LSB
/* [   ] */ 0x00, // 0000.0000 <--- Spec'd minimum voltage MSB
/* [   ] */ 0x00, // 0000.0000 <--- Spec'd maximum voltage LSB
/* [   ] */ 0x00, // 0000.0000 <--- Spec'd maximum voltage MSB
/* [   ] */ 0x00, // 0000.0000 <--- Spec'd Ripple and Noise pk-pk 10Hz to 30MHz LSB
/* [   ] */ 0x00, // 0000.0000 <--- Spec'd Ripple and Noise pk-pk 10Hz to 30MHz MSB
/* [   ] */ 0x00, // 0000.0000 <--- Minimum current load LSB
/* [   ] */ 0x00, // 0000.0000 <--- Minimum current load MSB
/* [   ] */ 0x00, // 0000.0000 <--- Maximum current load LSB
/* [155] */ 0x00, // 0000.0000 <--- Maximum current load MSB

/* [156] */ 0xFA, // 1111.1010 <--- Multirecord Header : FMC OEM Record type (0xFA)
/* [   ] */ 0x82, // 1000.0010 <--- Multirecord Header : End-of-list 7:7, 3:0 Record Format Version 2
/* [   ] */ 0x0B, // 0000.1011 <--- Multirecord Header : Record Length (11 bytes)
/* [   ] */ 0x0D, // 0000.1101 <--- Multirecord Header : Record Checksum
/* [   ] */ 0x6C, // 1110.1100 <--- Multirecord Header : Header Checksum
/* [   ] */ 0xA2, // 1010.0010 <--- VITA's OUI (0xA2) LSB
/* [   ] */ 0x12, // 0001.0010 <--- VITA's OUI (0x12)
/* [   ] */ 0x00, // 0000.0000 <--- VITA's OUI (0x00) MSB
/* [   ] */ 0x00, // 0000.0000 <--- Subtype/Version (00)
/* [   ] */ 0x0E, // 0000.1110 <--- Single width, P1 LPC, P2 not fitted, CLKx_BIDIR unused (Carrier to Mezzanine)
/* [   ] */ 0x32, // 0011.0010 <--- P1 Bank A Number Signals (50 pins)
/* [   ] */ 0x00, // 0000.0000 <--- P1 Bank B Number Signals
/* [   ] */ 0x00, // 0000.0000 <--- P2 Bank A Number Signals
/* [   ] */ 0x00, // 0000.0000 <--- P2 Bank B Number Signals
/* [   ] */ 0x00, // 0000.0000 <--- P1/P2 GBT Number Transceivers
/* [171] */ 0xFF, // 1111.1111 <--- Max Clock for TCK in MHz (0xFF = maximum, unused)

/* no I2C device other than the EEPROM on bus, so no I2C device definition multi-record */
/* MultiRecord area pad, so that it is 8B-aligned */
/* [172] */ 0x00, // padding with 0
/* [173] */ 0x00, // padding with 0
/* [174] */ 0x00, // padding with 0
/* [175] */ 0x00 // padding with 0

};

/*
 * Write buffer for writing a page.
 */
u8 WriteBuffer[sizeof(AddressType) + PAGE_SIZE];

u8 ReadBuffer[PAGE_SIZE];	/* Read buffer for reading a page. */

#if defined(XPAR_XIICPS_NUM_INSTANCES) && (XPAR_XIICPS_NUM_INSTANCES > 0)
/*****************************************************************************/
/**
* This function writes variable data to the FRU block.
*
* @param	dwManDate is the number of minutes lapsed, in the moment of
*           manufacturing, from 00:00 hours 1/1/1996.
* @param	dwBrdSerialNo is the serial number of the manufactured board.
*
* @return	none.
*
******************************************************************************/
int WriteIpmiToEeprom(Xuint32 dwManDate, Xuint32 dwBrdSerialNo) {

    u32 Index;
    int Status;
    AddressType Address = EEPROM_START_ADDRESS;
    unsigned int ibWrite = 0;
    u8 ReadBuffer[PAGE_SIZE];	/* Read buffer for reading a page. */

    if(verbose) {
        xil_printf("\r\nStarting the FMC EEprom program...");
    }

    if(verbose) {
        xil_printf("\r\nGenerating IPMI...");
    }

    GenIpmi(dwManDate, dwBrdSerialNo);

    while (ibWrite < sizeof(rgbDigilentIpmi))
    {
        /*
         * Initialize the data to write and the read buffer.
         */
        if (sizeof(Address) == 1) {
            WriteBuffer[0] = (u8) (Address);
        }
        else {
            WriteBuffer[0] = (u8) (Address >> 8);
            WriteBuffer[1] = (u8) (Address);
        }

        unsigned int BytesToWrite = (sizeof(rgbDigilentIpmi) - ibWrite > PAGE_SIZE) ? PAGE_SIZE : sizeof(rgbDigilentIpmi) - ibWrite;
        for (Index = 0; Index < BytesToWrite; Index++) {
            WriteBuffer[sizeof(Address) + Index] = rgbDigilentIpmi[ibWrite+Index];
            ReadBuffer[Index] = 0;
        }

        if(verbose) {
            xil_printf("\r\nWriting IPMI data to EEprom address %d...", Address);
        }

        /*
         * Write to the EEPROM.
         */
        Status = EepromWriteData(sizeof(Address) + BytesToWrite);
        if (Status != XST_SUCCESS) {
            return XST_FAILURE;
        }

        if(verbose) {
            xil_printf("\r\nReading back IPMI data from EEprom address %d...", Address);
        }

        /*
         * Read from the EEPROM.
         */
        Status = EepromReadData(ReadBuffer, BytesToWrite, Address);
        if (Status != XST_SUCCESS) {
            return XST_FAILURE;
        }

        if(verbose) {
            xil_printf("\r\nVerifying data...");
        }

        /*
         * Verify the data read against the data written.
         */
        for (Index = 0; Index < BytesToWrite; Index++) {
            //xil_printf("\r\n%d. 0x%x", Index, ReadBuffer[Index]);
            if (ReadBuffer[Index] != WriteBuffer[Index + sizeof(Address)]) {
                xil_printf("\r\nAddress %d. rd = 0x%x | wr = 0x%x",
                        Address+Index, ReadBuffer[Index], WriteBuffer[Index+sizeof(Address)]);
                return XST_FAILURE;
            }
            ReadBuffer[Index] = 0;
        }

        ibWrite += BytesToWrite;
        Address += BytesToWrite;
    }

    if(verbose) {
        xil_printf("\r\nDone, exiting.");
    }

    return XST_SUCCESS;
}
#endif

/*****************************************************************************/
/**
* This function writes variable data to the FRU block.
*
* @param	dwManDate is the number of minutes lapsed, in the moment of
*           manufacturing, from 00:00 hours 1/1/1996, LSB first
* @param	dwBrdSerialNo is the serial number of the manufactured board,
* 			MSB first
*
* @return	none.
*
******************************************************************************/
void GenIpmi(Xuint32 dwManDate, Xuint32 dwBrdSerialNo) {

    Xuint8 bSum = 0;
    unsigned int i;

    // Storing manufacturing date (number of minutes from 00:00 hrs 1/1/96) LSB first
    rgbDigilentIpmi[MANDATE_POS] = dwManDate & 0xFF;
    rgbDigilentIpmi[MANDATE_POS+1] = (dwManDate >> 8) & 0xFF;
    rgbDigilentIpmi[MANDATE_POS+2] = (dwManDate >> 16) & 0xFF;

    // Storing board serial number - 852884 MSB first
    rgbDigilentIpmi[SN_POS] = (dwBrdSerialNo >> 16) & 0xFF;
    rgbDigilentIpmi[SN_POS+1] = (dwBrdSerialNo >> 8) & 0xFF;
    rgbDigilentIpmi[SN_POS+2] = dwBrdSerialNo & 0xFF;

    // Calculating and storing zero checksum
    unsigned int boardAreaOffset = rgbDigilentIpmi[COMMON_HEADER_BOARD_AREA_OFFSET] * 8;
    unsigned int boardAreaLength = rgbDigilentIpmi[boardAreaOffset + BOARD_AREA_LENGTH_OFFSET] * 8;
    for(i=boardAreaOffset; i<boardAreaOffset+boardAreaLength-1; i++) {
        bSum += rgbDigilentIpmi[i];
    }
    rgbDigilentIpmi[boardAreaOffset+boardAreaLength-1] = (~bSum + 0x01) & 0xFF;
}

#if defined(XPAR_XIICPS_NUM_INSTANCES) && (XPAR_XIICPS_NUM_INSTANCES > 0)
/*****************************************************************************/
/**
* This function reads data from the IIC serial EEPROM into a specified buffer.
*
* @param	BufferPtr contains the address of the data buffer to be filled.
* @param	ByteCount contains the number of bytes in the buffer to be read.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		None.
*
******************************************************************************/
int EepromReadData(u8 *BufferPtr, u16 ByteCount, u8 StartAddress)
{
    int Status;
    AddressType Address = StartAddress;

    /*
     * Position the Pointer in EEPROM.
     */
    if (sizeof(Address) == 1) {
        WriteBuffer[0] = (u8) (Address);
    }
    else {
        WriteBuffer[0] = (u8) (Address >> 8);
        WriteBuffer[1] = (u8) (Address);
    }

    Status = EepromWriteData(sizeof(Address));
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    /*
     * Receive the Data.
     */
    Status = XIicPs_MasterRecvPolled(&IicInstance, BufferPtr,
                      ByteCount, IIC_SLAVE_ADDR);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    /*
     * Wait until bus is idle to start another transfer.
     */
    while (XIicPs_BusIsBusy(&IicInstance));

    return XST_SUCCESS;
}

/*****************************************************************************/
/**
* This function writes a buffer of data to the IIC serial EEPROM.
*
* @param	ByteCount contains the number of bytes in the buffer to be
*		written.
*
* @return	XST_SUCCESS if successful else XST_FAILURE.
*
* @note		The Byte count should not exceed the page size of the EEPROM as
*		noted by the constant PAGE_SIZE.
*
******************************************************************************/
int EepromWriteData(u16 ByteCount)
{
    int Status;

    /*
     * Send the Data.
     */
    Status = XIicPs_MasterSendPolled(&IicInstance, WriteBuffer,
                      ByteCount, IIC_SLAVE_ADDR);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    }

    /*
     * Wait until bus is idle to start another transfer.
     */
    while (XIicPs_BusIsBusy(&IicInstance));

    /*
     * Wait for a bit of time to allow the programming to complete
     */
    usleep(250000);

    return XST_SUCCESS;
}
#endif

// define allocation function for fru functions to use
void* fru_alloc(size_t size) { return malloc(size); }

#if defined(XPAR_XIICPS_NUM_INSTANCES) && (XPAR_XIICPS_NUM_INSTANCES > 0)
XStatus fUpgradeNeeded(uint8_t manufDate[3], uint8_t serialNum[3])
{
    XStatus Status;
    uint8_t rgbFRU[256];

    Status = EepromReadData(rgbFRU, sizeof(rgbFRU), 0);
    if (XST_SUCCESS != Status)
        return Status;

    struct fru_common_header* psCH = (struct fru_common_header*)rgbFRU;
    if (!fru_header_cksum_ok(psCH))
    {
        if (verbose) xil_printf("\r\nCommon Header Checksum failed.");
        return XST_FAILURE;

    }
    struct fru_board_info_area* psBIA = fru_get_board_area(psCH);
    if (!fru_bia_cksum_ok(psBIA))
    {
        if (verbose) xil_printf("\r\nBoard Info Area Checksum failed.");
        return XST_FAILURE;
    }
    char* szManuf = fru_get_board_manufacturer(psCH);
    if (szManuf == NULL || strcmp(szManuf, "Digilent"))
    {
        if (verbose) xil_printf("\r\nManufacturer does not match Digilent.");
        return XST_FAILURE;
    }
    char* szPN = fru_get_part_number(psCH);
    if (szPN == NULL || strcmp(szPN, "200-264"))
    {
        if (verbose) xil_printf("\r\nP/N does not match 200-264.");
        return XST_FAILURE;
    }
    //Get Manufacturing date and serial number
    struct fru_type_length* tl = fru_get_board_tl(psCH, 2);
    if (fru_type(tl) == FRU_TYPE_BINARY && fru_length(tl) == 4) //fru_length adds 1
    {
        memcpy(serialNum, tl->data, 3);
    } else {
        memset(serialNum, 0, 3);
    }
    memcpy(manufDate, psBIA->mfg_date, 3);

    char* szFRU_ID = fru_get_fru_id(psCH);
    if (szFRU_ID != NULL && 0 == strcmp(szFRU_ID, "Digilent"))
    {
        //First FRU version had "Digilent" string instead of binary
        //Manufacturing date had the wrong byte order
        manufDate[0] = psBIA->mfg_date[2];
        manufDate[2] = psBIA->mfg_date[0];
        return XST_SUCCESS;
    }
    struct fru_type_length* psTL = fru_get_board_tl(psCH, 4);
    if (psTL != NULL && fru_type(psTL) == FRU_TYPE_BINARY &&
            fru_length(psTL) == 2)
    {
        uint8_t id = *psTL->data;
        if (verbose)
        {
            xil_printf("\r\nFRU ID in EEPROM 0x%02x", id);
            xil_printf("\r\nFRU_ID in programmer 0x%02x", kFRU_ID);
        }
        if (FRU_ID > id) return XST_SUCCESS;
    }

    return XST_NO_DATA;
}
#endif

XStatus fruread(uint8_t * rgbFRU, unsigned size)
{
    XStatus Status;
    //uint8_t rgbFRU[256];

    //Status = EepromReadData(rgbFRU, sizeof(rgbFRU), 0);
    //if (XST_SUCCESS != Status)
    //	return Status;

    struct fru_common_header* psCH = (struct fru_common_header*)rgbFRU;
    if (!fru_header_cksum_ok(psCH))
    {
        if (verbose) xil_printf("\r\nCommon Header Checksum failed.");
        return XST_FAILURE;

    }
    struct fru_board_info_area* psBIA = fru_get_board_area(psCH);
    if (!fru_bia_cksum_ok(psBIA))
    {
        if (verbose) xil_printf("\r\nBoard Info Area Checksum failed.");
        return XST_FAILURE;
    }
    char* szManuf = fru_get_board_manufacturer(psCH);
    if (szManuf == NULL || strcmp(szManuf, "Digilent"))
    {
        if (verbose) xil_printf("\r\nManufacturer does not match Digilent.");
        return XST_FAILURE;
    }
    char* szPN = fru_get_part_number(psCH);
    if (szPN == NULL || strcmp(szPN, "200-264"))
    {
        if (verbose) xil_printf("\r\nP/N does not match 200-264.");
        return XST_FAILURE;
    }
    //Get Manufacturing date and serial number
    struct fru_type_length* tl = fru_get_board_tl(psCH, 2);
    if (fru_type(tl) == FRU_TYPE_BINARY && fru_length(tl) == 4) //fru_length adds 1
    {
        //memcpy(serialNum, tl->data, 3);
    } else {
        //memset(serialNum, 0, 3);
    }
    //memcpy(manufDate, psBIA->mfg_date, 3);

    char* szFRU_ID = fru_get_fru_id(psCH);
    if (szFRU_ID != NULL && 0 == strcmp(szFRU_ID, "Digilent"))
    {
        //First FRU version had "Digilent" string instead of binary
        //Manufacturing date had the wrong byte order
        //manufDate[0] = psBIA->mfg_date[2];
        //manufDate[2] = psBIA->mfg_date[0];
        return XST_SUCCESS;
    }
    struct fru_type_length* psTL = fru_get_board_tl(psCH, 4);
    if (psTL != NULL && fru_type(psTL) == FRU_TYPE_BINARY &&
            fru_length(psTL) == 2)
    {
        uint8_t id = *psTL->data;
        if (verbose)
        {
            xil_printf("\r\nFRU ID in EEPROM 0x%02x", id);
            xil_printf("\r\nFRU_ID in programmer 0x%02x", kFRU_ID);
        }
        if (FRU_ID > id) return XST_SUCCESS;
    }

    return XST_NO_DATA;
}

#if defined(XPAR_XIICPS_NUM_INSTANCES) && (XPAR_XIICPS_NUM_INSTANCES > 0)
XStatus InitSytem()
{
    XStatus Status;
    {
        XIicPs_Config* ConfigPtr;

        /*
         * Initialize the IIC driver so that it is ready to use.
         */
        ConfigPtr = XIicPs_LookupConfig(IIC_DEVICE_ID);
        if (ConfigPtr == NULL) {
            return XST_FAILURE;
        }

        Status = XIicPs_CfgInitialize(&IicInstance, ConfigPtr, ConfigPtr->BaseAddress);
        if (Status != XST_SUCCESS) {
            return XST_FAILURE;
        }

        /*
         * Set the IIC serial clock rate.
         */
        XIicPs_SetSClk(&IicInstance, IIC_SCLK_RATE);
    }
    {
        XGpioPs_Config* ConfigPtr;

        /*
         * Initialize the IIC driver so that it is ready to use.
         */
        ConfigPtr = XGpioPs_LookupConfig(GPIO_DEVICE_ID);
        if (ConfigPtr == NULL) {
            return XST_FAILURE;
        }

        Status = XGpioPs_CfgInitialize(&GpioInstance, ConfigPtr, ConfigPtr->BaseAddr);
        if (Status != XST_SUCCESS) {
            return XST_FAILURE;
        }

        XGpioPs_SetDirectionPin(&GpioInstance, FMC_PRSNT_L_PIN, 0); //Input
    }
    return XST_SUCCESS;
}
#endif

int fIsCardPresent()
{
    u32 gpio_reg;
    gpio_reg = XGpioPs_ReadPin(&GpioInstance, FMC_PRSNT_L_PIN);
    return (gpio_reg == 0);
}

