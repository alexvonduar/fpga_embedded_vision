#ifndef _FMC_EEPROM_H_
#define _FMC_EEPROM_H_

#include "fmc_iic.h"
#include "fmc_hdmi_cam.h"

int fmc_eeprom_parse(fmc_hdmi_cam_t *pContext);
#if defined(USE_EDID_DECODE) && USE_EDID_DECODE
int fmc_hdmio_edid_parse(fmc_hdmi_cam_t *pContext);
#endif

#endif//_FMC_EEPROM_H_
