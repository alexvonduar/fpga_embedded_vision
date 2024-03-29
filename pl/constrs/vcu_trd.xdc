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
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {vcu_trd_i/gt_refclk_buf/ibufds_gt/U0/IBUF_OUT[0]}]

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
set_property PACKAGE_PIN H12 [get_ports {sensor_gpio_rst[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sensor_gpio_rst[0]}]
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


set_clock_groups -name mux_clk -logically_exclusive -group [get_clocks [list  [get_clocks -of_objects [get_pins vcu_trd_i/clk_wiz_1/inst/mmcme4_adv_inst/CLKOUT1]]]] -group [get_clocks clk_pl_2]
