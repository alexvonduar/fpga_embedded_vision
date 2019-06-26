# board=ZCU104 project=fmchc_python1300c sdk=yes version_override=yes

# make.tcl
set debuglevel 0
set scriptdir [pwd]
set board "ZCU104"
set clean "no"
set project "fmchc_python1300c"
set tag "init"
set close_project "no"
set version_override "yes"
set found "false"
set ok_to_tag_public "false"
set sdk "yes"
set jtag "no"
set dev_arch "zynqmp"
set vivado_ver "2019_1"

puts "
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*-                                                     -*
*-        Welcome to the Avnet Project Builder         -*
*-                                                     -*
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
# fetch the required Vivado Board Definition File (BDF) from the bdf git repo
set bdf_path [file normalize ${scriptdir}/../bdf]
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
      puts "sdk=\n 'yes' will attempt to execute:\n ../software/<project_name>_sdk.tcl"
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
      puts "| Clean            |     $printmessage |"
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
set boards_folder [file normalize ${scriptdir}/../avnet/Boards]
set ip_folder [file normalize ${scriptdir}/../avnet/IP]
set projects_folder [file normalize ${scriptdir}/../projects/${project}/${board}_${vivado_ver}]
set scripts_folder [file normalize ${scriptdir}]
set repo_folder [file normalize ${scriptdir}]

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


proc validate_core_licenses { core_list ip_report_filename } {
   set valid_cores 0
   set invalid_cores 0

   puts ""
   puts "+------------------+------------------------------------+"
   puts "| Video IP Core    | License Status                     |"
   puts "+------------------+------------------------------------+"

   foreach core $core_list {

      # Format core name for display
      set core_name $core
      for {set j 0} {$j < [expr 16 - [string length $core]]} {incr j} {
         append core_name " "
      }

      # Search for core license status in ip status report
      set file [open $ip_report_filename r]
      set ip_status ""
      while {[gets $file line] >= 0} {
         if {[regexp $core $line]} {
            set ip_status $line
   		 break
         }
      }
      close $file
      #puts "ip_status = ${ip_status}"

      # Validate and display status of core license
      if {[regexp "Included" ${ip_status}]} {
         puts "| ${core_name} | VALID (Full License)               |"
         incr valid_cores
      } elseif {[regexp "Hardware_E" ${ip_status}]} {
         puts "| ${core_name} | VALID (Hardware Evaluation)        |"
         incr valid_cores
      } elseif {[regexp "Purchased" ${ip_status}]} {
         puts "| ${core_name} | VALID (Purchased)                  |"
         incr valid_cores
      } else {
         puts "| ${core_name} | INVALID                            |"
         incr invalid_cores
      }
      puts "+------------------+------------------------------------+"

   }
   return $valid_cores
}

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

proc avnet_generate_ip {ip_name} {
   puts "Making $ip_name..."
   source ${scriptdir}/../IP/$ip_name/$ip_name.tcl -notrace
   cd ${scriptdir}/../IP/$ip_name
   make_ip $ip_name
   cd ${scriptdir}
}

# Create Vivado project
puts "***** Creating Vivado Project..."
#source ../Boards/$board/[string tolower $board].tcl -notrace
#source ../Boards/$board/$board.tcl -notrace
#avnet_create_project $project $projects_folder $scriptdir

#source ${scripts_folder}/PZ7030_FMC2.tcl
#avnet_create_project $project $projects_folder $scriptdir

create_project $project $projects_folder -part xczu7ev-ffvc1156-2-e -force

#add_files -fileset constrs_1 -norecurse ${scriptdir}/pz7030_fmc2_fmchc_python1300c/PZ7030_7015_RevC_FMCV2_RevA_v1.xdc

remove_files -fileset constrs_1 *.xdc

set_property board_part xilinx.com:zcu104:part0:1.1 [current_project]
add_files -fileset constrs_1 -norecurse ${scriptdir}/zcu104_fmchc_python1300c.xdc

# Add Avnet IP Repository
puts "***** Updating Vivado to include IP Folder"
cd ${projects_folder}
set_property ip_repo_paths  ${ip_folder} [current_fileset]
update_ip_catalog

# Create Block Design and Add PS core
puts "***** Creating Block Design..."
create_bd_design ${project}

