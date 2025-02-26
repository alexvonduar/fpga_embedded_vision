hw_file=$(shell pwd)/fpga/build/imx219_to_mpsoc_displayport.xsa

hw: #$(hw_file)
	make -C fpga bitstream

app_src_dir=$(shell pwd)/software/src
app_src=$(wildcard $(app_src_dir)/*)
app_script=$(shell pwd)/software/scripts/vitis_app.tcl
app_workspace=$(shell pwd)/vitis

app: hw $(app_src) $(app_script)
	@echo "Building app"
	xsct ${app_script} ${hw_file} ${app_src_dir} ${app_workspace} -notrace

all: app
	@echo "Done"

.PHONY: all

clean:
	make -C fpga clean
	rm -rf $(app_workspace)
