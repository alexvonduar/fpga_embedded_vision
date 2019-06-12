

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "pcie_reg_space" "NUM_INSTANCES" "DEVICE_ID"  "C_S00_AXI_BASEADDR" "C_S00_AXI_HIGHADDR" "C_S01_AXI_BASEADDR" "C_S01_AXI_HIGHADDR"
}
