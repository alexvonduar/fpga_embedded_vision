# ----------------------------------------------------------------------------------------------------
# Copyright (c) 2024 by Enclustra GmbH, Switzerland.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this hardware, software, firmware, and associated documentation files (the
# "Product"), to deal in the Product without restriction, including without
# limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Product, and to permit persons to whom the
# Product is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Product.
#
# THE PRODUCT IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# PRODUCT OR THE USE OR OTHER DEALINGS IN THE PRODUCT.
# ----------------------------------------------------------------------------------------------------

create_bd_design $module


create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e zynq_ultra_ps_e
set_property -dict [ list \
  CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
  CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS18} \
] [get_bd_cells zynq_ultra_ps_e]
set_property -dict [ list \
  CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__DLL__ISUSED {1} \
  CONFIG.PSU__DPAUX__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__DP__LANE_SEL {Dual Lower} \
  CONFIG.PSU__DP__REF_CLK_FREQ {27} \
  CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk3} \
  CONFIG.PSU__USE__VIDEO {1} \
  CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
  CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
  CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {DPLL} \
  CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {DPLL} \
  CONFIG.PSU__USE__S_AXI_GP0 {1} \
  CONFIG.PSU__USE__M_AXI_GP2 {1} \
] [get_bd_cells zynq_ultra_ps_e]
set_property -dict [ list \
  CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {200} \
  CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {RPLL} \
  CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} \
  CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
  CONFIG.PSU__SD0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__SD0__SLOT_TYPE {eMMC} \
  CONFIG.PSU__SD0__PERIPHERAL__IO {MIO 13 .. 22} \
  CONFIG.PSU__SD0__DATA_TRANSFER_MODE {8Bit} \
  CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__SD1__SLOT_TYPE {SD 2.0} \
  CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 46 .. 51} \
  CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
  CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 10 .. 11} \
  CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 38 .. 39} \
  CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__ENET0__GRP_MDIO__ENABLE {1} \
  CONFIG.PSU__ENET0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__USB__RESET__MODE {Disable} \
  CONFIG.PSU__USB1__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__USB3_1__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk2} \
  CONFIG.PSU__USB0__REF_CLK_FREQ {100} \
  CONFIG.PSU__USB1__REF_CLK_SEL {Ref Clk2} \
  CONFIG.PSU__USB1__REF_CLK_FREQ {100} \
  CONFIG.PSU__FPGA_PL1_ENABLE {1} \
  CONFIG.PSU__CRL_APB__PL1_REF_CTRL__FREQMHZ {50} \
  CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__GPIO2_MIO__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU_MIO_12_PULLUPDOWN {disable} \
] [get_bd_cells zynq_ultra_ps_e]

if { $PS_DDR == "PS_D10H"} {
  set_property -dict [ list \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400T} \
    CONFIG.PSU__DDRC__CWL {12} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {4096 MBits} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {15} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
    CONFIG.PSU__DDRC__ECC {Disabled} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {1} \
    CONFIG.PSU__DDRC__BUS_WIDTH {32 Bit} \
  ] [get_bd_cells zynq_ultra_ps_e]
}

if { $PS_DDR == "PS_D11"} {
  set_property -dict [ list \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400T} \
    CONFIG.PSU__DDRC__CWL {12} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {4096 MBits} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {15} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
    CONFIG.PSU__DDRC__ECC {Disabled} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {1} \
    CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
  ] [get_bd_cells zynq_ultra_ps_e]
}

if { $PS_DDR == "PS_D12E"} {
  set_property -dict [ list \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400T} \
    CONFIG.PSU__DDRC__CWL {12} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
    CONFIG.PSU__DDRC__ECC {Enabled} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {1} \
    CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
  ] [get_bd_cells zynq_ultra_ps_e]
}

if { $PS_DDR == "PS_D12"} {
  set_property -dict [ list \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400T} \
    CONFIG.PSU__DDRC__CWL {12} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
    CONFIG.PSU__DDRC__ECC {Disabled} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {1} \
    CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
  ] [get_bd_cells zynq_ultra_ps_e]
}

if { $PS_DDR == "PS_D13E"} {
  set_property -dict [ list \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400T} \
    CONFIG.PSU__DDRC__CWL {12} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {16384 MBits} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {17} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
    CONFIG.PSU__DDRC__ECC {Enabled} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {1} \
    CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
  ] [get_bd_cells zynq_ultra_ps_e]
}

