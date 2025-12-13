########################
# Physical Constraints #
########################

# I2C Chain on FMC-HDMI-CAM
set_property -dict {PACKAGE_PIN R7  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 8} [get_ports {FMC_IIC_scl_io}]
set_property -dict {PACKAGE_PIN U7  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 8} [get_ports {FMC_IIC_sda_io}]
set_property -dict {PACKAGE_PIN J20 IOSTANDARD LVCMOS25 SLEW SLOW DRIVE 8} [get_ports {FMC_IIC_MUX_scl_io}]
set_property -dict {PACKAGE_PIN K21 IOSTANDARD LVCMOS25 SLEW SLOW DRIVE 8} [get_ports {FMC_IIC_MUX_sda_io}]
set_property -dict {PACKAGE_PIN N20 IOSTANDARD LVCMOS25 SLEW SLOW DRIVE 8} [get_ports {FMC_IIC_MUX_rst_n[0]}]

# HDMI Input (ADV7611) on FMC-HDMI-CAM
set_property PACKAGE_PIN D18   [get_ports FMC_HDMII_clk]
set_property PACKAGE_PIN A17   [get_ports {FMC_HDMII_data[0]}]
set_property PACKAGE_PIN A16   [get_ports {FMC_HDMII_data[1]}]
set_property PACKAGE_PIN C18   [get_ports {FMC_HDMII_data[2]}]
set_property PACKAGE_PIN D21   [get_ports {FMC_HDMII_data[3]}]
set_property PACKAGE_PIN E18   [get_ports {FMC_HDMII_data[4]}]
set_property PACKAGE_PIN C17   [get_ports {FMC_HDMII_data[5]}]
set_property PACKAGE_PIN E21   [get_ports {FMC_HDMII_data[6]}]
set_property PACKAGE_PIN F18   [get_ports {FMC_HDMII_data[7]}]
set_property PACKAGE_PIN A22   [get_ports {FMC_HDMII_data[8]}]
set_property PACKAGE_PIN A21   [get_ports {FMC_HDMII_data[9]}]
set_property PACKAGE_PIN B22   [get_ports {FMC_HDMII_data[10]}]
set_property PACKAGE_PIN B21   [get_ports {FMC_HDMII_data[11]}]
set_property PACKAGE_PIN B15   [get_ports {FMC_HDMII_data[12]}]
set_property PACKAGE_PIN C15   [get_ports {FMC_HDMII_data[13]}]
set_property PACKAGE_PIN B17   [get_ports {FMC_HDMII_data[14]}]
set_property PACKAGE_PIN B16   [get_ports {FMC_HDMII_data[15]}]
set_property PACKAGE_PIN A19   [get_ports {FMC_HDMII_spdif}]

set_property IOSTANDARD LVCMOS25 [get_ports FMC_HDMII_clk]
set_property IOSTANDARD LVCMOS25 [get_ports {FMC_HDMII_data*}]
set_property IOSTANDARD LVCMOS25 [get_ports {FMC_HDMII_spdif}]

# HDMI Output (ADV7511) on FMC-HDMI-CAM
set_property PACKAGE_PIN C19   [get_ports FMC_HDMIO_clk]
set_property PACKAGE_PIN C22   [get_ports {FMC_HDMIO_data[0]}]
set_property PACKAGE_PIN D22   [get_ports {FMC_HDMIO_data[1]}]
set_property PACKAGE_PIN E20   [get_ports {FMC_HDMIO_data[2]}]
set_property PACKAGE_PIN D15   [get_ports {FMC_HDMIO_data[3]}]
set_property PACKAGE_PIN E19   [get_ports {FMC_HDMIO_data[4]}]
set_property PACKAGE_PIN F19   [get_ports {FMC_HDMIO_data[5]}]
set_property PACKAGE_PIN C20   [get_ports {FMC_HDMIO_data[6]}]
set_property PACKAGE_PIN E15   [get_ports {FMC_HDMIO_data[7]}]
set_property PACKAGE_PIN G19   [get_ports {FMC_HDMIO_data[8]}]
set_property PACKAGE_PIN G16   [get_ports {FMC_HDMIO_data[9]}]
set_property PACKAGE_PIN D20   [get_ports {FMC_HDMIO_data[10]}]
set_property PACKAGE_PIN B20   [get_ports {FMC_HDMIO_data[11]}]
set_property PACKAGE_PIN G15   [get_ports {FMC_HDMIO_data[12]}]
set_property PACKAGE_PIN G21   [get_ports {FMC_HDMIO_data[13]}]
set_property PACKAGE_PIN B19   [get_ports {FMC_HDMIO_data[14]}]
set_property PACKAGE_PIN G20   [get_ports {FMC_HDMIO_data[15]}]
set_property PACKAGE_PIN A18   [get_ports FMC_HDMIO_spdif]

