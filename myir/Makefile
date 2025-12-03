TOP ?=
BOARD ?=
INPUT_PORT ?=
OUTPUT_PORT ?=
KEEP_VIVADO_HW ?= 1
KEEP_VIVADO_CACHE ?= 1

ifeq (${TOP},)
$(error TOP directory not set)
endif

#PROJECT ?= fmchc_python1300c
#BOARD ?= MYIR7020
VIVADO_VER ?= 2025.1

ifeq ("$(wildcard ${TOP})", "")
$(error TOP ${TOP} does not exist)
endif

PROJECT_NAME := ${INPUT_PORT}_${OUTPUT_PORT}

WS_DIR := ${TOP}/projects
TARGET_DIR :=${WS_DIR}/${BOARD}
#PROJECT_DIR := ${TARGET_DIR}/${PROJECT_NAME}_${VIVADO_VER}

VIVADO_DIR := ${TARGET_DIR}/${PROJECT_NAME}_vivado_${VIVADO_VER}
VIVADO_PRJ := ${VIVADO_DIR}/${PROJECT_NAME}.xpr
VIVADO_HW := $(TARGET_DIR)/${PROJECT_NAME}.xsa

AVNET_IP_SOURCES := $(shell find ${TOP}/avnet/IP -type f)

$(info ${BOARD})
ifeq (${BOARD}, MYIR7020)
	#$(info ${BOARD} is MYIR7020)
	XDC_FILE=${CURDIR}/myir7020_fmchc_python1300c.xdc
else ifeq (${BOARD}, ZYNQ_DEV)
	#$(info ${BOARD} is ZYNQ_DEV)
	XDC_FILE=${CURDIR}/zynqdev_fmchc_python1300c.xdc
endif


$(VIVADO_PRJ): ${CURDIR}/bd.tcl ${CURDIR}/utils.tcl ${XDC_FILE} $(AVNET_IP_SOURCES)
	vivado -mode batch -notrace -source $< -tclargs project_name=${PROJECT_NAME} project_dir=${VIVADO_DIR} board=${BOARD} input_port=${INPUT_PORT} output_port=${OUTPUT_PORT} top=${TOP} xdc=${XDC_FILE} vivado_ver=${VIVADO_VER}

$(VIVADO_HW) : ${CURDIR}/run.tcl $(VIVADO_PRJ)
	#faketime -f "-1y" vivado -mode batch -notrace -source $< -tclargs project=$(PROJECT_NAME) board=${BOARD} top=${TOP} vivado_ver=${VIVADO_VER} output=${VIVADO_HW}
	vivado -mode batch -notrace -source $< -tclargs project_name=${PROJECT_NAME} project_dir=${VIVADO_DIR} top=${TOP} board=${BOARD} vivado_ver=${VIVADO_VER} output=${VIVADO_HW}

AVNET_SW_BSP_SOURCES := $(shell find ${TOP}/avnet/Projects/fmchc_python1300c/software/sw_repository -type f)
AVNET_SW_APP_SOURCES := $(shell find ${TOP}/avnet/Projects/fmchc_python1300c/software/fmchc_python1300c_app -type f)
#$(info AVNET_IP_SOURCES: $(AVNET_IP_SOURCES))

VITIS_WS := $(TARGET_DIR)/${PROJECT_NAME}_vitis
VITIS_PLATFORM_NAME := ${PROJECT_NAME}_platform
VITIS_PLATFORM_PROJ := ${VITIS_WS}/$(VITIS_PLATFORM_NAME)/platform.spr
VITIS_APP_NAME := ${PROJECT_NAME}_app
VITIS_SYS_NAME := ${PROJECT_NAME}_system
VITIS_SYS_PROJ := ${VITIS_WS}/${VITIS_SYS_NAME}/${VITIS_SYS_NAME}.spr
BUILD ?= Release


BOOT_FILE := $(TARGET_DIR)/${PROJECT_NAME}_BOOT.BIN
APP_FILE := ${VITIS_WS}/${PROJECT_NAME}_app/build/${PROJECT_NAME}_app.elf
BIF_FILE := ${VITIS_WS}/${PROJECT_NAME}_BOOT.bif
#./workspace-fmchc_python1300c/fmc_python1300c_app/build/fmc_python1300c_app.elf

${APP_FILE}: vitis_app.py ${VIVADO_HW}
	echo "Building Vitis Application... "
	echo ${APP_FILE}
	vitis -s vitis_app.py --top ${TOP} --hw ${VIVADO_HW} --project ${PROJECT_NAME} --output ${TARGET_DIR} --board ${BOARD} --input_port ${INPUT_PORT} --output_port ${OUTPUT_PORT} --version ${VIVADO_VER}

${BOOT_FILE}: vitis_app.py ${APP_FILE} ${BIF_FILE}
	#rm ${BOOT_FILE}
	bootgen -image ${BIF_FILE} -arch zynq -w -o $@

all: ${BOOT_FILE}
	rm -rf ${TOP}/myir/vivado*.jou ${TOP}/myir/vivado*.log ${TOP}/myir/video_ip_core_status.log

.PHONY: all
