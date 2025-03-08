ifeq ($(TOP),)
$(error TOP directory not set)
endif

VIVADO_VER ?= 2024.2
PROJECT_NAME ?= ME_ST1_XU6_2CG_1E_D10H_MIPI0_1080P60_DP

ifeq ("$(wildcard $(TOP))", "")
$(error TOP ${TOP} does not exist)
endif

TARGET_DIR := ${TOP}/projects/$(PROJECT_NAME)_${VIVADO_VER}
VIVADO_DIR := ${TARGET_DIR}/vivado
VITIS_DIR := ${TARGET_DIR}/vitis

VIVADO_PRJ := $(VIVADO_DIR)/$(PROJECT_NAME).xpr
#VIVADO_BD := $(VIVADO_DIR)/$(PROJECT_NAME).bd
VIVADO_HW := $(VIVADO_DIR)/$(PROJECT_NAME).xsa

$(VIVADO_PRJ): ${CURDIR}/scripts/create_project.tcl
	vivado -mode batch -notrace -source $< -tclargs ME-XU6-2CG-1E-D10H project_name=$(PROJECT_NAME) vivado_dir=${VIVADO_DIR}

$(VIVADO_HW) : ${CURDIR}/scripts/run.tcl $(CURDIR)/scripts/utils.tcl $(VIVADO_PRJ)
	vivado -mode batch -notrace -source $< -tclargs top=${TOP} project=$(PROJECT_NAME) vivado_dir=${VIVADO_DIR} output=${VIVADO_HW}

#VITIS_WS := $(TARGET_DIR)/$(PROJECT_NAME).vitis
VITIS_PLATFORM_NAME := $(PROJECT_NAME)_platform
VITIS_PLATFORM_PROJ := $(VITIS_DIR)/$(VITIS_PLATFORM_NAME)/platform.spr
VITIS_APP_NAME := $(PROJECT_NAME)_app
VITIS_SYS_NAME := $(PROJECT_NAME)_system
VITIS_SYS_PROJ := $(VITIS_DIR)/$(VITIS_SYS_NAME)/$(VITIS_SYS_NAME).spr
BUILD ?= Release


BOOT_FILE := ${VITIS_DIR}/${PROJECT_NAME}_system/${BUILD}/sd_card/BOOT.BIN

$(VITIS_PLATFORM_PROJ) : ${CURDIR}/scripts/vitis_platform.tcl $(VIVADO_HW)
	xsct $< ${PROJECT_NAME} ${VITIS_PLATFORM_NAME} ${TOP} ${VITIS_DIR} ${VIVADO_HW}

$(BOOT_FILE): ${CURDIR}/scripts/vitis_app.tcl $(VITIS_PLATFORM_PROJ) $(AVNET_SW_BSP_SOURCES) $(AVNET_SW_APP_SOURCES)
	xsct $< ${PROJECT_NAME} ${VITIS_PLATFORM_NAME} ${VITIS_APP_NAME} ${VITIS_SYS_NAME} ${TOP} ${VITIS_DIR} $(BUILD) -notrace

all: $(BOOT_FILE)
	cp $< $(TARGET_DIR)/

.PHONY: all
