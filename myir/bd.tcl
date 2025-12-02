# ----------------------------------------------------------------------------
#
#        ** **        **          **  ****      **  **********  ********** ®
#       **   **        **        **   ** **     **  **              **
#      **     **        **      **    **  **    **  **              **
#     **       **        **    **     **   **   **  *********       **
#    **         **        **  **      **    **  **  **              **
#   **           **        ****       **     ** **  **              **
#  **  .........  **        **        **      ****  **********      **
#     ...........
#                                     Reach Further?
#
# ----------------------------------------------------------------------------
#
#  This design is the property of Avnet.  Publication of this
#  design is not authorized without written consent from Avnet.
#
#  Please direct any questions or issues to the MicroZed Community Forums:
#      http://www.microzed.org
#
#  Disclaimer:
#     Avnet, Inc. makes no warranty for the use of this code or design.
#     This code is provided  "As Is". Avnet, Inc assumes no responsibility for
#     any errors, which may appear in this code, nor does it make a commitment
#     to update the information contained herein. Avnet, Inc specifically
#     disclaims any implied warranties of fitness for a particular purpose.
#                      Copyright(c) 2014 Avnet, Inc.
#                              All rights reserved.
#
# ----------------------------------------------------------------------------
#
#  Create Date:         June 16, 2015
#  Design Name:
#  Module Name:
#  Project Name:
#  Target Devices:
#  Hardware Boards:     FMC-HDMI-CAM + PYTHON-1300-C Camera
#
#  Tool versions:       Vivado 2021.2
#
#  Description:         Build Script for FMC-HDMI-CAM + PYTHON-1300-C Getting Started design
#
#  Dependencies:        make.tcl
#
# ----------------------------------------------------------------------------

set required_version 2021.2
set top "init"
set ws "init"
set board "init"
#"MYIR7020_FMC"
set project "init"
#"fmchc_python1300c"
set xdc "init"
set version_override "yes"
set enable_hdmii "no"
set vivado_ver "${required_version}"

