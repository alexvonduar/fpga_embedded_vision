#####
## Constraints for ZCU106
## Version 1.0
#####


#####
## Pins
#####
set_property PACKAGE_PIN AH12 [get_ports si570_user_clk_p]
set_property IOSTANDARD LVDS [get_ports si570_user_clk_p]

# HDMI RX
set_property PACKAGE_PIN AC10 [get_ports HDMI_RX_CLK_P]

#SFP SI5328
#set_property PACKAGE_PIN W10 [get_ports {DRU_CLK_clk_p[0]}]
#SI570 - OUT OF SPEC CLOCK SOURCE LOCATION - DO NOT USE FOR PRODUCTION DESIGNS
set_property PACKAGE_PIN U10 [get_ports {DRU_CLK_clk_p[0]}]
#Override clock placement error
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {hdmi_plddr_i/gt_refclk_buf/ibufds_gt/U0/IBUF_OUT[0]}]

################
## Clock Groups #
#################
#
## A BUFGMUX selects between DP and HDMI video clock to couple the TPG with the desired display interface
## The two clocks are exclusive since they don't exist at the same time
#set_clock_groups -logically_exclusive -group [get_clocks clk_pl_1] -group [get_clocks -of [get_pins */vid_phy_controller/inst/gt_usrclk_source_inst/tx_mmcm.txoutclk_mmcm0_i/mmcm_adv_inst/CLKOUT2]]