set_property IOSTANDARD LVCMOS25 [get_ports FMC_HDMIO_clk]
set_property IOSTANDARD LVCMOS25 [get_ports FMC_HDMIO_data*]
set_property IOB TRUE [get_ports FMC_HDMIO_data*]
set_property IOSTANDARD LVCMOS25 [get_ports FMC_HDMIO_spdif]


# Camera interface (PYTHON-1300) on FMC-HDMI-CAM
set_property PACKAGE_PIN L17   [get_ports FMC_CAM_clk_pll]
set_property PACKAGE_PIN L19   [get_ports FMC_CAM_reset_n]
set_property PACKAGE_PIN M17   [get_ports {FMC_CAM_trigger[2]}]
set_property PACKAGE_PIN K19   [get_ports {FMC_CAM_trigger[1]}]
set_property PACKAGE_PIN K20   [get_ports {FMC_CAM_trigger[0]}]
set_property PACKAGE_PIN J16   [get_ports {FMC_CAM_monitor[0]}]
set_property PACKAGE_PIN J17   [get_ports {FMC_CAM_monitor[1]}]
set_property PACKAGE_PIN P20   [get_ports FMC_SPI_spi_sclk]
set_property PACKAGE_PIN P21   [get_ports FMC_SPI_spi_ssel_n]
set_property PACKAGE_PIN N17   [get_ports FMC_SPI_spi_mosi]
set_property PACKAGE_PIN N18   [get_ports FMC_SPI_spi_miso]
set_property PACKAGE_PIN M19   [get_ports FMC_CAM_clk_out_p]; #CAM_CLK_P
set_property PACKAGE_PIN M20   [get_ports FMC_CAM_clk_out_n]; #CAM_CLK_N
set_property PACKAGE_PIN R19   [get_ports FMC_CAM_sync_p]; #CAM_SYNC_P
set_property PACKAGE_PIN T19   [get_ports FMC_CAM_sync_n]; #CAM_SYNC_N
#set_property PACKAGE_PIN R20   [get_ports {FMC_CAM_data_p[]}]; #CAM_DATA7_P
#set_property PACKAGE_PIN R21   [get_ports {FMC_CAM_data_n[]}]; #CAM_DATA7_N
#set_property PACKAGE_PIN J21   [get_ports {FMC_CAM_data_p[]}]; #CAM_DATA6_P
#set_property PACKAGE_PIN J22   [get_ports {FMC_CAM_data_n[]}]; #CAM_DATA6_N
set_property PACKAGE_PIN T16   [get_ports {FMC_CAM_data_p[3]}]; #CAM_DATA5_P
set_property PACKAGE_PIN T17   [get_ports {FMC_CAM_data_n[3]}]; #CAM_DATA5_N
set_property PACKAGE_PIN J18   [get_ports {FMC_CAM_data_p[2]}]; #CAM_DATA4_P
set_property PACKAGE_PIN K18   [get_ports {FMC_CAM_data_n[2]}]; #CAM_DATA4_N
set_property PACKAGE_PIN M21   [get_ports {FMC_CAM_data_p[1]}]; #CAM_DATA3_P
set_property PACKAGE_PIN M22   [get_ports {FMC_CAM_data_n[1]}]; #CAM_DATA3_N
set_property PACKAGE_PIN L21   [get_ports {FMC_CAM_data_p[0]}]; #CAM_DATA2_P
set_property PACKAGE_PIN L22   [get_ports {FMC_CAM_data_n[0]}]; #CAM_DATA2_N
#set_property PACKAGE_PIN N22   [get_ports {FMC_CAM_data_p[]}]; #CAM_DATA1_P
#set_property PACKAGE_PIN P22   [get_ports {FMC_CAM_data_n[]}]; #CAM_DATA1_N
#set_property PACKAGE_PIN P17   [get_ports {FMC_CAM_data_p[]}]; #CAM_DATA0_P
#set_property PACKAGE_PIN P18   [get_ports {FMC_CAM_data_n[]}]; #CAM_DATA0_N

