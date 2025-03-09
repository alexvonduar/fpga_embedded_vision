PROJECT_NAME := rpi_mipi_to_mpsoc_displayport
PROJECT_DIR  := ${TOP}/projects/KV260_RPI_MIPI_DP_2024.2
SOURCE_DIR   := ${TOP}/kv260
hw_file=${PROJECT_DIR}/vivado/${PROJECT_NAME}.xsa

hw: #$(hw_file)
	make -C fpga PROJECT_NAME=${PROJECT_NAME} PROJECT_DIR=${PROJECT_DIR} SOURCE_DIR=${SOURCE_DIR} bitstream

app_src_dir=${SOURCE_DIR}/software/src
app_src=$(wildcard $(app_src_dir)/*)
app_script=${SOURCE_DIR}/software/scripts/vitis_app.tcl
app_workspace=${PROJECT_DIR}/vitis

app: hw $(app_src) $(app_script)
	@echo "Building app"
	xsct ${app_script} ${hw_file} ${app_src_dir} ${app_workspace} ${PROJECT_NAME} -notrace

all: app
	@echo "Done"

.PHONY: all

clean:
	make -C fpga PROJECT_NAME=${PROJECT_NAME} PROJECT_DIR=${PROJECT_DIR} SOURCE_DIR=${SOURCE_DIR} clean
	rm -rf $(app_workspace)