if { $PS_DDR == "PS_D13"} {
  set_property -dict [ list \
    CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400T} \
    CONFIG.PSU__DDRC__CWL {12} \
    CONFIG.PSU__DDRC__DEVICE_CAPACITY {16384 MBits} \
    CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
    CONFIG.PSU__DDRC__ROW_ADDR_COUNT {17} \
    CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
    CONFIG.PSU__DDRC__ECC {Disabled} \
    CONFIG.PSU__DDRC__PARITY_ENABLE {1} \
    CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
  ] [get_bd_cells zynq_ultra_ps_e]
}

create_bd_cell -type ip -vlnv xilinx.com:ip:system_management_wiz system_management_wiz
set_property -dict [ list \
  CONFIG.TEMPERATURE_ALARM_OT_TRIGGER {85} \
  CONFIG.CHANNEL_ENABLE_VP_VN {false} \
] [get_bd_cells system_management_wiz]
set_property -dict [ list \
  CONFIG.PSU_MIO_13_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_14_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_15_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_16_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_17_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_18_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_19_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_20_PULLUPDOWN {disable} \
  CONFIG.PSU_MIO_21_PULLUPDOWN {disable} \
  CONFIG.PSU__SD0__PERIPHERAL__IO {MIO 13 .. 22} \
  CONFIG.PSU__SD0__DATA_TRANSFER_MODE {8Bit} \
  CONFIG.PSU__USE__IRQ0  {1} \
] [get_bd_cells zynq_ultra_ps_e]
set_property -dict [ list \
  CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__I2C1__PERIPHERAL__IO {EMIO} \
] [get_bd_cells zynq_ultra_ps_e]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio led
set_property -dict [ list \
  CONFIG.C_GPIO_WIDTH {3} \
  CONFIG.C_ALL_OUTPUTS {1} \
  CONFIG.C_DOUT_DEFAULT {0x00000007} \
] [get_bd_cells led]
set_property -dict [ list \
  CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \
] [get_bd_cells zynq_ultra_ps_e]

# create display video clock 1080p@60
set CLK_148M5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 CLK_148M5 ]
set_property -dict [list \
  CONFIG.PRIM_IN_FREQ.VALUE_SRC PROPAGATED \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {148.5} \
  CONFIG.USE_LOCKED {false} \
  CONFIG.USE_RESET {false} \
] [get_bd_cells CLK_148M5]

# create instance: clk_wiz_1, and set properties
set CLK_200M [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 CLK_200M ]
set_property -dict [ list \
  CONFIG.PRIM_IN_FREQ.VALUE_SRC PROPAGATED \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200} \
  CONFIG.USE_LOCKED {false} \
  CONFIG.USE_RESET {false} \
] [get_bd_cells CLK_200M]

set mipi_csi2_rx_subsyst_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:6.0 mipi_csi2_rx_subsyst_0 ]
set_property -dict [list \
  CONFIG.AXIS_TDEST_WIDTH {4} \
  CONFIG.CMN_NUM_PIXELS {1} \
  CONFIG.CMN_NUM_LANES {2} \
  CONFIG.CMN_PXL_FORMAT {RAW10} \
  CONFIG.CSI_BUF_DEPTH {4096} \
  CONFIG.C_CSI_EN_CRC {false} \
  CONFIG.C_INC_PHY {true} \
  CONFIG.DPY_LINE_RATE {912} \
  CONFIG.SupportLevel {1} \
  CONFIG.VFB_TU_WIDTH {1} \
] [get_bd_cells mipi_csi2_rx_subsyst_0]

