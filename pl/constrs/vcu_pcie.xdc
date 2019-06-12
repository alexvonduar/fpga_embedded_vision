#####
## Constraints for ZCU106
## Version 1.0
#####


#####
## Pins
#####
set_property PACKAGE_PIN AH12 [get_ports {si570_user_clk_p}]
set_property IOSTANDARD LVDS [get_ports {si570_user_clk_p}]


################
## Clock Groups #
#################
#
## A BUFGMUX selects between DP and HDMI video clock to couple the TPG with the desired display interface
## The two clocks are exclusive since they don't exist at the same time
##set_clock_groups -logically_exclusive -group [get_clocks clk_pl_1] \
##                                      -group [get_clocks -of [get_pins */vid_phy_controller/inst/gt_usrclk_source_inst/tx_mmcm.txoutclk_mmcm0_i/mmcm_adv_inst/CLKOUT2]]




# PCIE
set_property PACKAGE_PIN AD4                    [get_ports {pcie4_mgt_0_0_txp[0]}]
set_property PACKAGE_PIN AE6                    [get_ports {pcie4_mgt_0_0_txp[1]}]
set_property PACKAGE_PIN AG6                    [get_ports {pcie4_mgt_0_0_txp[2]}]
set_property PACKAGE_PIN AH4                    [get_ports {pcie4_mgt_0_0_txp[3]}]



set_property PACKAGE_PIN AE2                    [get_ports {pcie4_mgt_0_0_rxp[0]}]
set_property PACKAGE_PIN AF4                    [get_ports {pcie4_mgt_0_0_rxp[1]}]
set_property PACKAGE_PIN AG2                    [get_ports {pcie4_mgt_0_0_rxp[2]}]
set_property PACKAGE_PIN AJ2                    [get_ports {pcie4_mgt_0_0_rxp[3]}]

# IO constraints
# ------------------------------------------------------------------------------
# ref_clk
#set_property PACKAGE_PIN AF12                    [get_ports {ref_clk_clk_p[0]}]
set_property PACKAGE_PIN AB8                    [get_ports {ref_clk_0_clk_p[0]}]

#set_property PACKAGE_PIN AL23                    [get_ports perst_n]
set_property PACKAGE_PIN L8                     [get_ports perst_n]
set_property IOSTANDARD LVCMOS18                 [get_ports perst_n]


# LED0 - link up
#set_property PACKAGE_PIN AL15                       [get_ports led_0]
set_property PACKAGE_PIN AM8                       [get_ports lnk_up_led]
set_property -dict {IOSTANDARD LVCMOS12 DRIVE 8}          [get_ports lnk_up_led]


create_clock -name sys_clk -period 10 [get_ports ref_clk_0_clk_p]