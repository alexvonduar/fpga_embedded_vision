#include "fmc_eeprom.h"

#include <xil_printf.h>
#include <string.h>

#include "fru.h"
#include "ipmi.h"

#include "edid-decode-export.h"

#define FRU_TOTAL_SIZE 256
static unsigned char fmc_eeprom_fru_buffer[FRU_TOTAL_SIZE+1];
#define EDID_BLOCK_SIZE 512
static unsigned char fmc_edid_buffer[EDID_BLOCK_SIZE+1];

int fmc_eeprom_parse(fmc_hdmi_cam_t *pContext)
{
    int read = 0;
    memset(fmc_eeprom_fru_buffer, 0, FRU_TOTAL_SIZE+1);
    read = fmc_hdmi_cam_read_eeprom(pContext, fmc_eeprom_fru_buffer, FRU_TOTAL_SIZE);
    if (read != FRU_TOTAL_SIZE)
    {
        xil_printf("FMC EEPROM: Failed to read FRU data from EEPROM (read %d bytes)\n\r", read);
        return -1;
    }
    xil_printf("RAW EEPROM DATA:");
    for (int i = 0; i < FRU_TOTAL_SIZE; i++)
    {
        if (i % 16 == 0)
            xil_printf("\r\n%04x: ", i);
        xil_printf("%02x ", fmc_eeprom_fru_buffer[i]);
    }
    xil_printf("\r\n");
#if 0
    XStatus status = fruread(fmc_eeprom_fru_buffer, FRU_TOTAL_SIZE);
    if (status != XST_SUCCESS)
    {
        xil_printf("FMC EEPROM: Failed to parse FRU data from EEPROM (status %d)\n\r", status);
        return -1;
    }
#else
    struct FRU_DATA *fru_data = parse_FRU(fmc_eeprom_fru_buffer);
    if (fru_data == NULL)
    {
        xil_printf("FMC EEPROM: Failed to parse FRU data from EEPROM\n\r");
        return -1;
    }

    if (fru_data->Board_Area) {
        dump_BOARD(fru_data->Board_Area);
    }
    if (fru_data->MultiRecord_Area) {
        dump_MULTIRECORD(fru_data->MultiRecord_Area);
        dump_FMConnector(fru_data->MultiRecord_Area);
        dump_i2c(fru_data->MultiRecord_Area);
    }

    free_FRU(fru_data);
#endif
    return 0;
}

/*
 * gettimeofday  -- Used to get the time of the day.
 * Declared as an empty function with __weak attribute to avoid build
 * errors and easy porting.
 */
int gettimeofday (struct timeval *restrict tp, void * restrict tzp)
{
    (void)tp;
    (void)tzp;
    return 0;
}

int _gettimeofday (struct timeval *restrict tp, void * restrict tzp)
{
    (void)tp;
    (void)tzp;
    return 0;
}


int fmc_hdmio_edid_parse(fmc_hdmi_cam_t *pContext)
{
    int read = 0;
    memset(fmc_edid_buffer, 0, EDID_BLOCK_SIZE+1);
    read = fmc_hdmi_cam_hdmio_read_edid(pContext, fmc_edid_buffer, EDID_BLOCK_SIZE);
    if (read != EDID_BLOCK_SIZE)
    {
        xil_printf("FMC EEPROM: Failed to read EDID data from EEPROM (read %d bytes)\n\r", read);
        return -1;
    }
    xil_printf("RAW EDID DATA:");
    for (int i = 0; i < EDID_BLOCK_SIZE; i++)
    {
        if (i % 16 == 0)
            xil_printf("\r\n%04x: ", i);
        xil_printf("%02x ", fmc_edid_buffer[i]);
    }
    xil_printf("\r\n");

    int status = parse_edid_from_array(fmc_edid_buffer, EDID_BLOCK_SIZE);

    return 0;
}
