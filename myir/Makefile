
#TOP ?= $(PWD)

ifeq ($(TOP),)
$(error TOP directory not set)
endif

PROJECT ?= fmchc_python1300c
BOARD ?= MYIR7020
VIVADO_VER ?= 2023.1

ifeq ("$(wildcard $(TOP))", "")
$(error TOP ${TOP} does not exist)
endif

TARGET_DIR := ${TOP}/${PROJECT}_${BOARD}_${VIVADO_VER}

VIVADO_PRJ := $(TARGET_DIR)/$(PROJECT).xpr
#VIVADO_BD := $(TARGET_DIR)/$(PROJECT).bd
VIVADO_HW := $(TARGET_DIR)/$(PROJECT).xsa

AVNET_IP_SOURCES := $(shell find $(TOP)/avnet/IP -type f)

$(VIVADO_PRJ): ${CURDIR}/bd.tcl ${CURDIR}/*.xdc ${CURDIR}/utils.tcl $(AVNET_IP_SOURCES)
	vivado -mode batch -notrace -source $< -tclargs project=$(PROJECT) board=$(BOARD) top=${TOP} vivado_ver=${VIVADO_VER}

$(VIVADO_HW) : ${CURDIR}/run.tcl $(VIVADO_PRJ)
	#faketime -f "-1y" vivado -mode batch -notrace -source $< -tclargs project=$(PROJECT) board=$(BOARD) top=${TOP} vivado_ver=${VIVADO_VER} output=${VIVADO_HW}
	vivado -mode batch -notrace -source $< -tclargs project=$(PROJECT) board=$(BOARD) top=${TOP} vivado_ver=${VIVADO_VER} output=${VIVADO_HW}

AVNET_SW_BSP_SOURCES := $(shell find $(TOP)/avnet/Projects/$(PROJECT)/software/sw_repository -type f)
AVNET_SW_APP_SOURCES := $(shell find $(TOP)/avnet/Projects/$(PROJECT)/software/$(PROJECT)_app -type f)
#$(info AVNET_IP_SOURCES: $(AVNET_IP_SOURCES))

VITIS_WS := $(TARGET_DIR)/$(PROJECT).vitis
VITIS_PLATFORM_NAME := $(PROJECT)_platform
VITIS_PLATFORM_PROJ := $(VITIS_WS)/$(VITIS_PLATFORM_NAME)/platform.spr
VITIS_APP_NAME := $(PROJECT)_app
VITIS_SYS_NAME := $(PROJECT)_system
VITIS_SYS_PROJ := $(VITIS_WS)/$(VITIS_SYS_NAME)/$(VITIS_SYS_NAME).spr
BUILD ?= Release


BOOT_FILE := ${VITIS_WS}/${PROJECT}_system/${BUILD}/sd_card/BOOT.BIN

$(VITIS_PLATFORM_PROJ) : vitis_platform.tcl $(VIVADO_HW)
	xsct $< ${PROJECT} ${VITIS_PLATFORM_NAME} ${TOP} ${VITIS_WS} ${VIVADO_HW} -notrace

$(BOOT_FILE): vitis_app.tcl $(VITIS_PLATFORM_PROJ) $(AVNET_SW_BSP_SOURCES) $(AVNET_SW_APP_SOURCES)
	xsct $< ${PROJECT} ${VITIS_PLATFORM_NAME} ${VITIS_APP_NAME} ${VITIS_SYS_NAME} ${TOP} ${VITIS_WS} $(BUILD) -notrace

all: $(BOOT_FILE)
	cp $< $(TARGET_DIR)/
	
.PHONY: all