source -notrace ${scriptdir}/zcu104_fmchc_python1300_ps.tcl
add_ps_preset processing_system7_0

create_bd_port -dir I -type clk maxihpm0_fpd_aclk
#TODO: connect_bd_net [get_bd_pins /processing_system7_0/maxihpm0_fpd_aclk] [get_bd_ports maxihpm0_fpd_aclk]

# General Config
puts "***** General Configuration for Design..."
set_property target_language VHDL [current_project]

# Enable XPM_FIFO primitives (required for new onsemi_vita_spi/cam) cores
puts "***** Enable XPM_FIFO primitives..."
set_property XPM_LIBRARIES XPM_FIFO [current_project]


# Check for Video IP core licenses
puts "***** Check for Video IP core licenses..."
set v_cfa_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_cfa v_cfa_0 ]
set v_cresample_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_cresample v_cresample_0 ]
set v_osd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_osd v_osd_0 ]
set v_rgb2ycrcb_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_rgb2ycrcb v_rgb2ycrcb_0 ]
set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc v_tc_0 ]
report_ip_status -file "video_ip_core_status.log"
set core_list [list "v_cfa" "v_cresample" "v_osd" "v_rgb2ycrcb" "v_tc" ]
set valid_cores [validate_core_licenses $core_list "video_ip_core_status.log"]
if { $valid_cores < 5 } {
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

set scripts_vivado_version 2016.4
set current_vivado_version [version -short]

# Creating design if needed
set errMsg ""
set nRet 0

  variable script_folder

 
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
  set IO_HDMII [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:avnet_hdmi_rtl:2.0 IO_HDMII ]
  set IO_HDMIO [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:avnet_hdmi_rtl:2.0 IO_HDMIO ]
  set IO_PYTHON_CAM [ create_bd_intf_port -mode Slave -vlnv avnet.com:interface:onsemi_vita_cam_rtl:1.0 IO_PYTHON_CAM ]
  set IO_PYTHON_SPI [ create_bd_intf_port -mode Master -vlnv avnet.com:interface:onsemi_vita_spi_rtl:1.0 IO_PYTHON_SPI ]
  set fmc_hdmi_cam_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 fmc_hdmi_cam_iic ]

  # Create ports
  #set maxihpm0_fpd_aclk [ create_bd_port -dir I -type clk maxihpm0_fpd_aclk ]
  set fmc_hdmi_cam_iic_rst_n [ create_bd_port -dir O -from 0 -to 0 fmc_hdmi_cam_iic_rst_n ]
  set fmc_hdmi_cam_vclk [ create_bd_port -dir I fmc_hdmi_cam_vclk ]

  # Create instance: avnet_hdmi_in_0, and set properties
  set avnet_hdmi_in_0 [ create_bd_cell -type ip -vlnv avnet:avnet_hdmi:avnet_hdmi_in avnet_hdmi_in_0 ]
  set_property -dict [ list \
CONFIG.C_USE_BUFR {true} \
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
CONFIG.active_cols {1280} \
CONFIG.active_rows {1024} \
CONFIG.has_axi4_lite {true} \
CONFIG.max_cols {1280} \
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
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_mem_intercon/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0_FPD]
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
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_HPM0_FPD] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins fmc_hdmi_cam_iic_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins axi_vdma_0/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI] [get_bd_intf_pins v_osd_0/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins onsemi_python_cam_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M04_AXI [get_bd_intf_pins processing_system7_0_axi_periph/M04_AXI] [get_bd_intf_pins v_cfa_0/ctrl]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M05_AXI [get_bd_intf_pins axi_vdma_1/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M06_AXI [get_bd_intf_pins onsemi_python_spi_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net v_axi4s_vid_out_0_vid_io_out [get_bd_intf_pins avnet_hdmi_out_0/VID_IO_IN] [get_bd_intf_pins v_axi4s_vid_out_0/vid_io_out]
  connect_bd_intf_net -intf_net v_cfa_0_video_out [get_bd_intf_pins v_cfa_0/video_out] [get_bd_intf_pins v_rgb2ycrcb_0/video_in]
  connect_bd_intf_net -intf_net v_cresample_0_video_out [get_bd_intf_pins axi_vdma_1/S_AXIS_S2MM] [get_bd_intf_pins v_cresample_0/video_out]
  connect_bd_intf_net -intf_net v_osd_0_video_out [get_bd_intf_pins v_axi4s_vid_out_0/video_in] [get_bd_intf_pins v_osd_0/video_out]
  connect_bd_intf_net -intf_net v_rgb2ycrcb_0_video_out [get_bd_intf_pins v_cresample_0/video_in] [get_bd_intf_pins v_rgb2ycrcb_0/video_out]
  connect_bd_intf_net -intf_net v_tc_0_vtiming_out [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in] [get_bd_intf_pins v_tc_0/vtiming_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_video_out [get_bd_intf_pins v_cfa_0/video_in] [get_bd_intf_pins v_vid_in_axi4s_0/video_out]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_1_video_out [get_bd_intf_pins axi_vdma_0/S_AXIS_S2MM] [get_bd_intf_pins v_vid_in_axi4s_1/video_out]

  # Create port connections
  #connect_bd_net -net maxihpm0_fpd_aclk_1 [get_bd_ports maxihpm0_fpd_aclk]
  connect_bd_net -net avnet_hdmi_in_0_audio_spdif [get_bd_pins avnet_hdmi_in_0/audio_spdif] [get_bd_pins avnet_hdmi_out_0/audio_spdif]
  connect_bd_net -net avnet_hdmi_in_0_hdmii_clk [get_bd_pins avnet_hdmi_in_0/hdmii_clk] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_clk]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins avnet_hdmi_out_0/clk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins rst_processing_system7_0_148_5M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins onsemi_python_cam_0/clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
  connect_bd_net -net fmc_hdmi_cam_iic_0_gpo [get_bd_ports fmc_hdmi_cam_iic_rst_n] [get_bd_pins fmc_hdmi_cam_iic_0/gpo]
  connect_bd_net -net fmc_hdmi_cam_vclk_1 [get_bd_ports fmc_hdmi_cam_vclk] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axi_vdma_1/s_axi_lite_aclk] [get_bd_pins fmc_hdmi_cam_iic_0/s_axi_aclk] [get_bd_pins onsemi_python_cam_0/s00_axi_aclk] [get_bd_pins onsemi_python_spi_0/s00_axi_aclk] [get_bd_pins processing_system7_0/pl_clk0] [get_bd_pins processing_system7_0/maxihpm0_fpd_aclk] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/M06_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_76M/slowest_sync_clk] [get_bd_pins v_cfa_0/s_axi_aclk] [get_bd_pins v_osd_0/s_axi_aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_mem_intercon/S01_ACLK] [get_bd_pins axi_mem_intercon/S02_ACLK] [get_bd_pins axi_mem_intercon/S03_ACLK] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_0/s_axis_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_1/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_1/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_1/s_axis_s2mm_aclk] [get_bd_pins processing_system7_0/pl_clk1] [get_bd_pins processing_system7_0/saxihp0_fpd_aclk] [get_bd_pins rst_processing_system7_0_149M/slowest_sync_clk] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_cfa_0/aclk] [get_bd_pins v_cresample_0/aclk] [get_bd_pins v_osd_0/aclk] [get_bd_pins v_rgb2ycrcb_0/aclk] [get_bd_pins v_vid_in_axi4s_0/aclk] [get_bd_pins v_vid_in_axi4s_1/aclk]
  connect_bd_net -net processing_system7_0_FCLK_CLK2 [get_bd_pins onsemi_python_cam_0/clk200] [get_bd_pins processing_system7_0/pl_clk2]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/pl_resetn0] [get_bd_pins rst_processing_system7_0_76M/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET1_N [get_bd_pins processing_system7_0/pl_resetn1] [get_bd_pins rst_processing_system7_0_149M/ext_reset_in]
  connect_bd_net -net processing_system7_0_FCLK_RESET2_N [get_bd_pins processing_system7_0/pl_resetn2] [get_bd_pins rst_processing_system7_0_148_5M/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_148_5M_peripheral_aresetn [get_bd_pins rst_processing_system7_0_148_5M/peripheral_aresetn] [get_bd_pins v_tc_0/resetn]
  connect_bd_net -net rst_processing_system7_0_148_5M_peripheral_reset [get_bd_pins onsemi_python_cam_0/reset] [get_bd_pins rst_processing_system7_0_148_5M/peripheral_reset]
  connect_bd_net -net rst_processing_system7_0_149M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins rst_processing_system7_0_149M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_149M_peripheral_aresetn [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_mem_intercon/S01_ARESETN] [get_bd_pins axi_mem_intercon/S02_ARESETN] [get_bd_pins axi_mem_intercon/S03_ARESETN] [get_bd_pins rst_processing_system7_0_149M/peripheral_aresetn] [get_bd_pins v_cfa_0/aresetn] [get_bd_pins v_cresample_0/aresetn] [get_bd_pins v_osd_0/aresetn] [get_bd_pins v_rgb2ycrcb_0/aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_76M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_peripheral_aresetn [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins axi_vdma_1/axi_resetn] [get_bd_pins fmc_hdmi_cam_iic_0/s_axi_aresetn] [get_bd_pins onsemi_python_cam_0/s00_axi_aresetn] [get_bd_pins onsemi_python_spi_0/s00_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M06_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_76M/peripheral_aresetn] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins v_cfa_0/s_axi_aresetn] [get_bd_pins v_osd_0/s_axi_aresetn] [get_bd_pins v_vid_in_axi4s_0/aresetn]
  connect_bd_net -net rst_processing_system7_0_76M_peripheral_reset [get_bd_pins avnet_hdmi_out_0/reset] [get_bd_pins rst_processing_system7_0_76M/peripheral_reset] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_reset]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins onsemi_python_cam_0/trigger1] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_reset] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins avnet_hdmi_out_0/embed_syncs] [get_bd_pins avnet_hdmi_out_0/oe] [get_bd_pins onsemi_python_cam_0/oe] [get_bd_pins onsemi_python_spi_0/oe] [get_bd_pins v_axi4s_vid_out_0/aclken] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] [get_bd_pins v_cfa_0/aclken] [get_bd_pins v_cfa_0/s_axi_aclken] [get_bd_pins v_cresample_0/aclken] [get_bd_pins v_osd_0/aclken] [get_bd_pins v_osd_0/s_axi_aclken] [get_bd_pins v_rgb2ycrcb_0/aclken] [get_bd_pins v_tc_0/clken] [get_bd_pins v_tc_0/gen_clken] [get_bd_pins v_vid_in_axi4s_0/aclken] [get_bd_pins v_vid_in_axi4s_0/axis_enable] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_ce] [get_bd_pins v_vid_in_axi4s_1/aclken] [get_bd_pins v_vid_in_axi4s_1/aresetn] [get_bd_pins v_vid_in_axi4s_1/axis_enable] [get_bd_pins v_vid_in_axi4s_1/vid_io_in_ce] [get_bd_pins xlconstant_1/dout]


  # Create address segments