set start_time [clock seconds]
set build_params ""
# to adjust the width of the chart, need to adjust this as well as the "predefined"
# chart elements below (there are 4 lines that need to be adjusted)
set chart_wdith 30
# need to add debug printing to a log
for {set i 0} {$i < [llength $argv]} {incr i} {
    # check for BOARD parameter
    if {[string match -nocase "*help*" [lindex $argv $i]]} {
        puts "Parameters are:"
        puts "top=<top_dir>\n top directory for the repository"
        puts "ws=<workspace_dir>\n workspace directory"
        puts "board=<board_name>\n boards are listed in the /Boards folder"
        puts "project=<project_name>\n project names are listed in the /Scripts/ProjectScripts folder"
        puts "xdc=<xdc_file>\n xdc file to use for constraints"
        puts "vivado_ver=${vivado_ver}\n vivado version to use"
        puts "version_override=yes\n ***************************** \n CAUTION: \n Override the Version Check\n and attempt to make project\n *****************************"
        return -code ok
    }
    # check for TOP parameter
    if {[string match -nocase "top=*" [lindex $argv $i]]} {
        set top [string range [lindex $argv $i] 4 end]
        puts "******* $top ********"
        set printmessage $top
        for {set j 0} {$j < [expr $chart_wdith - [string length $board]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Top            |     $printmessage |\n"
    }
    # check workspace directory
    if {[string match -nocase "ws=*" [lindex $argv $i]]} {
        set ws [string range [lindex $argv $i] 3 end]
        #puts "******* $ws ********"
        set printmessage $ws
        for {set j 0} {$j < [expr $chart_wdith - [string length $board]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Workspace      |     $printmessage |\n"
    }
    # check for BOARD parameter
    if {[string match -nocase "board=*" [lindex $argv $i]]} {
        set board [string range [lindex $argv $i] 6 end]
        set printmessage $board
        for {set j 0} {$j < [expr $chart_wdith - [string length $board]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Board            |     $printmessage |\n"
    }
    # check for PROJECT parameter
    if {[string match -nocase "project=*" [lindex $argv $i]]} {
        set project [string range [lindex $argv $i] 8 end]
        set printmessage $project
        for {set j 0} {$j < [expr $chart_wdith - [string length $project]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Project          |     $printmessage |\n"
    }
    # check for Version Override parameter
    if {[string match -nocase "version_override=*" [lindex $argv $i]]} {
        set version_override [string range [lindex $argv $i] 17 end]
        set printmessage $version_override
        for {set j 0} {$j < [expr $chart_wdith - [string length $version_override]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Version override |     $printmessage |\n"
    }
    # check for VIVADO_VER parameter
    if {[string match -nocase "vivado_ver=*" [lindex $argv $i]]} {
        set vivado_ver [string range [lindex $argv $i] 11 end]
        set printmessage $vivado_ver
        for {set j 0} {$j < [expr $chart_wdith - [string length $vivado_ver]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Vivado Version   |     $printmessage |\n"
    }
    # check xdc file parameter
    if {[string match -nocase "xdc=*" [lindex $argv $i]]} {
        set xdc [string range [lindex $argv $i] 4 end]
        set printmessage $xdc
        for {set j 0} {$j < [expr $chart_wdith - [string length $xdc]]} {incr j} {
            append printmessage " "
        }
        append build_params "| XDC File         |     $printmessage |\n"
    }
    # check enable_hdmii flag
    if {[string match -nocase "enable_hdmii=*" [lindex $argv $i]]} {
        set enable_hdmii [string range [lindex $argv $i] 12 end]
        set printmessage $enable_hdmii
        for {set j 0} {$j < [expr $chart_wdith - [string length $enable_hdmii]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Enable HDMII    |     $printmessage |\n"
    }
    append build_params "+------------------+------------------------------------+\n"
}
append build_params "\n\n"
puts $build_params

#version check
set version [version -short]
if {[string match -nocase "yes" $version_override]} {
    puts "Overriding Version Check, Please Check the Design for Validity!"
} else {
    if { [string first $required_version $version] == -1 } {
        puts "Version $version of Vivado not acceptable, please run with Vivado $required_version to continue"
        return -code ok
    } else {
        puts "Version of Vivado acceptable, continuing..."
    }
}

if {[string match -nocase "yes" $enable_hdmii]} {
    puts "Enabling HDMII"
} else {
    puts "Disabling HDMII"
}

# If variables do not exist, exit script
if {[string match -nocase "init" $top]} {
    puts "Top directory was not defined, please define and try again!"
    return -code ok
}
if {[string match -nocase "init" $ws]} {
    puts "Workspace directory was not defined, please define and try again!"
    return -code ok
}
if {[string match -nocase "init" $board]} {
    puts "Board was not defined, please define and try again!"
    return -code ok
}
if {[string match -nocase "init" $project]} {
    puts "Project was not defined, please define and try again!"
    return -code ok
}
if {[string match -nocase "init" $xdc]} {
    puts "XDC file was not defined, please define and try again!"
    return -code ok
}

set scriptdir "${top}/myir"
set avnet_dir "${top}/avnet"

source ${scriptdir}/utils.tcl -notrace
set numberOfCores [numberOfCPUs]

# create variables with absolute folders for all necessary folders
set projects_folder [file normalize ${ws}/${project}_${board}_${vivado_ver}]
puts "\nproject folder $projects_folder\n"


puts "\n\n*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
puts " Selected Board and Project as:\n$board and $project"
puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\n\n"


# Create Vivado project
puts "***** Creating Vivado Project..."

if {[string match -nocase "ZYNQ_DEV" $board]} {
    puts "Creating project for ZYNQ_DEV board"
    create_project $project $projects_folder -part xc7z020clg484-2 -force
} else {
    puts "Creating project for MYIR7020 board"
    create_project $project $projects_folder -part xc7z020clg400-1 -force
}
remove_files -fileset constrs_1 *.xdc
#add_files -fileset constrs_1 -norecurse ${scriptdir}/myir7020_fmchc_python1300c.xdc
add_files -fileset constrs_1 -norecurse ${xdc}

# Add Avnet IP Repository
puts "***** Updating Vivado to include IP Folder"
set_property ip_repo_paths [list ${top}/avnet/IP ${top}/digilent] [current_fileset]
update_ip_catalog

puts "***** Creating Block Design..."
create_bd_design ${project}
# add selection for customization depending on board choice (or none)
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7 processing_system7_0


# General PS config
set_property -dict [ list \
    CONFIG.PCW_USE_M_AXI_GP0 {1} \
    CONFIG.PCW_S_AXI_HP0_DATA_WIDTH {64} \
    CONFIG.PCW_USE_S_AXI_HP0 {1} \
    CONFIG.PCW_EN_CLK0_PORT {1} \
    CONFIG.PCW_EN_CLK1_PORT {1} \
    CONFIG.PCW_EN_CLK2_PORT {1} \
    CONFIG.PCW_EN_RST0_PORT {1} \
    CONFIG.PCW_EN_RST1_PORT {1} \
    CONFIG.PCW_EN_RST2_PORT {1} \
    CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {75} \
    CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {150} \
    CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {200} \
    CONFIG.PCW_EN_EMIO_TTC0 {1} \
    CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
    CONFIG.PCW_TTC0_TTC0_IO {EMIO} \
    CONFIG.PCW_TTC_PERIPHERAL_FREQMHZ {50} \
] [get_bd_cells processing_system7_0]

if {[string match -nocase "ZYNQ_DEV" $board]} {
    #puts "Creating project for ZYNQ_DEV board"
    #create_project $project $projects_folder -part xc7z020clg484-2 -force
    apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config \
    { \
        make_external "FIXED_IO, DDR" \
        Master "Disable" \
        Slave "Disable" \
    } [get_bd_cells processing_system7_0]

    # set Bank0/1 voltage
    set_property -dict [ list \
        CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
        CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
    ] [get_bd_cells processing_system7_0]

    # enable QSPI peripheral
    set_property -dict [list \
        CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
        CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
        CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
        CONFIG.PCW_SINGLE_QSPI_DATA_MODE {x4} \
        CONFIG.PCW_MIO_1_SLEW {fast} \
        CONFIG.PCW_MIO_2_SLEW {fast} \
        CONFIG.PCW_MIO_3_SLEW {fast} \
        CONFIG.PCW_MIO_4_SLEW {fast} \
        CONFIG.PCW_MIO_5_SLEW {fast} \
        CONFIG.PCW_MIO_6_SLEW {fast} \
    ] [get_bd_cells processing_system7_0]

    # enable ENET0
    set_property -dict [list \
        CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
        CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
        CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
        CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_MIO_16_SLEW {fast} \
        CONFIG.PCW_MIO_17_SLEW {fast} \
        CONFIG.PCW_MIO_18_SLEW {fast} \
        CONFIG.PCW_MIO_19_SLEW {fast} \
        CONFIG.PCW_MIO_20_SLEW {fast} \
        CONFIG.PCW_MIO_21_SLEW {fast} \
        CONFIG.PCW_MIO_22_SLEW {fast} \
        CONFIG.PCW_MIO_23_SLEW {fast} \
        CONFIG.PCW_MIO_24_SLEW {fast} \
        CONFIG.PCW_MIO_25_SLEW {fast} \
        CONFIG.PCW_MIO_26_SLEW {fast} \
        CONFIG.PCW_MIO_27_SLEW {fast} \
    ] [get_bd_cells processing_system7_0]

    # enable USB0
    set_property -dict [list \
        CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
    ] [get_bd_cells processing_system7_0]

    # enable SDIO0
    set_property -dict [list \
        CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
        CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
    ] [get_bd_cells processing_system7_0]

    # enable SDIO1 for NAND
    set_property -dict [list \
        CONFIG.PCW_SD1_GRP_CD_ENABLE {1} \
        CONFIG.PCW_SD1_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_SD1_SD1_IO {MIO 10 .. 15} \
    ] [get_bd_cells processing_system7_0]

    # enable UART1
    set_property -dict [list \
        CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_UART0_UART0_IO {MIO 48 .. 49} \
    ] [get_bd_cells processing_system7_0]

    # set GPIO1 MIO, GPIO0 EMIO, ENET Reset, USB Reset, I2C Reset
    set_property -dict [list \
        CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
        CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
    ] [get_bd_cells processing_system7_0]

    # configure DDR settings
    set_property -dict [list \
        CONFIG.PCW_UIPARAM_DDR_ENABLE {1} \
        CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125} \
    ] [get_bd_cells processing_system7_0]

    # enable interupt if using axi iic
    set_property -dict [list \
        CONFIG.PCW_IRQ_F2P_INTR {1} \
        CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
    ] [get_bd_cells processing_system7_0]
    #connect_bd_net [get_bd_pins HDMI2_IIC/iic2intc_irpt] [get_bd_pins processing_system7_0/IRQ_F2P]

    # PL clock 50MHz
    create_bd_port -dir I -type clk -freq_hz 50000000 PL_CLK_50M
    # PL EEPROM I2C
    create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 PL_EEPROM_IIC
    # PL LEDs
    create_bd_port -dir O -from 3 -to 0 PL_LED

    # PL OLED
    create_bd_port -dir O -from 1 -to 0 PL_OLED_D
    create_bd_port -dir O PL_OLED_DC
    create_bd_port -dir O PL_OLED_RST

    # PL KEY
    create_bd_port -dir I PL_KEY_RSTN
    create_bd_port -dir I PL_KEY3

    # on board MIPI
    create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 MIPI_CAM_IIC
    create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 MIPI_GPIO
    create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 MIPI_DPHY

    # on board HDMI
    create_bd_port -dir O -from 1 -to 0 HDMI_OE
    #create_bd_port -dir IO HDMI2_HPD
    create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 HDMI2_HPD
    create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 HDMI2_IIC
    create_bd_intf_port -mode Master -vlnv digilentinc.com:interface:tmds_rtl:1.0 HDMI1
    create_bd_intf_port -mode Master -vlnv digilentinc.com:interface:tmds_rtl:1.0 HDMI2

    # PL NET
    create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 PL_NET_RGMII
    create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0  PL_NET_MDIO_PHY
} else {
    #puts "Creating project for MYIR7020 board"
    #create_project $project $projects_folder -part xc7z020clg400-1 -force
    apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config \
    { \
        make_external "FIXED_IO, DDR" \
        Master "Disable" \
        Slave "Disable" \
    } [get_bd_cells processing_system7_0]

    # set Bank0/1 voltage
    set_property -dict [ list \
        CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
        CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
    ] [get_bd_cells processing_system7_0]

    # enable QSPI peripheral
    set_property -dict [list \
        CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
        CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
        CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
        CONFIG.PCW_SINGLE_QSPI_DATA_MODE {x4} \
    ] [get_bd_cells processing_system7_0]

    # enable ENET0
    set_property -dict [list \
        CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
        CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
        CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
        CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
    ] [get_bd_cells processing_system7_0]

    # enable USB0
    set_property -dict [list \
        CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
    ] [get_bd_cells processing_system7_0]

    # enable SDIO0
    set_property -dict [list \
        CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
        CONFIG.PCW_SD0_GRP_CD_IO {MIO 46} \
        CONFIG.PCW_SD0_GRP_WP_ENABLE {1} \
        CONFIG.PCW_SD0_GRP_WP_IO {MIO 47} \
        CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
    ] [get_bd_cells processing_system7_0]

    # enable SDIO1 for EMMC
    set_property -dict [list \
        CONFIG.PCW_SD1_GRP_CD_ENABLE {1} \
        CONFIG.PCW_SD1_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_SD1_SD1_IO {MIO 10 .. 15} \
    ] [get_bd_cells processing_system7_0]

    set SDIO1_CDN_0 [create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant:1.0 SDIO1_CDN_0]
    set_property -dict [list \
        CONFIG.CONST_VAL {0} \
        CONFIG.CONST_WIDTH {1} \
    ] [get_bd_cells SDIO1_CDN_0]
    connect_bd_net [get_bd_pins SDIO1_CDN_0/dout] [get_bd_pins processing_system7_0/SDIO1_CDN]

    # enable UART1
    set_property -dict [list \
        CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_UART0_UART0_IO {MIO 48 .. 49} \
    ] [get_bd_cells processing_system7_0]

    # enable I2C0
    set_property -dict [list \
        CONFIG.PCW_I2C0_I2C0_IO {MIO 50 .. 51} \
        CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
    ] [get_bd_cells processing_system7_0]

    # enable CAN1
    set_property -dict [list \
        CONFIG.PCW_CAN1_CAN1_IO {MIO 8 .. 9} \
        CONFIG.PCW_CAN1_PERIPHERAL_ENABLE {1} \
    ] [get_bd_cells processing_system7_0]

    # set GPIO1 MIO, GPIO0 EMIO, ENET Reset, USB Reset, I2C Reset
    set_property -dict [list \
        CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
        CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
        CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {1} \
        CONFIG.PCW_GPIO_EMIO_GPIO_IO {64} \
        CONFIG.PCW_USB_RESET_ENABLE {1} \
        CONFIG.PCW_USB0_RESET_ENABLE {1} \
        CONFIG.PCW_USB0_RESET_IO {MIO 7} \
        CONFIG.PCW_ENET_RESET_ENABLE {1} \
        CONFIG.PCW_I2C_RESET_ENABLE {1} \
    ] [get_bd_cells processing_system7_0]

    # enable Timer0
    set_property -dict [list \
        CONFIG.PCW_TTC0_TTC0_IO {EMIO} \
    ] [get_bd_cells processing_system7_0]

    # set clocks
    set_property -dict [list \
        CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {33.333333} \
        CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
        CONFIG.PCW_CPU_PERIPHERAL_CLKSRC {ARM PLL} \
        CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {667} \
    ] [get_bd_cells processing_system7_0]

    # configure DDR settings
    set_property -dict [list \
        CONFIG.PCW_UIPARAM_DDR_ENABLE {1} \
        CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41J256M16 RE-125} \
    ] [get_bd_cells processing_system7_0]

    # on board HDMI
    create_bd_port -dir O VID_HS
    create_bd_port -dir O VID_VS
    create_bd_port -dir O VID_DE
    create_bd_port -dir O -type clk VID_CLK
    create_bd_port -dir O -from 15 -to 0 RGB_D
    create_bd_port -dir O LCD_EN
    create_bd_port -dir O LCD_BL_EN
    create_bd_port -dir O TP_RST
    create_bd_port -dir I TP_INTR
    create_bd_port -dir I HDMI_INTR

    # 4 Pmods
    create_bd_port -dir IO -from 7 -to 0 PMOD1
    create_bd_port -dir IO -from 7 -to 0 PMOD2
    create_bd_port -dir IO -from 7 -to 0 PMOD3
    create_bd_port -dir IO -from 7 -to 0 PMOD4
}

# General Config
puts "***** General Configuration for Design..."
set_property target_language VHDL [current_project]

# Enable XPM_FIFO primitives (required for new onsemi_vita_spi/cam) cores
puts "***** Enable XPM_FIFO primitives..."
set_property XPM_LIBRARIES XPM_FIFO [current_project]


# Check for Video IP core licenses
puts "***** Check for Video IP core licenses..."
set v_cfa_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_demosaic v_cfa_0 ]
set v_mix_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_mix v_mix_0 ]
set v_csc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss v_csc_0 ]
set v_tpg_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tpg v_tpg_0 ]
set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc v_tc_0 ]
report_ip_status -file "video_ip_core_status.log"
set core_list [list "v_demosaic" "v_mix" "v_proc_ss" "v_tpg" "v_tc" ]
set valid_cores [validate_core_licenses $core_list "video_ip_core_status.log"]
if { $valid_cores < 1 } {
    puts "
    *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
    *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
    *-                                                     -*
    *-  !! Detected missing license for video ip cores !!  -*
    *-                                                     -*
    *-  For more details, refer to IP status report:   !!  -*
    *-     video_ip_core_status_report.log                 -*
    *-                                                     -*
    *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
    *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
    error "!! Detected missing license for video ip cores !!"
}

# Create Block Diagram
set design_name ${project}


################################################################
# Check if script is running in correct Vivado version.
################################################################
set current_vivado_version [version -short]

if { [string first $vivado_ver $current_vivado_version] == -1 } {
    puts ""
    common::send_msg_id "BD_TCL-1002" "WARNING" "This script was generated using Vivado <$vivado_ver> without IP versions in the create_bd_cell commands, but is now being run in <$current_vivado_version> of Vivado. There may have been major IP version changes between Vivado <$vivado_ver> and <$current_vivado_version>, which could impact the parameter settings of the IPs."

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

set parentCell [get_bd_cells /]

# Get object for parentCell
set parentObj [get_bd_cells $parentCell]
if { $parentObj == "" } {
    catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
    return
}

# Make sure parentObj is hier blk
set parentType [get_property TYPE $parentObj]
if { $parentType ne "hier" } {
    catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
    return
}

# Save current instance; Restore later
set oldCurInst [current_bd_instance .]

# Set parent object as current
current_bd_instance $parentObj


# Create interface ports
#set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
#set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
if {[string match -nocase "yes" $enable_hdmii]} {
set IO_HDMII [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:avnet_hdmi_rtl:2.0 IO_HDMII ]
}
set IO_HDMIO [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:avnet_hdmi_rtl:2.0 IO_HDMIO ]
set IO_PYTHON_CAM [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:onsemi_vita_cam_rtl:1.0 IO_PYTHON_CAM ]
set IO_PYTHON_SPI [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:onsemi_vita_spi_rtl:1.0 IO_PYTHON_SPI ]
set fmc_hdmi_cam_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 fmc_hdmi_cam_iic ]

# Create ports
#set M_AXI_GP0_ACLK [ create_bd_port -dir I -type clk M_AXI_GP0_ACLK ]
set fmc_hdmi_cam_iic_rst_n [ create_bd_port -dir O -from 0 -to 0 fmc_hdmi_cam_iic_rst_n ]
set fmc_hdmi_cam_vclk [ create_bd_port -dir I fmc_hdmi_cam_vclk ]

if {[string match -nocase "yes" $enable_hdmii]} {
# Create instance: avnet_hdmi_in_0, and set properties
set avnet_hdmi_in_0 [ create_bd_cell -type ip -vlnv avnet:avnet_hdmi:avnet_hdmi_in avnet_hdmi_in_0 ]
set_property -dict [ list \
    CONFIG.C_USE_BUFR {false} \
] $avnet_hdmi_in_0
}

# Create instance: avnet_hdmi_out_0, and set properties
set avnet_hdmi_out_0 [ create_bd_cell -type ip -vlnv avnet:avnet_hdmi:avnet_hdmi_out avnet_hdmi_out_0 ]
set_property -dict [ list \
    CONFIG.C_DEBUG_PORT {false} \
] $avnet_hdmi_out_0

# Create instance: axi_mem_intercon, and set properties
set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_mem_intercon ]
set_property -dict [ list \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_SI {4} \
] $axi_mem_intercon

if {[string match -nocase "yes" $enable_hdmii]} {

# Create instance: axi_vdma_hdmii, and set properties
set axi_vdma_hdmii [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma axi_vdma_hdmii ]
set_property -dict [ list \
    CONFIG.c_m_axi_s2mm_data_width {64} \
    CONFIG.c_m_axis_mm2s_tdata_width {16} \
    CONFIG.c_mm2s_linebuffer_depth {512} \
    CONFIG.c_mm2s_max_burst_length {256} \
    CONFIG.c_s2mm_linebuffer_depth {4096} \
    CONFIG.c_s2mm_max_burst_length {256} \
] $axi_vdma_hdmii

# Create instance: axis_conv_vdma_hdmii_2_3
set axis_conv_vdma_hdmii_2_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter axis_conv_vdma_hdmii_2_3 ]
set_property -dict [ list \
    CONFIG.M_TDATA_NUM_BYTES.VALUE_SRC USER \
    CONFIG.S_TDATA_NUM_BYTES.VALUE_SRC USER \
] $axis_conv_vdma_hdmii_2_3
set_property -dict [ list \
    CONFIG.S_TDATA_NUM_BYTES {2} \
    CONFIG.M_TDATA_NUM_BYTES {3} \
    CONFIG.TDATA_REMAP {8'b00000000,tdata[15:0]} \
] $axis_conv_vdma_hdmii_2_3

}

# Create instance: axi_vdma_cam, and set properties
set axi_vdma_cam [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma axi_vdma_cam ]
set_property -dict [ list \
    CONFIG.c_m_axi_s2mm_data_width {64} \
    CONFIG.c_m_axis_mm2s_tdata_width {16} \
    CONFIG.c_mm2s_linebuffer_depth {4096} \
    CONFIG.c_mm2s_max_burst_length {256} \
    CONFIG.c_s2mm_linebuffer_depth {4096} \
    CONFIG.c_s2mm_max_burst_length {256} \
] $axi_vdma_cam

# Create instance: axis_conv_vdma_cam_2_3
set axis_conv_vdma_cam_2_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter axis_conv_vdma_cam_2_3 ]
set_property -dict [ list \
    CONFIG.M_TDATA_NUM_BYTES.VALUE_SRC USER \
    CONFIG.S_TDATA_NUM_BYTES.VALUE_SRC USER \
] $axis_conv_vdma_cam_2_3
set_property -dict [ list \
    CONFIG.S_TDATA_NUM_BYTES {2} \
    CONFIG.M_TDATA_NUM_BYTES {3} \
    CONFIG.TDATA_REMAP {8'b00000000,tdata[15:0]} \
] $axis_conv_vdma_cam_2_3

# Create instance: clk_wiz_0, and set properties
set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz clk_wiz_0 ]
set_property -dict [ list \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {148.5} \
    CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {108} \
    CONFIG.CLKOUT2_USED {true} \
    CONFIG.NUM_OUT_CLKS {2} \
    CONFIG.PRIM_IN_FREQ {148.5} \
    CONFIG.USE_LOCKED {false} \
    CONFIG.USE_RESET {false} \
] $clk_wiz_0

# Need to retain value_src of defaults
#set_property -dict [ list \
#    CONFIG.CLKIN1_JITTER_PS.VALUE_SRC {DEFAULT} \
#    CONFIG.CLKOUT1_JITTER.VALUE_SRC {DEFAULT} \
#    CONFIG.CLKOUT1_PHASE_ERROR.VALUE_SRC {DEFAULT} \
#    CONFIG.CLKOUT2_JITTER.VALUE_SRC {DEFAULT} \
#    CONFIG.CLKOUT2_PHASE_ERROR.VALUE_SRC {DEFAULT} \
#    CONFIG.MMCM_CLKFBOUT_MULT_F.VALUE_SRC {DEFAULT} \
#    CONFIG.MMCM_CLKIN1_PERIOD.VALUE_SRC {DEFAULT} \
#    CONFIG.MMCM_CLKIN2_PERIOD.VALUE_SRC {DEFAULT} \
#    CONFIG.MMCM_CLKOUT0_DIVIDE_F.VALUE_SRC {DEFAULT} \
#    CONFIG.MMCM_CLKOUT1_DIVIDE.VALUE_SRC {DEFAULT} \
#    CONFIG.MMCM_COMPENSATION.VALUE_SRC {DEFAULT} \
#] $clk_wiz_0

# Create instance: fmc_hdmi_cam_iic_0, and set properties
set fmc_hdmi_cam_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic fmc_hdmi_cam_iic_0 ]
set_property -dict [ list \
    CONFIG.IIC_BOARD_INTERFACE {Custom} \
    CONFIG.USE_BOARD_FLOW {true} \
] $fmc_hdmi_cam_iic_0

# Create instance: onsemi_python_cam_0, and set properties
set onsemi_python_cam_0 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_cam onsemi_python_cam_0 ]

# Create instance: onsemi_python_spi_0, and set properties
set onsemi_python_spi_0 [ create_bd_cell -type ip -vlnv avnet:onsemi_vita:onsemi_vita_spi onsemi_python_spi_0 ]

# Create instance: processing_system7_0, and set properties
#set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7 processing_system7_0 ]

# Create instance: axi_periph, and set properties
set axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_periph ]
set_property -dict [ list \
    CONFIG.NUM_MI {10} \
] $axi_periph

# Create instance: rst_148_5M, and set properties
set rst_148_5M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_148_5M ]

# Create instance: rst_149M, and set properties
set rst_149M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_149M ]

# Create instance: rst_76M, and set properties
set rst_76M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_76M ]

# Create instance: v_axi4s_vid_out_0, and set properties
set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out v_axi4s_vid_out_0 ]
set_property -dict [ list \
    CONFIG.C_HAS_ASYNC_CLK {1} \
    CONFIG.C_VTG_MASTER_SLAVE {1} \
    CONFIG.C_S_AXIS_VIDEO_FORMAT {0} \
    CONFIG.C_PIXELS_PER_CLOCK {1} \
    CONFIG.C_S_AXIS_VIDEO_DATA_WIDTH.VALUE_SRC PROPAGATED \
    CONFIG.C_NATIVE_COMPONENT_WIDTH {8} \
    CONFIG.C_ADDR_WIDTH {10} \
] $v_axi4s_vid_out_0

