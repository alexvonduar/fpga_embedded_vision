ifeq ($(TOP),)
$(error TOP directory not set)
endif

CARRIER := ME_ST1
SOM := ME-XU6-2CG-1E-D10H
#BOARD ?= ME_ST1_XU6_2CG_1E_D10H
BOARD ?= me_st1_xu6_2cg
INPUT_PORT ?= mipi0
FMC_BOARD ?=
OUTPUT_PORT ?= ps_dp
#VIVADO_VER ?= 2025.1
#PROJECT_NAME ?= $(INPUT_PORT)_$(OUTPUT_PORT)
BUILD ?= Debug

ifeq ($(FMC_BOARD), none)
PROJECT_NAME := ${INPUT_PORT}_${OUTPUT_PORT}
else
ifeq ($(FMC_BOARD), fmchc_python1300c)
ifeq ($(INPUT_PORT), fmc_python1300c)
PROJECT_NAME := ${FMC_BOARD}_${OUTPUT_PORT}
else
PROJECT_NAME := ${FMC_BOARD}_${INPUT_PORT}_${OUTPUT_PORT}
endif
else
PROJECT_NAME := ${FMC_BOARD}_${INPUT_PORT}_${OUTPUT_PORT}
endif
endif

ifeq ("$(wildcard $(TOP))", "")
$(error TOP ${TOP} does not exist)
endif

BOARDS ?= me_st1_xu6_2cg
FMC_BOARDS ?= fmchc_python1300c opsero fl1404 none
INPUT_PORTS ?= fmc_python1300c fmc_hdmi fmc_mipi0 fmc_mipi1 fmc_mipi2 fmc_mipi3 mipi0 mipi1 fmc_imx274
OUTPUT_PORTS ?= fmc_hdmi ps_dp

ifeq ($(filter $(BOARD), $(BOARDS)),)
$(error BOARD $(BOARD) is not supported. Supported BOARDS: $(BOARDS))
endif

ifeq ($(filter $(FMC_BOARD), $(FMC_BOARDS)),)
$(error FMC_BOARD $(FMC_BOARD) is not supported. Supported FMC_BOARDS: $(FMC_BOARDS))
endif

ifeq ($(filter $(INPUT_PORT), $(INPUT_PORTS)),)
$(error INPUT_PORT $(INPUT_PORT) is not supported. Supported INPUT_PORTS: $(INPUT_PORTS))
endif

ifeq ($(filter $(OUTPUT_PORT), $(OUTPUT_PORTS)),)
$(error OUTPUT_PORT $(OUTPUT_PORT) is not supported. Supported OUTPUT_PORTS: $(OUTPUT_PORTS))
endif

#get VIVADO version
VIVADO_VER = $(shell vivado -version | grep -oP 'vivado\s+v\K[0-9]+\.[0-9]+' | head -1)

ifeq ($(VIVADO_VER),)
$(error Vivado not found in PATH)
endif

TARGET_DIR := ${TOP}/projects/${BOARD}
VIVADO_DIR := ${TARGET_DIR}/${PROJECT_NAME}_vivado_${VIVADO_VER}
VITIS_DIR := ${TARGET_DIR}/${PROJECT_NAME}_vitis

VIVADO_PRJ := $(VIVADO_DIR)/$(PROJECT_NAME).xpr
#VIVADO_BD := $(VIVADO_DIR)/$(PROJECT_NAME).bd
VIVADO_HW := $(TARGET_DIR)/$(PROJECT_NAME).xsa

$(VIVADO_PRJ): ${CURDIR}/scripts/create_project.tcl
	vivado -mode batch -notrace -source $< -tclargs $(SOM) project_name=$(PROJECT_NAME) target_dir=${TARGET_DIR} vivado_dir=${VIVADO_DIR} fmc_board=${FMC_BOARD} input_port=${INPUT_PORT}

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
BOOT_BIN := ${TARGET_DIR}/${PROJECT_NAME}_BOOT.BIN

#$(VITIS_PLATFORM_PROJ) : ${CURDIR}/scripts/vitis_platform.tcl $(VIVADO_HW)
#	xsct $< ${PROJECT_NAME} ${VITIS_PLATFORM_NAME} ${TOP} ${VITIS_DIR} ${VIVADO_HW}

$(APP_BIN): ${APP_SCRIPT} $(APP_SRCs) $(VIVADO_HW)
	vitis -s ${APP_SCRIPT} --hardware=${VIVADO_HW} --source=${APP_SRC_DIR} --workspace=${VITIS_DIR} --project=${PROJECT_NAME} --top=${TOP} --build_type=${BUILD} --fmc_board=${FMC_BOARD} --input_port=${INPUT_PORT}

$(BOOT_BIN): $(APP_BIN) $(BIF_FILE)
	@echo "Building boot.bin"
	bootgen -image $(BIF_FILE) -arch zynqmp -w -o $(BOOT_BIN)

all: $(BOOT_BIN)
	rm -rf ${CURDIR}/vivado*.jou ${CURDIR}/vivado*.log

.PHONY: all
