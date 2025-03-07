ifeq ($(TOP),)
$(error TOP directory not set)
endif

PROJECT ?= Mercury_XU6_ST1
#BOARD ?= MYIR7020
VIVADO_VER ?= 2024.2

ifeq ("$(wildcard $(TOP))", "")
$(error TOP ${TOP} does not exist)
endif

TARGET_DIR := ${TOP}/enclustra/Vivado/ME-XU6-2CG-1E-D10H

VIVADO_PRJ := $(TARGET_DIR)/$(PROJECT).xpr
#VIVADO_BD := $(TARGET_DIR)/$(PROJECT).bd
VIVADO_HW := $(TARGET_DIR)/$(PROJECT).xsa

$(VIVADO_PRJ): ${CURDIR}/scripts/create_project.tcl
	vivado -mode batch -notrace -source $<

$(VIVADO_HW) : ${CURDIR}/scripts/run.tcl $(CURDIR)/scripts/utils.tcl $(VIVADO_PRJ)
	vivado -mode batch -notrace -source $< -tclargs top=${TOP} project=Mercury_XU6_ST1 output=${VIVADO_HW}

VITIS_WS := $(TARGET_DIR)/$(PROJECT).vitis
VITIS_PLATFORM_NAME := $(PROJECT)_platform
VITIS_PLATFORM_PROJ := $(VITIS_WS)/$(VITIS_PLATFORM_NAME)/platform.spr
VITIS_APP_NAME := $(PROJECT)_app
VITIS_SYS_NAME := $(PROJECT)_system
VITIS_SYS_PROJ := $(VITIS_WS)/$(VITIS_SYS_NAME)/$(VITIS_SYS_NAME).spr
BUILD ?= Release


BOOT_FILE := ${VITIS_WS}/${PROJECT}_system/${BUILD}/sd_card/BOOT.BIN

$(VITIS_PLATFORM_PROJ) : ${CURDIR}/scripts/vitis_platform.tcl $(VIVADO_HW)
	xsct $< ${PROJECT} ${VITIS_PLATFORM_NAME} ${TOP} ${VITIS_WS} ${VIVADO_HW} -notrace

$(BOOT_FILE): ${CURDIR}/scripts/vitis_app.tcl $(VITIS_PLATFORM_PROJ) $(AVNET_SW_BSP_SOURCES) $(AVNET_SW_APP_SOURCES)
	xsct $< ${PROJECT} ${VITIS_PLATFORM_NAME} ${VITIS_APP_NAME} ${VITIS_SYS_NAME} ${TOP} ${VITIS_WS} $(BUILD) -notrace

all: $(BOOT_FILE)
	cp $< $(TARGET_DIR)/

.PHONY: all
