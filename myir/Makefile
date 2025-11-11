
#TOP ?= $(PWD)

ifeq ($(TOP),)
$(error TOP directory not set)
endif

PROJECT ?= fmchc_python1300c
#BOARD ?= MYIR7020
VIVADO_VER ?= 2025.1

ifeq ("$(wildcard $(TOP))", "")
$(error TOP ${TOP} does not exist)
endif

WS_DIR := ${TOP}/projects
TARGET_DIR := ${WS_DIR}/${PROJECT}_${BOARD}_${VIVADO_VER}

VIVADO_PRJ := $(TARGET_DIR)/$(PROJECT).xpr
#VIVADO_BD := $(TARGET_DIR)/$(PROJECT).bd
VIVADO_HW := $(TARGET_DIR)/$(PROJECT).xsa

AVNET_IP_SOURCES := $(shell find $(TOP)/avnet/IP -type f)

$(info $(BOARD))
ifeq ($(BOARD), MYIR7020)
	#$(info $(BOARD) is MYIR7020)
	XDC_FILE=${CURDIR}/myir7020_fmchc_python1300c.xdc
else ifeq ($(BOARD), ZYNQ_DEV)
	#$(info $(BOARD) is ZYNQ_DEV)
	XDC_FILE=${CURDIR}/zynqdev_fmchc_python1300c.xdc
endif


$(VIVADO_PRJ): ${CURDIR}/bd.tcl ${CURDIR}/utils.tcl ${XDC_FILE} $(AVNET_IP_SOURCES)
	vivado -mode batch -notrace -source $< -tclargs project=$(PROJECT) board=$(BOARD) top=${TOP} ws=${WS_DIR} xdc=${XDC_FILE} vivado_ver=${VIVADO_VER}

$(VIVADO_HW) : ${CURDIR}/run.tcl $(VIVADO_PRJ)
	#faketime -f "-1y" vivado -mode batch -notrace -source $< -tclargs project=$(PROJECT) board=$(BOARD) top=${TOP} vivado_ver=${VIVADO_VER} output=${VIVADO_HW}
	vivado -mode batch -notrace -source $< -tclargs project=$(PROJECT) board=$(BOARD) top=${TOP} ws=${WS_DIR} vivado_ver=${VIVADO_VER} output=${VIVADO_HW}

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


BOOT_FILE := $(TARGET_DIR)/BOOT.BIN
APP_FILE := ${VITIS_WS}/${PROJECT}_app/build/${PROJECT}_app.elf
BIF_FILE := ${TARGET_DIR}/boot.bif
#./workspace-fmchc_python1300c/fmc_python1300c_app/build/fmc_python1300c_app.elf

#$(VITIS_PLATFORM_PROJ) : vitis_platform.tcl $(VIVADO_HW)
#	xsct $< ${PROJECT} ${VITIS_PLATFORM_NAME} ${TOP} ${VITIS_WS} ${VIVADO_HW} -notrace
$(APP_FILE): vitis_app.py $(VIVADO_HW)
	echo "Building Vitis Application... "
	echo $(APP_FILE)
	vitis -s vitis_app.py --top $(TOP) --project $(PROJECT) --output $(TARGET_DIR) --target $(BOARD) --version $(VIVADO_VER)

#$(BOOT_FILE): vitis_app.tcl $(VITIS_PLATFORM_PROJ) $(AVNET_SW_BSP_SOURCES) $(AVNET_SW_APP_SOURCES)
#	xsct $< ${PROJECT} ${VITIS_PLATFORM_NAME} ${VITIS_APP_NAME} ${VITIS_SYS_NAME} ${TOP} ${VITIS_WS} $(BUILD) -notrace

$(BOOT_FILE): vitis_app.py $(APP_FILE) $(BIF_FILE)
	#rm $(BOOT_FILE)
	bootgen -image $(BIF_FILE) -arch zynq -w -o $@

all: $(BOOT_FILE)
#	cp $< $(TARGET_DIR)/
	rm -rf $(TOP)/myir/vivado*.jou $(TOP)/myir/vivado*.log $(TOP)/myir/video_ip_core_status.log
	
.PHONY: all
