BOARD ?= kv260
INPUT ?= rpi_mipi
OUTPUT ?= dp
PROJECT_NAME := $(INPUT)_$(OUTPUT)
VIVADO_VER ?= 2024.2
PROJECT_DIR  := ${TOP}/projects/$(PROJECT_NAME)_$(BOARD)_$(VIVADO_VER)
SOURCE_DIR   := ${TOP}/kv260
hw_src =${SOURCE_DIR}/fpga
hw_file=${PROJECT_DIR}/vivado/${PROJECT_NAME}.xsa

$(hw_file): #$(hw_file)
	make -C fpga PROJECT_NAME=${PROJECT_NAME} PROJECT_DIR=${PROJECT_DIR} SOURCE_DIR=${SOURCE_DIR} BOARD=${BOARD} bitstream

app_src_dir=${SOURCE_DIR}/software/src
app_src=$(wildcard $(app_src_dir)/*) $(wildcard $(app_src_dir)/*/*) $(wildcard $(app_src_dir)/*/*/*)
app_script=${SOURCE_DIR}/software/scripts/vitis_app.py
app_workspace=${PROJECT_DIR}/vitis
app_file = ${app_workspace}/$(PROJECT_NAME)_app/build/$(PROJECT_NAME)_app.elf
bif_file = ${app_workspace}/boot.bif
boot_bin = ${PROJECT_DIR}/BOOT.BIN

$(app_file): $(hw_file) $(app_src) $(app_script)
	vitis -s ${app_script} --hardware=${hw_file} --source=${app_src_dir} --workspace=${app_workspace} --project=${PROJECT_NAME}

$(boot_bin): $(app_file) $(bif_file)
	bootgen -image $(bif_file) -arch zynqmp -w -o $(boot_bin)

all: $(boot_bin)
	rm -rf .Xil fpga/.Xil fpga/.srcs fpga/clockInfo.txt fpga/logs fpga/prj fpga/runhls.tcl

.PHONY: all

clean:
	make -C fpga PROJECT_NAME=${PROJECT_NAME} PROJECT_DIR=${PROJECT_DIR} SOURCE_DIR=${SOURCE_DIR} clean
	rm -rf $(app_workspace)
