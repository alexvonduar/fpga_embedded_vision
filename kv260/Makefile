BOARD ?= kv260
INPUT_PORT ?= mipi0
OUTPUT_PORT ?= ps_dp
BUILD ?= Debug
PROJECT_NAME := ${INPUT_PORT}_${OUTPUT_PORT}

#get VIVADO version
VIVADO_VER = $(shell vivado -version | grep -oP 'vivado\s+v\K[0-9]+\.[0-9]+' | head -1)

ifeq (${VIVADO_VER},)
$(error Vivado not found in PATH)
endif

TARGET_DIR   := ${TOP}/projects/${BOARD}
PROJECT_DIR  := ${TARGET_DIR}/${PROJECT_NAME}_vivado_${VIVADO_VER}
SOURCE_DIR   := ${TOP}/kv260
hw_src =${SOURCE_DIR}/fpga
hw_file=${TARGET_DIR}/${PROJECT_NAME}.xsa

BOARDS ?= kv260
FMC_BOARDS ?= none
INPUT_PORTS ?= mipi0 ias0 ias1
OUTPUT_PORTS ?= ps_dp

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

$(hw_file):
	make -C ${hw_src} PROJECT_NAME=${PROJECT_NAME} TARGET_DIR=${TARGET_DIR} PROJECT_DIR=${PROJECT_DIR} SOURCE_DIR=${SOURCE_DIR} BOARD=${BOARD} bitstream

app_src_dir=${SOURCE_DIR}/software/src
app_src=$(wildcard $(app_src_dir)/*) $(wildcard $(app_src_dir)/*/*) $(wildcard $(app_src_dir)/*/*/*)
app_script=${SOURCE_DIR}/software/scripts/vitis_app.py
app_workspace=${TARGET_DIR}/${PROJECT_NAME}_vitis
app_file = ${app_workspace}/$(PROJECT_NAME)_app/build/$(PROJECT_NAME)_app.elf
bif_file = ${app_workspace}/boot.bif
boot_bin = ${TARGET_DIR}/$(PROJECT_NAME)_BOOT.BIN

$(app_file): $(hw_file) $(app_src) $(app_script)
	vitis -s ${app_script} --hardware=${hw_file} --source=${app_src_dir} --workspace=${app_workspace} --project=${PROJECT_NAME} --build_type=${BUILD}

$(boot_bin): $(app_file) $(bif_file)
	bootgen -image $(bif_file) -arch zynqmp -w -o $(boot_bin)

all: $(boot_bin)
	rm -rf .Xil fpga/.Xil fpga/.srcs fpga/clockInfo.txt fpga/logs fpga/prj fpga/runhls.tcl

.PHONY: all

clean:
	make -C fpga PROJECT_NAME=${PROJECT_NAME} PROJECT_DIR=${PROJECT_DIR} SOURCE_DIR=${SOURCE_DIR} clean
	rm -rf $(app_workspace)