if { $fmc_board == "opsero"} {
  if { $mipi_port == "1" }  {
    set_property -dict [list \
      CONFIG.HP_IO_BANK_SELECTION {65} \
      CONFIG.CLK_LANE_IO_LOC {L7} \
      CONFIG.CLK_LANE_IO_LOC_NAME {IO_L13P_T2L_N0_GC_QBC_65} \
      CONFIG.DATA_LANE0_IO_LOC {L1} \
      CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L7P_T1L_N0_QBC_AD13P_65} \
      CONFIG.DATA_LANE1_IO_LOC {J1} \
      CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L8P_T1L_N2_AD5P_65} \
    ] [get_bd_cells mipi_csi2_rx_subsyst_0]
  } elseif { $mipi_port == "2" } {
    set_property -dict [list \
      CONFIG.HP_IO_BANK_SELECTION {66} \
      CONFIG.CLK_LANE_IO_LOC {D7} \
      CONFIG.CLK_LANE_IO_LOC_NAME {IO_L13P_T2L_N0_GC_QBC_66} \
      CONFIG.DATA_LANE0_IO_LOC {C8} \
      CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L22P_T3U_N6_DBC_AD0P_66} \
      CONFIG.DATA_LANE1_IO_LOC {E5} \
      CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L14P_T2L_N2_GC_66} \
    ] [get_bd_cells mipi_csi2_rx_subsyst_0]
  }
} else {
  if { $mipi_port == "0" }  {
    set_property -dict [list \
      CONFIG.HP_IO_BANK_SELECTION {64} \
      CONFIG.CLK_LANE_IO_LOC {AC9} \
      CONFIG.CLK_LANE_IO_LOC_NAME {IO_L1P_T0L_N0_DBC_64} \
      CONFIG.DATA_LANE0_IO_LOC {AE9} \
      CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L2P_T0L_N2_64} \
      CONFIG.DATA_LANE1_IO_LOC {AB8} \
      CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L3P_T0L_N4_AD15P_64} \
    ] [get_bd_cells mipi_csi2_rx_subsyst_0]
  } elseif { $mipi_port == "1" } {
    set_property -dict [list \
      CONFIG.HP_IO_BANK_SELECTION {64} \
      CONFIG.CLK_LANE_IO_LOC {AD7} \
      CONFIG.CLK_LANE_IO_LOC_NAME {IO_L4P_T0U_N6_DBC_AD7P_64} \
      CONFIG.DATA_LANE0_IO_LOC {AB6} \
      CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L6P_T0U_N10_AD6P_64} \
      CONFIG.DATA_LANE1_IO_LOC {AB7} \
      CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L5P_T0U_N8_AD14P_64} \
    ] [get_bd_cells mipi_csi2_rx_subsyst_0]
  }
}

# Create instance: axi_vdma_0, and set properties
set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.3 axi_vdma_0 ]
set_property -dict [ list \
  CONFIG.c_include_mm2s_dre {1} \
  CONFIG.c_include_s2mm_dre {1} \
  CONFIG.c_mm2s_linebuffer_depth {4096} \
  CONFIG.c_s2mm_linebuffer_depth {4096} \
] [get_bd_cells axi_vdma_0]

set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:4.0 v_axi4s_vid_out_0 ]
set_property -dict [list \
  CONFIG.C_HAS_ASYNC_CLK {1} \
  CONFIG.C_NATIVE_COMPONENT_WIDTH {12} \
  CONFIG.C_PIXELS_PER_CLOCK {1} \
  CONFIG.C_S_AXIS_VIDEO_DATA_WIDTH {10} \
] [get_bd_cells v_axi4s_vid_out_0]

# Create instance: v_demosaic_0, and set properties
set v_demosaic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_demosaic:1.1 v_demosaic_0 ]
set_property -dict [ list \
  CONFIG.MAX_COLS {1920} \
  CONFIG.MAX_DATA_WIDTH {10} \
  CONFIG.MAX_ROWS {1080} \
  CONFIG.SAMPLES_PER_CLOCK {1} \
] [get_bd_cells v_demosaic_0]

# Create instance: v_gamma_lut_0, and set properties
set v_gamma_lut_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_gamma_lut:1.1 v_gamma_lut_0 ]
set_property -dict [ list \
  CONFIG.MAX_COLS {1920} \
  CONFIG.MAX_DATA_WIDTH {10} \
  CONFIG.MAX_ROWS {1080} \
] [get_bd_cells v_gamma_lut_0]

set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.2 v_tc_0 ]
set_property -dict [list \
  CONFIG.enable_detection {false} \
  CONFIG.VIDEO_MODE {1080p} \
] [get_bd_cells v_tc_0]

set v_tpg_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tpg:8.2 v_tpg_0 ]
set_property -dict [list \
  CONFIG.DISPLAY_PORT {1} \
  CONFIG.HAS_AXI4S_SLAVE {0} \
  CONFIG.MAX_DATA_WIDTH {10} \
  CONFIG.MAX_COLS {1920} \
  CONFIG.MAX_ROWS {1080} \
] [get_bd_cells v_tpg_0]