create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_DDR_HIGH] SEG_processing_system7_0_HP0_DDR_HIGH
create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_DDR_LOW] SEG_processing_system7_0_HP0_DDR_LOW
create_bd_addr_seg -range 0x00040000 -offset 0xFFFC0000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_LPS_OCM] SEG_processing_system7_0_HP0_DDR_OCM
create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_QSPI] SEG_processing_system7_0_HP0_QSPI

create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_DDR_HIGH] SEG_processing_system7_0_HP0_DDR_HIGH
create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_DDR_LOW] SEG_processing_system7_0_HP0_DDR_LOWOCM
create_bd_addr_seg -range 0x00040000 -offset 0xFFFC0000 [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_LPS_OCM] SEG_processing_system7_0_HP0_DDR_OCM
create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_QSPI] SEG_processing_system7_0_HP0_QSPI

create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces axi_vdma_1/Data_MM2S] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_DDR_HIGH] SEG_processing_system7_0_HP0_DDR_HIGH
create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_1/Data_MM2S] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_DDR_LOW] SEG_processing_system7_0_HP0_DDR_LOWOCM
create_bd_addr_seg -range 0x00040000 -offset 0xFFFC0000 [get_bd_addr_spaces axi_vdma_1/Data_MM2S] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_LPS_OCM] SEG_processing_system7_0_HP0_DDR_OCM
create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces axi_vdma_1/Data_MM2S] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_QSPI] SEG_processing_system7_0_HP0_QSPI