set_property IOSTANDARD LVCMOS25 [get_ports FMC_CAM_clk_pll]
set_property IOSTANDARD LVCMOS25 [get_ports FMC_CAM_reset_n]
set_property IOSTANDARD LVCMOS25 [get_ports FMC_CAM_trigger*]
set_property IOSTANDARD LVCMOS25 [get_ports FMC_CAM_monitor*]
set_property IOSTANDARD LVCMOS25 [get_ports FMC_SPI_spi_*]

set_property IOSTANDARD LVDS_25 [get_ports FMC_CAM_clk_out_*]
set_property IOSTANDARD LVDS_25 [get_ports FMC_CAM_sync_*]
set_property IOSTANDARD LVDS_25 [get_ports FMC_CAM_data_*]

set_property DIFF_TERM true [get_ports FMC_CAM_clk_out_*]
set_property DIFF_TERM true [get_ports FMC_CAM_sync_*]
set_property DIFF_TERM true [get_ports FMC_CAM_data_*]


# Video Clock Synthesizer on FMC-HDMI-CAM
set_property PACKAGE_PIN L18   [get_ports FMC_VCLK]
set_property IOSTANDARD LVCMOS25 [get_ports FMC_VCLK]

######################
#  Clock Constraints #
######################

# The following constraints are already created by the "ZYNQ7 Processing System" core
#create_clock -period 13.333 -name clk_fpga_0 [get_nets -hierarchical FCLK_CLK0]
#create_clock -period  6.667 -name clk_fpga_1 [get_nets -hierarchical FCLK_CLK1]
#create_clock -period  5.000 -name clk_fpga_2 [get_nets -hierarchical FCLK_CLK2]

create_clock -period 6.730 -name VIDEO_CLK [get_ports FMC_VCLK]

create_clock -period 6.730 -name HDMII_CLK [get_ports FMC_HDMII_clk]

create_clock -period 3.703 -name VITA_SER_CLK [get_ports FMC_CAM_clk_out_p]


# Define asynchronous clock domains
set_clock_groups -asynchronous -group [get_clocks clk_fpga_0] \
                               -group [get_clocks clk_fpga_1] \
                               -group [get_clocks clk_out1_*_clk_wiz_*] \
                               -group [get_clocks clk_out2_*_clk_wiz_*] \
                               -group [get_clocks video_clk] \
                               -group [get_clocks HDMII_CLK] \
                               -group [get_clocks *CLKDIV*] \
                               -group [get_clocks vita_clk*]

set_input_delay -clock [get_clocks HDMII_CLK] -clock_fall -min -add_delay 0.500 [get_ports {FMC_HDMII_data[*]}]
set_input_delay -clock [get_clocks HDMII_CLK] -clock_fall -max -add_delay 1.300 [get_ports {FMC_HDMII_data[*]}]


#zynqdev board interface pin constraints

# PL clock 50MHz
set_property -dict {PACKAGE_PIN W17  IOSTANDARD LVCMOS33} [get_ports {PL_CLK_50M}]

# PL key
set_property -dict {PACKAGE_PIN V4   IOSTANDARD LVCMOS33} [get_ports {PL_KEY_RSTN}]
set_property -dict {PACKAGE_PIN V5   IOSTANDARD LVCMOS33} [get_ports {PL_KEY3}]

# PL EEPROM I2C
set_property -dict {PACKAGE_PIN N15  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 8} [get_ports {PL_EEPROM_IIC_scl_io}]
set_property -dict {PACKAGE_PIN M15  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 8} [get_ports {PL_EEPROM_IIC_sda_io}]

# PL LEDs
set_property -dict {PACKAGE_PIN Y14  IOSTANDARD LVCMOS33} [get_ports {PL_LED[0]}]
set_property -dict {PACKAGE_PIN AA13 IOSTANDARD LVCMOS33} [get_ports {PL_LED[1]}]
set_property -dict {PACKAGE_PIN AB14 IOSTANDARD LVCMOS33} [get_ports {PL_LED[2]}]
set_property -dict {PACKAGE_PIN AB15 IOSTANDARD LVCMOS33} [get_ports {PL_LED[3]}]