# Create instance: v_mix_0, and set properties
set v_mix_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_mix v_mix_0 ]
set_property -dict [ list \
  CONFIG.VIDEO_FORMAT {0} \
  CONFIG.SAMPLES_PER_CLOCK {1} \
  CONFIG.LAYER1_INTF_TYPE {1} \
  CONFIG.MAX_COLS {1920} \
  CONFIG.MAX_DATA_WIDTH {10} \
  CONFIG.MAX_ROWS {1080} \
  CONFIG.NR_LAYERS {2} \
] [get_bd_cells v_mix_0]

set CONST1 [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant:1.0 CONST1 ]
set_property -dict [list \
  CONFIG.CONST_VAL {1} \
  CONFIG.CONST_WIDTH {1} \
] [get_bd_cells CONST1]

set CONST0 [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant:1.0 CONST0 ]
set_property -dict [list \
  CONFIG.CONST_VAL {0} \
  CONFIG.CONST_WIDTH {1} \
] [get_bd_cells CONST0]

# Create instance: axi_smc, and set properties
set axi_smc [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc ]
set_property -dict [ list \
  CONFIG.NUM_SI {2} \
] [get_bd_cells axi_smc]

if {$fmc_board == "opsero"} {
  # enable pl_ps irq1
  set_property -dict [ list \
    CONFIG.PSU__USE__IRQ1  {1} \
  ] [get_bd_cells zynq_ultra_ps_e]
  # Create MIPI I2C interface
  set FMC_CAM_IIC [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic FMC_CAM_IIC ]
  set_property -dict [ list \
    CONFIG.TEN_BIT_ADR {10_bit} \
    CONFIG.IIC_FREQ_KHZ {400} \
  ] [get_bd_cells FMC_CAM_IIC]
  set FMC_CAM_IIC [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 FMC_CAM_IIC ]
  connect_bd_intf_net [get_bd_intf_ports FMC_CAM_IIC] [get_bd_intf_pins FMC_CAM_IIC/IIC]
  connect_bd_net [get_bd_pins FMC_CAM_IIC/iic2intc_irpt] [get_bd_pins zynq_ultra_ps_e/pl_ps_irq1]
  # Create GPIO for FMC camera power down and reset
  set FMC_CAM_IO [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio FMC_CAM_IO ]
  set_property -dict [ list \
    CONFIG.C_GPIO_WIDTH {2} \
    CONFIG.C_All_INPUTS {0} \
    CONFIG.C_ALL_OUTPUTS {0} \
    CONFIG.C_DOUT_DEFAULT {0x00000003} \
  ] [get_bd_cells FMC_CAM_IO]
  set FMC_CAM_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 FMC_CAM_IO ]
  connect_bd_intf_net [get_bd_intf_ports FMC_CAM_IO] [get_bd_intf_pins FMC_CAM_IO/GPIO]
  # Create constants for FMC camera IO direction and output enable
  # 0 = input
  # 1 = output
  set FMC_CAM_IO_DIR [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant FMC_CAM_IO_DIR]
  set_property -dict [list \
    CONFIG.CONST_VAL {3} \
    CONFIG.CONST_WIDTH {2} \
  ] [get_bd_cells FMC_CAM_IO_DIR]
  set FMC_CAM_IO_DIR [ create_bd_port -dir O -from 1 -to 0 FMC_CAM_IO_DIR ]
  connect_bd_net [get_bd_ports FMC_CAM_IO_DIR] [get_bd_pins FMC_CAM_IO_DIR/dout]
  # Create constant for FMC camera IO output enable negated
  # 0 = output enabled
  # 1 = high impedance
  set FMC_CAM_IO_OE_N [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant FMC_CAM_IO_OE_N]
  set_property -dict [list \
    CONFIG.CONST_VAL {2} \
    CONFIG.CONST_WIDTH {2} \
  ] [get_bd_cells FMC_CAM_IO_OE_N]
  set FMC_CAM_IO_OE_N [ create_bd_port -dir O -from 1 -to 0 FMC_CAM_IO_OE_N ]
  connect_bd_net [get_bd_ports FMC_CAM_IO_OE_N] [get_bd_pins FMC_CAM_IO_OE_N/dout]
  # Create constant for FMC camera 1 and camera 3 clock selection
  # SEL[0]: 0=CAM1_CLK => LA01 1=CAM1_CLK => LA16
  # SEL[1]: 0=CAM3_CLK => LA26 1=CAM3_CLK => LA31
  set FMC_CAM_CLK_SEL [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant FMC_CAM_CLK_SEL ]
  set_property -dict [list \
    CONFIG.CONST_VAL {0} \
    CONFIG.CONST_WIDTH {2} \
  ] [get_bd_cells FMC_CAM_CLK_SEL]
  set FMC_CAM_CLK_SEL [ create_bd_port -dir O -from 1 -to 0 FMC_CAM_CLK_SEL ]
  connect_bd_net [get_bd_ports FMC_CAM_CLK_SEL] [get_bd_pins FMC_CAM_CLK_SEL/dout]
}