create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces axi_vdma_1/Data_S2MM] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_DDR_HIGH] SEG_processing_system7_0_HP0_DDR_HIGH
create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces axi_vdma_1/Data_S2MM] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_DDR_LOW] SEG_processing_system7_0_HP0_DDR_LOWOCM
create_bd_addr_seg -range 0x00040000 -offset 0xFFFC0000 [get_bd_addr_spaces axi_vdma_1/Data_S2MM] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_LPS_OCM] SEG_processing_system7_0_HP0_DDR_OCM
create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces axi_vdma_1/Data_S2MM] [get_bd_addr_segs processing_system7_0/SAXIGP2/HP0_QSPI] SEG_processing_system7_0_HP0_QSPI

create_bd_addr_seg -range 0x00010000 -offset 0xA0010000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
create_bd_addr_seg -range 0x00010000 -offset 0xA0020000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_1/S_AXI_LITE/Reg] SEG_axi_vdma_1_Reg
create_bd_addr_seg -range 0x00010000 -offset 0xA0000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs fmc_hdmi_cam_iic_0/S_AXI/Reg] SEG_fmc_hdmi_cam_iic_0_Reg
create_bd_addr_seg -range 0x00010000 -offset 0xA0040000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_python_cam_0/S00_AXI/Reg] SEG_onsemi_python_cam_0_Reg
create_bd_addr_seg -range 0x00010000 -offset 0xA0050000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs onsemi_python_spi_0/S00_AXI/Reg] SEG_onsemi_python_spi_0_Reg
create_bd_addr_seg -range 0x00010000 -offset 0xA0060000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_cfa_0/ctrl/Reg] SEG_v_cfa_0_Reg
create_bd_addr_seg -range 0x00010000 -offset 0xA0030000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_osd_0/ctrl/Reg] SEG_v_osd_0_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.6.5b  2016-09-06 bk=1.3687 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port IO_PYTHON_SPI -pg 1 -y 930 -defaultsOSRD
preplace port DDR -pg 1 -y 40 -defaultsOSRD
preplace port IO_HDMIO -pg 1 -y 730 -defaultsOSRD
preplace port maxihpm0_fpd_aclk -pg 1 -y 20 -defaultsOSRD
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
preplace netloc maxihpm0_fpd_aclk_1 1 0 1 N
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

