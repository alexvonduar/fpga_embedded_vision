# ----------------------------------------------------------------------------
#
#        ** **        **          **  ****      **  **********  ********** �
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
#  Tool versions:       Vivado 2015.2
#
#  Description:         Build Script for FMC-HDMI-CAM + PYTHON-1300-C Getting Started design
#
#  Dependencies:        make.tcl
#
# ----------------------------------------------------------------------------

# Build FMC-HDMI-CAM + PYTHON-1300-C Getting Started design for the PicoZed-7030 + FMC Carrier Card V2
#set argv [list board=MYIR7020_FMC project=fmchc_python1300c sdk=yes version_override=yes]
#set argc [llength $argv]
#source ./make.tcl -notrace


# ----------------------------------------------------------------------------
#       _____
#      *     *
#     *____   *____
#    * *===*   *==*
#   *___*===*___**  AVNET
#        *======*
#         *====*
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
#  Create Date:         December 02, 2014
#  Design Name:
#  Module Name:
#  Project Name:
#  Target Devices:
#  Hardware Boards:
#
#  Tool versions:
set required_version 2020.1
#
#  Description:         Build Script for sample project (fails build)
#
#  Dependencies:        Variable Configuration Scripts, Project Build Scripts,
#                       Tagging Scripts
#
# ----------------------------------------------------------------------------

set debuglevel 0
set scriptdir [pwd]
set board "MYIR7020_FMC"
set clean "no"
set project "fmchc_python1300c"
set tag "init"
set close_project "no"
set version_override "yes"
set found "false"
set ok_to_tag_public "false"
set sdk "yes"
set jtag "no"
set dev_arch "zynq"
set vivado_ver "2020_1"
set avnet_dir "${scriptdir}/../avnet"

source ${scriptdir}/utils.tcl -notrace

set numberOfCores [numberOfCPUs]

puts "
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*-                                                     -*
*-        Welcome to the Avnet Project Builder         -*
*-                                                     -*
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
# fetch the required Vivado Board Definition File (BDF) from the bdf git repo
set bdf_path [file normalize [pwd]/../../bdf]
set_param board.repoPaths $bdf_path
puts "\nBDF path set to $bdf_path \n\n"