set_property PACKAGE_PIN M10 [get_ports {RX_HPD[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RX_HPD[0]}]

set_property PACKAGE_PIN M9 [get_ports RX_DDC_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports RX_DDC_scl_io]

set_property PACKAGE_PIN M11 [get_ports RX_DDC_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports RX_DDC_sda_io]

set_property PACKAGE_PIN G14 [get_ports RX_REFCLK_P]
set_property IOSTANDARD DIFF_SSTL12 [get_ports RX_REFCLK_P]

set_property PACKAGE_PIN M8 [get_ports RX_DET]
set_property IOSTANDARD LVCMOS33 [get_ports RX_DET]


# HDMI TX
set_property PACKAGE_PIN AD8 [get_ports TX_REFCLK_P]

set_property PACKAGE_PIN G21 [get_ports HDMI_TX_CLK_P]
set_property IOSTANDARD LVDS [get_ports HDMI_TX_CLK_P]

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
set_property PACKAGE_PIN AL13 [get_ports {LED1[0]}]
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

# MIPI CSI-2 - GPIO - CAM_FLASH, CAM_XCE, CAM_RST
#
# PL Port               Pin   Schematic    FMC
#
# sensor_gpio_rst       H12   HPC0_LA22_N  G25  FMC_RST
# sensor_gpio_spi_cs_n  A8   HPC0_LA27_P  C26  FMC_SPI_CS_N
# sensor_gpio_flash     C17  HPC0_LA16_N  G19  FMC_FLASH
#
set_property PACKAGE_PIN A8 [get_ports {sensor_gpio_spi_cs_n[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sensor_gpio_spi_cs_n[0]}]
set_property PACKAGE_PIN C17 [get_ports {sensor_gpio_flash[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sensor_gpio_flash[0]}]

# MIPI CSI-2 - I2C IMX274 Sensor
#
# PL Port            Pin  Schematic    FMC
#
# sensor_iic_scl_io  L15  HPC0_LA26_P  D26  FMC_SCL
# sensor_iic_sda_io  K15  HPC0_LA26_N  D27  FMC_SDA
#
set_property PACKAGE_PIN B9 [get_ports sensor_iic_scl_io]
set_property PACKAGE_PIN B8 [get_ports sensor_iic_sda_io]
set_property PULLUP true [get_ports sensor_iic_scl_io]
set_property PULLUP true [get_ports sensor_iic_sda_io]
set_property IOSTANDARD HSUL_12_DCI [get_ports sensor_iic_*]


#Set max_delay in path between clocks as the source clock period - 100 ps
set_max_delay -datapath_only -from [get_clocks mmcm_clkout0] -to [get_clocks mmcm_clkout2] 2.900
set_max_delay -datapath_only -from [get_clocks mmcm_clkout2] -to [get_clocks mmcm_clkout0] 3.900

set_property PACKAGE_PIN AD14 [get_ports {C0_DDR4_act_n[0]}]

set_property PACKAGE_PIN AK9 [get_ports {C0_DDR4_adr[0]}]
set_property PACKAGE_PIN AG11 [get_ports {C0_DDR4_adr[1]}]
set_property PACKAGE_PIN AJ10 [get_ports {C0_DDR4_adr[2]}]
set_property PACKAGE_PIN AL8 [get_ports {C0_DDR4_adr[3]}]
set_property PACKAGE_PIN AK10 [get_ports {C0_DDR4_adr[4]}]
set_property PACKAGE_PIN AH8 [get_ports {C0_DDR4_adr[5]}]
set_property PACKAGE_PIN AJ9 [get_ports {C0_DDR4_adr[6]}]
set_property PACKAGE_PIN AG8 [get_ports {C0_DDR4_adr[7]}]
set_property PACKAGE_PIN AH9 [get_ports {C0_DDR4_adr[8]}]
set_property PACKAGE_PIN AG10 [get_ports {C0_DDR4_adr[9]}]
set_property PACKAGE_PIN AH13 [get_ports {C0_DDR4_adr[10]}]
set_property PACKAGE_PIN AG9 [get_ports {C0_DDR4_adr[11]}]
set_property PACKAGE_PIN AM13 [get_ports {C0_DDR4_adr[12]}]
set_property PACKAGE_PIN AF8 [get_ports {C0_DDR4_adr[13]}]
set_property PACKAGE_PIN AC12 [get_ports {C0_DDR4_adr[14]}]
set_property PACKAGE_PIN AE12 [get_ports {C0_DDR4_adr[15]}]
set_property PACKAGE_PIN AF11 [get_ports {C0_DDR4_adr[16]}]

set_property PACKAGE_PIN AK8 [get_ports {C0_DDR4_ba[0]}]
set_property PACKAGE_PIN AL12 [get_ports {C0_DDR4_ba[1]}]

set_property PACKAGE_PIN AE14 [get_ports {C0_DDR4_bg[0]}]

set_property PACKAGE_PIN AJ11 [get_ports {C0_DDR4_ck_c[0]}]

set_property PACKAGE_PIN AB13 [get_ports {C0_DDR4_cke[0]}]

set_property PACKAGE_PIN AD12 [get_ports {C0_DDR4_cs_n[0]}]

set_property PACKAGE_PIN AH18 [get_ports {C0_DDR4_dm_n[0]}]
set_property PACKAGE_PIN AD15 [get_ports {C0_DDR4_dm_n[1]}]
set_property PACKAGE_PIN AM16 [get_ports {C0_DDR4_dm_n[2]}]
set_property PACKAGE_PIN AP18 [get_ports {C0_DDR4_dm_n[3]}]
set_property PACKAGE_PIN AE18 [get_ports {C0_DDR4_dm_n[4]}]
set_property PACKAGE_PIN AH22 [get_ports {C0_DDR4_dm_n[5]}]
set_property PACKAGE_PIN AL20 [get_ports {C0_DDR4_dm_n[6]}]
set_property PACKAGE_PIN AP19 [get_ports {C0_DDR4_dm_n[7]}]

set_property PACKAGE_PIN AF16 [get_ports {C0_DDR4_dq[0]}]
set_property PACKAGE_PIN AF18 [get_ports {C0_DDR4_dq[1]}]
set_property PACKAGE_PIN AG15 [get_ports {C0_DDR4_dq[2]}]
set_property PACKAGE_PIN AF17 [get_ports {C0_DDR4_dq[3]}]
set_property PACKAGE_PIN AF15 [get_ports {C0_DDR4_dq[4]}]
set_property PACKAGE_PIN AG18 [get_ports {C0_DDR4_dq[5]}]
set_property PACKAGE_PIN AG14 [get_ports {C0_DDR4_dq[6]}]
set_property PACKAGE_PIN AE17 [get_ports {C0_DDR4_dq[7]}]
set_property PACKAGE_PIN AA14 [get_ports {C0_DDR4_dq[8]}]
set_property PACKAGE_PIN AC16 [get_ports {C0_DDR4_dq[9]}]
set_property PACKAGE_PIN AB15 [get_ports {C0_DDR4_dq[10]}]
set_property PACKAGE_PIN AD16 [get_ports {C0_DDR4_dq[11]}]
set_property PACKAGE_PIN AB16 [get_ports {C0_DDR4_dq[12]}]
set_property PACKAGE_PIN AC17 [get_ports {C0_DDR4_dq[13]}]
set_property PACKAGE_PIN AB14 [get_ports {C0_DDR4_dq[14]}]
set_property PACKAGE_PIN AD17 [get_ports {C0_DDR4_dq[15]}]
set_property PACKAGE_PIN AJ16 [get_ports {C0_DDR4_dq[16]}]
set_property PACKAGE_PIN AJ17 [get_ports {C0_DDR4_dq[17]}]
set_property PACKAGE_PIN AL15 [get_ports {C0_DDR4_dq[18]}]
set_property PACKAGE_PIN AK17 [get_ports {C0_DDR4_dq[19]}]
set_property PACKAGE_PIN AJ15 [get_ports {C0_DDR4_dq[20]}]
set_property PACKAGE_PIN AK18 [get_ports {C0_DDR4_dq[21]}]
set_property PACKAGE_PIN AL16 [get_ports {C0_DDR4_dq[22]}]
set_property PACKAGE_PIN AL18 [get_ports {C0_DDR4_dq[23]}]
set_property PACKAGE_PIN AP13 [get_ports {C0_DDR4_dq[24]}]
set_property PACKAGE_PIN AP16 [get_ports {C0_DDR4_dq[25]}]
set_property PACKAGE_PIN AP15 [get_ports {C0_DDR4_dq[26]}]
set_property PACKAGE_PIN AN16 [get_ports {C0_DDR4_dq[27]}]
set_property PACKAGE_PIN AN13 [get_ports {C0_DDR4_dq[28]}]
set_property PACKAGE_PIN AM18 [get_ports {C0_DDR4_dq[29]}]
set_property PACKAGE_PIN AN17 [get_ports {C0_DDR4_dq[30]}]
set_property PACKAGE_PIN AN18 [get_ports {C0_DDR4_dq[31]}]
set_property PACKAGE_PIN AB19 [get_ports {C0_DDR4_dq[32]}]
set_property PACKAGE_PIN AD19 [get_ports {C0_DDR4_dq[33]}]
set_property PACKAGE_PIN AC18 [get_ports {C0_DDR4_dq[34]}]
set_property PACKAGE_PIN AC19 [get_ports {C0_DDR4_dq[35]}]
set_property PACKAGE_PIN AA20 [get_ports {C0_DDR4_dq[36]}]
set_property PACKAGE_PIN AE20 [get_ports {C0_DDR4_dq[37]}]
set_property PACKAGE_PIN AA19 [get_ports {C0_DDR4_dq[38]}]
set_property PACKAGE_PIN AD20 [get_ports {C0_DDR4_dq[39]}]
set_property PACKAGE_PIN AF22 [get_ports {C0_DDR4_dq[40]}]
set_property PACKAGE_PIN AH21 [get_ports {C0_DDR4_dq[41]}]
set_property PACKAGE_PIN AG19 [get_ports {C0_DDR4_dq[42]}]
set_property PACKAGE_PIN AG21 [get_ports {C0_DDR4_dq[43]}]
set_property PACKAGE_PIN AE24 [get_ports {C0_DDR4_dq[44]}]
set_property PACKAGE_PIN AG20 [get_ports {C0_DDR4_dq[45]}]
set_property PACKAGE_PIN AE23 [get_ports {C0_DDR4_dq[46]}]
set_property PACKAGE_PIN AF21 [get_ports {C0_DDR4_dq[47]}]
set_property PACKAGE_PIN AL22 [get_ports {C0_DDR4_dq[48]}]
set_property PACKAGE_PIN AJ22 [get_ports {C0_DDR4_dq[49]}]
set_property PACKAGE_PIN AL23 [get_ports {C0_DDR4_dq[50]}]
set_property PACKAGE_PIN AJ21 [get_ports {C0_DDR4_dq[51]}]
set_property PACKAGE_PIN AK20 [get_ports {C0_DDR4_dq[52]}]
set_property PACKAGE_PIN AJ19 [get_ports {C0_DDR4_dq[53]}]
set_property PACKAGE_PIN AK19 [get_ports {C0_DDR4_dq[54]}]
set_property PACKAGE_PIN AJ20 [get_ports {C0_DDR4_dq[55]}]
set_property PACKAGE_PIN AP22 [get_ports {C0_DDR4_dq[56]}]
set_property PACKAGE_PIN AN22 [get_ports {C0_DDR4_dq[57]}]
set_property PACKAGE_PIN AP21 [get_ports {C0_DDR4_dq[58]}]
set_property PACKAGE_PIN AP23 [get_ports {C0_DDR4_dq[59]}]
set_property PACKAGE_PIN AM19 [get_ports {C0_DDR4_dq[60]}]
set_property PACKAGE_PIN AM23 [get_ports {C0_DDR4_dq[61]}]
set_property PACKAGE_PIN AN19 [get_ports {C0_DDR4_dq[62]}]
set_property PACKAGE_PIN AN23 [get_ports {C0_DDR4_dq[63]}]

set_property PACKAGE_PIN AJ14 [get_ports {C0_DDR4_dqs_c[0]}]
set_property PACKAGE_PIN AA15 [get_ports {C0_DDR4_dqs_c[1]}]
set_property PACKAGE_PIN AK14 [get_ports {C0_DDR4_dqs_c[2]}]
set_property PACKAGE_PIN AN14 [get_ports {C0_DDR4_dqs_c[3]}]
set_property PACKAGE_PIN AB18 [get_ports {C0_DDR4_dqs_c[4]}]
set_property PACKAGE_PIN AG23 [get_ports {C0_DDR4_dqs_c[5]}]
set_property PACKAGE_PIN AK23 [get_ports {C0_DDR4_dqs_c[6]}]
set_property PACKAGE_PIN AN21 [get_ports {C0_DDR4_dqs_c[7]}]

set_property PACKAGE_PIN AF10 [get_ports {C0_DDR4_odt[0]}]

set_property PACKAGE_PIN AF12 [get_ports {C0_DDR4_reset_n[0]}]

set_property PACKAGE_PIN H9 [get_ports {mig_sys_clk_p[0]}]
set_property PACKAGE_PIN G9 [get_ports {mig_sys_clk_n[0]}]
set_property IOSTANDARD LVDS [get_ports mig_sys_clk_*]