# Create instance: concat_vid_out_0, and set properties
set concat_vid_out_0 [create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconcat xlconcat_0]
set_property -dict [list \
    CONFIG.NUM_PORTS {4} \
    CONFIG.IN0_WIDTH.VALUE_SRC USER \
    CONFIG.IN1_WIDTH.VALUE_SRC USER \
    CONFIG.IN2_WIDTH.VALUE_SRC USER \
    CONFIG.IN3_WIDTH.VALUE_SRC USER \
] $concat_vid_out_0
set_property -dict [list \
    CONFIG.IN0_WIDTH {1} \
    CONFIG.IN1_WIDTH {1} \
    CONFIG.IN2_WIDTH {1} \
    CONFIG.IN3_WIDTH {11} \
] $concat_vid_out_0

# Create instance: axi_gpio_vid_out_0, and set properties
set axi_gpio_vid_out_0 [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_vid_out_0]
set_property -dict [list \
    CONFIG.C_GPIO_WIDTH {14} \
    CONFIG.C_GPIO2_WIDTH {32} \
    CONFIG.C_IS_DUAL {1} \
    CONFIG.C_ALL_INPUTS {1} \
    CONFIG.C_ALL_INPUTS_2 {1} \
] $axi_gpio_vid_out_0

# Create instance: v_cfa_0, and set properties
set v_cfa_0 [get_bd_cells v_cfa_0]
set_property -dict [ list \
    CONFIG.ALGORITHM {0} \
    CONFIG.MAX_COLS {1280} \
    CONFIG.MAX_ROWS {1024} \
] $v_cfa_0

