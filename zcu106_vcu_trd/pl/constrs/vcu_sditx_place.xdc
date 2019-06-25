#------------------------------------------------------------------------------
#   ____  ____
#  /   /\/   /
# /___/  \  /    Vendor: Xilinx
# \   \   \/     Version: $Revision: #1 $
# #  /   /         Filename: $File: zcu102_uhdsdi_demo.xdc $
# /___/   /\     Timestamp: $DateTime: 2017/04/16
# \   \  /
#  \___\/\___ #
# Description:
#   This is the Vivado constraints file defining the location of all pins used
#   in the zcu106 SDI demo.
#------------------------------------------------------------------------------

# Clock Constraints
#300MHz system clock
#USER_SI570_P/N
#set_property IOSTANDARD DIFF_SSTL12 [get_ports SYSCLK_300_P]
#set_property PACKAGE_PIN AH12 [get_ports SYSCLK_300_P]
#set_property PACKAGE_PIN AJ12 [get_ports SYSCLK_300_N]
#set_property IOSTANDARD DIFF_SSTL12 [get_ports SYSCLK_300_N]

#CLK_125MHz
#set_property IOSTANDARD LVDS [get_ports SYSCLK_300_P]
#set_property IOSTANDARD LVDS [get_ports SYSCLK_300_N]
#set_property PACKAGE_PIN H9 [get_ports SYSCLK_300_P]
#set_property PACKAGE_PIN G9 [get_ports SYSCLK_300_N]


##Reset Bank 34 CPU_RESET
#set_property PACKAGE_PIN G13 [get_ports CPU_RESET]
#set_property IOSTANDARD LVCMOS18 [get_ports CPU_RESET]
#set_false_path -from [get_ports CPU_RESET]

# False path constraint for synchronizer
set_false_path -to [get_pins -hier *data_sync*/D]
set_false_path -to [get_pins -hier *_sync1*/D]
set_false_path -to [get_pins -hier *_sync*/D]
set_false_path -to [get_pins -hier *_sync1*/CE]
set_false_path -to [get_pins -hier *_sync*/CE]

#USER_MGT_SI570 (default 156.2Mhz,pls program it to 148.5Mhz)
set_property PACKAGE_PIN U9 [get_ports USER_MGT_SI570_CLOCK1_C_N]
set_property PACKAGE_PIN U10 [get_ports USER_MGT_SI570_CLOCK1_C_P]

#SDI TX/RX
set_property PACKAGE_PIN AC2 [get_ports gtrxp]
set_property PACKAGE_PIN AC1 [get_ports gtrxn]
set_property PACKAGE_PIN AC6 [get_ports gttxp]
set_property PACKAGE_PIN AC5 [get_ports gttxn]

##27 MHz Clock
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_CLK0_M2C_N]
#set_property PACKAGE_PIN AE7 [get_ports FMC_HPC_CLK0_M2C_P]
#set_property PACKAGE_PIN AF7 [get_ports FMC_HPC_CLK0_M2C_N]
#set_property IOSTANDARD LVDS [get_ports FMC_HPC_CLK0_M2C_P]

#148.5 MHz Clock
#set_property PACKAGE_PIN G28 [get_ports FMC_HPC_GBTCLK0_M2C_C_N]
#set_property PACKAGE_PIN G27 [get_ports FMC_HPC_GBTCLK0_M2C_C_P]

#148.35 MHz Clock
#set_property PACKAGE_PIN E28 [get_ports FMC_HPC_GBTCLK1_M2C_C_N]
#set_property PACKAGE_PIN E27 [get_ports FMC_HPC_GBTCLK1_M2C_C_P]


# LEDs
set_property PACKAGE_PIN AL11 [get_ports GPIO_LED_0_LS]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_LED_0_LS]
set_property PACKAGE_PIN AL13 [get_ports GPIO_LED_1_LS]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_LED_1_LS]
set_property PACKAGE_PIN AK13 [get_ports GPIO_LED_2_LS]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_LED_2_LS]
set_property PACKAGE_PIN AP8 [get_ports GPIO_LED_3_LS]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_LED_3_LS]
set_property PACKAGE_PIN AM8 [get_ports GPIO_LED_4_LS]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_LED_4_LS]
set_property PACKAGE_PIN AM9 [get_ports GPIO_LED_5_LS]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_LED_5_LS]
set_property PACKAGE_PIN AM10 [get_ports GPIO_LED_6_LS]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_LED_6_LS]
set_property PACKAGE_PIN AM11 [get_ports GPIO_LED_7_LS]
set_property IOSTANDARD LVCMOS12 [get_ports GPIO_LED_7_LS]