connect_bd_net [get_bd_pins zynq_ultra_ps_e/maxihpm0_lpd_aclk] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 ps_sys_rst
connect_bd_net [get_bd_pins ps_sys_rst/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net [get_bd_pins ps_sys_rst/ext_reset_in] [get_bd_pins zynq_ultra_ps_e/pl_resetn0]
connect_bd_net [get_bd_pins system_management_wiz/ip2intc_irpt] [get_bd_pins zynq_ultra_ps_e/pl_ps_irq0]
set IIC_FPGA [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_FPGA ]
connect_bd_intf_net [get_bd_intf_ports IIC_FPGA] [get_bd_intf_pins zynq_ultra_ps_e/IIC_1]

set CLK_100_CAL [ create_bd_port -dir I -type clk -freq_hz 100000000 CLK_100_CAL ]
set I2C_MIPI_SEL [ create_bd_port -dir O -from 0 -to 0 I2C_MIPI_SEL ]
connect_bd_net [get_bd_pins CONST0/dout] [get_bd_pins I2C_MIPI_SEL]
set mipi_phy_if_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_0 ]

#connect
connect_bd_intf_net [get_bd_intf_pins axi_smc/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e/S_AXI_HPC0_FPD]
connect_bd_intf_net [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S] [get_bd_intf_pins v_mix_0/s_axis_video1]
connect_bd_intf_net [get_bd_intf_pins axi_smc/S00_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S]
connect_bd_intf_net [get_bd_intf_pins axi_smc/S01_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_S2MM]
connect_bd_intf_net [get_bd_intf_pins mipi_csi2_rx_subsyst_0/video_out] [get_bd_intf_pins v_demosaic_0/s_axis_video]
connect_bd_intf_net [get_bd_intf_ports mipi_phy_if_0] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/mipi_phy_if]
connect_bd_intf_net [get_bd_intf_pins v_demosaic_0/m_axis_video] [get_bd_intf_pins v_gamma_lut_0/s_axis_video]
connect_bd_intf_net [get_bd_intf_pins axi_vdma_0/S_AXIS_S2MM] [get_bd_intf_pins v_gamma_lut_0/m_axis_video]
connect_bd_intf_net [get_bd_intf_pins v_mix_0/s_axis_video] [get_bd_intf_pins v_tpg_0/m_axis_video]

#connect_bd_intf_net [get_bd_intf_pins ps8_0_axi_periph/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e/M_AXI_HPM0_FPD]
#connect_bd_intf_net [get_bd_intf_pins ps8_0_axi_periph/S01_AXI] [get_bd_intf_pins zynq_ultra_ps_e/M_AXI_HPM1_FPD]

# Create port connections
#connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk] [get_bd_pins zynq_ultra_ps_e/dp_video_in_clk]
#connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0/dcm_locked]
connect_bd_net [get_bd_pins CLK_200M/clk_out1] [get_bd_pins mipi_csi2_rx_subsyst_0/dphy_clk_200M]
#connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins v_tc_0/resetn]
#connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_reset] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset]
#connect_bd_net [get_bd_pins v_axi4s_vid_out_0/vid_data] [get_bd_pins zynq_ultra_ps_e/dp_live_video_in_pixel1]
#connect_bd_net [get_bd_pins v_axi4s_vid_out_0/vid_hsync] [get_bd_pins zynq_ultra_ps_e/dp_live_video_in_hsync]
#connect_bd_net [get_bd_pins v_axi4s_vid_out_0/vid_vsync] [get_bd_pins zynq_ultra_ps_e/dp_live_video_in_vsync]
#connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins axi_smc/aclk]
#connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk]
#connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins axi_vdma_0/m_axi_s2mm_aclk]
#connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins axi_vdma_0/s_axi_lite_aclk]
#connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins zynq_ultra_ps_e/saxihpc0_fpd_aclk]
#connect_bd_net [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins rst_ps8_0_100M/ext_reset_in] [get_bd_pins zynq_ultra_ps_e/pl_resetn0]