# Create instance: v_mix_0, and set properties
set v_mix_0 [get_bd_cells v_mix_0]
set_property -dict [ list \
    CONFIG.SAMPLES_PER_CLOCK {1} \
    CONFIG.MAX_COLS {1920} \
    CONFIG.MAX_ROWS {1080} \
    CONFIG.VIDEO_FORMAT {2} \
    CONFIG.NR_LAYERS {2} \
    CONFIG.LAYER1_VIDEO_FORMAT {2} \
    CONFIG.LAYER1_ALPHA {true} \
    CONFIG.LAYER1_INTF_TYPE {1} \
    CONFIG.AXIMM_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO1_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO2_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO3_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO4_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO5_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO6_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO7_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO8_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO9_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO10_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO11_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO12_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO13_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO14_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO15_DATA_WIDTH {64} \
    CONFIG.C_M_AXI_MM_VIDEO16_DATA_WIDTH {64} \
] $v_mix_0

if {[string match -nocase "yes" $enable_hdmii]} {
set_property -dict [ list \
    CONFIG.NR_LAYERS {3} \
    CONFIG.LAYER1_VIDEO_FORMAT {2} \
    CONFIG.LAYER2_VIDEO_FORMAT {2} \
    CONFIG.LAYER1_ALPHA {true} \
    CONFIG.LAYER2_ALPHA {true} \
    CONFIG.LAYER1_INTF_TYPE {1} \
    CONFIG.LAYER2_INTF_TYPE {1} \
] $v_mix_0
}