# PL OLED
set_property -dict {PACKAGE_PIN T22  IOSTANDARD LVCMOS33} [get_ports {PL_OLED_D[1]}]
set_property -dict {PACKAGE_PIN U22  IOSTANDARD LVCMOS33} [get_ports {PL_OLED_D[0]}]
set_property -dict {PACKAGE_PIN V22  IOSTANDARD LVCMOS33} [get_ports {PL_OLED_DC}]
set_property -dict {PACKAGE_PIN W22  IOSTANDARD LVCMOS33} [get_ports {PL_OLED_RST}]

# MIPI
set_property -dict {PACKAGE_PIN AA14 IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 8 PULLUP true} [get_ports {MIPI_CAM_IIC_scl_io}]
set_property -dict {PACKAGE_PIN U14  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 8 PULLUP true} [get_ports {MIPI_CAM_IIC_sda_io}]

set_property -dict {PACKAGE_PIN Y15  IOSTANDARD LVCMOS33 PULLUP true} [get_ports {MIPI_GPIO_tri_io[0]}]
set_property -dict {PACKAGE_PIN W15  IOSTANDARD LVCMOS33 PULLUP true} [get_ports {MIPI_GPIO_tri_io[1]}]

set_property INTERNAL_VREF 0.6 [get_iobanks 13]

set_property -dict {PACKAGE_PIN U5   IOSTANDARD HSUL_12} [get_ports {MIPI_DPHY_clk_lp_n}]
set_property -dict {PACKAGE_PIN U6   IOSTANDARD HSUL_12} [get_ports {MIPI_DPHY_clk_lp_p}]

set_property -dict {PACKAGE_PIN T6   IOSTANDARD HSUL_12} [get_ports {MIPI_DPHY_data_lp_n[0]}]
set_property -dict {PACKAGE_PIN R6   IOSTANDARD HSUL_12} [get_ports {MIPI_DPHY_data_lp_p[0]}]
set_property -dict {PACKAGE_PIN W7   IOSTANDARD HSUL_12} [get_ports {MIPI_DPHY_data_lp_n[1]}]
set_property -dict {PACKAGE_PIN V7   IOSTANDARD HSUL_12} [get_ports {MIPI_DPHY_data_lp_p[1]}]

set_property -dict {PACKAGE_PIN Y8   IOSTANDARD LVDS_25} [get_ports {MIPI_DPHY_clk_hs_n}]
set_property -dict {PACKAGE_PIN Y9   IOSTANDARD LVDS_25} [get_ports {MIPI_DPHY_clk_hs_p}]

set_property -dict {PACKAGE_PIN W5   IOSTANDARD LVDS_25} [get_ports {MIPI_DPHY_data_hs_n[0]}]
set_property -dict {PACKAGE_PIN W6   IOSTANDARD LVDS_25} [get_ports {MIPI_DPHY_data_hs_p[0]}]
set_property -dict {PACKAGE_PIN U4   IOSTANDARD LVDS_25} [get_ports {MIPI_DPHY_data_hs_n[1]}]
set_property -dict {PACKAGE_PIN T4   IOSTANDARD LVDS_25} [get_ports {MIPI_DPHY_data_hs_p[1]}]

# HDMI1
set_property -dict {PACKAGE_PIN V18  IOSTANDARD LVCMOS33} [get_ports {HDMI_OE[0]}]
set_property -dict {PACKAGE_PIN V13  IOSTANDARD TMDS_33 } [get_ports {HDMI1_data_p[0]}]
set_property -dict {PACKAGE_PIN W13  IOSTANDARD TMDS_33 } [get_ports {HDMI1_data_n[0]}]
set_property -dict {PACKAGE_PIN V14  IOSTANDARD TMDS_33 } [get_ports {HDMI1_data_p[1]}]
set_property -dict {PACKAGE_PIN V15  IOSTANDARD TMDS_33 } [get_ports {HDMI1_data_n[1]}]
set_property -dict {PACKAGE_PIN AA16 IOSTANDARD TMDS_33 } [get_ports {HDMI1_data_p[2]}]
set_property -dict {PACKAGE_PIN AB16 IOSTANDARD TMDS_33 } [get_ports {HDMI1_Data_n[2]}]
set_property -dict {PACKAGE_PIN Y18  IOSTANDARD TMDS_33 } [get_ports {HDMI1_clk_p}]
set_property -dict {PACKAGE_PIN AA18 IOSTANDARD TMDS_33 } [get_ports {HDMI1_clk_n}]

