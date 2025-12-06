#ifndef _FMC_EEPROM_H_
#define _FMC_EEPROM_H_

#include "fmc_iic.h"
#include "fmc_hdmi_cam.h"

int fmc_eeprom_parse(fmc_hdmi_cam_t *pContext);
int fmc_hdmio_edid_parse(fmc_hdmi_cam_t *pContext);

#endif//_FMC_EEPROM_H_
