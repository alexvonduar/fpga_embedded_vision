########################
# Physical Constraints #
########################

# I2C Chain on FMC-HDMI-CAM
set_property PACKAGE_PIN F16    [get_ports fmc_hdmi_cam_iic_scl_io]
set_property IOSTANDARD LVCMOS25 [get_ports fmc_hdmi_cam_iic_scl_io]
set_property SLEW SLOW [get_ports fmc_hdmi_cam_iic_scl_io]
set_property DRIVE 8 [get_ports fmc_hdmi_cam_iic_scl_io]

set_property PACKAGE_PIN F17    [get_ports fmc_hdmi_cam_iic_sda_io]
set_property IOSTANDARD LVCMOS25 [get_ports fmc_hdmi_cam_iic_sda_io]
set_property SLEW SLOW [get_ports fmc_hdmi_cam_iic_sda_io]
set_property DRIVE 8 [get_ports fmc_hdmi_cam_iic_sda_io]

set_property PACKAGE_PIN L17    [get_ports {fmc_hdmi_cam_iic_rst_n[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {fmc_hdmi_cam_iic_rst_n[0]}]
set_property SLEW SLOW [get_ports {fmc_hdmi_cam_iic_rst_n[0]}]
set_property DRIVE 8 [get_ports {fmc_hdmi_cam_iic_rst_n[0]}]

# HDMI Input (ADV7611) on FMC-HDMI-CAM
set_property PACKAGE_PIN H16   [get_ports IO_HDMII_clk]
set_property PACKAGE_PIN U12   [get_ports {IO_HDMII_data[0]}]
set_property PACKAGE_PIN T12   [get_ports {IO_HDMII_data[1]}] 
set_property PACKAGE_PIN Y19   [get_ports {IO_HDMII_data[2]}]
set_property PACKAGE_PIN Y14   [get_ports {IO_HDMII_data[3]}]
set_property PACKAGE_PIN W15   [get_ports {IO_HDMII_data[4]}]
set_property PACKAGE_PIN Y18   [get_ports {IO_HDMII_data[5]}]
set_property PACKAGE_PIN W14   [get_ports {IO_HDMII_data[6]}]
set_property PACKAGE_PIN V15   [get_ports {IO_HDMII_data[7]}]
set_property PACKAGE_PIN R14   [get_ports {IO_HDMII_data[8]}]
set_property PACKAGE_PIN P14   [get_ports {IO_HDMII_data[9]}]
set_property PACKAGE_PIN W13   [get_ports {IO_HDMII_data[10]}]
set_property PACKAGE_PIN V12   [get_ports {IO_HDMII_data[11]}]
set_property PACKAGE_PIN Y17   [get_ports {IO_HDMII_data[12]}]
set_property PACKAGE_PIN Y16   [get_ports {IO_HDMII_data[13]}]
set_property PACKAGE_PIN T10   [get_ports {IO_HDMII_data[14]}]
set_property PACKAGE_PIN T11   [get_ports {IO_HDMII_data[15]}]
set_property PACKAGE_PIN W20   [get_ports {IO_HDMII_spdif}]

set_property IOSTANDARD LVCMOS25 [get_ports IO_HDMII_clk]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMII_data*}]
set_property IOSTANDARD LVCMOS25 [get_ports {IO_HDMII_spdif}]

# HDMI Output (ADV7511) on FMC-HDMI-CAM
set_property PACKAGE_PIN H17   [get_ports IO_HDMIO_clk]
set_property PACKAGE_PIN U20   [get_ports {IO_HDMIO_data[0]}]
set_property PACKAGE_PIN T20   [get_ports {IO_HDMIO_data[1]}]
set_property PACKAGE_PIN P20   [get_ports {IO_HDMIO_data[2]}]
set_property PACKAGE_PIN G20   [get_ports {IO_HDMIO_data[3]}]
set_property PACKAGE_PIN N20   [get_ports {IO_HDMIO_data[4]}]
set_property PACKAGE_PIN L20   [get_ports {IO_HDMIO_data[5]}]
set_property PACKAGE_PIN U15   [get_ports {IO_HDMIO_data[6]}]
set_property PACKAGE_PIN G19   [get_ports {IO_HDMIO_data[7]}]
set_property PACKAGE_PIN L19   [get_ports {IO_HDMIO_data[8]}]
set_property PACKAGE_PIN L15   [get_ports {IO_HDMIO_data[9]}]
set_property PACKAGE_PIN U14   [get_ports {IO_HDMIO_data[10]}]
set_property PACKAGE_PIN M20   [get_ports {IO_HDMIO_data[11]}]
set_property PACKAGE_PIN L14   [get_ports {IO_HDMIO_data[12]}]
set_property PACKAGE_PIN J14   [get_ports {IO_HDMIO_data[13]}]
set_property PACKAGE_PIN M19   [get_ports {IO_HDMIO_data[14]}]
set_property PACKAGE_PIN K14   [get_ports {IO_HDMIO_data[15]}]
set_property PACKAGE_PIN V20   [get_ports IO_HDMIO_spdif]