# Create instance: axis_conv_mix_3_2
set axis_conv_mix_3_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter axis_conv_mix_3_2 ]
set_property -dict [ list \
    CONFIG.S_TDATA_NUM_BYTES.VALUE_SRC USER \
    CONFIG.M_TDATA_NUM_BYTES.VALUE_SRC USER \
] $axis_conv_mix_3_2
set_property -dict [ list \
    CONFIG.S_TDATA_NUM_BYTES {3} \
    CONFIG.M_TDATA_NUM_BYTES {2} \
    CONFIG.TDATA_REMAP {tdata[15:0]} \
] $axis_conv_mix_3_2

# Create instance: v_tpg_0, and set properties
set v_tpg_0 [get_bd_cells v_tpg_0]
set_property -dict [ list \
    CONFIG.MAX_COLS {1920} \
    CONFIG.MAX_ROWS {1080} \
    CONFIG.SOLID_COLOR {1} \
    CONFIG.RAMP {1} \
    CONFIG.DISPLAY_PORT {0} \
    CONFIG.COLOR_SWEEP {0} \
    CONFIG.ZONE_PLATE {0} \
    CONFIG.FOREGROUND {1} \
] $v_tpg_0

# Create instance: v_csc_0, and set properties
set v_csc_0 [get_bd_cells v_csc_0]
set_property -dict [ list \
    CONFIG.C_TOPOLOGY {3} \
    CONFIG.C_SAMPLES_PER_CLK {1} \
    CONFIG.C_MAX_DATA_WIDTH {8} \
    CONFIG.C_MAX_COLS {1280} \
    CONFIG.C_MAX_ROWS {1024} \
    CONFIG.C_COLORSPACE_SUPPORT {1} \
] $v_csc_0

# Create instance: axis_conv_csc_3_2
set axis_conv_csc_3_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter axis_conv_csc_3_2 ]
set_property -dict [ list \
    CONFIG.S_TDATA_NUM_BYTES.VALUE_SRC USER \
    CONFIG.M_TDATA_NUM_BYTES.VALUE_SRC USER \
] $axis_conv_csc_3_2
set_property -dict [ list \
    CONFIG.S_TDATA_NUM_BYTES {3} \
    CONFIG.M_TDATA_NUM_BYTES {2} \
    CONFIG.TDATA_REMAP {tdata[15:0]} \
] $axis_conv_csc_3_2

# Create instance: v_tc_0, and set properties
set v_tc_0 [get_bd_cells v_tc_0]
set_property -dict [ list \
    CONFIG.HAS_AXI4_LITE {false} \
    CONFIG.VIDEO_MODE {1080p} \
    CONFIG.enable_detection {false} \
] $v_tc_0

# Create instance: v_vid_in_axi4s_cam, and set properties
set v_vid_in_axi4s_cam [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s v_vid_in_axi4s_cam ]
set_property -dict [ list \
    CONFIG.C_HAS_ASYNC_CLK {1} \
    CONFIG.C_M_AXIS_VIDEO_FORMAT {12} \
] $v_vid_in_axi4s_cam

if {[string match -nocase "yes" $enable_hdmii]} {

# Create instance: v_vid_in_axi4s_hdmii, and set properties
set v_vid_in_axi4s_hdmii [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s v_vid_in_axi4s_hdmii ]
set_property -dict [ list \
    CONFIG.C_HAS_ASYNC_CLK {1} \
    CONFIG.C_M_AXIS_VIDEO_FORMAT {0} \
] $v_vid_in_axi4s_hdmii

}

# Create instance: xlconstant_0, and set properties
set xlconstant_0 [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant xlconstant_0 ]
set_property -dict [ list \
    CONFIG.CONST_VAL {0} \
] $xlconstant_0

# Create instance: xlconstant_1, and set properties
set xlconstant_1 [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconstant xlconstant_1 ]