#connect

#connect_bd_net [get_bd_ports CLK_100_CAL] [get_bd_pins CLK_148M5/clk_in1]
connect_bd_net [get_bd_pins CLK_148M5/clk_in1] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net [get_bd_pins CLK_200M/clk_in1] [get_bd_pins zynq_ultra_ps_e/pl_clk0]

create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 CLK_148M5_RST
connect_bd_net [get_bd_pins CLK_148M5_RST/slowest_sync_clk] [get_bd_pins CLK_148M5/clk_out1]
connect_bd_net [get_bd_pins CLK_148M5_RST/ext_reset_in] [get_bd_pins zynq_ultra_ps_e/pl_resetn0]

connect_bd_net [get_bd_pins v_tc_0/s_axi_aclk   ] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net [get_bd_pins v_tc_0/s_axi_aresetn] [get_bd_pins ps_sys_rst/peripheral_aresetn]

connect_bd_intf_net [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]
connect_bd_intf_net [get_bd_intf_pins v_axi4s_vid_out_0/video_in] [get_bd_intf_pins v_mix_0/m_axis_video]
connect_bd_net [get_bd_pins v_axi4s_vid_out_0/vtg_ce] [get_bd_pins v_tc_0/gen_clken]

#set TMDS [ create_bd_intf_port -mode Master -vlnv digilentinc.com:interface:tmds_rtl:1.0 TMDS ]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aclk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aclk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins v_demosaic_0/ap_clk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins v_gamma_lut_0/ap_clk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins axi_smc/aclk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins axi_vdma_0/m_axi_s2mm_aclk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins axi_vdma_0/s_axi_lite_aclk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins zynq_ultra_ps_e/saxihpc0_fpd_aclk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins axi_vdma_0/s_axis_s2mm_aclk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins v_mix_0/ap_clk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins v_tc_0/clk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins v_axi4s_vid_out_0/aclk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk]
#connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk]
#connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins axi_vdma_0/s_axis_s2mm_aclk]
#connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins zynq_ultra_ps_e/maxihpm0_fpd_aclk]
#connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins zynq_ultra_ps_e/maxihpm1_fpd_aclk]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0
if { $fmc_board == "opsero"} {
set_property -dict [list CONFIG.NUM_MI {11} CONFIG.NUM_SI {1}] [get_bd_cells axi_interconnect_0]
} else {
set_property -dict [list CONFIG.NUM_MI {9} CONFIG.NUM_SI {1}] [get_bd_cells axi_interconnect_0]
}
connect_bd_intf_net [get_bd_intf_pins zynq_ultra_ps_e/M_AXI_HPM0_LPD] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
connect_bd_net [get_bd_pins axi_interconnect_0/ACLK    ] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net [get_bd_pins axi_interconnect_0/ARESETN ] [get_bd_pins ps_sys_rst/interconnect_aresetn]
connect_bd_net [get_bd_pins axi_interconnect_0/S00_ACLK   ] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins ps_sys_rst/interconnect_aresetn]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M00_AXI    ] [get_bd_intf_pins system_management_wiz/S_AXI_LITE]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M00_ACLK   ] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M00_ARESETN] [get_bd_pins ps_sys_rst/interconnect_aresetn]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M01_AXI    ] [get_bd_intf_pins led/S_AXI]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M01_ACLK   ] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M01_ARESETN] [get_bd_pins ps_sys_rst/interconnect_aresetn]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M02_AXI    ] [get_bd_intf_pins mipi_csi2_rx_subsyst_0/csirxss_s_axi]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M02_ACLK   ] [get_bd_pins CLK_148M5/clk_out1]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M02_ARESETN] [get_bd_pins CLK_148M5_RST/interconnect_aresetn]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M03_AXI    ] [get_bd_intf_pins v_demosaic_0/s_axi_CTRL]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M03_ACLK   ] [get_bd_pins CLK_148M5/clk_out1]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M03_ARESETN] [get_bd_pins CLK_148M5_RST/interconnect_aresetn]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M04_AXI    ] [get_bd_intf_pins v_gamma_lut_0/s_axi_CTRL]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M04_ACLK   ] [get_bd_pins CLK_148M5/clk_out1]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M04_ARESETN] [get_bd_pins CLK_148M5_RST/interconnect_aresetn]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M05_AXI    ] [get_bd_intf_pins axi_vdma_0/S_AXI_LITE]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M05_ACLK   ] [get_bd_pins CLK_148M5/clk_out1]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M05_ARESETN] [get_bd_pins CLK_148M5_RST/interconnect_aresetn]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M06_AXI    ] [get_bd_intf_pins v_tpg_0/s_axi_CTRL]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M06_ACLK   ] [get_bd_pins CLK_148M5/clk_out1]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M06_ARESETN] [get_bd_pins CLK_148M5_RST/interconnect_aresetn]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M07_AXI    ] [get_bd_intf_pins v_mix_0/s_axi_CTRL]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M07_ACLK   ] [get_bd_pins CLK_148M5/clk_out1]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M07_ARESETN] [get_bd_pins CLK_148M5_RST/interconnect_aresetn]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M08_AXI    ] [get_bd_intf_pins v_tc_0/ctrl]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M08_ACLK   ] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M08_ARESETN] [get_bd_pins ps_sys_rst/interconnect_aresetn]
if { $fmc_board == "opsero"} {
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M09_AXI    ] [get_bd_intf_pins FMC_CAM_IIC/S_AXI]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M09_ACLK   ] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M09_ARESETN] [get_bd_pins ps_sys_rst/interconnect_aresetn]
connect_bd_intf_net [get_bd_intf_pins axi_interconnect_0/M10_AXI    ] [get_bd_intf_pins FMC_CAM_IO/S_AXI]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M10_ACLK   ] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net      [get_bd_pins      axi_interconnect_0/M10_ARESETN] [get_bd_pins ps_sys_rst/interconnect_aresetn]
}

