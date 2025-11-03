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
app_src=$(wildcard $(app_src_dir)/*)
app_script=${SOURCE_DIR}/software/scripts/vitis_app.py
app_workspace=${PROJECT_DIR}/vitis

app: $(hw_file) $(app_src) $(app_script)
	@echo "Building app"
	# xsct ${app_script} ${hw_file} ${app_src_dir} ${app_workspace} ${PROJECT_NAME} -notrace
	vitis -s ${app_script} --hardware=${hw_file} --source=${app_src_dir} --workspace=${app_workspace} --project=${PROJECT_NAME}

all: app
	@echo "Done"

.PHONY: all

clean:
	make -C fpga PROJECT_NAME=${PROJECT_NAME} PROJECT_DIR=${PROJECT_DIR} SOURCE_DIR=${SOURCE_DIR} clean
	rm -rf $(app_workspace)