# Create interface connections
connect_bd_intf_net -intf_net IO_CAM_IN_1 [get_bd_intf_ports IO_PYTHON_CAM] [get_bd_intf_pins onsemi_python_cam_0/IO_CAM_IN]
if {[string match -nocase "yes" $enable_hdmii]} {
connect_bd_intf_net -intf_net IO_HDMII_1 [get_bd_intf_ports IO_HDMII] [get_bd_intf_pins avnet_hdmi_in_0/IO_HDMII]
connect_bd_intf_net -intf_net avnet_hdmi_in_0_VID_IO_OUT [get_bd_intf_pins avnet_hdmi_in_0/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_hdmii/vid_io_in]
}
connect_bd_intf_net -intf_net avnet_hdmi_out_0_IO_HDMIO [get_bd_intf_ports IO_HDMIO] [get_bd_intf_pins avnet_hdmi_out_0/IO_HDMIO]
connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_mem_intercon/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
if {[string match -nocase "yes" $enable_hdmii]} {
connect_bd_intf_net -intf_net axi_vdma_hdmii_M_AXIS_MM2S \
    [get_bd_intf_pins axi_vdma_hdmii/M_AXIS_MM2S] \
    [get_bd_intf_pins axis_conv_vdma_hdmii_2_3/S_AXIS]
connect_bd_intf_net -intf_net v_mix_0_s_axis_video2 \
    [get_bd_intf_pins axis_conv_vdma_hdmii_2_3/M_AXIS] \
    [get_bd_intf_pins v_mix_0/s_axis_video2]
connect_bd_intf_net -intf_net axi_vdma_hdmii_M_AXI_MM2S [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins axi_vdma_hdmii/M_AXI_MM2S]
connect_bd_intf_net -intf_net axi_vdma_hdmii_M_AXI_S2MM [get_bd_intf_pins axi_mem_intercon/S01_AXI] [get_bd_intf_pins axi_vdma_hdmii/M_AXI_S2MM]
}
connect_bd_intf_net -intf_net axi_vdma_cam_M_AXIS_MM2S \
    [get_bd_intf_pins axi_vdma_cam/M_AXIS_MM2S] \
    [get_bd_intf_pins axis_conv_vdma_cam_2_3/S_AXIS]
connect_bd_intf_net -intf_net v_mix_0_s_axis_video1 \
    [get_bd_intf_pins axis_conv_vdma_cam_2_3/M_AXIS] \
    [get_bd_intf_pins v_mix_0/s_axis_video1]
connect_bd_intf_net -intf_net v_mix_0_s_axis_video \
    [get_bd_intf_pins v_tpg_0/m_axis_video] \
    [get_bd_intf_pins v_mix_0/s_axis_video]
connect_bd_intf_net -intf_net axi_vdma_cam_M_AXI_MM2S [get_bd_intf_pins axi_mem_intercon/S02_AXI] [get_bd_intf_pins axi_vdma_cam/M_AXI_MM2S]
connect_bd_intf_net -intf_net axi_vdma_cam_M_AXI_S2MM [get_bd_intf_pins axi_mem_intercon/S03_AXI] [get_bd_intf_pins axi_vdma_cam/M_AXI_S2MM]
connect_bd_intf_net -intf_net fmc_hdmi_cam_iic_0_IIC [get_bd_intf_ports fmc_hdmi_cam_iic] [get_bd_intf_pins fmc_hdmi_cam_iic_0/IIC]
connect_bd_intf_net -intf_net onsemi_python_cam_0_VID_IO_OUT [get_bd_intf_pins onsemi_python_cam_0/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_cam/vid_io_in]
connect_bd_intf_net -intf_net onsemi_python_spi_0_IO_SPI_OUT [get_bd_intf_ports IO_PYTHON_SPI] [get_bd_intf_pins onsemi_python_spi_0/IO_SPI_OUT]
#connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
#connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins axi_periph/S00_AXI]
connect_bd_intf_net -intf_net axi_periph_M07_AXI [get_bd_intf_pins fmc_hdmi_cam_iic_0/S_AXI] [get_bd_intf_pins axi_periph/M07_AXI]
if {[string match -nocase "yes" $enable_hdmii]} {
connect_bd_intf_net -intf_net axi_periph_M00_AXI [get_bd_intf_pins axi_vdma_hdmii/S_AXI_LITE] [get_bd_intf_pins axi_periph/M00_AXI]
}
connect_bd_intf_net -intf_net axi_periph_M06_AXI \
    [get_bd_intf_pins axi_periph/M06_AXI] \
    [get_bd_intf_pins v_mix_0/s_axi_CTRL]
connect_bd_intf_net -intf_net axi_periph_M01_AXI [get_bd_intf_pins onsemi_python_cam_0/S00_AXI] [get_bd_intf_pins axi_periph/M01_AXI]
connect_bd_intf_net -intf_net axi_periph_M02_AXI [get_bd_intf_pins axi_periph/M02_AXI] [get_bd_intf_pins v_cfa_0/s_axi_CTRL]
connect_bd_intf_net -intf_net axi_periph_M04_AXI [get_bd_intf_pins axi_vdma_cam/S_AXI_LITE] [get_bd_intf_pins axi_periph/M04_AXI]
connect_bd_intf_net -intf_net axi_periph_M08_AXI [get_bd_intf_pins onsemi_python_spi_0/S00_AXI] [get_bd_intf_pins axi_periph/M08_AXI]
connect_bd_intf_net -intf_net axi_periph_M09_AXI \
    [get_bd_intf_pins axi_gpio_vid_out_0/S_AXI] [get_bd_intf_pins axi_periph/M09_AXI]
connect_bd_intf_net -intf_net axi_periph_M05_AXI \
    [get_bd_intf_pins v_tpg_0/s_axi_CTRL] \
    [get_bd_intf_pins axi_periph/M05_AXI]
connect_bd_intf_net -intf_net axi_periph_M03_AXI \
    [get_bd_intf_pins v_csc_0/s_axi_ctrl] \
    [get_bd_intf_pins axi_periph/M03_AXI]
connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins avnet_hdmi_out_0/VID_IO_IN] [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out]
connect_bd_intf_net -intf_net v_cfa_0_video_out \
    [get_bd_intf_pins v_cfa_0/m_axis_video] \
    [get_bd_intf_pins v_csc_0/s_axis]
connect_bd_intf_net -intf_net v_csc_0_maxis \
    [get_bd_intf_pins v_csc_0/m_axis] \
    [get_bd_intf_pins axis_conv_csc_3_2/s_axis]
connect_bd_intf_net -intf_net axi_vdma_cam_S_AXIS_S2MM \
    [get_bd_intf_pins axi_vdma_cam/S_AXIS_S2MM] \
    [get_bd_intf_pins axis_conv_csc_3_2/m_axis]
connect_bd_intf_net -intf_net v_mix_0_m_axis_video \
    [get_bd_intf_pins v_mix_0/m_axis_video ] \
    [get_bd_intf_pins axis_conv_mix_3_2/S_AXIS]
connect_bd_intf_net -intf_net v_axi4s_vid_out_0_video_in \
    [get_bd_intf_pins v_axi4s_vid_out_0/video_in] \
    [get_bd_intf_pins axis_conv_mix_3_2/M_AXIS]
connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]
connect_bd_intf_net -intf_net v_vid_in_axi4s_cam_video_out [get_bd_intf_pins v_cfa_0/s_axis_video] [get_bd_intf_pins v_vid_in_axi4s_cam/video_out]
if {[string match -nocase "yes" $enable_hdmii]} {
connect_bd_intf_net -intf_net v_vid_in_axi4s_hdmii_video_out [get_bd_intf_pins axi_vdma_hdmii/S_AXIS_S2MM] [get_bd_intf_pins v_vid_in_axi4s_hdmii/video_out]
}