set ranonce "false"
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
        puts "board=<board_name>\n boards are listed in the /Boards folder"
        puts "project=<project_name>\n project names are listed in the /Scripts/ProjectScripts folder"
        puts "sdk=\n 'yes' will attempt to execute:\n ../../../Software/<project_name>_sdk.tcl"
        puts " in order to build the SDK portion of the project (prior to tagging request)"
        puts "tag=\n 'yes' will tag locally\n this will attempt to tag based on that flag"
        puts " each project has a release level flag, in the project make script\n the project has been released for the tag level you are attempting to run at"
        puts " 'private' used to allow this project to be privately tagged"
        puts "    with release_state set to private the script will release a tag + compress the package"
        puts " 'public' used to allow this project to be publicly tagged"
        puts "    with release_state set to public the script will release to GITHUB"
        puts "close_project=\n 'no' will prevent the script from closing the project\n used to allow 'up+enter' rebuilds of a project"
        puts "jtag=\n 'yes' will attempt to JTAG a project after synthesis and binary generation"
        puts "arch=\n specifies the target device architecture (zynq or zynqmp) to create a boot.bin file"
        puts "clean=\n Be careful due to destructive nature of wiping ALL output products out"
        puts "version_override=yes\n ***************************** \n CAUTION: \n Override the Version Check\n and attempt to make project\n *****************************"
        return -code ok
    } elseif [string match -nocase "false" $ranonce] {
        set ranonce "true"
        set build_params "\n"
        append build_params "+------------------+------------------------------------+\n"
        append build_params "| Setting          |     Configuration                  |\n"
        append build_params "+------------------+------------------------------------+\n"
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
    # check for CLEAN parameter
    if {[string match -nocase "clean=*" [lindex $argv $i]]} {
        set clean [string range [lindex $argv $i] 6 end]
        set printmessage $clean
        for {set j 0} {$j < [expr $chart_wdith - [string length $clean]]} {incr j} {
            append printmessage " "
        }
        append build_params  "| Clean            |     $printmessage |\n"
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
    # check for TAG parameter
    if {[string match -nocase "tag=*" [lindex $argv $i]]} {
        set tag [string range [lindex $argv $i] 4 end]
        set printmessage $tag
        for {set j 0} {$j < [expr $chart_wdith - [string length $tag]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Tag              |     $printmessage |\n"
    }
    # check for SDK parameter
    if {[string match -nocase "sdk=*" [lindex $argv $i]]} {
        set sdk [string range [lindex $argv $i] 4 end]
        set printmessage $sdk
        for {set j 0} {$j < [expr $chart_wdith - [string length $sdk]]} {incr j} {
            append printmessage " "
        }
        append build_params "| SDK              |     $printmessage |\n"
    }
    # check for Version parameter
    if {[string match -nocase "version_override=*" [lindex $argv $i]]} {
        set version_override [string range [lindex $argv $i] 17 end]
        set printmessage $version_override
        for {set j 0} {$j < [expr $chart_wdith - [string length $version_override]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Version override |     $printmessage |\n"
    }
    # check for No Close Project parameter
    if {[string match -nocase "close_project=*" [lindex $argv $i]]} {
        set close_project [string range [lindex $argv $i] 14 end]
        set printmessage $close_project
        for {set j 0} {$j < [expr $chart_wdith - [string length $close_project]]} {incr j} {
            append printmessage " "
        }
        append build_params "| No Close Project |     $printmessage |\n"
    }
    # check for JTAG parameter
    if {[string match -nocase "jtag=*" [lindex $argv $i]]} {
        set jtag [string range [lindex $argv $i] 5 end]
        set printmessage $jtag
        for {set j 0} {$j < [expr $chart_wdith - [string length $jtag]]} {incr j} {
            append printmessage " "
        }
        append build_params "| JTAG             |     $printmessage |\n"
    }
    # check for DEV_ARCH parameter
    if {[string match -nocase "dev_arch=*" [lindex $argv $i]]} {
        set dev_arch [string range [lindex $argv $i] 9 end]
        set printmessage $dev_arch
        for {set j 0} {$j < [expr $chart_wdith - [string length $dev_arch]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Device           |     $printmessage |\n"
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
    append build_params "+------------------+------------------------------------+\n"
}
append build_params "\n\n"
puts $build_params
#unset printmessage
unset ranonce

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

# If variables do not exist, exit script
if {[string match -nocase "init" $board]} {
    puts "Board was not defined, please define and try again!"
    return -code ok
}
if {[string match -nocase "init" $project]} {
    puts "Project was not defined, please define and try again!"
    return -code ok
}

# create variables with absolute folders for all necessary folders
set repo_folder [file normalize [pwd]/../]
set boards_folder [file normalize ${avnet_dir}/Boards]
set ip_folder [file normalize ${avnet_dir}/IP]
set projects_folder [file normalize ${repo_folder}/projects/${project}/${board}_${vivado_ver}]
set scripts_folder [file normalize ${avnet_dir}/Scripts]


puts "\n\n*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
puts " Selected Board and Project as:\n$board and $project"
puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\n\n"

if {[string match -nocase "yes" $clean]} {
    puts "Cleaning Project..."
    file delete -force ${projects_folder}
    return -code ok
}

# IF tagging - check for modified files
set GUI $rdi::mode
if {[string match -nocase "init" $tag]} {
    puts "Not Requesting Tag"
    if {[string match -nocase "yes" $jtag]} {
        if {[string match -nocase "tcl" $GUI]} {
            puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
            puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
            puts "*-                                                     -*"
            puts "*-              JTAG recommended to                    -*"
            puts "*-            Use GUI!  Please run from GUI!           -*"
            puts "*-                                                     -*"
            puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
            puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
            return -code ok
        }
    }
} else {
    puts "Requesting Tag"
    cd $repo_folder
    set modified_files [exec git ls-files -m]
    cd $scripts_folder
    if {[llength $modified_files] > 0} {
        puts "Please commit all files before trying to TAG\nNot Tagging..."
        return -code ok
    }
    if {[string match -nocase "gui" $GUI]} {
        puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
        puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
        puts "*-                                                     -*"
        puts "*-             Cannot TAG from GUI!                    -*"
        puts "*-           Please RUN from TCL SHELL                 -*"
        puts "*-                                                     -*"
        puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
        puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
        return -code ok
    }
}

if {![file exists ${projects_folder}/${project}.xpr] || ![file exists ${projects_folder}/${project}.srcs/sources_1/bd/${project}/${project}.bd]} {

# Project Creation Cases
# use a - for fall through expressions
puts "Setting Up Project $project..."
#source ${scripts_folder}/ProjectScripts/$project.tcl -notrace

# 'private' used to allow this project to be privately tagged
# 'public' used to allow this project to be publicly tagged
set release_state public

# Generate Avnet IP
puts "***** Generating IP..."
#source ./makeip.tcl -notrace

#avnet_generate_ip onsemi_vita_spi
#avnet_generate_ip onsemi_vita_cam
#avnet_generate_ip avnet_hdmi_in
#avnet_generate_ip avnet_hdmi_out

# Create Vivado project
puts "***** Creating Vivado Project..."
#source ../Boards/$board/[string tolower $board].tcl -notrace

create_project $project $projects_folder -part xc7z020clg400-1 -force
# add selection for proper xdc based on needs
# if IO carrier, then use that xdc
# if FMC, choose that one
#import_files -fileset constrs_1 -norecurse $scriptdir/../Boards/PZ7030_FMC2/#PZ7030_7015_RevC_FMCV2_RevA_v1.xdc
# TODO: import xdc here
#
remove_files -fileset constrs_1 *.xdc
# Add board specific constraint file

#PZ7030_FMC2 {
#set_property board_part em.avnet.com:picozed_7030_fmc2:part0:1.1 [current_project]
#add_files -fileset constrs_1 -norecurse ${projects_folder}/../pz7030_fmc2_fmchc_python1300c.xdc
#}
#TODO: add myir7020 constraint file here
#add_files -fileset constrs_1 -norecurse ${scriptdir}/zedboard_fmchc_python1300c.xdc
add_files -fileset constrs_1 -norecurse ${scriptdir}/myir7020_fmchc_python1300c.xdc

# Add Avnet IP Repository
puts "***** Updating Vivado to include IP Folder"
#cd ../Projects/$project
set_property ip_repo_paths  ${avnet_dir}/IP [current_fileset]
update_ip_catalog

# Create Block Design and Add PS core
puts "***** Creating Block Design..."
create_bd_design ${project}
# add selection for customization depending on board choice (or none)
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" }  [get_bd_cells processing_system7_0]
#create_bd_port -dir I -type clk M_AXI_GP0_ACLK
#connect_bd_net [get_bd_pins /processing_system7_0/M_AXI_GP0_ACLK] [get_bd_ports M_AXI_GP0_ACLK]
# Apply board specific settings
#PZ7030_FMC2 {
#    source ../../Scripts/ProjectScripts/picozed_preset.tcl
#}
# TODO: apply myir7020 preset here


# General Config
puts "***** General Configuration for Design..."
set_property target_language VHDL [current_project]

# Enable XPM_FIFO primitives (required for new onsemi_vita_spi/cam) cores
puts "***** Enable XPM_FIFO primitives..."
set_property XPM_LIBRARIES XPM_FIFO [current_project]


# Check for Video IP core licenses
puts "***** Check for Video IP core licenses..."
set v_cfa_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_demosaic v_cfa_0 ]
set v_cresample_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_cresample v_cresample_0 ]
set v_osd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_osd v_osd_0 ]
set v_rgb2ycrcb_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_rgb2ycrcb v_rgb2ycrcb_0 ]
set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc v_tc_0 ]
report_ip_status -file "video_ip_core_status.log"
set core_list [list "v_cfa" "v_cresample" "v_osd" "v_rgb2ycrcb" "v_tc" ]
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
# Create board specific block diagram
#PZ7030_FMC2 {
#source ../../Scripts/ProjectScripts/fmchc_python1300c_bd.tcl
#}
####### board specific block diagram #######



################################################################
# This is a generated script based on design: fmchc_python1300c
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
    proc get_script_folder {} {
        set script_path [file normalize [info script]]
        set script_folder [file dirname $script_path]
        return $script_folder
    }
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
    puts ""
    common::send_msg_id "BD_TCL-1002" "WARNING" "This script was generated using Vivado <$scripts_vivado_version> without IP versions in the create_bd_cell commands, but is now being run in <$current_vivado_version> of Vivado. There may have been major IP version changes between Vivado <$scripts_vivado_version> and <$current_vivado_version>, which could impact the parameter settings of the IPs."

}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source fmchc_python1300c_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

#set list_projs [get_projects -quiet]
#if { $list_projs eq "" } {
#   create_project project_1 myproj -part xc7z030sbg485-1
#   set_property BOARD_PART em.avnet.com:picozed_7030_fmc2:part0:1.1 [current_project]
#}


# CHANGE DESIGN NAME HERE
#set design_name fmchc_python1300c

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

#set cur_design [current_bd_design -quiet]
#set list_cells [get_bd_cells -quiet]
#
#if { ${design_name} eq "" } {
#   # USE CASES:
#   #    1) Design_name not set
#
#   set errMsg "Please set the variable <design_name> to a non-empty value."
#   set nRet 1
#
#} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
#   # USE CASES:
#   #    2): Current design opened AND is empty AND names same.
#   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
#   #    4): Current design opened AND is empty AND names diff; design_name exists in project.
#
#   if { $cur_design ne $design_name } {
#      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
#      set design_name [get_property NAME $cur_design]
#   }
#   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."
#
#} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
#   # USE CASES:
#   #    5) Current design opened AND has components AND same names.
#
#   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
#   set nRet 1
#} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
#   # USE CASES:
#   #    6) Current opened design, has components, but diff names, design_name exists in project.
#   #    7) No opened design, design_name exists in project.
#
#   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
#   set nRet 2
#
#} else {
#   # USE CASES:
#   #    8) No opened design, design_name not in project.
#   #    9) Current opened design, has components, but diff names, design_name not in project.
#
#   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."
#
#   create_bd_design $design_name
#
#   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
#   current_bd_design $design_name
#
#}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
    catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
    return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

    variable script_folder

    if { $parentCell eq "" } {
        set parentCell [get_bd_cells /]
    }

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
    set IO_HDMII [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:avnet_hdmi_rtl:2.0 IO_HDMII ]
    set IO_HDMIO [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:avnet_hdmi_rtl:2.0 IO_HDMIO ]
    set IO_PYTHON_CAM [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:onsemi_vita_cam_rtl:1.0 IO_PYTHON_CAM ]
    set IO_PYTHON_SPI [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:onsemi_vita_spi_rtl:1.0 IO_PYTHON_SPI ]
    set fmc_hdmi_cam_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 fmc_hdmi_cam_iic ]

    # Create ports
    #set M_AXI_GP0_ACLK [ create_bd_port -dir I -type clk M_AXI_GP0_ACLK ]
    set fmc_hdmi_cam_iic_rst_n [ create_bd_port -dir O -from 0 -to 0 fmc_hdmi_cam_iic_rst_n ]
    set fmc_hdmi_cam_vclk [ create_bd_port -dir I fmc_hdmi_cam_vclk ]

    # Create instance: avnet_hdmi_in_0, and set properties
    set avnet_hdmi_in_0 [ create_bd_cell -type ip -vlnv avnet:avnet_hdmi:avnet_hdmi_in avnet_hdmi_in_0 ]
    set_property -dict [ list \
        CONFIG.C_USE_BUFR {false} \
    ] $avnet_hdmi_in_0

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

    # Create instance: axi_vdma_0, and set properties
    set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma axi_vdma_0 ]
    set_property -dict [ list \
        CONFIG.c_m_axi_s2mm_data_width {64} \
        CONFIG.c_m_axis_mm2s_tdata_width {16} \
        CONFIG.c_mm2s_linebuffer_depth {512} \
        CONFIG.c_mm2s_max_burst_length {256} \
        CONFIG.c_s2mm_linebuffer_depth {4096} \
        CONFIG.c_s2mm_max_burst_length {256} \
    ] $axi_vdma_0

    # Create instance: axi_vdma_1, and set properties
    set axi_vdma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma axi_vdma_1 ]
    set_property -dict [ list \
        CONFIG.c_m_axi_s2mm_data_width {64} \
        CONFIG.c_m_axis_mm2s_tdata_width {16} \
        CONFIG.c_mm2s_linebuffer_depth {4096} \
        CONFIG.c_mm2s_max_burst_length {256} \
        CONFIG.c_s2mm_linebuffer_depth {4096} \
        CONFIG.c_s2mm_max_burst_length {256} \
    ] $axi_vdma_1

    # Create instance: clk_wiz_0, and set properties
    set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz clk_wiz_0 ]
    set_property -dict [ list \
        CONFIG.CLKIN1_JITTER_PS {67.34} \
        CONFIG.CLKOUT1_JITTER {103.270} \
        CONFIG.CLKOUT1_PHASE_ERROR {86.054} \
        CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {148.5} \
        CONFIG.CLKOUT2_JITTER {109.684} \
        CONFIG.CLKOUT2_PHASE_ERROR {86.054} \
        CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {108} \
        CONFIG.CLKOUT2_USED {true} \
        CONFIG.MMCM_CLKFBOUT_MULT_F {8.000} \
        CONFIG.MMCM_CLKIN1_PERIOD {6.734} \
        CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
        CONFIG.MMCM_CLKOUT0_DIVIDE_F {8.000} \
        CONFIG.MMCM_CLKOUT1_DIVIDE {11} \
        CONFIG.MMCM_COMPENSATION {ZHOLD} \
        CONFIG.NUM_OUT_CLKS {2} \
        CONFIG.PRIM_IN_FREQ {148.5} \
        CONFIG.USE_LOCKED {false} \
        CONFIG.USE_RESET {false} \
    ] $clk_wiz_0

    # Need to retain value_src of defaults
    set_property -dict [ list \
        CONFIG.CLKIN1_JITTER_PS.VALUE_SRC {DEFAULT} \
        CONFIG.CLKOUT1_JITTER.VALUE_SRC {DEFAULT} \
        CONFIG.CLKOUT1_PHASE_ERROR.VALUE_SRC {DEFAULT} \
        CONFIG.CLKOUT2_JITTER.VALUE_SRC {DEFAULT} \
        CONFIG.CLKOUT2_PHASE_ERROR.VALUE_SRC {DEFAULT} \
        CONFIG.MMCM_CLKFBOUT_MULT_F.VALUE_SRC {DEFAULT} \
        CONFIG.MMCM_CLKIN1_PERIOD.VALUE_SRC {DEFAULT} \
        CONFIG.MMCM_CLKIN2_PERIOD.VALUE_SRC {DEFAULT} \
        CONFIG.MMCM_CLKOUT0_DIVIDE_F.VALUE_SRC {DEFAULT} \
        CONFIG.MMCM_CLKOUT1_DIVIDE.VALUE_SRC {DEFAULT} \
        CONFIG.MMCM_COMPENSATION.VALUE_SRC {DEFAULT} \
    ] $clk_wiz_0

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
    set processing_system7_0 [get_bd_cells processing_system7_0]
    set_property -dict [ list \
        CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ {10.000000} \
        CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ {10.158730} \
        CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {125.000000} \
        CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ {10.000000} \
        CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {76.923080} \
        CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {142.857132} \
        CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {200.000000} \
        CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {10.000000} \
        CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ {200.000000} \
        CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {200.000000} \
        CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {50.000000} \
        CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ {10.000000} \
        CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ {10.000000} \
        CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ {200.000000} \
        CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {50.000000} \
        CONFIG.PCW_APU_CLK_RATIO_ENABLE {6:2:1} \
        CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {667} \
        CONFIG.PCW_ARMPLL_CTRL_FBDIV {40} \
        CONFIG.PCW_CAN0_CAN0_IO {<Select>} \
        CONFIG.PCW_CAN0_GRP_CLK_ENABLE {0} \
        CONFIG.PCW_CAN0_GRP_CLK_IO {<Select>} \
        CONFIG.PCW_CAN0_PERIPHERAL_CLKSRC {External} \
        CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_CAN1_CAN1_IO {<Select>} \
        CONFIG.PCW_CAN1_GRP_CLK_ENABLE {0} \
        CONFIG.PCW_CAN1_GRP_CLK_IO {<Select>} \
        CONFIG.PCW_CAN1_PERIPHERAL_CLKSRC {External} \
        CONFIG.PCW_CAN1_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_CAN_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_CAN_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_CAN_PERIPHERAL_DIVISOR1 {1} \
        CONFIG.PCW_CAN_PERIPHERAL_FREQMHZ {100} \
        CONFIG.PCW_CLK0_FREQ {76923080} \
        CONFIG.PCW_CLK1_FREQ {142857132} \
        CONFIG.PCW_CLK2_FREQ {200000000} \
        CONFIG.PCW_CLK3_FREQ {10000000} \
        CONFIG.PCW_CPU_CPU_6X4X_MAX_RANGE {667} \
        CONFIG.PCW_CPU_CPU_PLL_FREQMHZ {1333.333} \
        CONFIG.PCW_CPU_PERIPHERAL_CLKSRC {ARM PLL} \
        CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0 {2} \
        CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {33.333333} \
        CONFIG.PCW_DCI_PERIPHERAL_CLKSRC {DDR PLL} \
        CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0 {15} \
        CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1 {7} \
        CONFIG.PCW_DCI_PERIPHERAL_FREQMHZ {10.159} \
        CONFIG.PCW_DDRPLL_CTRL_FBDIV {32} \
        CONFIG.PCW_DDR_DDR_PLL_FREQMHZ {1066.667} \
        CONFIG.PCW_DDR_HPRLPR_QUEUE_PARTITION {HPR(0)/LPR(32)} \
        CONFIG.PCW_DDR_HPR_TO_CRITICAL_PRIORITY_LEVEL {15} \
        CONFIG.PCW_DDR_LPR_TO_CRITICAL_PRIORITY_LEVEL {2} \
        CONFIG.PCW_DDR_PERIPHERAL_CLKSRC {DDR PLL} \
        CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0 {2} \
        CONFIG.PCW_DDR_PORT0_HPR_ENABLE {0} \
        CONFIG.PCW_DDR_PORT1_HPR_ENABLE {0} \
        CONFIG.PCW_DDR_PORT2_HPR_ENABLE {0} \
        CONFIG.PCW_DDR_PORT3_HPR_ENABLE {0} \
        CONFIG.PCW_DDR_PRIORITY_READPORT_0 {<Select>} \
        CONFIG.PCW_DDR_PRIORITY_READPORT_1 {<Select>} \
        CONFIG.PCW_DDR_PRIORITY_READPORT_2 {<Select>} \
        CONFIG.PCW_DDR_PRIORITY_READPORT_3 {<Select>} \
        CONFIG.PCW_DDR_PRIORITY_WRITEPORT_0 {<Select>} \
        CONFIG.PCW_DDR_PRIORITY_WRITEPORT_1 {<Select>} \
        CONFIG.PCW_DDR_PRIORITY_WRITEPORT_2 {<Select>} \
        CONFIG.PCW_DDR_PRIORITY_WRITEPORT_3 {<Select>} \
        CONFIG.PCW_DDR_WRITE_TO_CRITICAL_PRIORITY_LEVEL {2} \
        CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
        CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
        CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
        CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0 {8} \
        CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1 {1} \
        CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
        CONFIG.PCW_ENET0_RESET_ENABLE {0} \
        CONFIG.PCW_ENET0_RESET_IO {<Select>} \
        CONFIG.PCW_ENET1_ENET1_IO {<Select>} \
        CONFIG.PCW_ENET1_GRP_MDIO_ENABLE {0} \
        CONFIG.PCW_ENET1_GRP_MDIO_IO {<Select>} \
        CONFIG.PCW_ENET1_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1 {1} \
        CONFIG.PCW_ENET1_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_ENET1_PERIPHERAL_FREQMHZ {1000 Mbps} \
        CONFIG.PCW_ENET1_RESET_ENABLE {0} \
        CONFIG.PCW_ENET1_RESET_IO {<Select>} \
        CONFIG.PCW_ENET_RESET_ENABLE {1} \
        CONFIG.PCW_ENET_RESET_POLARITY {Active Low} \
        CONFIG.PCW_ENET_RESET_SELECT {Share reset pin} \
        CONFIG.PCW_EN_4K_TIMER {0} \
        CONFIG.PCW_EN_CLK0_PORT {1} \
        CONFIG.PCW_EN_CLK1_PORT {1} \
        CONFIG.PCW_EN_CLK2_PORT {1} \
        CONFIG.PCW_EN_CLK3_PORT {0} \
        CONFIG.PCW_EN_DDR {1} \
        CONFIG.PCW_EN_EMIO_CD_SDIO1 {1} \
        CONFIG.PCW_EN_EMIO_TTC0 {1} \
        CONFIG.PCW_EN_ENET0 {1} \
        CONFIG.PCW_EN_QSPI {1} \
        CONFIG.PCW_EN_RST0_PORT {1} \
        CONFIG.PCW_EN_RST1_PORT {1} \
        CONFIG.PCW_EN_RST2_PORT {1} \
        CONFIG.PCW_EN_RST3_PORT {0} \
        CONFIG.PCW_EN_SDIO0 {1} \
        CONFIG.PCW_EN_SDIO1 {1} \
        CONFIG.PCW_EN_TTC0 {1} \
        CONFIG.PCW_EN_UART1 {1} \
        CONFIG.PCW_EN_USB0 {1} \
        CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0 {13} \
        CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1 {1} \
        CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0 {7} \
        CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1 {1} \
        CONFIG.PCW_FCLK2_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0 {5} \
        CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR1 {1} \
        CONFIG.PCW_FCLK3_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR1 {1} \
        CONFIG.PCW_FCLK_CLK0_BUF {TRUE} \
        CONFIG.PCW_FCLK_CLK1_BUF {TRUE} \
        CONFIG.PCW_FCLK_CLK2_BUF {TRUE} \
        CONFIG.PCW_FCLK_CLK3_BUF {FALSE} \
        CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {75} \
        CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {150} \
        CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {200} \
        CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ {50} \
        CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
        CONFIG.PCW_FPGA_FCLK1_ENABLE {1} \
        CONFIG.PCW_FPGA_FCLK2_ENABLE {1} \
        CONFIG.PCW_FTM_CTI_IN0 {<Select>} \
        CONFIG.PCW_FTM_CTI_IN1 {<Select>} \
        CONFIG.PCW_FTM_CTI_IN2 {<Select>} \
        CONFIG.PCW_FTM_CTI_IN3 {<Select>} \
        CONFIG.PCW_FTM_CTI_OUT0 {<Select>} \
        CONFIG.PCW_FTM_CTI_OUT1 {<Select>} \
        CONFIG.PCW_FTM_CTI_OUT2 {<Select>} \
        CONFIG.PCW_FTM_CTI_OUT3 {<Select>} \
        CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {0} \
        CONFIG.PCW_GPIO_EMIO_GPIO_IO {<Select>} \
        CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
        CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
        CONFIG.PCW_GPIO_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_I2C0_GRP_INT_ENABLE {0} \
        CONFIG.PCW_I2C0_GRP_INT_IO {<Select>} \
        CONFIG.PCW_I2C0_I2C0_IO {<Select>} \
        CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_I2C0_RESET_ENABLE {0} \
        CONFIG.PCW_I2C0_RESET_IO {<Select>} \
        CONFIG.PCW_I2C1_GRP_INT_ENABLE {0} \
        CONFIG.PCW_I2C1_GRP_INT_IO {<Select>} \
        CONFIG.PCW_I2C1_I2C1_IO {<Select>} \
        CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_I2C1_RESET_ENABLE {0} \
        CONFIG.PCW_I2C1_RESET_IO {<Select>} \
        CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ {25} \
        CONFIG.PCW_I2C_RESET_ENABLE {0} \
        CONFIG.PCW_I2C_RESET_POLARITY {Active Low} \
        CONFIG.PCW_I2C_RESET_SELECT {<Select>} \
        CONFIG.PCW_IOPLL_CTRL_FBDIV {30} \
        CONFIG.PCW_IO_IO_PLL_FREQMHZ {1000.000} \
        CONFIG.PCW_MIO_0_DIRECTION {inout} \
        CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_0_PULLUP {disabled} \
        CONFIG.PCW_MIO_0_SLEW {slow} \
        CONFIG.PCW_MIO_10_DIRECTION {inout} \
        CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_10_PULLUP {disabled} \
        CONFIG.PCW_MIO_10_SLEW {slow} \
        CONFIG.PCW_MIO_11_DIRECTION {inout} \
        CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_11_PULLUP {disabled} \
        CONFIG.PCW_MIO_11_SLEW {slow} \
        CONFIG.PCW_MIO_12_DIRECTION {inout} \
        CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_12_PULLUP {disabled} \
        CONFIG.PCW_MIO_12_SLEW {slow} \
        CONFIG.PCW_MIO_13_DIRECTION {inout} \
        CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_13_PULLUP {disabled} \
        CONFIG.PCW_MIO_13_SLEW {slow} \
        CONFIG.PCW_MIO_14_DIRECTION {inout} \
        CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_14_PULLUP {disabled} \
        CONFIG.PCW_MIO_14_SLEW {slow} \
        CONFIG.PCW_MIO_15_DIRECTION {inout} \
        CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_15_PULLUP {disabled} \
        CONFIG.PCW_MIO_15_SLEW {slow} \
        CONFIG.PCW_MIO_16_DIRECTION {out} \
        CONFIG.PCW_MIO_16_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_16_PULLUP {disabled} \
        CONFIG.PCW_MIO_16_SLEW {slow} \
        CONFIG.PCW_MIO_17_DIRECTION {out} \
        CONFIG.PCW_MIO_17_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_17_PULLUP {disabled} \
        CONFIG.PCW_MIO_17_SLEW {slow} \
        CONFIG.PCW_MIO_18_DIRECTION {out} \
        CONFIG.PCW_MIO_18_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_18_PULLUP {disabled} \
        CONFIG.PCW_MIO_18_SLEW {slow} \
        CONFIG.PCW_MIO_19_DIRECTION {out} \
        CONFIG.PCW_MIO_19_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_19_PULLUP {disabled} \
        CONFIG.PCW_MIO_19_SLEW {slow} \
        CONFIG.PCW_MIO_1_DIRECTION {out} \
        CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_1_PULLUP {disabled} \
        CONFIG.PCW_MIO_1_SLEW {slow} \
        CONFIG.PCW_MIO_20_DIRECTION {out} \
        CONFIG.PCW_MIO_20_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_20_PULLUP {disabled} \
        CONFIG.PCW_MIO_20_SLEW {slow} \
        CONFIG.PCW_MIO_21_DIRECTION {out} \
        CONFIG.PCW_MIO_21_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_21_PULLUP {disabled} \
        CONFIG.PCW_MIO_21_SLEW {slow} \
        CONFIG.PCW_MIO_22_DIRECTION {in} \
        CONFIG.PCW_MIO_22_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_22_PULLUP {disabled} \
        CONFIG.PCW_MIO_22_SLEW {slow} \
        CONFIG.PCW_MIO_23_DIRECTION {in} \
        CONFIG.PCW_MIO_23_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_23_PULLUP {disabled} \
        CONFIG.PCW_MIO_23_SLEW {slow} \
        CONFIG.PCW_MIO_24_DIRECTION {in} \
        CONFIG.PCW_MIO_24_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_24_PULLUP {disabled} \
        CONFIG.PCW_MIO_24_SLEW {slow} \
        CONFIG.PCW_MIO_25_DIRECTION {in} \
        CONFIG.PCW_MIO_25_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_25_PULLUP {disabled} \
        CONFIG.PCW_MIO_25_SLEW {slow} \
        CONFIG.PCW_MIO_26_DIRECTION {in} \
        CONFIG.PCW_MIO_26_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_26_PULLUP {disabled} \
        CONFIG.PCW_MIO_26_SLEW {slow} \
        CONFIG.PCW_MIO_27_DIRECTION {in} \
        CONFIG.PCW_MIO_27_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_27_PULLUP {disabled} \
        CONFIG.PCW_MIO_27_SLEW {slow} \
        CONFIG.PCW_MIO_28_DIRECTION {inout} \
        CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_28_PULLUP {disabled} \
        CONFIG.PCW_MIO_28_SLEW {slow} \
        CONFIG.PCW_MIO_29_DIRECTION {in} \
        CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_29_PULLUP {disabled} \
        CONFIG.PCW_MIO_29_SLEW {slow} \
        CONFIG.PCW_MIO_2_DIRECTION {inout} \
        CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_2_PULLUP {disabled} \
        CONFIG.PCW_MIO_2_SLEW {slow} \
        CONFIG.PCW_MIO_30_DIRECTION {out} \
        CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_30_PULLUP {disabled} \
        CONFIG.PCW_MIO_30_SLEW {slow} \
        CONFIG.PCW_MIO_31_DIRECTION {in} \
        CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_31_PULLUP {disabled} \
        CONFIG.PCW_MIO_31_SLEW {slow} \
        CONFIG.PCW_MIO_32_DIRECTION {inout} \
        CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_32_PULLUP {disabled} \
        CONFIG.PCW_MIO_32_SLEW {slow} \
        CONFIG.PCW_MIO_33_DIRECTION {inout} \
        CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_33_PULLUP {disabled} \
        CONFIG.PCW_MIO_33_SLEW {slow} \
        CONFIG.PCW_MIO_34_DIRECTION {inout} \
        CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_34_PULLUP {disabled} \
        CONFIG.PCW_MIO_34_SLEW {slow} \
        CONFIG.PCW_MIO_35_DIRECTION {inout} \
        CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_35_PULLUP {disabled} \
        CONFIG.PCW_MIO_35_SLEW {slow} \
        CONFIG.PCW_MIO_36_DIRECTION {in} \
        CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_36_PULLUP {disabled} \
        CONFIG.PCW_MIO_36_SLEW {slow} \
        CONFIG.PCW_MIO_37_DIRECTION {inout} \
        CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_37_PULLUP {disabled} \
        CONFIG.PCW_MIO_37_SLEW {slow} \
        CONFIG.PCW_MIO_38_DIRECTION {inout} \
        CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_38_PULLUP {disabled} \
        CONFIG.PCW_MIO_38_SLEW {slow} \
        CONFIG.PCW_MIO_39_DIRECTION {inout} \
        CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_39_PULLUP {disabled} \
        CONFIG.PCW_MIO_39_SLEW {slow} \
        CONFIG.PCW_MIO_3_DIRECTION {inout} \
        CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_3_PULLUP {disabled} \
        CONFIG.PCW_MIO_3_SLEW {slow} \
        CONFIG.PCW_MIO_40_DIRECTION {inout} \
        CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_40_PULLUP {disabled} \
        CONFIG.PCW_MIO_40_SLEW {slow} \
        CONFIG.PCW_MIO_41_DIRECTION {inout} \
        CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_41_PULLUP {disabled} \
        CONFIG.PCW_MIO_41_SLEW {slow} \
        CONFIG.PCW_MIO_42_DIRECTION {inout} \
        CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_42_PULLUP {disabled} \
        CONFIG.PCW_MIO_42_SLEW {slow} \
        CONFIG.PCW_MIO_43_DIRECTION {inout} \
        CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_43_PULLUP {disabled} \
        CONFIG.PCW_MIO_43_SLEW {slow} \
        CONFIG.PCW_MIO_44_DIRECTION {inout} \
        CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_44_PULLUP {disabled} \
        CONFIG.PCW_MIO_44_SLEW {slow} \
        CONFIG.PCW_MIO_45_DIRECTION {inout} \
        CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_45_PULLUP {disabled} \
        CONFIG.PCW_MIO_45_SLEW {slow} \
        CONFIG.PCW_MIO_46_DIRECTION {in} \
        CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_46_PULLUP {disabled} \
        CONFIG.PCW_MIO_46_SLEW {slow} \
        CONFIG.PCW_MIO_47_DIRECTION {inout} \
        CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_47_PULLUP {disabled} \
        CONFIG.PCW_MIO_47_SLEW {slow} \
        CONFIG.PCW_MIO_48_DIRECTION {out} \
        CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_48_PULLUP {disabled} \
        CONFIG.PCW_MIO_48_SLEW {slow} \
        CONFIG.PCW_MIO_49_DIRECTION {in} \
        CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_49_PULLUP {disabled} \
        CONFIG.PCW_MIO_49_SLEW {slow} \
        CONFIG.PCW_MIO_4_DIRECTION {inout} \
        CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_4_PULLUP {disabled} \
        CONFIG.PCW_MIO_4_SLEW {slow} \
        CONFIG.PCW_MIO_50_DIRECTION {inout} \
        CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_50_PULLUP {disabled} \
        CONFIG.PCW_MIO_50_SLEW {slow} \
        CONFIG.PCW_MIO_51_DIRECTION {inout} \
        CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_51_PULLUP {disabled} \
        CONFIG.PCW_MIO_51_SLEW {slow} \
        CONFIG.PCW_MIO_52_DIRECTION {out} \
        CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_52_PULLUP {disabled} \
        CONFIG.PCW_MIO_52_SLEW {slow} \
        CONFIG.PCW_MIO_53_DIRECTION {inout} \
        CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 1.8V} \
        CONFIG.PCW_MIO_53_PULLUP {disabled} \
        CONFIG.PCW_MIO_53_SLEW {slow} \
        CONFIG.PCW_MIO_5_DIRECTION {inout} \
        CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_5_PULLUP {disabled} \
        CONFIG.PCW_MIO_5_SLEW {slow} \
        CONFIG.PCW_MIO_6_DIRECTION {out} \
        CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_6_PULLUP {disabled} \
        CONFIG.PCW_MIO_6_SLEW {slow} \
        CONFIG.PCW_MIO_7_DIRECTION {out} \
        CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_7_PULLUP {disabled} \
        CONFIG.PCW_MIO_7_SLEW {slow} \
        CONFIG.PCW_MIO_8_DIRECTION {out} \
        CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_8_PULLUP {disabled} \
        CONFIG.PCW_MIO_8_SLEW {slow} \
        CONFIG.PCW_MIO_9_DIRECTION {inout} \
        CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 3.3V} \
        CONFIG.PCW_MIO_9_PULLUP {disabled} \
        CONFIG.PCW_MIO_9_SLEW {slow} \
        CONFIG.PCW_MIO_TREE_PERIPHERALS {GPIO#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#USB Reset#Quad SPI Flash#GPIO#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#GPIO#UART 1#UART 1#GPIO#GPIO#Enet 0#Enet 0} \
        CONFIG.PCW_MIO_TREE_SIGNALS {gpio[0]#qspi0_ss_b#qspi0_io[0]#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]#qspi0_sclk#reset#qspi_fbclk#gpio[9]#data[0]#cmd#clk#data[1]#data[2]#data[3]#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#data[4]#dir#stp#nxt#data[0]#data[1]#data[2]#data[3]#clk#data[5]#data[6]#data[7]#clk#cmd#data[0]#data[1]#data[2]#data[3]#cd#gpio[47]#tx#rx#gpio[50]#gpio[51]#mdc#mdio} \
        CONFIG.PCW_NAND_CYCLES_T_AR {1} \
        CONFIG.PCW_NAND_CYCLES_T_CLR {1} \
        CONFIG.PCW_NAND_CYCLES_T_RC {11} \
        CONFIG.PCW_NAND_CYCLES_T_REA {1} \
        CONFIG.PCW_NAND_CYCLES_T_RR {1} \
        CONFIG.PCW_NAND_CYCLES_T_WC {11} \
        CONFIG.PCW_NAND_CYCLES_T_WP {1} \
        CONFIG.PCW_NAND_GRP_D8_ENABLE {0} \
        CONFIG.PCW_NAND_GRP_D8_IO {<Select>} \
        CONFIG.PCW_NAND_NAND_IO {<Select>} \
        CONFIG.PCW_NAND_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_NOR_CS0_T_CEOE {1} \
        CONFIG.PCW_NOR_CS0_T_PC {1} \
        CONFIG.PCW_NOR_CS0_T_RC {11} \
        CONFIG.PCW_NOR_CS0_T_TR {1} \
        CONFIG.PCW_NOR_CS0_T_WC {11} \
        CONFIG.PCW_NOR_CS0_T_WP {1} \
        CONFIG.PCW_NOR_CS0_WE_TIME {0} \
        CONFIG.PCW_NOR_CS1_T_CEOE {1} \
        CONFIG.PCW_NOR_CS1_T_PC {1} \
        CONFIG.PCW_NOR_CS1_T_RC {11} \
        CONFIG.PCW_NOR_CS1_T_TR {1} \
        CONFIG.PCW_NOR_CS1_T_WC {11} \
        CONFIG.PCW_NOR_CS1_T_WP {1} \
        CONFIG.PCW_NOR_CS1_WE_TIME {0} \
        CONFIG.PCW_NOR_GRP_A25_ENABLE {0} \
        CONFIG.PCW_NOR_GRP_A25_IO {<Select>} \
        CONFIG.PCW_NOR_GRP_CS0_ENABLE {0} \
        CONFIG.PCW_NOR_GRP_CS0_IO {<Select>} \
        CONFIG.PCW_NOR_GRP_CS1_ENABLE {0} \
        CONFIG.PCW_NOR_GRP_CS1_IO {<Select>} \
        CONFIG.PCW_NOR_GRP_SRAM_CS0_ENABLE {0} \
        CONFIG.PCW_NOR_GRP_SRAM_CS0_IO {<Select>} \
        CONFIG.PCW_NOR_GRP_SRAM_CS1_ENABLE {0} \
        CONFIG.PCW_NOR_GRP_SRAM_CS1_IO {<Select>} \
        CONFIG.PCW_NOR_GRP_SRAM_INT_ENABLE {0} \
        CONFIG.PCW_NOR_GRP_SRAM_INT_IO {<Select>} \
        CONFIG.PCW_NOR_NOR_IO {<Select>} \
        CONFIG.PCW_NOR_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_NOR_SRAM_CS0_T_CEOE {1} \
        CONFIG.PCW_NOR_SRAM_CS0_T_PC {1} \
        CONFIG.PCW_NOR_SRAM_CS0_T_RC {11} \
        CONFIG.PCW_NOR_SRAM_CS0_T_TR {1} \
        CONFIG.PCW_NOR_SRAM_CS0_T_WC {11} \
        CONFIG.PCW_NOR_SRAM_CS0_T_WP {1} \
        CONFIG.PCW_NOR_SRAM_CS0_WE_TIME {0} \
        CONFIG.PCW_NOR_SRAM_CS1_T_CEOE {1} \
        CONFIG.PCW_NOR_SRAM_CS1_T_PC {1} \
        CONFIG.PCW_NOR_SRAM_CS1_T_RC {11} \
        CONFIG.PCW_NOR_SRAM_CS1_T_TR {1} \
        CONFIG.PCW_NOR_SRAM_CS1_T_WC {11} \
        CONFIG.PCW_NOR_SRAM_CS1_T_WP {1} \
        CONFIG.PCW_NOR_SRAM_CS1_WE_TIME {0} \
        CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0 {0.301} \
        CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1 {0.308} \
        CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2 {0.357} \
        CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3 {0.361} \
        CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0 {-0.033} \
        CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1 {-0.029} \
        CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2 {0.057} \
        CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3 {0.038} \
        CONFIG.PCW_PACKAGE_NAME {clg400} \
        CONFIG.PCW_PCAP_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0 {5} \
        CONFIG.PCW_PCAP_PERIPHERAL_FREQMHZ {200} \
        CONFIG.PCW_PERIPHERAL_BOARD_PRESET {part0} \
        CONFIG.PCW_PJTAG_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_PJTAG_PJTAG_IO {<Select>} \
        CONFIG.PCW_PLL_BYPASSMODE_ENABLE {0} \
        CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
        CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
        CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} \
        CONFIG.PCW_QSPI_GRP_FBCLK_IO {MIO 8} \
        CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0} \
        CONFIG.PCW_QSPI_GRP_IO1_IO {<Select>} \
        CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
        CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
        CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} \
        CONFIG.PCW_QSPI_GRP_SS1_IO {<Select>} \
        CONFIG.PCW_QSPI_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0 {5} \
        CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200.000000} \
        CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
        CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
        CONFIG.PCW_SD0_GRP_CD_IO {MIO 46} \
        CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
        CONFIG.PCW_SD0_GRP_POW_IO {<Select>} \
        CONFIG.PCW_SD0_GRP_WP_ENABLE {0} \
        CONFIG.PCW_SD0_GRP_WP_IO {<Select>} \
        CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
        CONFIG.PCW_SD1_GRP_CD_ENABLE {1} \
        CONFIG.PCW_SD1_GRP_CD_IO {EMIO} \
        CONFIG.PCW_SD1_GRP_POW_ENABLE {0} \
        CONFIG.PCW_SD1_GRP_POW_IO {<Select>} \
        CONFIG.PCW_SD1_GRP_WP_ENABLE {0} \
        CONFIG.PCW_SD1_GRP_WP_IO {<Select>} \
        CONFIG.PCW_SD1_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_SD1_SD1_IO {MIO 10 .. 15} \
        CONFIG.PCW_SDIO_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0 {20} \
        CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
        CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} \
        CONFIG.PCW_SMC_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_SMC_PERIPHERAL_FREQMHZ {100} \
        CONFIG.PCW_SPI0_GRP_SS0_ENABLE {0} \
        CONFIG.PCW_SPI0_GRP_SS0_IO {<Select>} \
        CONFIG.PCW_SPI0_GRP_SS1_ENABLE {0} \
        CONFIG.PCW_SPI0_GRP_SS1_IO {<Select>} \
        CONFIG.PCW_SPI0_GRP_SS2_ENABLE {0} \
        CONFIG.PCW_SPI0_GRP_SS2_IO {<Select>} \
        CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_SPI0_SPI0_IO {<Select>} \
        CONFIG.PCW_SPI1_GRP_SS0_ENABLE {0} \
        CONFIG.PCW_SPI1_GRP_SS0_IO {<Select>} \
        CONFIG.PCW_SPI1_GRP_SS1_ENABLE {0} \
        CONFIG.PCW_SPI1_GRP_SS1_IO {<Select>} \
        CONFIG.PCW_SPI1_GRP_SS2_ENABLE {0} \
        CONFIG.PCW_SPI1_GRP_SS2_IO {<Select>} \
        CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_SPI1_SPI1_IO {<Select>} \
        CONFIG.PCW_SPI_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_SPI_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_SPI_PERIPHERAL_FREQMHZ {166.666666} \
        CONFIG.PCW_S_AXI_HP0_DATA_WIDTH {64} \
        CONFIG.PCW_S_AXI_HP1_DATA_WIDTH {64} \
        CONFIG.PCW_S_AXI_HP2_DATA_WIDTH {64} \
        CONFIG.PCW_S_AXI_HP3_DATA_WIDTH {64} \
        CONFIG.PCW_TPIU_PERIPHERAL_CLKSRC {External} \
        CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_TPIU_PERIPHERAL_FREQMHZ {200} \
        CONFIG.PCW_TRACE_GRP_16BIT_ENABLE {0} \
        CONFIG.PCW_TRACE_GRP_16BIT_IO {<Select>} \
        CONFIG.PCW_TRACE_GRP_2BIT_ENABLE {0} \
        CONFIG.PCW_TRACE_GRP_2BIT_IO {<Select>} \
        CONFIG.PCW_TRACE_GRP_32BIT_ENABLE {0} \
        CONFIG.PCW_TRACE_GRP_32BIT_IO {<Select>} \
        CONFIG.PCW_TRACE_GRP_4BIT_ENABLE {0} \
        CONFIG.PCW_TRACE_GRP_4BIT_IO {<Select>} \
        CONFIG.PCW_TRACE_GRP_8BIT_ENABLE {0} \
        CONFIG.PCW_TRACE_GRP_8BIT_IO {<Select>} \
        CONFIG.PCW_TRACE_INTERNAL_WIDTH {2} \
        CONFIG.PCW_TRACE_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_TRACE_TRACE_IO {<Select>} \
        CONFIG.PCW_TTC0_CLK0_PERIPHERAL_CLKSRC {CPU_1X} \
        CONFIG.PCW_TTC0_CLK0_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_TTC0_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
        CONFIG.PCW_TTC0_CLK1_PERIPHERAL_CLKSRC {CPU_1X} \
        CONFIG.PCW_TTC0_CLK1_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_TTC0_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
        CONFIG.PCW_TTC0_CLK2_PERIPHERAL_CLKSRC {CPU_1X} \
        CONFIG.PCW_TTC0_CLK2_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_TTC0_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
        CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_TTC0_TTC0_IO {EMIO} \
        CONFIG.PCW_TTC1_CLK0_PERIPHERAL_CLKSRC {CPU_1X} \
        CONFIG.PCW_TTC1_CLK0_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_TTC1_CLK0_PERIPHERAL_FREQMHZ {133.333333} \
        CONFIG.PCW_TTC1_CLK1_PERIPHERAL_CLKSRC {CPU_1X} \
        CONFIG.PCW_TTC1_CLK1_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_TTC1_CLK1_PERIPHERAL_FREQMHZ {133.333333} \
        CONFIG.PCW_TTC1_CLK2_PERIPHERAL_CLKSRC {CPU_1X} \
        CONFIG.PCW_TTC1_CLK2_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_TTC1_CLK2_PERIPHERAL_FREQMHZ {133.333333} \
        CONFIG.PCW_TTC1_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_TTC1_TTC1_IO {<Select>} \
        CONFIG.PCW_TTC_PERIPHERAL_FREQMHZ {50} \
        CONFIG.PCW_UART0_BAUD_RATE {115200} \
        CONFIG.PCW_UART0_GRP_FULL_ENABLE {0} \
        CONFIG.PCW_UART0_GRP_FULL_IO {<Select>} \
        CONFIG.PCW_UART0_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_UART0_UART0_IO {<Select>} \
        CONFIG.PCW_UART1_BAUD_RATE {115200} \
        CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} \
        CONFIG.PCW_UART1_GRP_FULL_IO {<Select>} \
        CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
        CONFIG.PCW_UART_PERIPHERAL_CLKSRC {IO PLL} \
        CONFIG.PCW_UART_PERIPHERAL_DIVISOR0 {20} \
        CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {50} \
        CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
        CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {533.333374} \
        CONFIG.PCW_UIPARAM_DDR_ADV_ENABLE {0} \
        CONFIG.PCW_UIPARAM_DDR_AL {0} \
        CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} \
        CONFIG.PCW_UIPARAM_DDR_BL {8} \
        CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.240} \
        CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.238} \
        CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.283} \
        CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.284} \
        CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {32 Bit} \
        CONFIG.PCW_UIPARAM_DDR_CL {7} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_0_LENGTH_MM {33.621} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH {73.818} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PROPOGATION_DELAY {160} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_1_LENGTH_MM {33.621} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH {73.818} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PROPOGATION_DELAY {160} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_2_LENGTH_MM {48.166} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH {73.818} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PROPOGATION_DELAY {160} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_3_LENGTH_MM {48.166} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH {73.818} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PROPOGATION_DELAY {160} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_STOP_EN {0} \
        CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} \
        CONFIG.PCW_UIPARAM_DDR_CWL {6} \
        CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {4096 MBits} \
        CONFIG.PCW_UIPARAM_DDR_DQS_0_LENGTH_MM {38.200} \
        CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH {78.217} \
        CONFIG.PCW_UIPARAM_DDR_DQS_0_PROPOGATION_DELAY {160} \
        CONFIG.PCW_UIPARAM_DDR_DQS_1_LENGTH_MM {38.692} \
        CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH {70.543} \
        CONFIG.PCW_UIPARAM_DDR_DQS_1_PROPOGATION_DELAY {160} \
        CONFIG.PCW_UIPARAM_DDR_DQS_2_LENGTH_MM {38.778} \
        CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH {76.039} \
        CONFIG.PCW_UIPARAM_DDR_DQS_2_PROPOGATION_DELAY {160} \
        CONFIG.PCW_UIPARAM_DDR_DQS_3_LENGTH_MM {38.635} \
        CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH {96.0285} \
        CONFIG.PCW_UIPARAM_DDR_DQS_3_PROPOGATION_DELAY {160} \
        CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {-0.036} \
        CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {-0.036} \
        CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.058} \
        CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.057} \
        CONFIG.PCW_UIPARAM_DDR_DQ_0_LENGTH_MM {38.671} \
        CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH {71.836} \
        CONFIG.PCW_UIPARAM_DDR_DQ_0_PROPOGATION_DELAY {160} \
        CONFIG.PCW_UIPARAM_DDR_DQ_1_LENGTH_MM {38.635} \
        CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH {87.0105} \
        CONFIG.PCW_UIPARAM_DDR_DQ_1_PROPOGATION_DELAY {160} \
        CONFIG.PCW_UIPARAM_DDR_DQ_2_LENGTH_MM {38.671} \
        CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH {93.232} \
        CONFIG.PCW_UIPARAM_DDR_DQ_2_PROPOGATION_DELAY {160} \
        CONFIG.PCW_UIPARAM_DDR_DQ_3_LENGTH_MM {38.679} \
        CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH {100.6725} \
        CONFIG.PCW_UIPARAM_DDR_DQ_3_PROPOGATION_DELAY {160} \
        CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
        CONFIG.PCW_UIPARAM_DDR_ECC {Disabled} \
        CONFIG.PCW_UIPARAM_DDR_ENABLE {1} \
        CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {533.333333} \
        CONFIG.PCW_UIPARAM_DDR_HIGH_TEMP {Normal (0-85)} \
        CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE {DDR 3 (Low Voltage)} \
        CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125} \
        CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {15} \
        CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} \
        CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
        CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
        CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
        CONFIG.PCW_UIPARAM_DDR_T_FAW {40.0} \
        CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {35.0} \
        CONFIG.PCW_UIPARAM_DDR_T_RC {48.75} \
        CONFIG.PCW_UIPARAM_DDR_T_RCD {7} \
        CONFIG.PCW_UIPARAM_DDR_T_RP {7} \
        CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {1} \
        CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
        CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ {60} \
        CONFIG.PCW_USB0_RESET_ENABLE {1} \
        CONFIG.PCW_USB0_RESET_IO {MIO 7} \
        CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
        CONFIG.PCW_USB1_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_USB1_PERIPHERAL_FREQMHZ {60} \
        CONFIG.PCW_USB1_RESET_ENABLE {0} \
        CONFIG.PCW_USB1_RESET_IO {<Select>} \
        CONFIG.PCW_USB1_USB1_IO {<Select>} \
        CONFIG.PCW_USB_RESET_ENABLE {1} \
        CONFIG.PCW_USB_RESET_POLARITY {Active Low} \
        CONFIG.PCW_USB_RESET_SELECT {Share reset pin} \
        CONFIG.PCW_USE_CROSS_TRIGGER {0} \
        CONFIG.PCW_USE_M_AXI_GP0 {1} \
        CONFIG.PCW_USE_M_AXI_GP1 {0} \
        CONFIG.PCW_USE_S_AXI_HP0 {1} \
        CONFIG.PCW_WDT_PERIPHERAL_CLKSRC {CPU_1X} \
        CONFIG.PCW_WDT_PERIPHERAL_DIVISOR0 {1} \
        CONFIG.PCW_WDT_PERIPHERAL_ENABLE {0} \
        CONFIG.PCW_WDT_PERIPHERAL_FREQMHZ {133.333333} \
        CONFIG.PCW_WDT_WDT_IO {<Select>} \
    ] $processing_system7_0

    # Need to retain value_src of defaults
    set_property -dict [ list \
        CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ARMPLL_CTRL_FBDIV.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN0_CAN0_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN0_GRP_CLK_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN0_GRP_CLK_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN0_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN1_CAN1_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN1_GRP_CLK_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN1_GRP_CLK_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CAN_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CLK0_FREQ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CLK1_FREQ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CLK2_FREQ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CLK3_FREQ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CPU_CPU_6X4X_MAX_RANGE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CPU_CPU_PLL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DCI_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DCI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDRPLL_CTRL_FBDIV.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_DDR_PLL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_HPRLPR_QUEUE_PARTITION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_HPR_TO_CRITICAL_PRIORITY_LEVEL.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_LPR_TO_CRITICAL_PRIORITY_LEVEL.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PORT0_HPR_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PORT1_HPR_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PORT2_HPR_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PORT3_HPR_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PRIORITY_READPORT_0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PRIORITY_READPORT_1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PRIORITY_READPORT_2.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PRIORITY_READPORT_3.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PRIORITY_WRITEPORT_0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PRIORITY_WRITEPORT_1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PRIORITY_WRITEPORT_2.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_PRIORITY_WRITEPORT_3.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_DDR_WRITE_TO_CRITICAL_PRIORITY_LEVEL.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET0_RESET_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET1_ENET1_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET1_GRP_MDIO_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET1_GRP_MDIO_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET1_RESET_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET1_RESET_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET_RESET_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET_RESET_POLARITY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_ENET_RESET_SELECT.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_EN_4K_TIMER.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_EN_EMIO_CD_SDIO1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_EN_EMIO_TTC0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_EN_ENET0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_EN_QSPI.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_EN_SDIO0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_EN_SDIO1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_EN_TTC0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_EN_UART1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_EN_USB0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FPGA_FCLK0_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FPGA_FCLK1_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FPGA_FCLK2_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FTM_CTI_IN0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FTM_CTI_IN1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FTM_CTI_IN2.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FTM_CTI_IN3.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FTM_CTI_OUT0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FTM_CTI_OUT1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FTM_CTI_OUT2.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_FTM_CTI_OUT3.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_GPIO_EMIO_GPIO_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_GPIO_MIO_GPIO_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C0_GRP_INT_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C0_GRP_INT_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C0_I2C0_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C0_RESET_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C0_RESET_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C1_GRP_INT_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C1_GRP_INT_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C1_I2C1_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C1_RESET_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C1_RESET_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C_RESET_POLARITY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_I2C_RESET_SELECT.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_IOPLL_CTRL_FBDIV.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_IO_IO_PLL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_0_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_0_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_10_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_10_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_11_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_11_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_12_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_12_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_13_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_13_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_14_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_14_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_15_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_15_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_16_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_16_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_17_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_17_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_18_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_18_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_19_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_19_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_1_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_1_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_20_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_20_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_21_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_21_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_22_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_22_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_23_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_23_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_24_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_24_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_25_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_25_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_26_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_26_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_27_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_27_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_28_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_28_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_29_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_29_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_2_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_2_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_30_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_30_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_31_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_31_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_32_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_32_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_33_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_33_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_34_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_34_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_35_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_35_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_36_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_36_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_37_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_37_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_38_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_38_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_39_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_39_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_3_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_3_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_40_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_40_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_41_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_41_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_42_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_42_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_43_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_43_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_44_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_44_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_45_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_45_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_46_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_46_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_47_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_47_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_48_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_48_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_49_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_49_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_4_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_4_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_50_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_50_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_51_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_51_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_52_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_52_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_53_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_53_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_5_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_5_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_6_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_6_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_7_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_7_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_8_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_8_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_9_DIRECTION.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_9_IOTYPE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_TREE_PERIPHERALS.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_MIO_TREE_SIGNALS.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NAND_CYCLES_T_AR.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NAND_CYCLES_T_CLR.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NAND_CYCLES_T_RC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NAND_CYCLES_T_REA.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NAND_CYCLES_T_RR.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NAND_CYCLES_T_WC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NAND_CYCLES_T_WP.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NAND_GRP_D8_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NAND_GRP_D8_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NAND_NAND_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NAND_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS0_T_CEOE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS0_T_PC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS0_T_RC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS0_T_TR.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS0_T_WC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS0_T_WP.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS0_WE_TIME.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS1_T_CEOE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS1_T_PC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS1_T_RC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS1_T_TR.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS1_T_WC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS1_T_WP.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_CS1_WE_TIME.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_GRP_A25_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_GRP_A25_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_GRP_CS0_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_GRP_CS0_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_GRP_CS1_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_GRP_CS1_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_GRP_SRAM_CS0_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_GRP_SRAM_CS0_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_GRP_SRAM_CS1_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_GRP_SRAM_CS1_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_GRP_SRAM_INT_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_GRP_SRAM_INT_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_NOR_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS0_T_CEOE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS0_T_PC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS0_T_RC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS0_T_TR.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS0_T_WC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS0_T_WP.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS0_WE_TIME.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS1_T_CEOE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS1_T_PC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS1_T_RC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS1_T_TR.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS1_T_WC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS1_T_WP.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_NOR_SRAM_CS1_WE_TIME.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PCAP_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PCAP_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PERIPHERAL_BOARD_PRESET.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PJTAG_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PJTAG_PJTAG_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_PLL_BYPASSMODE_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_QSPI_GRP_IO1_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_QSPI_GRP_IO1_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_QSPI_GRP_SS1_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_QSPI_GRP_SS1_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_QSPI_QSPI_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SD0_GRP_POW_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SD0_GRP_POW_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SD0_GRP_WP_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SD1_GRP_CD_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SD1_GRP_POW_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SD1_GRP_POW_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SD1_GRP_WP_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SDIO_PERIPHERAL_VALID.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SMC_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SMC_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI0_GRP_SS0_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI0_GRP_SS0_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI0_GRP_SS1_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI0_GRP_SS1_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI0_GRP_SS2_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI0_GRP_SS2_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI0_SPI0_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI1_GRP_SS0_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI1_GRP_SS0_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI1_GRP_SS1_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI1_GRP_SS1_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI1_GRP_SS2_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI1_GRP_SS2_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI1_SPI1_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_SPI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_S_AXI_HP0_DATA_WIDTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_S_AXI_HP1_DATA_WIDTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_S_AXI_HP2_DATA_WIDTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_S_AXI_HP3_DATA_WIDTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TPIU_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TPIU_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_GRP_16BIT_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_GRP_16BIT_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_GRP_2BIT_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_GRP_2BIT_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_GRP_32BIT_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_GRP_32BIT_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_GRP_4BIT_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_GRP_4BIT_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_GRP_8BIT_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_GRP_8BIT_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_INTERNAL_WIDTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TRACE_TRACE_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC0_CLK0_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC0_CLK1_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC0_CLK2_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC1_CLK0_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC1_CLK0_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC1_CLK0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC1_CLK1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC1_CLK1_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC1_CLK1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC1_CLK2_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC1_CLK2_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC1_CLK2_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC1_TTC1_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_TTC_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UART0_BAUD_RATE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UART0_GRP_FULL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UART0_GRP_FULL_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UART0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UART0_UART0_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UART1_BAUD_RATE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UART1_GRP_FULL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UART1_GRP_FULL_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UART_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UART_PERIPHERAL_VALID.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_ADV_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_AL.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_CL.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_CLOCK_STOP_EN.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQS_0_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQS_1_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQS_2_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQS_3_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQ_0_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQ_1_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQ_2_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_DQ_3_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_ECC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_HIGH_TEMP.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_T_RCD.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_UIPARAM_DDR_T_RP.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_USB1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_USB1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_USB1_RESET_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_USB1_RESET_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_USB1_USB1_IO.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_USB_RESET_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_USB_RESET_POLARITY.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_USB_RESET_SELECT.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_USE_CROSS_TRIGGER.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_WDT_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_WDT_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_WDT_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_WDT_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
        CONFIG.PCW_WDT_WDT_IO.VALUE_SRC {DEFAULT} \
    ] $processing_system7_0

    # Create instance: processing_system7_0_axi_periph, and set properties
    set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect processing_system7_0_axi_periph ]
    set_property -dict [ list \
        CONFIG.NUM_MI {7} \
    ] $processing_system7_0_axi_periph

    # Create instance: rst_processing_system7_0_148_5M, and set properties
    set rst_processing_system7_0_148_5M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_processing_system7_0_148_5M ]

    # Create instance: rst_processing_system7_0_149M, and set properties
    set rst_processing_system7_0_149M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_processing_system7_0_149M ]

    # Create instance: rst_processing_system7_0_76M, and set properties
    set rst_processing_system7_0_76M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset rst_processing_system7_0_76M ]

    # Create instance: v_axi4s_vid_out_0, and set properties
    set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out v_axi4s_vid_out_0 ]
    set_property -dict [ list \
        CONFIG.C_HAS_ASYNC_CLK {1} \
        CONFIG.C_VTG_MASTER_SLAVE {1} \
    ] $v_axi4s_vid_out_0

    # Create instance: v_cfa_0, and set properties
    #set v_cfa_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_cfa v_cfa_0 ]
    set v_cfa_0 [get_bd_cells v_cfa_0]
    set_property -dict [ list \
        CONFIG.ALGORITHM {0} \
        CONFIG.MAX_COLS {1280} \
        CONFIG.MAX_ROWS {1024} \
    ] $v_cfa_0

    # Create instance: v_cresample_0, and set properties
    #set v_cresample_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_cresample v_cresample_0 ]
    set v_cresample_0 [get_bd_cells v_cresample_0]
    set_property -dict [ list \
        CONFIG.active_cols {1280} \
        CONFIG.active_rows {1024} \
        CONFIG.m_axis_video_format {2} \
        CONFIG.s_axis_video_format {3} \
    ] $v_cresample_0

    # Create instance: v_osd_0, and set properties
    #set v_osd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_osd v_osd_0 ]
    set v_osd_0 [get_bd_cells v_osd_0]
    set_property -dict [ list \
        CONFIG.LAYER0_GLOBAL_ALPHA_ENABLE {true} \
        CONFIG.LAYER0_GLOBAL_ALPHA_VALUE {256} \
        CONFIG.LAYER0_HEIGHT {1080} \
        CONFIG.LAYER0_WIDTH {1920} \
        CONFIG.LAYER1_GLOBAL_ALPHA_ENABLE {true} \
        CONFIG.LAYER1_GLOBAL_ALPHA_VALUE {256} \
        CONFIG.LAYER1_HEIGHT {1080} \
        CONFIG.LAYER1_WIDTH {1920} \
        CONFIG.LAYER2_GLOBAL_ALPHA_VALUE {256} \
        CONFIG.LAYER2_PRIORITY {1} \
        CONFIG.LAYER3_GLOBAL_ALPHA_VALUE {256} \
        CONFIG.LAYER3_PRIORITY {1} \
        CONFIG.LAYER4_GLOBAL_ALPHA_VALUE {256} \
        CONFIG.LAYER4_PRIORITY {1} \
        CONFIG.LAYER5_GLOBAL_ALPHA_VALUE {256} \
        CONFIG.LAYER5_PRIORITY {1} \
        CONFIG.LAYER6_GLOBAL_ALPHA_VALUE {256} \
        CONFIG.LAYER6_PRIORITY {1} \
        CONFIG.LAYER7_GLOBAL_ALPHA_VALUE {256} \
        CONFIG.LAYER7_PRIORITY {1} \
        CONFIG.M_AXIS_VIDEO_HEIGHT {1080} \
        CONFIG.M_AXIS_VIDEO_WIDTH {1920} \
        CONFIG.NUMBER_OF_LAYERS {2} \
        CONFIG.SCREEN_WIDTH {1920} \
    ] $v_osd_0

    # Need to retain value_src of defaults
    set_property -dict [ list \
        CONFIG.LAYER0_GLOBAL_ALPHA_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER0_GLOBAL_ALPHA_VALUE.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER1_GLOBAL_ALPHA_ENABLE.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER1_GLOBAL_ALPHA_VALUE.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER2_GLOBAL_ALPHA_VALUE.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER2_PRIORITY.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER3_GLOBAL_ALPHA_VALUE.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER3_PRIORITY.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER4_GLOBAL_ALPHA_VALUE.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER4_PRIORITY.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER5_GLOBAL_ALPHA_VALUE.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER5_PRIORITY.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER6_GLOBAL_ALPHA_VALUE.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER6_PRIORITY.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER7_GLOBAL_ALPHA_VALUE.VALUE_SRC {DEFAULT} \
        CONFIG.LAYER7_PRIORITY.VALUE_SRC {DEFAULT} \
    ] $v_osd_0

    # Create instance: v_rgb2ycrcb_0, and set properties
    #set v_rgb2ycrcb_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_rgb2ycrcb v_rgb2ycrcb_0 ]
    set v_rgb2ycrcb_0 [get_bd_cells v_rgb2ycrcb_0]
    set_property -dict [ list \
        CONFIG.ACTIVE_COLS {1280} \
        CONFIG.ACTIVE_ROWS {1024} \
    ] $v_rgb2ycrcb_0

    # Create instance: v_tc_0, and set properties
    #set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc v_tc_0 ]
    set v_tc_0 [get_bd_cells v_tc_0]
    set_property -dict [ list \
        CONFIG.HAS_AXI4_LITE {false} \
        CONFIG.VIDEO_MODE {1080p} \
        CONFIG.enable_detection {false} \
    ] $v_tc_0

    # Create instance: v_vid_in_axi4s_0, and set properties
    set v_vid_in_axi4s_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s v_vid_in_axi4s_0 ]
    set_property -dict [ list \
        CONFIG.C_HAS_ASYNC_CLK {1} \
        CONFIG.C_M_AXIS_VIDEO_FORMAT {12} \
    ] $v_vid_in_axi4s_0

    # Create instance: v_vid_in_axi4s_1, and set properties
    set v_vid_in_axi4s_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s v_vid_in_axi4s_1 ]
    set_property -dict [ list \
        CONFIG.C_HAS_ASYNC_CLK {1} \
        CONFIG.C_M_AXIS_VIDEO_FORMAT {0} \
    ] $v_vid_in_axi4s_1

    # Create instance: xlconstant_0, and set properties
    set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_0 ]
    set_property -dict [ list \
        CONFIG.CONST_VAL {0} \
    ] $xlconstant_0

    # Create instance: xlconstant_1, and set properties
    set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_1 ]

    # Create interface connections
    connect_bd_intf_net -intf_net IO_CAM_IN_1 [get_bd_intf_ports IO_PYTHON_CAM] [get_bd_intf_pins onsemi_python_cam_0/IO_CAM_IN]
    connect_bd_intf_net -intf_net IO_HDMII_1 [get_bd_intf_ports IO_HDMII] [get_bd_intf_pins avnet_hdmi_in_0/IO_HDMII]
    connect_bd_intf_net -intf_net avnet_hdmi_in_0_VID_IO_OUT [get_bd_intf_pins avnet_hdmi_in_0/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_1/vid_io_in]
    connect_bd_intf_net -intf_net avnet_hdmi_out_0_IO_HDMIO [get_bd_intf_ports IO_HDMIO] [get_bd_intf_pins avnet_hdmi_out_0/IO_HDMIO]
    connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_mem_intercon/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
    connect_bd_intf_net -intf_net axi_vdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S] [get_bd_intf_pins v_osd_0/video_s0_in]
    connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S]
    connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_S2MM [get_bd_intf_pins axi_mem_intercon/S01_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_S2MM]
    connect_bd_intf_net -intf_net axi_vdma_1_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_1/M_AXIS_MM2S] [get_bd_intf_pins v_osd_0/video_s1_in]
    connect_bd_intf_net -intf_net axi_vdma_1_M_AXI_MM2S [get_bd_intf_pins axi_mem_intercon/S02_AXI] [get_bd_intf_pins axi_vdma_1/M_AXI_MM2S]
    connect_bd_intf_net -intf_net axi_vdma_1_M_AXI_S2MM [get_bd_intf_pins axi_mem_intercon/S03_AXI] [get_bd_intf_pins axi_vdma_1/M_AXI_S2MM]
    connect_bd_intf_net -intf_net fmc_hdmi_cam_iic_0_IIC [get_bd_intf_ports fmc_hdmi_cam_iic] [get_bd_intf_pins fmc_hdmi_cam_iic_0/IIC]
    connect_bd_intf_net -intf_net onsemi_python_cam_0_VID_IO_OUT [get_bd_intf_pins onsemi_python_cam_0/VID_IO_OUT] [get_bd_intf_pins v_vid_in_axi4s_0/vid_io_in]
    connect_bd_intf_net -intf_net onsemi_python_spi_0_IO_SPI_OUT [get_bd_intf_ports IO_PYTHON_SPI] [get_bd_intf_pins onsemi_python_spi_0/IO_SPI_OUT]
    #connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
    #connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
    connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
    connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins fmc_hdmi_cam_iic_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
    connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins axi_vdma_0/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
    connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI] [get_bd_intf_pins v_osd_0/ctrl]
    connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins onsemi_python_cam_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]
    connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M04_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M04_AXI] [get_bd_intf_pins v_cfa_0/s_axi_CTRL]
    connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M05_AXI [get_bd_intf_pins axi_vdma_1/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M05_AXI]
    connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M06_AXI [get_bd_intf_pins onsemi_python_spi_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M06_AXI]
    connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins avnet_hdmi_out_0/VID_IO_IN] [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out]
    connect_bd_intf_net -intf_net v_cfa_0_video_out [get_bd_intf_pins v_cfa_0/m_axis_video] [get_bd_intf_pins v_rgb2ycrcb_0/video_in]
    connect_bd_intf_net -intf_net v_cresample_0_video_out [get_bd_intf_pins axi_vdma_1/S_AXIS_S2MM] [get_bd_intf_pins v_cresample_0/video_out]
    connect_bd_intf_net -intf_net v_osd_0_video_out [get_bd_intf_pins v_axi4s_vid_out_0/video_in] [get_bd_intf_pins v_osd_0/video_out]
    connect_bd_intf_net -intf_net v_rgb2ycrcb_0_video_out [get_bd_intf_pins v_cresample_0/video_in] [get_bd_intf_pins v_rgb2ycrcb_0/video_out]
    connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]
    connect_bd_intf_net -intf_net v_vid_in_axi4s_0_video_out [get_bd_intf_pins v_cfa_0/s_axis_video] [get_bd_intf_pins v_vid_in_axi4s_0/video_out]
    connect_bd_intf_net -intf_net v_vid_in_axi4s_1_video_out [get_bd_intf_pins axi_vdma_0/S_AXIS_S2MM] [get_bd_intf_pins v_vid_in_axi4s_1/video_out]

    # Create port connections
    #connect_bd_net -net M_AXI_GP0_ACLK_1 [get_bd_ports M_AXI_GP0_ACLK]
    connect_bd_net -net avnet_hdmi_in_0_audio_spdif [get_bd_pins avnet_hdmi_in_0/audio_spdif] [get_bd_pins avnet_hdmi_out_0/audio_spdif]
    connect_bd_net -net avnet_hdmi_in_0_hdmii_clk [get_bd_pins avnet_hdmi_in_0/hdmii_clk] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_clk]
    connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins avnet_hdmi_out_0/clk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins rst_processing_system7_0_148_5M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk]
    connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins onsemi_python_cam_0/clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
    connect_bd_net -net fmc_hdmi_cam_iic_0_gpo [get_bd_ports fmc_hdmi_cam_iic_rst_n] [get_bd_pins fmc_hdmi_cam_iic_0/gpo]
    connect_bd_net -net fmc_hdmi_cam_vclk_1 [get_bd_ports fmc_hdmi_cam_vclk] [get_bd_pins clk_wiz_0/clk_in1]
    connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axi_vdma_1/s_axi_lite_aclk] [get_bd_pins fmc_hdmi_cam_iic_0/s_axi_aclk] [get_bd_pins onsemi_python_cam_0/s00_axi_aclk] [get_bd_pins onsemi_python_spi_0/s00_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/M06_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_76M/slowest_sync_clk] [get_bd_pins v_osd_0/s_axi_aclk]
    connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_mem_intercon/S01_ACLK] [get_bd_pins axi_mem_intercon/S02_ACLK] [get_bd_pins axi_mem_intercon/S03_ACLK] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_0/s_axis_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_1/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_1/s_axis_s2mm_aclk] [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] [get_bd_pins rst_processing_system7_0_149M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins v_cfa_0/ap_clk] [get_bd_pins v_cresample_0/aclk] [get_bd_pins v_osd_0/aclk] [get_bd_pins v_rgb2ycrcb_0/aclk] [get_bd_pins v_vid_in_axi4s_0/aclk] [get_bd_pins v_vid_in_axi4s_1/aclk]
    connect_bd_net -net processing_system7_0_FCLK_CLK2 [get_bd_pins onsemi_python_cam_0/clk200] [get_bd_pins processing_system7_0/FCLK_CLK2]
    connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_76M/ext_reset_in]
    connect_bd_net -net processing_system7_0_FCLK_RESET1_N [get_bd_pins processing_system7_0/FCLK_RESET1_N] [get_bd_pins rst_processing_system7_0_149M/ext_reset_in]
    connect_bd_net -net processing_system7_0_FCLK_RESET2_N [get_bd_pins processing_system7_0/FCLK_RESET2_N] [get_bd_pins rst_processing_system7_0_148_5M/ext_reset_in]
    connect_bd_net -net rst_processing_system7_0_148_5M_peripheral_aresetn [get_bd_pins rst_processing_system7_0_148_5M/peripheral_aresetn] [get_bd_pins v_tc_0/resetn]
    connect_bd_net -net rst_processing_system7_0_148_5M_peripheral_reset [get_bd_pins onsemi_python_cam_0/reset] [get_bd_pins rst_processing_system7_0_148_5M/peripheral_reset]
    connect_bd_net -net rst_processing_system7_0_149M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_processing_system7_0_149M/interconnect_aresetn]
    connect_bd_net -net rst_processing_system7_0_149M_peripheral_aresetn [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_mem_intercon/S01_ARESETN] [get_bd_pins axi_mem_intercon/S02_ARESETN] [get_bd_pins axi_mem_intercon/S03_ARESETN] [get_bd_pins rst_processing_system7_0_149M/peripheral_aresetn] [get_bd_pins v_cfa_0/ap_rst_n] [get_bd_pins v_cresample_0/aresetn] [get_bd_pins v_osd_0/aresetn] [get_bd_pins v_rgb2ycrcb_0/aresetn]
    connect_bd_net -net rst_processing_system7_0_76M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_76M/interconnect_aresetn]
    connect_bd_net -net rst_processing_system7_0_76M_peripheral_aresetn [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins axi_vdma_1/axi_resetn] [get_bd_pins fmc_hdmi_cam_iic_0/s_axi_aresetn] [get_bd_pins onsemi_python_cam_0/s00_axi_aresetn] [get_bd_pins onsemi_python_spi_0/s00_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M06_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_76M/peripheral_aresetn] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins v_osd_0/s_axi_aresetn] [get_bd_pins v_vid_in_axi4s_0/aresetn]
    connect_bd_net -net rst_processing_system7_0_76M_peripheral_reset [get_bd_pins avnet_hdmi_out_0/reset] [get_bd_pins rst_processing_system7_0_76M/peripheral_reset] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_reset]
    connect_bd_net -net xlconstant_0_dout [get_bd_pins onsemi_python_cam_0/trigger1] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_reset] [get_bd_pins xlconstant_0/dout]
    connect_bd_net -net xlconstant_1_dout [get_bd_pins avnet_hdmi_out_0/embed_syncs] [get_bd_pins avnet_hdmi_out_0/oe] [get_bd_pins onsemi_python_cam_0/oe] [get_bd_pins onsemi_python_spi_0/oe] [get_bd_pins v_axi4s_vid_out_0/aclken] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] [get_bd_pins v_cresample_0/aclken] [get_bd_pins v_osd_0/aclken] [get_bd_pins v_osd_0/s_axi_aclken] [get_bd_pins v_rgb2ycrcb_0/aclken] [get_bd_pins v_tc_0/clken] [get_bd_pins v_tc_0/gen_clken] [get_bd_pins v_vid_in_axi4s_0/aclken] [get_bd_pins v_vid_in_axi4s_0/axis_enable] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_ce] [get_bd_pins v_vid_in_axi4s_1/aclken] [get_bd_pins v_vid_in_axi4s_1/aresetn] [get_bd_pins v_vid_in_axi4s_1/axis_enable] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_ce] [get_bd_pins xlconstant_1/dout]

    # Create address segments
    create_bd_addr_seg -range 0x20000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
    create_bd_addr_seg -range 0x20000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
    create_bd_addr_seg -range 0x20000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_1/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
    create_bd_addr_seg -range 0x20000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_1/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
    create_bd_addr_seg -range 0x00010000 -offset 0x43000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
    create_bd_addr_seg -range 0x00010000 -offset 0x43010000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_1/S_AXI_LITE/Reg] SEG_axi_vdma_1_Reg
    create_bd_addr_seg -range 0x00010000 -offset 0x41600000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs fmc_hdmi_cam_iic_0/S_AXI/Reg] SEG_fmc_hdmi_cam_iic_0_Reg
    create_bd_addr_seg -range 0x00010000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_python_cam_0/S00_AXI/Reg] SEG_onsemi_python_cam_0_Reg
    create_bd_addr_seg -range 0x00010000 -offset 0x43C40000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_python_spi_0/S00_AXI/Reg] SEG_onsemi_python_spi_0_Reg
    create_bd_addr_seg -range 0x00010000 -offset 0x43C30000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cfa_0/s_axi_CTRL/Reg] SEG_v_cfa_0_Reg
    create_bd_addr_seg -range 0x00010000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_osd_0/ctrl/Reg] SEG_v_osd_0_Reg

    # Perform GUI Layout
    regenerate_bd_layout -layout_string {
    guistr: "# # String gsaved with Nlview 6.6.5b  2016-09-06 bk=1.3687 VDI=39 GEI=35 GUI=JA:1.6
    #  -string -flagsOSRD
    preplace port IO_PYTHON_SPI -pg 1 -y 930 -defaultsOSRD
    preplace port DDR -pg 1 -y 40 -defaultsOSRD
    preplace port IO_HDMIO -pg 1 -y 730 -defaultsOSRD
    preplace port M_AXI_GP0_ACLK -pg 1 -y 20 -defaultsOSRD
    preplace port fmc_hdmi_cam_iic -pg 1 -y 1080 -defaultsOSRD
    preplace port IO_PYTHON_CAM -pg 1 -y 1090 -defaultsOSRD
    preplace port FIXED_IO -pg 1 -y 60 -defaultsOSRD
    preplace port fmc_hdmi_cam_vclk -pg 1 -y 1020 -defaultsOSRD
    preplace port IO_HDMII -pg 1 -y 790 -defaultsOSRD
    preplace portBus fmc_hdmi_cam_iic_rst_n -pg 1 -y 1120 -defaultsOSRD
    preplace inst avnet_hdmi_in_0 -pg 1 -lvl 1 -y 790 -defaultsOSRD
    preplace inst v_axi4s_vid_out_0 -pg 1 -lvl 14 -y 740 -defaultsOSRD
    preplace inst rst_processing_system7_0_76M -pg 1 -lvl 2 -y 650 -defaultsOSRD
    preplace inst axi_vdma_0 -pg 1 -lvl 3 -y 870 -defaultsOSRD
    preplace inst v_tc_0 -pg 1 -lvl 13 -y 990 -defaultsOSRD
    preplace inst xlconstant_0 -pg 1 -lvl 1 -y 970 -defaultsOSRD
    preplace inst axi_vdma_1 -pg 1 -lvl 12 -y 720 -defaultsOSRD
    preplace inst v_cfa_0 -pg 1 -lvl 9 -y 910 -defaultsOSRD
    preplace inst xlconstant_1 -pg 1 -lvl 1 -y 890 -defaultsOSRD
    preplace inst rst_processing_system7_0_148_5M -pg 1 -lvl 6 -y 930 -defaultsOSRD
    preplace inst onsemi_python_cam_0 -pg 1 -lvl 7 -y 1150 -defaultsOSRD
    preplace inst fmc_hdmi_cam_iic_0 -pg 1 -lvl 15 -y 1100 -defaultsOSRD
    preplace inst v_osd_0 -pg 1 -lvl 13 -y 670 -defaultsOSRD
    preplace inst v_cresample_0 -pg 1 -lvl 11 -y 960 -defaultsOSRD
    preplace inst rst_processing_system7_0_149M -pg 1 -lvl 3 -y 270 -defaultsOSRD
    preplace inst v_vid_in_axi4s_0 -pg 1 -lvl 8 -y 900 -defaultsOSRD
    preplace inst onsemi_python_spi_0 -pg 1 -lvl 15 -y 930 -defaultsOSRD
    preplace inst v_vid_in_axi4s_1 -pg 1 -lvl 2 -y 860 -defaultsOSRD
    preplace inst clk_wiz_0 -pg 1 -lvl 5 -y 1020 -defaultsOSRD
    preplace inst v_rgb2ycrcb_0 -pg 1 -lvl 10 -y 930 -defaultsOSRD
    preplace inst avnet_hdmi_out_0 -pg 1 -lvl 15 -y 740 -defaultsOSRD
    preplace inst axi_mem_intercon -pg 1 -lvl 4 -y 600 -defaultsOSRD
    preplace inst processing_system7_0_axi_periph -pg 1 -lvl 6 -y 310 -defaultsOSRD
    preplace inst processing_system7_0 -pg 1 -lvl 5 -y 170 -defaultsOSRD
    preplace netloc processing_system7_0_DDR 1 5 11 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ 40 NJ
    preplace netloc xlconstant_1_dout 1 1 14 260 1090 NJ 1090 NJ 1090 NJ 1090 NJ 1090 2220 960 2570 1090 2880 1090 3110 1090 3340 1090 NJ 1090 4030 1090 4290 1090 4620
    preplace netloc rst_processing_system7_0_149M_peripheral_aresetn 1 3 10 1020 830 1390J 750 NJ 750 NJ 750 NJ 750 2840 750 3100 750 3330 750 3590J 860 4020J
    preplace netloc rst_processing_system7_0_149M_interconnect_aresetn 1 3 1 1030
    preplace netloc v_vid_in_axi4s_0_video_out 1 8 1 N
    preplace netloc axi_vdma_1_M_AXI_S2MM 1 3 10 1060 390 1330J 580 NJ 580 NJ 580 NJ 580 NJ 580 NJ 580 NJ 580 NJ 580 3960
    preplace netloc avnet_hdmi_in_0_hdmii_clk 1 1 1 270
    preplace netloc fmc_hdmi_cam_iic_0_IIC 1 15 1 NJ
    preplace netloc processing_system7_0_axi_periph_M03_AXI 1 6 1 2260
    preplace netloc processing_system7_0_axi_periph_M00_AXI 1 6 9 N 250 NJ 250 NJ 250 NJ 250 NJ 250 NJ 250 NJ 250 NJ 250 4600J
    preplace netloc rst_processing_system7_0_76M_peripheral_aresetn 1 2 13 610 750 970J 820 NJ 820 1870 820 2210 210 2560 210 2870 210 NJ 210 NJ 210 3630 210 4010 210 4280 210 4580
    preplace netloc v_axi4s_vid_out_0_vid_io_out 1 14 1 N
    preplace netloc processing_system7_0_M_AXI_GP0 1 5 1 1880
    preplace netloc axi_vdma_1_M_AXI_MM2S 1 3 10 1050 380 1340J 560 NJ 560 NJ 560 NJ 560 NJ 560 NJ 560 NJ 560 NJ 560 3970
    preplace netloc axi_vdma_0_M_AXI_MM2S 1 3 1 980
    preplace netloc processing_system7_0_axi_periph_M05_AXI 1 6 6 NJ 350 NJ 350 NJ 350 NJ 350 NJ 350 3610
    preplace netloc axi_vdma_0_M_AXIS_MM2S 1 3 10 NJ 850 1370J 600 NJ 600 NJ 600 NJ 600 NJ 600 NJ 600 NJ 600 NJ 600 3980
    preplace netloc processing_system7_0_FCLK_RESET0_N 1 1 5 260 360 NJ 360 NJ 360 NJ 360 1820
    preplace netloc v_vid_in_axi4s_1_video_out 1 2 1 N
    preplace netloc v_osd_0_video_out 1 13 1 N
    preplace netloc v_cresample_0_video_out 1 11 1 3570
    preplace netloc axi_mem_intercon_M00_AXI 1 4 1 1320
    preplace netloc processing_system7_0_FCLK_RESET2_N 1 5 1 1840
    preplace netloc processing_system7_0_axi_periph_M02_AXI 1 6 7 NJ 290 NJ 290 NJ 290 NJ 290 NJ 290 NJ 290 4030
    preplace netloc processing_system7_0_FCLK_RESET1_N 1 2 4 640 180 NJ 180 1380J 350 1810
    preplace netloc v_cfa_0_video_out 1 9 1 N
    preplace netloc processing_system7_0_axi_periph_M06_AXI 1 6 9 N 370 NJ 370 NJ 370 NJ 370 NJ 370 NJ 370 NJ 370 NJ 370 4590J
    preplace netloc axi_vdma_1_M_AXIS_MM2S 1 12 1 3980
    preplace netloc xlconstant_0_dout 1 1 6 270 1190 NJ 1190 NJ 1190 NJ 1190 NJ 1190 NJ
    preplace netloc processing_system7_0_FIXED_IO 1 5 11 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ 60 NJ
    preplace netloc rst_processing_system7_0_76M_peripheral_reset 1 2 13 N 650 990J 840 1380J 650 NJ 650 NJ 650 2580 650 NJ 650 NJ 650 NJ 650 3600J 870 NJ 870 4310 870 4560
    preplace netloc clk_wiz_0_clk_out1 1 5 10 1860 730 NJ 730 NJ 730 NJ 730 NJ 730 NJ 730 3580J 960 4040 900 4300 900 4570
    preplace netloc avnet_hdmi_out_0_IO_HDMIO 1 15 1 N
    preplace netloc avnet_hdmi_in_0_VID_IO_OUT 1 1 1 280
    preplace netloc rst_processing_system7_0_76M_interconnect_aresetn 1 2 4 NJ 670 970J 350 1370J 370 1860
    preplace netloc fmc_hdmi_cam_iic_0_gpo 1 15 1 NJ
    preplace netloc clk_wiz_0_clk_out2 1 5 3 NJ 1030 2270 850 N
    preplace netloc v_rgb2ycrcb_0_video_out 1 10 1 N
    preplace netloc onsemi_python_cam_0_VID_IO_OUT 1 7 1 2540
    preplace netloc processing_system7_0_FCLK_CLK0 1 1 14 280 560 630 390 980J 320 1390 400 1880 570 2250 390 NJ 390 2860 390 NJ 390 NJ 390 3620 390 4000 390 NJ 390 4550
    preplace netloc IO_HDMII_1 1 0 1 N
    preplace netloc v_tc_0_vtiming_out 1 13 1 4260
    preplace netloc axi_vdma_0_M_AXI_S2MM 1 3 1 1000
    preplace netloc rst_processing_system7_0_148_5M_peripheral_reset 1 6 1 2230
    preplace netloc rst_processing_system7_0_148_5M_peripheral_aresetn 1 6 7 NJ 970 2530J 1040 NJ 1040 NJ 1040 NJ 1040 NJ 1040 4040
    preplace netloc processing_system7_0_FCLK_CLK1 1 1 13 280 980 620 400 1040 330 1360 710 1830 710 NJ 710 2550 710 2880 710 3110 710 3340 710 3610 840 3990 800 4270
    preplace netloc fmc_hdmi_cam_vclk_1 1 0 5 NJ 1020 NJ 1020 NJ 1020 NJ 1020 NJ
    preplace netloc M_AXI_GP0_ACLK_1 1 0 1 N
    preplace netloc onsemi_python_spi_0_IO_SPI_OUT 1 15 1 NJ
    preplace netloc IO_CAM_IN_1 1 0 7 20J 1080 NJ 1080 NJ 1080 NJ 1080 NJ 1080 NJ 1080 2240J
    preplace netloc processing_system7_0_axi_periph_M04_AXI 1 6 3 NJ 330 NJ 330 2850
    preplace netloc processing_system7_0_axi_periph_M01_AXI 1 2 5 640 370 NJ 370 1350J 550 NJ 550 2200
    preplace netloc processing_system7_0_FCLK_CLK2 1 5 2 1850J 1110 N
    preplace netloc avnet_hdmi_in_0_audio_spdif 1 1 14 260J 740 NJ 740 1010J 810 1340J 740 NJ 740 NJ 740 NJ 740 NJ 740 NJ 740 NJ 740 3560J 880 NJ 880 NJ 880 4610
    levelinfo -pg 1 0 140 450 810 1190 1600 2040 2410 2720 2990 3230 3460 3800 4150 4430 4740 4880 -top 0 -bot 1280
    ",
    }

    # Restore current instance
    current_bd_instance $oldCurInst

    save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""





