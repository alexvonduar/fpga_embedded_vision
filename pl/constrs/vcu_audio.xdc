#####
## Constraints for ZCU106
## Version 1.0
#####

set_property PACKAGE_PIN AC14 [get_ports RESET]
set_property IOSTANDARD LVCMOS12 [get_ports RESET]

#####
## Pins
#####

# HDMI RX
set_property PACKAGE_PIN AC10 [get_ports HDMI_RX_CLK_P]

#SFP SI5328
#set_property PACKAGE_PIN W10 [get_ports {DRU_CLK_clk_p[0]}]
#SI570 - OUT OF SPEC CLOCK SOURCE LOCATION - DO NOT USE FOR PRODUCTION DESIGNS
set_property PACKAGE_PIN U10 [get_ports {DRU_CLK_clk_p[0]}]
#Override clock placement error
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {vcu_audio_i/gt_refclk_buf/ibufds_gt/U0/IBUF_OUT[0]}]

set_property PACKAGE_PIN M10 [get_ports {RX_HPD[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RX_HPD[0]}]

set_property PACKAGE_PIN M9 [get_ports RX_DDC_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports RX_DDC_scl_io]

set_property PACKAGE_PIN M11 [get_ports RX_DDC_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports RX_DDC_sda_io]

#set_property IOSTANDARD LVDS [get_ports RX_REFCLK_P]
set_property IOSTANDARD DIFF_SSTL12 [get_ports RX_REFCLK_P]
set_property PACKAGE_PIN G14 [get_ports RX_REFCLK_P]

set_property PACKAGE_PIN M8 [get_ports RX_DET]
set_property IOSTANDARD LVCMOS33 [get_ports RX_DET]


# HDMI TX
set_property PACKAGE_PIN AD8 [get_ports TX_REFCLK_P]

#set_property IOSTANDARD LVDS [get_ports HDMI_TX_CLK_P]

set_property IOSTANDARD DIFF_SSTL12 [get_ports HDMI_TX_CLK_P]

set_property PACKAGE_PIN G21 [get_ports HDMI_TX_CLK_P]

set_property PACKAGE_PIN N13 [get_ports TX_HPD]
set_property IOSTANDARD LVCMOS33 [get_ports TX_HPD]

set_property PACKAGE_PIN N8 [get_ports TX_DDC_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports TX_DDC_scl_io]

set_property PACKAGE_PIN N9 [get_ports TX_DDC_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports TX_DDC_sda_io]

# I2C
set_property PACKAGE_PIN N12 [get_ports HDMI_CTRL_IIC_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports HDMI_CTRL_IIC_scl_io]

set_property PACKAGE_PIN P12 [get_ports HDMI_CTRL_IIC_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports HDMI_CTRL_IIC_sda_io]


# Misc
#GPIO_LED_0_LS
set_property PACKAGE_PIN AL11 [get_ports LED0]
#GPIO_LED_1_LS
#set_property PACKAGE_PIN AL13 [get_ports {LED1[0]}]
#GPIO_LED_2_LS
set_property PACKAGE_PIN AK13 [get_ports {LED2[0]}]
#GPIO_LED_3_LS
set_property PACKAGE_PIN AE15 [get_ports {LED3[0]}]
#GPIO_LED_4_LS
set_property PACKAGE_PIN AM8 [get_ports {LED4[0]}]
#GPIO_LED_5_LS
set_property PACKAGE_PIN AM9 [get_ports {LED5[0]}]
#GPIO_LED_6_LS
set_property PACKAGE_PIN AM10 [get_ports LED6]
#GPIO_LED_7_LS
set_property PACKAGE_PIN AM11 [get_ports LED7]


set_property IOSTANDARD LVCMOS12 [get_ports LED*]

set_property PACKAGE_PIN H8 [get_ports {SI5319_RST[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SI5319_RST[0]}]

set_property PACKAGE_PIN G8 [get_ports SI5319_LOL]
set_property IOSTANDARD LVCMOS33 [get_ports SI5319_LOL]

set_property PACKAGE_PIN N11 [get_ports {TX_EN[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {TX_EN[0]}]


#####
## End
#####

#Digilent PMOD pins
set_property PACKAGE_PIN A23 [get_ports lrclk_tx]
set_property IOSTANDARD LVCMOS12 [get_ports lrclk_tx]
set_property PACKAGE_PIN F25 [get_ports sclk_tx]
set_property IOSTANDARD LVCMOS12 [get_ports sclk_tx]
set_property PACKAGE_PIN E20 [get_ports sdata_tx]
set_property IOSTANDARD LVCMOS12 [get_ports sdata_tx]
set_property PACKAGE_PIN B23 [get_ports mclk_out_tx]
set_property IOSTANDARD LVCMOS12 [get_ports mclk_out_tx]
#
##input side
set_property PACKAGE_PIN D7 [get_ports sdata_rx]
set_property IOSTANDARD LVCMOS12 [get_ports sdata_rx]
set_property PACKAGE_PIN L23 [get_ports lrclk_rx]
set_property IOSTANDARD LVCMOS12 [get_ports lrclk_rx]
set_property PACKAGE_PIN L22 [get_ports sclk_rx]
set_property IOSTANDARD LVCMOS12 [get_ports sclk_rx]
set_property PACKAGE_PIN K24 [get_ports mclk_out_rx]
set_property IOSTANDARD LVCMOS12 [get_ports mclk_out_rx]


##  MIPI



set_property PACKAGE_PIN H12 [get_ports {sensor_gpio_rst[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sensor_gpio_rst[0]}]
set_property PACKAGE_PIN A8 [get_ports {sensor_gpio_spi_cs_n[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sensor_gpio_spi_cs_n[0]}]
set_property PACKAGE_PIN C17 [get_ports {sensor_gpio_flash[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sensor_gpio_flash[0]}]



#I2C


set_property PACKAGE_PIN B9 [get_ports sensor_iic_scl_io]
set_property PACKAGE_PIN B8 [get_ports sensor_iic_sda_io]
set_property PULLUP true [get_ports sensor_iic_scl_io]
set_property PULLUP true [get_ports sensor_iic_sda_io]
set_property IOSTANDARD HSUL_12_DCI [get_ports sensor_iic_*]






#set_property PACKAGE_PIN F25 [get_ports lrclk_tx]
#set_property IOSTANDARD LVCMOS18 [get_ports lrclk_tx]
#set_property PACKAGE_PIN A23 [get_ports sclk_tx]
#set_property IOSTANDARD LVCMOS18 [get_ports sclk_tx]
#set_property PACKAGE_PIN B23 [get_ports sdata_tx]
#set_property IOSTANDARD LVCMOS18 [get_ports sdata_tx]
#set_property PACKAGE_PIN E20 [get_ports mclk_out_tx]
#set_property IOSTANDARD LVCMOS18 [get_ports mclk_out_tx]

##input side
#set_property PACKAGE_PIN D7 [get_ports sdata_rx]
#set_property IOSTANDARD LVCMOS18 [get_ports sdata_rx]
#set_property PACKAGE_PIN L23 [get_ports lrclk_rx]
#set_property IOSTANDARD LVCMOS18 [get_ports lrclk_rx]
#set_property PACKAGE_PIN L22 [get_ports sclk_rx]
#set_property IOSTANDARD LVCMOS18 [get_ports sclk_rx]
#set_property PACKAGE_PIN K24 [get_ports mclk_out_rx]
#set_property IOSTANDARD LVCMOS18 [get_ports mclk_out_rx]


#set_property PACKAGE_PIN H16 [get_ports lrclk_tx]
#set_property IOSTANDARD LVCMOS18 [get_ports lrclk_tx]
#set_property PACKAGE_PIN G16 [get_ports sclk_tx]
#set_property IOSTANDARD LVCMOS18 [get_ports sclk_tx]
#set_property PACKAGE_PIN J17 [get_ports sdata_tx]
#set_property IOSTANDARD LVCMOS18 [get_ports sdata_tx]
#
#set_property PACKAGE_PIN K17 [get_ports mclk_out_tx]
#set_property IOSTANDARD LVCMOS18 [get_ports mclk_out_tx]
#
#set_property PACKAGE_PIN B8 [get_ports mclk_out_rx]
#set_property IOSTANDARD LVCMOS18 [get_ports mclk_out_rx]
#
#set_property PACKAGE_PIN B9 [get_ports sdata_rx]
#set_property IOSTANDARD LVCMOS18 [get_ports sdata_rx]
#set_property PACKAGE_PIN H12 [get_ports lrclk_rx]
#set_property IOSTANDARD LVCMOS18 [get_ports lrclk_rx]
#set_property PACKAGE_PIN H13 [get_ports sclk_rx]
#set_property IOSTANDARD LVCMOS18 [get_ports sclk_rx]

#set_property IOSTANDARD LVDS [get_ports {OBUF_DS_P_0[0]}]
#set_property IOSTANDARD LVDS [get_ports {OBUF_DS_N_0[0]}]
set_property IOSTANDARD DIFF_SSTL12 [get_ports {OBUF_DS_P_0[0]}]
set_property IOSTANDARD DIFF_SSTL12 [get_ports {OBUF_DS_N_0[0]}]


set_property PACKAGE_PIN H11 [get_ports {OBUF_DS_P_0[0]}]
set_property PACKAGE_PIN G11 [get_ports {OBUF_DS_N_0[0]}]

#create_clock -period 10.172 -name mclk_in [get_ports aud_mclk_in_clk_p]

#set_property IOSTANDARD LVDS [get_ports {aud_mclk_in_clk_p[0]}]
#set_property IOSTANDARD LVDS [get_ports {aud_mclk_in_clk_n[0]}]

#set_property PACKAGE_PIN W9 [get_ports {aud_mclk_in_clk_n[0]}]
#set_property PACKAGE_PIN W10 [get_ports {aud_mclk_in_clk_p[0]}]

#set_property PACKAGE_PIN D11 [get_ports {aud_mclk_in_clk_p}]
#set_property PACKAGE_PIN D10 [get_ports {aud_mclk_in_clk_n}]
set_false_path -from [get_cells -hier -filter name=~*HDMI_ACR_CTRL_AXI_INST/rEnab_ACR_reg] -to [get_cells -hier -filter {name=~*aud_enab_acr_sync_reg[0]}]

set_false_path -from [get_cells -hier -filter name=~*HDMI_ACR_CTRL_AXI_INST/rACR_Sel_reg] -to [get_cells -hier -filter {name=~*aud_acr_sel_sync_reg[0]}]
set_false_path -from [get_cells -hier -filter name=~*HDMI_ACR_CTRL_AXI_INST/rTMDSClkRatio_reg] -to [get_cells -hier -filter {name=~*aud_tmdsclkratio_sync_reg[0]}]

set_false_path -from [get_cells -hier -filter name=~*PULSE_CLKCROSS_INST/rIn_Toggle_reg] -to [get_cells -hier -filter {name=~*PULSE_CLKCROSS_INST/rOut_Sync_reg[0]}]

set_false_path -from [get_cells -hier -filter name=~*HDMI_ACR_CTRL_AXI_INST/rAud_Reset_reg] -to [get_cells -hier -filter {name=~*aud_rst_chain_reg[*]}]

# Clock crossing of the N value from the AXI clock to the Audio clock
set_false_path -from [get_cells -hier -filter {name=~*NVAL_CLKCROSS_INST/rIn_Data_reg[*]}] -to [get_cells -hier -filter {name=~*NVAL_CLKCROSS_INST/rOut_Data_reg[*]}]

set_false_path -from [get_cells -hier -filter name=~*NVAL_CLKCROSS_INST/rIn_DValid_reg] -to [get_cells -hier -filter {name=~*NVAL_CLKCROSS_INST/rOut_DValid_Sync_reg[0]}]

set_false_path -from [get_cells -hier -filter name=~*NVAL_CLKCROSS_INST/rOut_ACK_reg] -to [get_cells -hier -filter {name=~*NVAL_CLKCROSS_INST/rIn_ACK_Sync_reg[0]}]

# Clock crossing of the CTS value from the HDMI clock to the AXI clock
set_false_path -from [get_cells -hier -filter {name=~*CTS_CLKCROSS_ACLK_INST/rIn_Data_reg[*]}] -to [get_cells -hier -filter {name=~*CTS_CLKCROSS_ACLK_INST/rOut_Data_reg[*]}]

set_false_path -from [get_cells -hier -filter name=~*CTS_CLKCROSS_ACLK_INST/rIn_DValid_reg] -to [get_cells -hier -filter {name=~*CTS_CLKCROSS_ACLK_INST/rOut_DValid_Sync_reg[0]}]

set_false_path -from [get_cells -hier -filter name=~*CTS_CLKCROSS_ACLK_INST/rOut_ACK_reg] -to [get_cells -hier -filter {name=~*CTS_CLKCROSS_ACLK_INST/rIn_ACK_Sync_reg[0]}]

# Clock crossing of the CTS value from the HDMI clock to the Audio clock
set_false_path -from [get_cells -hier -filter {name=~*CTS_CLKCROSS_AUD_INST/rIn_Data_reg[*]}] -to [get_cells -hier -filter {name=~*CTS_CLKCROSS_AUD_INST/rOut_Data_reg[*]}]

set_false_path -from [get_cells -hier -filter name=~*CTS_CLKCROSS_AUD_INST/rIn_DValid_reg] -to [get_cells -hier -filter {name=~*CTS_CLKCROSS_AUD_INST/rOut_DValid_Sync_reg[0]}]

set_false_path -from [get_cells -hier -filter name=~*CTS_CLKCROSS_AUD_INST/rOut_ACK_reg] -to [get_cells -hier -filter {name=~*CTS_CLKCROSS_AUD_INST/rIn_ACK_Sync_reg[0]}]


#set_clock_groups -name clk_pl_async -asynchronous -group [get_clocks clk_out1_zcu106_vcu_audio_clk_wiz_1_0] -group [get_clocks clk_pl_0]



#create_debug_core u_ila_0 ila
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
#set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
#set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
#set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
#set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
#set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
#set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
#set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
#set_property port_width 1 [get_debug_ports u_ila_0/clk]
#connect_debug_port u_ila_0/clk [get_nets [list hdmi_example_zcu106_i/mpsoc_ss/zynq_ultra_ps_e_0/inst/pl_clk2]]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
#set_property port_width 32 [get_debug_ports u_ila_0/probe0]
#connect_debug_port u_ila_0/probe0 [get_nets [list {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[0]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[1]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[2]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[3]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[4]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[5]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[6]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[7]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[8]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[9]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[10]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[11]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[12]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[13]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[14]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[15]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[16]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[17]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[18]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[19]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[20]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[21]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[22]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[23]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[24]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[25]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[26]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[27]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[28]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[29]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[30]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TDATA[31]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
#set_property port_width 3 [get_debug_ports u_ila_0/probe1]
#connect_debug_port u_ila_0/probe1 [get_nets [list {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TID[0]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TID[1]} {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TID[2]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
#set_property port_width 1 [get_debug_ports u_ila_0/probe2]
#connect_debug_port u_ila_0/probe2 [get_nets [list {hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1/s_aud_tid[0]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
#set_property port_width 32 [get_debug_ports u_ila_0/probe3]
#connect_debug_port u_ila_0/probe3 [get_nets [list {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[32]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[33]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[34]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[35]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[36]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[37]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[38]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[39]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[40]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[41]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[42]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[43]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[44]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[45]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[46]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[47]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[48]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[49]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[50]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[51]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[52]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[53]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[54]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[55]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[56]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[57]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[58]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[59]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[60]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[61]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[62]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TDATA[63]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
#set_property port_width 3 [get_debug_ports u_ila_0/probe4]
#connect_debug_port u_ila_0/probe4 [get_nets [list {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TID[3]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TID[4]} {hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TID[5]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
#set_property port_width 32 [get_debug_ports u_ila_0/probe5]
#connect_debug_port u_ila_0/probe5 [get_nets [list {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[0]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[1]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[2]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[3]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[4]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[5]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[6]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[7]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[8]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[9]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[10]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[11]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[12]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[13]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[14]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[15]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[16]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[17]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[18]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[19]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[20]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[21]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[22]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[23]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[24]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[25]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[26]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[27]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[28]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[29]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[30]} {hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TDATA[31]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
#set_property port_width 1 [get_debug_ports u_ila_0/probe6]
#connect_debug_port u_ila_0/probe6 [get_nets [list hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TLAST]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
#set_property port_width 1 [get_debug_ports u_ila_0/probe7]
#connect_debug_port u_ila_0/probe7 [get_nets [list hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TREADY]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
#set_property port_width 1 [get_debug_ports u_ila_0/probe8]
#connect_debug_port u_ila_0/probe8 [get_nets [list hdmi_example_zcu106_i/audio_ss_0/axi_fifo_mm_s_0_AXI_STR_TXD_TVALID]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
#set_property port_width 1 [get_debug_ports u_ila_0/probe9]
#connect_debug_port u_ila_0/probe9 [get_nets [list hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1/s_aud_tready]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
#set_property port_width 1 [get_debug_ports u_ila_0/probe10]
#connect_debug_port u_ila_0/probe10 [get_nets [list hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1/s_aud_tvalid]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
#set_property port_width 1 [get_debug_ports u_ila_0/probe11]
#connect_debug_port u_ila_0/probe11 [get_nets [list hdmi_example_zcu106_i/audio_ss_0/i2s_transmitter_0/s_axis_aud_aresetn]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
#set_property port_width 1 [get_debug_ports u_ila_0/probe12]
#connect_debug_port u_ila_0/probe12 [get_nets [list hdmi_example_zcu106_i/audio_ss_0/i2s_transmitter_0/s_axis_aud_tready]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
#set_property port_width 1 [get_debug_ports u_ila_0/probe13]
#connect_debug_port u_ila_0/probe13 [get_nets [list hdmi_example_zcu106_i/audio_ss_0/i2s_transmitter_0/s_axis_aud_tvalid]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
#set_property port_width 1 [get_debug_ports u_ila_0/probe14]
#connect_debug_port u_ila_0/probe14 [get_nets [list hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TREADY]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
#set_property port_width 1 [get_debug_ports u_ila_0/probe15]
#connect_debug_port u_ila_0/probe15 [get_nets [list hdmi_example_zcu106_i/audio_ss_0/axis_switch_1_M01_AXIS_TVALID]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
#set_property port_width 1 [get_debug_ports u_ila_0/probe16]
#connect_debug_port u_ila_0/probe16 [get_nets [list hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TREADY]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
#set_property port_width 1 [get_debug_ports u_ila_0/probe17]
#connect_debug_port u_ila_0/probe17 [get_nets [list hdmi_example_zcu106_i/audio_ss_0/a_tpg_v1_0_1_m_aud_TVALID]]
#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
#connect_debug_port dbg_hub/clk [get_nets u_ila_0_pl_clk2]

#create_debug_core u_ila_0 ila
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
#set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
#set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
#set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
#set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
#set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
#set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
#set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
#set_property port_width 1 [get_debug_ports u_ila_0/clk]
#connect_debug_port u_ila_0/clk [get_nets [list hdmi_example_zcu106_i/mpsoc_ss/zynq_ultra_ps_e_0/inst/pl_clk2]]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
#set_property port_width 20 [get_debug_ports u_ila_0/probe0]
#connect_debug_port u_ila_0/probe0 [get_nets [list {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[0]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[1]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[2]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[3]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[4]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[5]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[6]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[7]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[8]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[9]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[10]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[11]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[12]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[13]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[14]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[15]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[16]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[17]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[18]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_cts_out[19]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
#set_property port_width 20 [get_debug_ports u_ila_0/probe1]
#connect_debug_port u_ila_0/probe1 [get_nets [list {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[0]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[1]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[2]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[3]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[4]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[5]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[6]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[7]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[8]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[9]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[10]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[11]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[12]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[13]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[14]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[15]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[16]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[17]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[18]} {hdmi_example_zcu106_i/audio_ss_0_aud_acr_n_out[19]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
#set_property port_width 1 [get_debug_ports u_ila_0/probe2]
#connect_debug_port u_ila_0/probe2 [get_nets [list hdmi_example_zcu106_i/audio_ss_0_aud_acr_valid_out]]
#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
#connect_debug_port dbg_hub/clk [get_nets u_ila_0_pl_clk2]