# Add Project source files
puts "***** Adding Source Files to Block Design..."
make_wrapper -files [get_files ${projects_folder}/${project}.srcs/sources_1/bd/${project}/${project}.bd] -top
add_files -norecurse ${projects_folder}/${project}.srcs/sources_1/bd/${project}/hdl/${project}_wrapper.vhd

# Build the binary
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
#*- KEEP OUT, do not touch this section unless you know what you are doing! -*
#*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
puts "***** Building Binary..."
# add this to allow up+enter rebuild capability
cd $scripts_folder
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
save_bd_design
launch_runs impl_1 -to_step write_bitstream -j 4


if {[string match -nocase "no" $jtag]} {
   puts "Generating Binary..."
   source ${scriptdir}/../avnet/Scripts/bin_helper.tcl -notrace

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
      puts "Attempting to Build SDK..."
      cd ${projects_folder}
      # Change starting with 2018.2 (Ultra96v2 validation test, Nov 2018) to use xsct instead of xsdk
      # https://www.xilinx.com/html_docs/xilinx2018_2/SDK_Doc/xsct/use_cases/xsct_howtoruntclscriptfiles.html
      exec >@stdout 2>@stderr xsct ${scripts_folder}/../avnet/Projects/${projects}/software/zcu104_$project\_sdk.tcl -notrace
      # Build a BOOT.bin file only if a BIF file exists for the project.
      if {[file exists ${scripts_folder}/../avnet/Projects/${projects}/software/zcu104_$project\_sd.bif]} {
         puts "Generating BOOT.BIN..."
         exec >@stdout 2>@stderr bootgen -arch $dev_arch -image ${scripts_folder}/../avnet/Projects/${projects}/software/zcu104_$project\_sd.bif -w -o BOOT.bin
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