set_property IOSTANDARD LVCMOS25 [get_ports IO_HDMIO_clk]
set_property IOSTANDARD LVCMOS25 [get_ports IO_HDMIO_data*]
set_property IOB TRUE [get_ports IO_HDMIO_data*]
set_property IOSTANDARD LVCMOS25 [get_ports IO_HDMIO_spdif]


# Camera interface (PYTHON-1300) on FMC-HDMI-CAM
set_property PACKAGE_PIN N15   [get_ports IO_PYTHON_CAM_clk_pll]
set_property PACKAGE_PIN K18   [get_ports IO_PYTHON_CAM_reset_n]
set_property PACKAGE_PIN N16   [get_ports {IO_PYTHON_CAM_trigger[2]}]
set_property PACKAGE_PIN J20   [get_ports {IO_PYTHON_CAM_trigger[1]}]
set_property PACKAGE_PIN H20   [get_ports {IO_PYTHON_CAM_trigger[0]}]
set_property PACKAGE_PIN K16   [get_ports {IO_PYTHON_CAM_monitor[0]}]
set_property PACKAGE_PIN J16   [get_ports {IO_PYTHON_CAM_monitor[1]}]
set_property PACKAGE_PIN H15   [get_ports IO_PYTHON_SPI_spi_sclk]
set_property PACKAGE_PIN G15   [get_ports IO_PYTHON_SPI_spi_ssel_n]
set_property PACKAGE_PIN M14   [get_ports IO_PYTHON_SPI_spi_mosi]
set_property PACKAGE_PIN M15   [get_ports IO_PYTHON_SPI_spi_miso]
set_property PACKAGE_PIN J18   [get_ports IO_PYTHON_CAM_clk_out_p]; #CAM_CLK_P
set_property PACKAGE_PIN H18   [get_ports IO_PYTHON_CAM_clk_out_n]; #CAM_CLK_N
set_property PACKAGE_PIN M17   [get_ports IO_PYTHON_CAM_sync_p]; #CAM_SYNC_P
set_property PACKAGE_PIN M18   [get_ports IO_PYTHON_CAM_sync_n]; #CAM_SYNC_N
#set_property PACKAGE_PIN F19   [get_ports {IO_PYTHON_CAM_data_p[]}]; #CAM_DATA7_P
#set_property PACKAGE_PIN F20   [get_ports {IO_PYTHON_CAM_data_n[]}]; #CAM_DATA7_N
#set_property PACKAGE_PIN C20   [get_ports {IO_PYTHON_CAM_data_p[]}]; #CAM_DATA6_P
#set_property PACKAGE_PIN B20   [get_ports {IO_PYTHON_CAM_data_n[]}]; #CAM_DATA6_N
set_property PACKAGE_PIN D19   [get_ports {IO_PYTHON_CAM_data_p[3]}]; #CAM_DATA5_P
set_property PACKAGE_PIN D20   [get_ports {IO_PYTHON_CAM_data_n[3]}]; #CAM_DATA5_N
set_property PACKAGE_PIN G17   [get_ports {IO_PYTHON_CAM_data_p[2]}]; #CAM_DATA4_P
set_property PACKAGE_PIN G18   [get_ports {IO_PYTHON_CAM_data_n[2]}]; #CAM_DATA4_N
set_property PACKAGE_PIN B19   [get_ports {IO_PYTHON_CAM_data_p[1]}]; #CAM_DATA3_P
set_property PACKAGE_PIN A20   [get_ports {IO_PYTHON_CAM_data_n[1]}]; #CAM_DATA3_N
set_property PACKAGE_PIN E18   [get_ports {IO_PYTHON_CAM_data_p[0]}]; #CAM_DATA2_P
set_property PACKAGE_PIN E19   [get_ports {IO_PYTHON_CAM_data_n[0]}]; #CAM_DATA2_N
#set_property PACKAGE_PIN E17   [get_ports {IO_PYTHON_CAM_data_p[]}]; #CAM_DATA1_P
#set_property PACKAGE_PIN D18   [get_ports {IO_PYTHON_CAM_data_n[]}]; #CAM_DATA1_N
#set_property PACKAGE_PIN K19   [get_ports {IO_PYTHON_CAM_data_p[]}]; #CAM_DATA0_P
#set_property PACKAGE_PIN J19   [get_ports {IO_PYTHON_CAM_data_n[]}]; #CAM_DATA0_N