# Create port connections
#connect_bd_net -net M_AXI_GP0_ACLK_1 [get_bd_ports M_AXI_GP0_ACLK]
if {[string match -nocase "yes" $enable_hdmii]} {
connect_bd_net -net avnet_hdmi_in_0_audio_spdif [get_bd_pins avnet_hdmi_in_0/audio_spdif] [get_bd_pins avnet_hdmi_out_0/audio_spdif]
connect_bd_net -net avnet_hdmi_in_0_hdmii_clk [get_bd_pins avnet_hdmi_in_0/hdmii_clk] [get_bd_pins v_vid_in_axi4s_hdmii/vid_io_in_clk]
}
connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins avnet_hdmi_out_0/clk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins rst_148_5M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk]
connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins onsemi_python_cam_0/clk] [get_bd_pins v_vid_in_axi4s_cam/vid_io_in_clk]
connect_bd_net -net fmc_hdmi_cam_iic_0_gpo [get_bd_ports fmc_hdmi_cam_iic_rst_n] [get_bd_pins fmc_hdmi_cam_iic_0/gpo]
connect_bd_net -net fmc_hdmi_cam_vclk_1 [get_bd_ports fmc_hdmi_cam_vclk] [get_bd_pins clk_wiz_0/clk_in1]
connect_bd_net -net processing_system7_0_FCLK_CLK0 \
    [get_bd_pins axi_vdma_cam/s_axi_lite_aclk] \
    [get_bd_pins fmc_hdmi_cam_iic_0/s_axi_aclk] \
    [get_bd_pins onsemi_python_cam_0/s00_axi_aclk] \
    [get_bd_pins onsemi_python_spi_0/s00_axi_aclk] \
    [get_bd_pins processing_system7_0/FCLK_CLK0] \
    [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] \
    [get_bd_pins axi_periph/ACLK] \
    [get_bd_pins axi_periph/M07_ACLK] \
    [get_bd_pins axi_periph/M00_ACLK] \
    [get_bd_pins axi_periph/M01_ACLK] \
    [get_bd_pins axi_periph/M04_ACLK] \
    [get_bd_pins axi_periph/M08_ACLK] \
    [get_bd_pins axi_periph/M09_ACLK] \
    [get_bd_pins axi_periph/S00_ACLK] \
    [get_bd_pins axi_gpio_vid_out_0/s_axi_aclk] \
    [get_bd_pins rst_76M/slowest_sync_clk]
if {[string match -nocase "yes" $enable_hdmii]} {
connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_vdma_hdmii/s_axi_lite_aclk]
}
connect_bd_net -net processing_system7_0_FCLK_CLK1 \
    [get_bd_pins axi_mem_intercon/ACLK] \
    [get_bd_pins axi_mem_intercon/M00_ACLK] \
    [get_bd_pins axi_mem_intercon/S00_ACLK] \
    [get_bd_pins axi_mem_intercon/S01_ACLK] \
    [get_bd_pins axi_mem_intercon/S02_ACLK] \
    [get_bd_pins axi_mem_intercon/S03_ACLK] \
    [get_bd_pins axi_vdma_cam/m_axi_mm2s_aclk] \
    [get_bd_pins axi_vdma_cam/m_axi_s2mm_aclk] \
    [get_bd_pins axi_vdma_cam/m_axis_mm2s_aclk] \
    [get_bd_pins axi_vdma_cam/s_axis_s2mm_aclk] \
    [get_bd_pins axis_conv_vdma_cam_2_3/aclk] \
    [get_bd_pins processing_system7_0/FCLK_CLK1] \
    [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] \
    [get_bd_pins rst_149M/slowest_sync_clk] \
    [get_bd_pins v_axi4s_vid_out_0/aclk] \
    [get_bd_pins axi_periph/M02_ACLK] \
    [get_bd_pins v_cfa_0/ap_clk] \
    [get_bd_pins axi_periph/M03_ACLK] \
    [get_bd_pins v_csc_0/aclk] \
    [get_bd_pins axi_periph/M05_ACLK] \
    [get_bd_pins v_tpg_0/ap_clk] \
    [get_bd_pins axi_periph/M06_ACLK] \
    [get_bd_pins v_mix_0/ap_clk] \
    [get_bd_pins axis_conv_csc_3_2/aclk] \
    [get_bd_pins axis_conv_mix_3_2/aclk] \
    [get_bd_pins v_vid_in_axi4s_cam/aclk]

if {[string match -nocase "yes" $enable_hdmii]} {
connect_bd_net -net processing_system7_0_FCLK_CLK1 \
    [get_bd_pins axi_vdma_hdmii/m_axi_mm2s_aclk] \
    [get_bd_pins axi_vdma_hdmii/m_axi_s2mm_aclk] \
    [get_bd_pins axi_vdma_hdmii/m_axis_mm2s_aclk] \
    [get_bd_pins axi_vdma_hdmii/s_axis_s2mm_aclk] \
    [get_bd_pins axis_conv_vdma_hdmii_2_3/aclk] \
    [get_bd_pins v_vid_in_axi4s_hdmii/aclk]
}
connect_bd_net -net processing_system7_0_FCLK_CLK2 [get_bd_pins onsemi_python_cam_0/clk200] [get_bd_pins processing_system7_0/FCLK_CLK2]
connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_76M/ext_reset_in]
connect_bd_net -net processing_system7_0_FCLK_RESET1_N [get_bd_pins processing_system7_0/FCLK_RESET1_N] [get_bd_pins rst_149M/ext_reset_in]
connect_bd_net -net processing_system7_0_FCLK_RESET2_N [get_bd_pins processing_system7_0/FCLK_RESET2_N] [get_bd_pins rst_148_5M/ext_reset_in]
connect_bd_net -net rst_148_5M_peripheral_aresetn [get_bd_pins rst_148_5M/peripheral_aresetn] [get_bd_pins v_tc_0/resetn]
connect_bd_net -net rst_148_5M_peripheral_reset [get_bd_pins onsemi_python_cam_0/reset] [get_bd_pins rst_148_5M/peripheral_reset]
connect_bd_net -net rst_149M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_149M/interconnect_aresetn]
connect_bd_net -net rst_149M_peripheral_aresetn \
    [get_bd_pins axi_mem_intercon/M00_ARESETN] \
    [get_bd_pins axi_mem_intercon/S00_ARESETN] \
    [get_bd_pins axi_mem_intercon/S01_ARESETN] \
    [get_bd_pins axi_mem_intercon/S02_ARESETN] \
    [get_bd_pins axi_mem_intercon/S03_ARESETN] \
    [get_bd_pins rst_149M/peripheral_aresetn] \
    [get_bd_pins axi_periph/M02_ARESETN] \
    [get_bd_pins v_cfa_0/ap_rst_n] \
    [get_bd_pins axi_periph/M03_ARESETN] \
    [get_bd_pins v_csc_0/aresetn] \
    [get_bd_pins axi_periph/M05_ARESETN] \
    [get_bd_pins v_tpg_0/ap_rst_n] \
    [get_bd_pins axi_periph/M06_ARESETN] \
    [get_bd_pins v_mix_0/ap_rst_n] \
    [get_bd_pins axis_conv_csc_3_2/aresetn] \
    [get_bd_pins axis_conv_vdma_cam_2_3/aresetn] \
    [get_bd_pins axis_conv_mix_3_2/aresetn]
if {[string match -nocase "yes" $enable_hdmii]} {
connect_bd_net -net rst_149M_peripheral_aresetn \
    [get_bd_pins axis_conv_vdma_hdmii_2_3/aresetn]
}