connect_bd_net [get_bd_pins ps_sys_rst/peripheral_aresetn] [get_bd_pins system_management_wiz/s_axi_aresetn]
connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins system_management_wiz/s_axi_aclk]
connect_bd_net [get_bd_pins ps_sys_rst/peripheral_aresetn] [get_bd_pins led/s_axi_aresetn]
connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins led/s_axi_aclk]
if { $fmc_board == "opsero"} {
connect_bd_net [get_bd_pins ps_sys_rst/peripheral_aresetn] [get_bd_pins FMC_CAM_IIC/s_axi_aresetn]
connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins FMC_CAM_IIC/s_axi_aclk]
connect_bd_net [get_bd_pins ps_sys_rst/peripheral_aresetn] [get_bd_pins FMC_CAM_IO/s_axi_aresetn]
connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins FMC_CAM_IO/s_axi_aclk]
}
connect_bd_net [get_bd_pins CLK_148M5_RST/peripheral_aresetn] [get_bd_pins mipi_csi2_rx_subsyst_0/lite_aresetn]
connect_bd_net [get_bd_pins CLK_148M5_RST/peripheral_aresetn] [get_bd_pins mipi_csi2_rx_subsyst_0/video_aresetn]
connect_bd_net [get_bd_pins CLK_148M5_RST/peripheral_aresetn] [get_bd_pins v_demosaic_0/ap_rst_n]
connect_bd_net [get_bd_pins CLK_148M5_RST/peripheral_aresetn] [get_bd_pins v_gamma_lut_0/ap_rst_n]
connect_bd_net [get_bd_pins CLK_148M5_RST/peripheral_aresetn] [get_bd_pins axi_vdma_0/axi_resetn]
connect_bd_net [get_bd_pins CLK_148M5_RST/peripheral_aresetn] [get_bd_pins v_mix_0/ap_rst_n]
connect_bd_net [get_bd_pins CLK_148M5_RST/peripheral_aresetn] [get_bd_pins v_tpg_0/ap_rst_n]
connect_bd_net [get_bd_pins CLK_148M5_RST/peripheral_aresetn] [get_bd_pins axi_smc/aresetn]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins v_tpg_0/ap_clk]
connect_bd_net [get_bd_pins CLK_148M5/clk_out1] [get_bd_pins zynq_ultra_ps_e/dp_video_in_clk]
connect_bd_net [get_bd_pins CLK_148M5_RST/peripheral_aresetn] [get_bd_pins v_tc_0/resetn]
#connect_bd_net [get_bd_pins zynq_ultra_ps_e/pl_clk0] [get_bd_pins v_tc_0/s_axi_aclk]
connect_bd_net [get_bd_pins CLK_148M5_RST/peripheral_aresetn] [get_bd_pins v_axi4s_vid_out_0/aresetn]
#connect_bd_net [get_bd_pins CLK_148M5_RST/peripheral_reset] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset]