set_property IOSTANDARD LVCMOS25 [get_ports IO_PYTHON_CAM_clk_pll]
set_property IOSTANDARD LVCMOS25 [get_ports IO_PYTHON_CAM_reset_n]
set_property IOSTANDARD LVCMOS25 [get_ports IO_PYTHON_CAM_trigger*]
set_property IOSTANDARD LVCMOS25 [get_ports IO_PYTHON_CAM_monitor*]
set_property IOSTANDARD LVCMOS25 [get_ports IO_PYTHON_SPI_spi_*]

set_property IOSTANDARD LVDS_25 [get_ports IO_PYTHON_CAM_clk_out_*]
set_property IOSTANDARD LVDS_25 [get_ports IO_PYTHON_CAM_sync_*]
set_property IOSTANDARD LVDS_25 [get_ports IO_PYTHON_CAM_data_*]

set_property DIFF_TERM true [get_ports IO_PYTHON_CAM_clk_out_*]
set_property DIFF_TERM true [get_ports IO_PYTHON_CAM_sync_*]
set_property DIFF_TERM true [get_ports IO_PYTHON_CAM_data_*]


# Video Clock Synthesizer on FMC-HDMI-CAM
set_property PACKAGE_PIN K17   [get_ports fmc_hdmi_cam_vclk]
set_property IOSTANDARD LVCMOS25 [get_ports fmc_hdmi_cam_vclk]

######################
#  Clock Constraints #
######################

# The following constraints are already created by the "ZYNQ7 Processing System" core
#create_clock -period 13.333 -name clk_fpga_0 [get_nets -hierarchical FCLK_CLK0]
#create_clock -period  6.667 -name clk_fpga_1 [get_nets -hierarchical FCLK_CLK1]
#create_clock -period  5.000 -name clk_fpga_2 [get_nets -hierarchical FCLK_CLK2]

create_clock -period 6.730 -name video_clk [get_ports fmc_hdmi_cam_vclk]

create_clock -period 6.730 -name hdmii_clk [get_ports IO_HDMII_clk]

create_clock -period 3.703 -name vita_ser_clk [get_ports IO_PYTHON_CAM_clk_out_p]


# Define asynchronous clock domains
set_clock_groups -asynchronous -group [get_clocks clk_fpga_0] \
                               -group [get_clocks clk_fpga_1] \
                               -group [get_clocks clk_out1_*_clk_wiz_*] \
                               -group [get_clocks clk_out2_*_clk_wiz_*] \
                               -group [get_clocks video_clk] \
                               -group [get_clocks hdmii_clk] \
                               -group [get_clocks *CLKDIV*] \
                               -group [get_clocks vita_clk*]

set_input_delay -clock [get_clocks hdmii_clk] -clock_fall -min -add_delay 0.500 [get_ports {IO_HDMII_data[*]}]
set_input_delay -clock [get_clocks hdmii_clk] -clock_fall -max -add_delay 1.300 [get_ports {IO_HDMII_data[*]}]

# MYIR 7020 board specific constraints

# RGB interface for HDMI/LCD/FPC touchscreen
# Bank 34 (2.5V)
set_property -dict {PACKAGE_PIN V18 IOSTANDARD LVCMOS25} [get_ports VID_HS]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS25} [get_ports VID_VS]
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS25} [get_ports VID_DE]
set_property -dict {PACKAGE_PIN P19 IOSTANDARD LVCMOS25} [get_ports VID_CLK]