# HDMI2
set_property -dict {PACKAGE_PIN W18  IOSTANDARD LVCMOS33} [get_ports {HDMI_OE[1]}]
set_property -dict {PACKAGE_PIN U19  IOSTANDARD LVCMOS33} [get_ports {HDMI2_HPD_tri_io}]
set_property -dict {PACKAGE_PIN U15  IOSTANDARD TMDS_33 } [get_ports {HDMI2_data_p[0]}]
set_property -dict {PACKAGE_PIN U16  IOSTANDARD TMDS_33 } [get_ports {HDMI2_data_n[0]}]
set_property -dict {PACKAGE_PIN U17  IOSTANDARD TMDS_33 } [get_ports {HDMI2_data_p[1]}]
set_property -dict {PACKAGE_PIN V17  IOSTANDARD TMDS_33 } [get_ports {HDMI2_data_n[1]}]
set_property -dict {PACKAGE_PIN AA17 IOSTANDARD TMDS_33 } [get_ports {HDMI2_data_p[2]}]
set_property -dict {PACKAGE_PIN AB17 IOSTANDARD TMDS_33 } [get_ports {HDMI2_data_n[2]}]
set_property -dict {PACKAGE_PIN W16  IOSTANDARD TMDS_33 } [get_ports {HDMI2_clk_p}]
set_property -dict {PACKAGE_PIN Y16  IOSTANDARD TMDS_33 } [get_ports {HDMI2_clk_n}]

# Bank 34
set_property -dict {PACKAGE_PIN R16  IOSTANDARD LVCMOS25 SLEW SLOW DRIVE 8} [get_ports HDMI2_IIC_scl_io]
set_property -dict {PACKAGE_PIN P16  IOSTANDARD LVCMOS25 SLEW SLOW DRIVE 8} [get_ports HDMI2_IIC_sda_io]

# PL ETNET
set_property -dict {PACKAGE_PIN AB22 IOSTANDARD LVCMOS33} [get_ports PL_NET_RGMII_txc]
set_property -dict {PACKAGE_PIN AB21 IOSTANDARD LVCMOS33} [get_ports PL_NET_RGMII_tx_ctl]
set_property -dict {PACKAGE_PIN Y19  IOSTANDARD LVCMOS33} [get_ports PL_NET_RGMII_rxc]
set_property -dict {PACKAGE_PIN V19  IOSTANDARD LVCMOS33} [get_ports PL_NET_RGMII_rx_ctl]
set_property -dict {PACKAGE_PIN T21  IOSTANDARD LVCMOS33} [get_ports {PL_NET_RGMII_td[0]}]
set_property -dict {PACKAGE_PIN U21  IOSTANDARD LVCMOS33} [get_ports {PL_NET_RGMII_td[1]}]
set_property -dict {PACKAGE_PIN AA22 IOSTANDARD LVCMOS33} [get_ports {PL_NET_RGMII_td[2]}]
set_property -dict {PACKAGE_PIN AA21 IOSTANDARD LVCMOS33} [get_ports {PL_NET_RGMII_td[3]}]
set_property -dict {PACKAGE_PIN W20  IOSTANDARD LVCMOS33} [get_ports {PL_NET_RGMII_rd[0]}]
set_property -dict {PACKAGE_PIN W21  IOSTANDARD LVCMOS33} [get_ports {PL_NET_RGMII_rd[1]}]
set_property -dict {PACKAGE_PIN U20  IOSTANDARD LVCMOS33} [get_ports {PL_NET_RGMII_rd[2]}]
set_property -dict {PACKAGE_PIN V20  IOSTANDARD LVCMOS33} [get_ports {PL_NET_RGMII_rd[3]}]
set_property -dict {PACKAGE_PIN AB19 IOSTANDARD LVCMOS33} [get_ports PL_NET_MDIO_PHY_mdio_io]
set_property -dict {PACKAGE_PIN AB20 IOSTANDARD LVCMOS33} [get_ports PL_NET_MDIO_PHY_mdc]