connect_bd_net -net rst_76M_interconnect_aresetn [get_bd_pins axi_periph/ARESETN] [get_bd_pins rst_76M/interconnect_aresetn]
connect_bd_net -net rst_76M_peripheral_aresetn \
    [get_bd_pins axi_vdma_cam/axi_resetn] \
    [get_bd_pins fmc_hdmi_cam_iic_0/s_axi_aresetn] \
    [get_bd_pins onsemi_python_cam_0/s00_axi_aresetn] \
    [get_bd_pins onsemi_python_spi_0/s00_axi_aresetn] \
    [get_bd_pins axi_periph/M07_ARESETN] \
    [get_bd_pins axi_periph/M00_ARESETN] \
    [get_bd_pins axi_periph/M01_ARESETN] \
    [get_bd_pins axi_periph/M04_ARESETN] \
    [get_bd_pins axi_periph/M08_ARESETN] \
    [get_bd_pins axi_periph/M09_ARESETN] \
    [get_bd_pins axi_periph/S00_ARESETN] \
    [get_bd_pins rst_76M/peripheral_aresetn] \
    [get_bd_pins v_axi4s_vid_out_0/aresetn] \
    [get_bd_pins axi_gpio_vid_out_0/s_axi_aresetn] \
    [get_bd_pins v_vid_in_axi4s_cam/aresetn]
if {[string match -nocase "yes" $enable_hdmii]} {
connect_bd_net -net rst_76M_peripheral_aresetn \
    [get_bd_pins axi_vdma_hdmii/axi_resetn]
}
connect_bd_net -net rst_76M_peripheral_reset [get_bd_pins avnet_hdmi_out_0/reset] [get_bd_pins rst_76M/peripheral_reset] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset] [get_bd_pins v_vid_in_axi4s_cam/vid_io_in_reset]
connect_bd_net -net xlconstant_0_dout [get_bd_pins onsemi_python_cam_0/trigger1] [get_bd_pins xlconstant_0/dout]
if {[string match -nocase "yes" $enable_hdmii]} {
connect_bd_net -net xlconstant_0_dout [get_bd_pins v_vid_in_axi4s_hdmii/vid_io_in_reset]
}
connect_bd_net -net xlconstant_1_dout \
    [get_bd_pins avnet_hdmi_out_0/embed_syncs] \
    [get_bd_pins avnet_hdmi_out_0/oe] \
    [get_bd_pins onsemi_python_cam_0/oe] \
    [get_bd_pins onsemi_python_spi_0/oe] \
    [get_bd_pins v_axi4s_vid_out_0/aclken] \
    [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] \
    [get_bd_pins v_tc_0/clken] \
    [get_bd_pins v_vid_in_axi4s_cam/aclken] \
    [get_bd_pins v_vid_in_axi4s_cam/axis_enable] \
    [get_bd_pins v_vid_in_axi4s_cam/vid_io_in_ce] \
    [get_bd_pins xlconstant_1/dout]
if {[string match -nocase "yes" $enable_hdmii]} {
connect_bd_net -net xlconstant_1_dout \
    [get_bd_pins v_vid_in_axi4s_hdmii/aclken] \
    [get_bd_pins v_vid_in_axi4s_hdmii/aresetn] \
    [get_bd_pins v_vid_in_axi4s_hdmii/axis_enable] \
    [get_bd_pins v_vid_in_axi4s_hdmii/vid_io_in_ce]
}
connect_bd_net -net v_tc_0_gen_clken \
    [get_bd_pins v_axi4s_vid_out_0/vtg_ce] \
    [get_bd_pins v_tc_0/gen_clken]
connect_bd_net -net v_axi4s_vid_out_0_locked \
    [get_bd_pins v_axi4s_vid_out_0/locked] \
    [get_bd_pins xlconcat_0/In0]
connect_bd_net -net v_axi4s_vid_out_0_overflow \
    [get_bd_pins v_axi4s_vid_out_0/overflow] \
    [get_bd_pins xlconcat_0/In1]
connect_bd_net -net v_axi4s_vid_out_0_underflow \
    [get_bd_pins v_axi4s_vid_out_0/underflow] \
    [get_bd_pins xlconcat_0/In2]
connect_bd_net -net v_axi4s_vid_out_0_fifo_read_level \
    [get_bd_pins v_axi4s_vid_out_0/fifo_read_level] \
    [get_bd_pins xlconcat_0/In3]
connect_bd_net -net v_axi4s_vid_out_0_status \
    [get_bd_pins v_axi4s_vid_out_0/status] \
    [get_bd_pins axi_gpio_vid_out_0/gpio2_io_i]
connect_bd_net -net xlconcat_0_dout \
    [get_bd_pins xlconcat_0/dout] \
    [get_bd_pins axi_gpio_vid_out_0/gpio_io_i]

# Create address segments
if {[string match -nocase "yes" $enable_hdmii]} {
create_bd_addr_seg -range 0x20000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_hdmii/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
create_bd_addr_seg -range 0x20000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_hdmii/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
}
create_bd_addr_seg -range 0x20000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_cam/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
create_bd_addr_seg -range 0x20000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_cam/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
create_bd_addr_seg -range 0x00010000 -offset 0x43000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_cam/S_AXI_LITE/Reg] SEG_axi_vdma_cam_Reg
if {[string match -nocase "yes" $enable_hdmii]} {
create_bd_addr_seg -range 0x00010000 -offset 0x43010000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_hdmii/S_AXI_LITE/Reg] SEG_axi_vdma_hdmii_Reg
}
create_bd_addr_seg -range 0x00010000 -offset 0x41600000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs fmc_hdmi_cam_iic_0/S_AXI/Reg] SEG_fmc_hdmi_cam_iic_0_Reg
create_bd_addr_seg -range 0x00010000 -offset 0x41700000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_vid_out_0/S_AXI/Reg] SEG_axi_gpio_vid_out_0_Reg
create_bd_addr_seg -range 0x00010000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_python_cam_0/S00_AXI/Reg] SEG_onsemi_python_cam_0_Reg
create_bd_addr_seg -range 0x00010000 -offset 0x43C40000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_python_spi_0/S00_AXI/Reg] SEG_onsemi_python_spi_0_Reg
create_bd_addr_seg -range 0x00010000 -offset 0x43C30000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cfa_0/s_axi_CTRL/Reg] SEG_v_cfa_0_Reg
create_bd_addr_seg -range 0x00010000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_mix_0/s_axi_CTRL/Reg] SEG_v_mix_0_Reg
create_bd_addr_seg -range 0x00010000 -offset 0x43C50000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_csc_0/s_axi_ctrl/Reg] SEG_v_csc_0_Reg
create_bd_addr_seg -range 0x00010000 -offset 0x43C60000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_tpg_0/s_axi_CTRL/Reg] SEG_v_tpg_0_Reg

# Restore current instance
current_bd_instance $oldCurInst

save_bd_design


# Add Project source files
puts "***** Adding Source Files to Block Design..."
make_wrapper -files [get_files ${projects_folder}/${project}.srcs/sources_1/bd/${project}/${project}.bd] -top
add_files -norecurse ${projects_folder}/${project}.srcs/sources_1/bd/${project}/hdl/${project}_wrapper.vhd
close_project



set end_time [clock seconds]
set number_seconds [expr {$end_time - $start_time}]
set time_string "Your Build Took\nseconds [$number_seconds]\n\nor a total of:\n\ndays [[expr {$number_seconds/86400}]]\nhrs  [[expr {($number_seconds%86400)/3600}]]\nmin  [[expr {(($number_seconds%86400)%3600)/60}]]\nsec  [[expr {(($number_seconds%86400)%3600)%60}]]\n\nto complete"

append build_params "\n"
append build_params $time_string
set out [open $projects_folder/buildInfo.log w]
puts -nonewline $out $build_params
close $out

puts "
$time_string

*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*-                                                     -*
*-            Finished Running Script                  -*
*-                                                     -*
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
"
unset out
unset build_params
unset start_time
unset end_time
unset number_seconds
unset time_string