set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS25} [get_ports {RGB_D[0]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS25} [get_ports {RGB_D[1]}]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS25} [get_ports {RGB_D[2]}]
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS25} [get_ports {RGB_D[3]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS25} [get_ports {RGB_D[4]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS25} [get_ports {RGB_D[5]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS25} [get_ports {RGB_D[6]}]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS25} [get_ports {RGB_D[7]}]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS25} [get_ports {RGB_D[8]}]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS25} [get_ports {RGB_D[9]}]
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS25} [get_ports {RGB_D[10]}]
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS25} [get_ports {RGB_D[11]}]
set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS25} [get_ports {RGB_D[12]}]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS25} [get_ports {RGB_D[13]}]
set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS25} [get_ports {RGB_D[14]}]
set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS25} [get_ports {RGB_D[15]}]

set_property -dict {PACKAGE_PIN T19 IOSTANDARD LVCMOS25} [get_ports LCD_EN]
#set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports LCD_DATA_EN]
set_property -dict {PACKAGE_PIN R19 IOSTANDARD LVCMOS25} [get_ports LCD_BL_EN]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS25} [get_ports TP_RST]
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS25} [get_ports TP_INTR]
set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS25} [get_ports HDMI_INTR]

set_property PULLUP true [get_ports LCD_BL_EN]
set_property PULLUP true [get_ports TP_RST]

# Pmods
set_property -dict {PACKAGE_PIN W10 IOSTANDARD LVCMOS33} [get_ports {PMOD1_io[0]}]
set_property -dict {PACKAGE_PIN Y12 IOSTANDARD LVCMOS33} [get_ports {PMOD1_io[1]}]
set_property -dict {PACKAGE_PIN W9  IOSTANDARD LVCMOS33} [get_ports {PMOD1_io[2]}]
set_property -dict {PACKAGE_PIN Y13 IOSTANDARD LVCMOS33} [get_ports {PMOD1_io[3]}]
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports {PMOD1_io[4]}]
set_property -dict {PACKAGE_PIN T9  IOSTANDARD LVCMOS33} [get_ports {PMOD1_io[5]}]
set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports {PMOD1_io[6]}]
set_property -dict {PACKAGE_PIN U10 IOSTANDARD LVCMOS33} [get_ports {PMOD1_io[7]}]

set_property -dict {PACKAGE_PIN W11 IOSTANDARD LVCMOS33} [get_ports {PMOD2_io[0]}]
set_property -dict {PACKAGE_PIN Y9  IOSTANDARD LVCMOS33} [get_ports {PMOD2_io[1]}]
set_property -dict {PACKAGE_PIN Y11 IOSTANDARD LVCMOS33} [get_ports {PMOD2_io[2]}]
set_property -dict {PACKAGE_PIN Y8  IOSTANDARD LVCMOS33} [get_ports {PMOD2_io[3]}]
set_property -dict {PACKAGE_PIN U9  IOSTANDARD LVCMOS33} [get_ports {PMOD2_io[4]}]
set_property -dict {PACKAGE_PIN U7  IOSTANDARD LVCMOS33} [get_ports {PMOD2_io[5]}]
set_property -dict {PACKAGE_PIN U8  IOSTANDARD LVCMOS33} [get_ports {PMOD2_io[6]}]
set_property -dict {PACKAGE_PIN V7  IOSTANDARD LVCMOS33} [get_ports {PMOD2_io[7]}]

set_property -dict {PACKAGE_PIN Y7  IOSTANDARD LVCMOS33} [get_ports {PMOD3_io[0]}]
set_property -dict {PACKAGE_PIN T5  IOSTANDARD LVCMOS33} [get_ports {PMOD3_io[1]}]
set_property -dict {PACKAGE_PIN Y6  IOSTANDARD LVCMOS33} [get_ports {PMOD3_io[2]}]
set_property -dict {PACKAGE_PIN U5  IOSTANDARD LVCMOS33} [get_ports {PMOD3_io[3]}]
set_property -dict {PACKAGE_PIN V8  IOSTANDARD LVCMOS33} [get_ports {PMOD3_io[4]}]
set_property -dict {PACKAGE_PIN V6  IOSTANDARD LVCMOS33} [get_ports {PMOD3_io[5]}]
set_property -dict {PACKAGE_PIN W8  IOSTANDARD LVCMOS33} [get_ports {PMOD3_io[6]}]
set_property -dict {PACKAGE_PIN W6  IOSTANDARD LVCMOS33} [get_ports {PMOD3_io[7]}]
