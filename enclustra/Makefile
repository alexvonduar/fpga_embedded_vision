ifeq ($(TOP),)
$(error TOP directory not set)
endif

CARRIER := ME_ST1
SOM := ME-XU6-2CG-1E-D10H
#BOARD ?= ME_ST1_XU6_2CG_1E_D10H
BOARD ?= me_st1_xu6_2cg
INPUT ?= rpi_mipi0
OUTPUT ?= dp
VIVADO_VER ?= 2024.2
PROJECT_NAME ?= $(INPUT)_$(OUTPUT)_$(BOARD)

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
	vivado -mode batch -notrace -source $< -tclargs $(SOM) project_name=$(PROJECT_NAME) vivado_dir=${VIVADO_DIR}

$(VIVADO_HW) : ${CURDIR}/scripts/run.tcl $(CURDIR)/scripts/utils.tcl $(VIVADO_PRJ)
	vivado -mode batch -notrace -source $< -tclargs top=${TOP} project=$(PROJECT_NAME) vivado_dir=${VIVADO_DIR} output=${VIVADO_HW}

#VITIS_WS := $(TARGET_DIR)/$(PROJECT_NAME).vitis
VITIS_PLATFORM_NAME := $(PROJECT_NAME)_platform
VITIS_PLATFORM_PROJ := $(VITIS_DIR)/$(VITIS_PLATFORM_NAME)/platform.spr
VITIS_APP_NAME := $(PROJECT_NAME)_app
VITIS_SYS_NAME := $(PROJECT_NAME)_system
VITIS_SYS_PROJ := $(VITIS_DIR)/$(VITIS_SYS_NAME)/$(VITIS_SYS_NAME).spr
BUILD ?= Release

SOURCE_DIR   := ${TOP}/kv260
APP_SRC_DIR =${SOURCE_DIR}/software/src
APP_SRCs = $(wildcard $(APP_SRC_DIR)/*) $(wildcard $(APP_SRC_DIR)/*/*) $(wildcard $(APP_SRC_DIR)/*/*/*)
APP_SCRIPT = ${CURDIR}/scripts/vitis_app.py
APP_BIN := ${VITIS_DIR}/${VITIS_APP_NAME}/build/${VITIS_APP_NAME}.elf
BIF_FILE = ${VITIS_DIR}/boot.bif

#BOOT_FILE := ${VITIS_DIR}/${PROJECT_NAME}_system/${BUILD}/sd_card/BOOT.BIN
BOOT_BIN := ${TARGET_DIR}/BOOT.BIN

#$(VITIS_PLATFORM_PROJ) : ${CURDIR}/scripts/vitis_platform.tcl $(VIVADO_HW)
#	xsct $< ${PROJECT_NAME} ${VITIS_PLATFORM_NAME} ${TOP} ${VITIS_DIR} ${VIVADO_HW}

$(APP_BIN): ${APP_SCRIPT} $(APP_SRCs) $(VIVADO_HW)
	vitis -s ${APP_SCRIPT} --hardware=${VIVADO_HW} --source=${APP_SRC_DIR} --workspace=${VITIS_DIR} --project=${PROJECT_NAME}

$(BOOT_BIN): $(APP_BIN) $(BIF_FILE)
	@echo "Building boot.bin"
	bootgen -image $(BIF_FILE) -arch zynqmp -w -o $(BOOT_BIN)

all: $(BOOT_BIN)
	rm -rf ${CURDIR}/vivado*.jou ${CURDIR}/vivado*.log

.PHONY: all
