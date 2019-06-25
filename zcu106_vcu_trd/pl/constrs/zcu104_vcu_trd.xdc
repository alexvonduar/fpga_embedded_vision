#####
## Constraints for ZCU104
## Version 1.0
#####


#####
## Pins
#####
set_property PACKAGE_PIN AH12 [get_ports CLK_300_C_P_clk_p]
set_property IOSTANDARD LVDS [get_ports CLK_300_C_P_clk_p]

# HDMI RX
set_property PACKAGE_PIN R10 [get_ports HDMI_RX_CLK_P]

#SFP SI5328
#set_property PACKAGE_PIN W10 [get_ports {DRU_CLK_clk_p[0]}]

#
# HDMI DRU Clock SI570
#
# PL Port           Pin  Schematic
#
# dru_clk_in_clk_n  U9   HDMI_DRU_CLOCK_C_N
# dru_clk_in_clk_p  U10  HDMI_DRU_CLOCK_C_P
#
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

#
# HDMI RX
#
# PL Port                 Pin  Schematic
#
# hdmi_rx_clk_p_in        R10  HDMI_RX_CLK_C_P
# hdmi_rx_clk_n_in        R9   HDMI_RX_CLK_C_N
# hdmi_rx_dat_p_in[0]     N2   HDMI_RX0_C_P
# hdmi_rx_dat_n_in[0]     N1   HDMI_RX0_C_N
# hdmi_rx_dat_p_in[1]     L2   HDMI_RX1_C_P
# hdmi_rx_dat_n_in[1]     L1   HDMI_RX1_C_N
# hdmi_rx_dat_p_in[2]     J2   HDMI_RX2_C_P
# hdmi_rx_dat_n_in[2]     J1   HDMI_RX2_C_N
# hdmi_rx_ddc_out_scl_io  D2   HDMI_RX_SNK_SCL
# hdmi_rx_ddc_out_sda_io  E2   HDMI_RX_SNK_SDA
# hdmi_rx_hpd_out         F6   HDMI_RX_HPD
# hdmi_rx_det_in          E5   HDMI_RX_PWR_DET
#

set_property PACKAGE_PIN F6 [get_ports {RX_HPD[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RX_HPD[0]}]

set_property PACKAGE_PIN D2 [get_ports RX_DDC_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports RX_DDC_scl_io]

set_property PACKAGE_PIN E2 [get_ports RX_DDC_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports RX_DDC_sda_io]

set_property PACKAGE_PIN G14 [get_ports RX_REFCLK_P]
set_property IOSTANDARD DIFF_SSTL12 [get_ports RX_REFCLK_P]

set_property PACKAGE_PIN E5 [get_ports RX_DET]
set_property IOSTANDARD LVCMOS33 [get_ports RX_DET]


# HDMI TX
#
# PL Port                 Pin  Schematic
#
# hdmi_tx_clk_p_out       G21  HDMI_TX_LVDS_OUT_P
# hdmi_tx_clk_n_out       F21  HDMI_TX_LVDS_OUT_N
# hdmi_tx_dat_p_out[0]    M4   HDMI_TX0_P
# hdmi_tx_dat_n_out[0]    M3   HDMI_TX0_N
# hdmi_tx_dat_p_out[1]    L6   HDMI_TX1_P
# hdmi_tx_dat_n_out[1]    L5   HDMI_TX1_N
# hdmi_tx_dat_p_out[2]    K4   HDMI_TX2_P
# hdmi_tx_dat_n_out[2]    K3   HDMI_TX2_N
# hdmi_tx_ddc_out_scl_io  B1   HDMI_TX_SRC_SCL
# hdmi_tx_ddc_out_sda_io  C1   HDMI_TX_SRC_SDA
# hdmi_tx_hpd_in          E3   HDMI_TX_HPD
# hdmi_tx_en_out          A2   HDMI_TX_EN
#

set_property PACKAGE_PIN T8 [get_ports TX_REFCLK_P]

set_property PACKAGE_PIN H9 [get_ports HDMI_TX_CLK_P]
set_property IOSTANDARD LVDS [get_ports HDMI_TX_CLK_P]

set_property PACKAGE_PIN E3 [get_ports TX_HPD]
set_property IOSTANDARD LVCMOS33 [get_ports TX_HPD]

set_property PACKAGE_PIN B1 [get_ports TX_DDC_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports TX_DDC_scl_io]

set_property PACKAGE_PIN C1 [get_ports TX_DDC_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports TX_DDC_sda_io]

#set_property PACKAGE_PIN A2 [get_ports HDMI_TX_EN]
#set_property IOSTANDARD LVCMOS33 [get_ports HDMI_TX_EN]

# I2C
set_property PACKAGE_PIN D1 [get_ports HDMI_CTRL_IIC_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports HDMI_CTRL_IIC_scl_io]

set_property PACKAGE_PIN E1 [get_ports HDMI_CTRL_IIC_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports HDMI_CTRL_IIC_sda_io]


# Misc
#GPIO_LED_0_LS
set_property PACKAGE_PIN D5 [get_ports LED0]
#GPIO_LED_1_LS
set_property PACKAGE_PIN D6 [get_ports {LED1[0]}]
##GPIO_LED_2_LS
#set_property PACKAGE_PIN AK13 [get_ports {LED2[0]}]
##GPIO_LED_3_LS
#set_property PACKAGE_PIN AE15 [get_ports {LED3[0]}]
##GPIO_LED_4_LS
#set_property PACKAGE_PIN AM8 [get_ports {LED4[0]}]
##GPIO_LED_5_LS
#set_property PACKAGE_PIN AM9 [get_ports {LED5[0]}]
#GPIO_LED_6_LS
set_property PACKAGE_PIN A5 [get_ports LED2]
#GPIO_LED_7_LS
set_property PACKAGE_PIN B5 [get_ports LED3]


set_property IOSTANDARD LVCMOS33 [get_ports LED*]

set_property PACKAGE_PIN M12 [get_ports {SI5319_RST[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SI5319_RST[0]}]

set_property PACKAGE_PIN N11 [get_ports SI5319_LOL]
set_property IOSTANDARD LVCMOS33 [get_ports SI5319_LOL]

set_property PACKAGE_PIN A2 [get_ports {TX_EN[0]}]
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
set_property IOSTANDARD LVCMOS18 [get_ports {sensor_gpio_rst[0]}]
set_property PACKAGE_PIN A8 [get_ports {sensor_gpio_spi_cs_n[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {sensor_gpio_spi_cs_n[0]}]
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
#set_property IOSTANDARD HSUL_12_DCI [get_ports sensor_iic_*]
set_property IOSTANDARD LVCMOS18 [get_ports sensor_iic_*]

#
# The VRP pin in Bank 67 is not connected (NC). To use MIPI_DPHY_DCI on this bank,
# DCI Cascade must be used. Since Bank 66 has a 240 ohm resistor connected to the
# VRP pin, use Bank 66 as a DCI cascade master bank for Bank 66 (see AR# 67565).
#
set_property DCI_CASCADE {67} [get_iobanks 66]

set_clock_groups -name mux_clk -logically_exclusive -group [get_clocks [list  [get_clocks -of_objects [get_pins vcu_trd_i/clk_wiz_1/inst/mmcme4_adv_inst/CLKOUT1]]]] -group [get_clocks clk_pl_2]