####### end board specific block diagram #######s

# Add Project source files
puts "***** Adding Source Files to Block Design..."
make_wrapper -files [get_files ${projects_folder}/${project}.srcs/sources_1/bd/${project}/${project}.bd] -top
add_files -norecurse ${projects_folder}/${project}.srcs/sources_1/bd/${project}/hdl/${project}_wrapper.vhd

} else {
    puts "***** open project ${project}"
    open_project ${projects_folder}/${project}.xpr
}
# Build the binary
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
#*- KEEP OUT, do not touch this section unless you know what you are doing! -*
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
if {![file exists ${projects_folder}/${project}.runs/impl_1/${project}_wrapper.bit]} {
puts "***** Generating Hardware implementation..."
# add this to allow up+enter rebuild capability
#cd $scripts_folder
#update_compile_order -fileset sources_1
#update_compile_order -fileset sim_1
#save_bd_design
launch_runs impl_1 -to_step write_bitstream -j 6
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
#*- KEEP OUT, do not touch this section unless you know what you are doing! -*
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
} else {
    puts "**** Hardware already done..."
}


####### make #######

if {[string match -nocase "no" $jtag]} {
    puts "***** Building Binary..."
    #source ./bin_helper.tcl -notrace

    # if using for development, can set this to yes to just use the script
    # to build your project in Vivado
    if {[string match -nocase "no" $close_project]} {
        puts "Not Closing Project..."
    } else {
        set curr_proj [current_project -quiet]
        if {[string match -nocase "" $curr_proj]} {
            puts "Not Closing Project..."
        } else {
            puts "Closing Project..."
            close_project
        }
        unset curr_proj
    }

    # attempt to build SDK portion
    if {[string match -nocase "yes" $sdk]} {
        pwd
        puts "Attempting to Build SDK..."
        cd ${projects_folder}
        # Change starting with 2018.2 (Ultra96v2 validation test, Nov 2018) to use xsct instead of xsdk
        # https://www.xilinx.com/html_docs/xilinx2018_2/SDK_Doc/xsct/use_cases/xsct_howtoruntclscriptfiles.html
        # added the Board variable so it could be used when needed - see uz_petalinux SDK build script for
        # how to use this
        file copy -force ${repo_folder}/myir/$project\_sdk.tcl ./
        exec >@stdout 2>@stderr xsct $project\_sdk.tcl -notrace $board $vivado_ver
        # Build a BOOT.bin file only if a BIF file exists for the project.
        if {[file exists ${repo_folder}/myir/$project\_sd.bif]} {
            file copy -force ${repo_folder}/myir/$project\_sd.bif ./
            puts "Generating BOOT.BIN..."
            exec >@stdout 2>@stderr bootgen -arch $dev_arch -image $project\_sd.bif -w -o BOOT.bin
        }
        cd ${scripts_folder}
    }

    # run Tagging script
    if {[string match -nocase "yes" $tag]} {
        puts "Running Tag"
        source ./tag.tcl -notrace
    } else {
        puts "Not Running Tag"
    }
}
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
