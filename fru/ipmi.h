#include <stdio.h>
#include <xbasic_types.h>
#include <xstatus.h>
//#include "sleep.h"
//#include "xiicps.h"
//#include "xil_printf.h"

int WriteIpmiToEeprom(Xuint32 dwManDate, Xuint32 dwBrdSerialNo);
void GenIpmi(Xuint32 dwManDate, Xuint32 dwBrdSerialNo);
int EepromReadData(u8 *BufferPtr, u16 ByteCount, u8 StartAddress);
int EepromWriteData(u16 ByteCount);
XStatus fUpgradeNeeded(uint8_t manufDate[3], uint8_t serialNum[3]);
XStatus fruread(uint8_t * rgbFRU, unsigned size);

int fIsCardPresent();
XStatus InitSytem();