connect_bd_net [get_bd_pins v_axi4s_vid_out_0/vid_active_video] [get_bd_pins zynq_ultra_ps_e/dp_live_video_in_de]
connect_bd_net [get_bd_pins v_axi4s_vid_out_0/vid_data] [get_bd_pins zynq_ultra_ps_e/dp_live_video_in_pixel1]
connect_bd_net [get_bd_pins v_axi4s_vid_out_0/vid_hsync] [get_bd_pins zynq_ultra_ps_e/dp_live_video_in_hsync]
connect_bd_net [get_bd_pins v_axi4s_vid_out_0/vid_vsync] [get_bd_pins zynq_ultra_ps_e/dp_live_video_in_vsync]

connect_bd_net [get_bd_pins CONST1/dout] [get_bd_pins v_tc_0/clken]
connect_bd_net [get_bd_pins CONST1/dout] [get_bd_pins v_tc_0/s_axi_aclken]
connect_bd_net [get_bd_pins CONST1/dout] [get_bd_pins v_axi4s_vid_out_0/aclken]
connect_bd_net [get_bd_pins CONST1/dout] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce]

set DP_AUX_OUT [ create_bd_port -dir O DP_AUX_OUT]
connect_bd_net [get_bd_ports DP_AUX_OUT] [get_bd_pins zynq_ultra_ps_e/dp_aux_data_out]
set DP_AUX_OE [ create_bd_port -dir O DP_AUX_OE]
connect_bd_net [get_bd_ports DP_AUX_OE] [get_bd_pins zynq_ultra_ps_e/dp_aux_data_oe_n]
set DP_AUX_IN [ create_bd_port -dir I DP_AUX_IN]
connect_bd_net [get_bd_ports DP_AUX_IN] [get_bd_pins zynq_ultra_ps_e/dp_aux_data_in]
set DP_HPD [ create_bd_port -dir I DP_HPD]
connect_bd_net [get_bd_ports DP_HPD] [get_bd_pins zynq_ultra_ps_e/dp_hot_plug_detect]
set Clk100 [ create_bd_port -dir O -type clk Clk100]
connect_bd_net [get_bd_ports Clk100] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
set Clk50 [ create_bd_port -dir O -type clk Clk50]
connect_bd_net [get_bd_ports Clk50] [get_bd_pins zynq_ultra_ps_e/pl_clk1]
set Rst_N [ create_bd_port -dir O -type rst Rst_N]
connect_bd_net [get_bd_ports Rst_N] [get_bd_pins zynq_ultra_ps_e/pl_resetn0]
set LED_N [ create_bd_port -dir O -from 2 -to 0 LED_N]
connect_bd_net [get_bd_ports LED_N] [get_bd_pins LED/gpio_io_o]

# Create address segments
#assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP0/HPC0_DDR_LOW] -force
#assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP0/HPC0_DDR_LOW] -force
#assign_bd_address -offset 0xA0010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] -force
#assign_bd_address -offset 0xA0000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs mipi_csi2_rx_subsyst_0/csirxss_s_axi/Reg] -force
#assign_bd_address -offset 0xA0020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs v_demosaic_0/s_axi_CTRL/Reg] -force
#assign_bd_address -offset 0xA0030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs v_gamma_lut_0/s_axi_CTRL/Reg] -force
#assign_bd_address -offset 0xA0040000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs v_tc_0/ctrl/Reg] -force
#assign_bd_address -offset 0xA0050000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs v_tpg_0/s_axi_CTRL/Reg] -force
#assign_bd_address -offset 0xA0060000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs v_mix_0/s_axi_CTRL/Reg] -force

# Exclude Address Segments
exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP0/HPC0_DDR_HIGH]
exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP0/HPC0_LPS_OCM]
exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP0/HPC0_DDR_HIGH]
exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP0/HPC0_LPS_OCM]
assign_bd_address
save_bd_design
validate_bd_design
save_bd_design
