
################################################################
# This is a generated script based on design: system_basic
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
set scripts_vivado_version 2019.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   common::send_msg_id "BD_TCL-1002" "WARNING" "This script was generated using Vivado <$scripts_vivado_version> without IP versions in the create_bd_cell commands, but is now being run in <$current_vivado_version> of Vivado. There may have been major IP version changes between Vivado <$scripts_vivado_version> and <$current_vivado_version>, which could impact the parameter settings of the IPs."

}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_basic_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# compact_gt_ctrl

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu7ev-ffvc1156-2-e
   set_property BOARD_PART xilinx.com:zcu106:part0:2.3 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name system_basic

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

  # Add USER_COMMENTS on $design_name
  set_property USER_COMMENTS.comment_0 "Zynq UltraScale+ SDI TRD" [get_bd_designs $design_name]

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:util_ds_buf:*\
xilinx.com:ip:axi_gpio:*\
xilinx.com:ip:xlslice:*\
xilinx.com:ip:vcu:*\
xilinx.com:ip:xlconstant:*\
xilinx.com:ip:audio_formatter:*\
xilinx.com:ip:proc_sys_reset:*\
xilinx.com:ip:v_uhdsdi_audio:*\
xilinx.com:ip:xlconcat:*\
xilinx.com:ip:util_vector_logic:*\
xilinx.com:ip:v_frmbuf_wr:*\
xilinx.com:ip:v_proc_ss:*\
xilinx.com:ip:v_smpte_uhdsdi_rx_ss:*\
xilinx.com:ip:axis_subset_converter:*\
xilinx.com:ip:v_frmbuf_rd:*\
xilinx.com:ip:v_mix:*\
xilinx.com:ip:v_smpte_uhdsdi_tx_ss:*\
xilinx.com:ip:clk_wiz:*\
xilinx.com:ip:zynq_ultra_ps_e:*\
xilinx.com:ip:uhdsdi_gt:*\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
compact_gt_ctrl\
"

   set list_mods_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_msg_id "BD_TCL-008" "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: compact_gt
proc create_hier_cell_compact_gt { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_compact_gt() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 intf_0_ctrl_sb_rx

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 intf_0_ctrl_sb_tx

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 intf_0_rx_axi4s_ch0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 intf_0_stat_sb_rx

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 intf_0_stat_sb_tx

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 intf_0_tx_axi4s_ch0


  # Create pins
  create_bd_pin -dir I -from 63 -to 0 cmp_gt_ctrl
  create_bd_pin -dir O -from 63 -to 0 cmp_gt_sts
  create_bd_pin -dir I -type clk drpclk
  create_bd_pin -dir O -from 0 -to 0 gt_cmn_qpll0lock
  create_bd_pin -dir O -from 0 -to 0 gt_cmn_qpll1lock
  create_bd_pin -dir I -type clk intf_0_rx_axi4s_aclk
  create_bd_pin -dir I -type rst intf_0_rx_axi4s_rst
  create_bd_pin -dir I -from 0 -to 0 intf_0_rxn
  create_bd_pin -dir O -type clk intf_0_rxoutclk
  create_bd_pin -dir I -from 0 -to 0 intf_0_rxp
  create_bd_pin -dir I -type clk intf_0_sb_rx_clk
  create_bd_pin -dir I -type rst intf_0_sb_rx_rst
  create_bd_pin -dir I -type clk intf_0_sb_tx_clk
  create_bd_pin -dir I -type rst intf_0_sb_tx_rst
  create_bd_pin -dir I -type clk intf_0_tx_axi4s_aclk
  create_bd_pin -dir I -type rst intf_0_tx_axi4s_rst
  create_bd_pin -dir O -from 0 -to 0 intf_0_txn
  create_bd_pin -dir O -type clk intf_0_txoutclk
  create_bd_pin -dir O -from 0 -to 0 intf_0_txp
  create_bd_pin -dir I x0y8_gtsouthrefclk1_0

  # Create instance: cmp_gt_sts_bit0, and set properties
  set cmp_gt_sts_bit0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice cmp_gt_sts_bit0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {64} \
 ] $cmp_gt_sts_bit0

  # Create instance: cmp_gt_sts_bit1, and set properties
  set cmp_gt_sts_bit1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice cmp_gt_sts_bit1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {64} \
   CONFIG.DOUT_WIDTH {1} \
 ] $cmp_gt_sts_bit1

  # Create instance: uhdsdi_gt_0, and set properties
  set uhdsdi_gt_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:uhdsdi_gt uhdsdi_gt_0 ]
  set_property -dict [ list \
   CONFIG.C_QPLL0_Refclk_Sel {5} \
   CONFIG.C_Rx_PLL2_Selection_INTF_0 {1} \
   CONFIG.C_Rx_PLL2_Selection_INTF_1 {2} \
   CONFIG.C_Rx_PLL2_Selection_INTF_2 {2} \
   CONFIG.C_Rx_PLL2_Selection_INTF_3 {2} \
   CONFIG.C_Rx_PLL_Selection_INTF_0 {1} \
   CONFIG.C_Rx_PLL_Selection_INTF_1 {1} \
   CONFIG.C_Rx_PLL_Selection_INTF_2 {1} \
   CONFIG.C_Rx_PLL_Selection_INTF_3 {1} \
   CONFIG.C_Tx_PLL2_Selection_INTF_0 {1} \
   CONFIG.C_Tx_PLL2_Selection_INTF_1 {2} \
   CONFIG.C_Tx_PLL2_Selection_INTF_2 {2} \
   CONFIG.C_Tx_PLL2_Selection_INTF_3 {2} \
   CONFIG.C_Tx_PLL_Selection_INTF_0 {1} \
   CONFIG.C_Tx_PLL_Selection_INTF_1 {1} \
   CONFIG.C_Tx_PLL_Selection_INTF_2 {1} \
   CONFIG.C_Tx_PLL_Selection_INTF_3 {1} \
   CONFIG.SupportLevel {1} \
 ] $uhdsdi_gt_0

  # Create interface connections
  connect_bd_intf_net -intf_net intf_0_ctrl_sb_rx_1 [get_bd_intf_pins intf_0_ctrl_sb_rx] [get_bd_intf_pins uhdsdi_gt_0/intf_0_ctrl_sb_rx]
  connect_bd_intf_net -intf_net intf_0_ctrl_sb_tx_1 [get_bd_intf_pins intf_0_ctrl_sb_tx] [get_bd_intf_pins uhdsdi_gt_0/intf_0_ctrl_sb_tx]
  connect_bd_intf_net -intf_net intf_0_tx_axi4s_ch0_1 [get_bd_intf_pins intf_0_tx_axi4s_ch0] [get_bd_intf_pins uhdsdi_gt_0/intf_0_tx_axi4s_ch0]
  connect_bd_intf_net -intf_net uhdsdi_gt_0_intf_0_rx_axi4s_ch0 [get_bd_intf_pins intf_0_rx_axi4s_ch0] [get_bd_intf_pins uhdsdi_gt_0/intf_0_rx_axi4s_ch0]
  connect_bd_intf_net -intf_net uhdsdi_gt_0_intf_0_stat_sb_rx [get_bd_intf_pins intf_0_stat_sb_rx] [get_bd_intf_pins uhdsdi_gt_0/intf_0_stat_sb_rx]
  connect_bd_intf_net -intf_net uhdsdi_gt_0_intf_0_stat_sb_tx [get_bd_intf_pins intf_0_stat_sb_tx] [get_bd_intf_pins uhdsdi_gt_0/intf_0_stat_sb_tx]

  # Create port connections
  connect_bd_net -net cmp_gt_ctrl_1 [get_bd_pins cmp_gt_ctrl] [get_bd_pins uhdsdi_gt_0/cmp_gt_ctrl]
  connect_bd_net -net cmp_gt_sts_bit0_Dout [get_bd_pins gt_cmn_qpll0lock] [get_bd_pins cmp_gt_sts_bit0/Dout]
  connect_bd_net -net cmp_gt_sts_bit1_Dout [get_bd_pins gt_cmn_qpll1lock] [get_bd_pins cmp_gt_sts_bit1/Dout]
  connect_bd_net -net compact_gt_0_cmp_gt_sts [get_bd_pins cmp_gt_sts] [get_bd_pins cmp_gt_sts_bit0/Din] [get_bd_pins cmp_gt_sts_bit1/Din] [get_bd_pins uhdsdi_gt_0/cmp_gt_sts]
  connect_bd_net -net drpclk_1 [get_bd_pins drpclk] [get_bd_pins uhdsdi_gt_0/drpclk_in]
  connect_bd_net -net intf_0_rx_axi4s_aclk_1 [get_bd_pins intf_0_rx_axi4s_aclk] [get_bd_pins uhdsdi_gt_0/intf_0_rx_axi4s_aclk]
  connect_bd_net -net intf_0_rx_axi4s_rst_1 [get_bd_pins intf_0_rx_axi4s_rst] [get_bd_pins uhdsdi_gt_0/intf_0_rx_axi4s_rst]
  connect_bd_net -net intf_0_rxn_1 [get_bd_pins intf_0_rxn] [get_bd_pins uhdsdi_gt_0/intf_0_rxn]
  connect_bd_net -net intf_0_rxp_1 [get_bd_pins intf_0_rxp] [get_bd_pins uhdsdi_gt_0/intf_0_rxp]
  connect_bd_net -net intf_0_sb_rx_clk_1 [get_bd_pins intf_0_sb_rx_clk] [get_bd_pins uhdsdi_gt_0/intf_0_sb_rx_clk]
  connect_bd_net -net intf_0_sb_rx_rst_1 [get_bd_pins intf_0_sb_rx_rst] [get_bd_pins uhdsdi_gt_0/intf_0_sb_rx_rst]
  connect_bd_net -net intf_0_sb_tx_clk_1 [get_bd_pins intf_0_sb_tx_clk] [get_bd_pins uhdsdi_gt_0/intf_0_sb_tx_clk]
  connect_bd_net -net intf_0_sb_tx_rst_1 [get_bd_pins intf_0_sb_tx_rst] [get_bd_pins uhdsdi_gt_0/intf_0_sb_tx_rst]
  connect_bd_net -net intf_0_tx_axi4s_aclk_1 [get_bd_pins intf_0_tx_axi4s_aclk] [get_bd_pins uhdsdi_gt_0/intf_0_tx_axi4s_aclk]
  connect_bd_net -net intf_0_tx_axi4s_rst_1 [get_bd_pins intf_0_tx_axi4s_rst] [get_bd_pins uhdsdi_gt_0/intf_0_tx_axi4s_rst]
  connect_bd_net -net uhdsdi_gt_0_intf_0_rxoutclk [get_bd_pins intf_0_rxoutclk] [get_bd_pins uhdsdi_gt_0/intf_0_rxoutclk]
  connect_bd_net -net uhdsdi_gt_0_intf_0_txn [get_bd_pins intf_0_txn] [get_bd_pins uhdsdi_gt_0/intf_0_txn]
  connect_bd_net -net uhdsdi_gt_0_intf_0_txoutclk [get_bd_pins intf_0_txoutclk] [get_bd_pins uhdsdi_gt_0/intf_0_txoutclk]
  connect_bd_net -net uhdsdi_gt_0_intf_0_txp [get_bd_pins intf_0_txp] [get_bd_pins uhdsdi_gt_0/intf_0_txp]
  connect_bd_net -net x0y8_gtsouthrefclk1_0_1 [get_bd_pins x0y8_gtsouthrefclk1_0] [get_bd_pins uhdsdi_gt_0/intf_0_qpll0_refclk_in]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: zynq_us_ss
proc create_hier_cell_zynq_us_ss { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_zynq_us_ss() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 CLK_IN1_D

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M03_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M04_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M05_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M06_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M07_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M08_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M09_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M10_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M11_AXI

  create_bd_intf_pin -mode Monitor -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Monitor -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HP0_FPD

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HP1_FPD

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HP2_FPD

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HP3_FPD

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HPC0_FPD


  # Create pins
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir I -from 0 -to 0 In2
  create_bd_pin -dir I -from 0 -to 0 In3
  create_bd_pin -dir I -from 0 -to 0 -type intr In4
  create_bd_pin -dir I -from 0 -to 0 In5
  create_bd_pin -dir I -type intr In6
  create_bd_pin -dir I -from 1 -to 0 -type intr In7
  create_bd_pin -dir I -type rst M00_ARESETN
  create_bd_pin -dir O clk_out3
  create_bd_pin -dir O -from 0 -to 0 dcm_locked
  create_bd_pin -dir O -from 94 -to 0 emio_gpio_o
  create_bd_pin -dir O -type clk pl_clk3
  create_bd_pin -dir O -type rst pl_resetn0
  create_bd_pin -dir I -type rst reset
  create_bd_pin -dir O -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir O -type clk sys_clk
  create_bd_pin -dir I uhdsdi_rx_irq
  create_bd_pin -dir I uhdsdi_tx_irq

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_interconnect_0 ]

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_interconnect_1 ]
  set_property -dict [ list \
   CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
   CONFIG.NUM_MI {12} \
 ] $axi_interconnect_1

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {33.330000000000005} \
   CONFIG.CLKOUT1_JITTER {101.475} \
   CONFIG.CLKOUT1_PHASE_ERROR {77.836} \
   CONFIG.CLKOUT2_JITTER {81.814} \
   CONFIG.CLKOUT2_PHASE_ERROR {77.836} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {300.000} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_JITTER {126.270} \
   CONFIG.CLKOUT3_PHASE_ERROR {77.836} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {33.33} \
   CONFIG.CLKOUT3_USED {true} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {4.000} \
   CONFIG.MMCM_CLKIN1_PERIOD {3.333} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {12.000} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {4} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {36} \
   CONFIG.MMCM_DIVCLK_DIVIDE {1} \
   CONFIG.NUM_OUT_CLKS {3} \
   CONFIG.PRIM_IN_FREQ {300.000} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.USE_LOCKED {true} \
   CONFIG.USE_RESET {false} \
 ] $clk_wiz_0

  # Create instance: xlconcat0, and set properties
  set xlconcat0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat0 ]
  set_property -dict [ list \
   CONFIG.IN5_WIDTH {1} \
   CONFIG.NUM_PORTS {7} \
 ] $xlconcat0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_0 ]

  # Create instance: zynq_us, and set properties
  set zynq_us [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e zynq_us ]
  set_property -dict [ list \
   CONFIG.CAN0_BOARD_INTERFACE {custom} \
   CONFIG.CAN1_BOARD_INTERFACE {custom} \
   CONFIG.CSU_BOARD_INTERFACE {custom} \
   CONFIG.DP_BOARD_INTERFACE {custom} \
   CONFIG.GEM0_BOARD_INTERFACE {custom} \
   CONFIG.GEM1_BOARD_INTERFACE {custom} \
   CONFIG.GEM2_BOARD_INTERFACE {custom} \
   CONFIG.GEM3_BOARD_INTERFACE {custom} \
   CONFIG.GPIO_BOARD_INTERFACE {custom} \
   CONFIG.IIC0_BOARD_INTERFACE {custom} \
   CONFIG.IIC1_BOARD_INTERFACE {custom} \
   CONFIG.NAND_BOARD_INTERFACE {custom} \
   CONFIG.PCIE_BOARD_INTERFACE {custom} \
   CONFIG.PJTAG_BOARD_INTERFACE {custom} \
   CONFIG.PMU_BOARD_INTERFACE {custom} \
   CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS33} \
   CONFIG.PSU_DDR_RAM_HIGHADDR {0xFFFFFFFF} \
   CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
   CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
   CONFIG.PSU_DYNAMIC_DDR_CONFIG_EN {0} \
   CONFIG.PSU_IMPORT_BOARD_PRESET {} \
   CONFIG.PSU_MIO_0_DIRECTION {out} \
   CONFIG.PSU_MIO_0_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_0_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_0_POLARITY {Default} \
   CONFIG.PSU_MIO_0_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_0_SLEW {slow} \
   CONFIG.PSU_MIO_10_DIRECTION {inout} \
   CONFIG.PSU_MIO_10_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_10_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_10_POLARITY {Default} \
   CONFIG.PSU_MIO_10_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_10_SLEW {slow} \
   CONFIG.PSU_MIO_11_DIRECTION {inout} \
   CONFIG.PSU_MIO_11_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_11_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_11_POLARITY {Default} \
   CONFIG.PSU_MIO_11_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_11_SLEW {slow} \
   CONFIG.PSU_MIO_12_DIRECTION {out} \
   CONFIG.PSU_MIO_12_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_12_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_12_POLARITY {Default} \
   CONFIG.PSU_MIO_12_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_12_SLEW {slow} \
   CONFIG.PSU_MIO_13_DIRECTION {inout} \
   CONFIG.PSU_MIO_13_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_13_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_13_POLARITY {Default} \
   CONFIG.PSU_MIO_13_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_13_SLEW {slow} \
   CONFIG.PSU_MIO_14_DIRECTION {inout} \
   CONFIG.PSU_MIO_14_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_14_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_14_POLARITY {Default} \
   CONFIG.PSU_MIO_14_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_14_SLEW {slow} \
   CONFIG.PSU_MIO_15_DIRECTION {inout} \
   CONFIG.PSU_MIO_15_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_15_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_15_POLARITY {Default} \
   CONFIG.PSU_MIO_15_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_15_SLEW {slow} \
   CONFIG.PSU_MIO_16_DIRECTION {inout} \
   CONFIG.PSU_MIO_16_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_16_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_16_POLARITY {Default} \
   CONFIG.PSU_MIO_16_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_16_SLEW {slow} \
   CONFIG.PSU_MIO_17_DIRECTION {inout} \
   CONFIG.PSU_MIO_17_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_17_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_17_POLARITY {Default} \
   CONFIG.PSU_MIO_17_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_17_SLEW {slow} \
   CONFIG.PSU_MIO_18_DIRECTION {in} \
   CONFIG.PSU_MIO_18_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_18_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_18_POLARITY {Default} \
   CONFIG.PSU_MIO_18_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_18_SLEW {fast} \
   CONFIG.PSU_MIO_19_DIRECTION {out} \
   CONFIG.PSU_MIO_19_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_19_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_19_POLARITY {Default} \
   CONFIG.PSU_MIO_19_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_19_SLEW {slow} \
   CONFIG.PSU_MIO_1_DIRECTION {inout} \
   CONFIG.PSU_MIO_1_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_1_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_1_POLARITY {Default} \
   CONFIG.PSU_MIO_1_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_1_SLEW {slow} \
   CONFIG.PSU_MIO_20_DIRECTION {out} \
   CONFIG.PSU_MIO_20_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_20_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_20_POLARITY {Default} \
   CONFIG.PSU_MIO_20_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_20_SLEW {slow} \
   CONFIG.PSU_MIO_21_DIRECTION {in} \
   CONFIG.PSU_MIO_21_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_21_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_21_POLARITY {Default} \
   CONFIG.PSU_MIO_21_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_21_SLEW {fast} \
   CONFIG.PSU_MIO_22_DIRECTION {inout} \
   CONFIG.PSU_MIO_22_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_22_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_22_POLARITY {Default} \
   CONFIG.PSU_MIO_22_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_22_SLEW {slow} \
   CONFIG.PSU_MIO_23_DIRECTION {inout} \
   CONFIG.PSU_MIO_23_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_23_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_23_POLARITY {Default} \
   CONFIG.PSU_MIO_23_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_23_SLEW {slow} \
   CONFIG.PSU_MIO_24_DIRECTION {out} \
   CONFIG.PSU_MIO_24_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_24_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_24_POLARITY {Default} \
   CONFIG.PSU_MIO_24_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_24_SLEW {slow} \
   CONFIG.PSU_MIO_25_DIRECTION {in} \
   CONFIG.PSU_MIO_25_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_25_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_25_POLARITY {Default} \
   CONFIG.PSU_MIO_25_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_25_SLEW {fast} \
   CONFIG.PSU_MIO_26_DIRECTION {inout} \
   CONFIG.PSU_MIO_26_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_26_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_26_POLARITY {Default} \
   CONFIG.PSU_MIO_26_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_26_SLEW {slow} \
   CONFIG.PSU_MIO_27_DIRECTION {out} \
   CONFIG.PSU_MIO_27_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_27_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_27_POLARITY {Default} \
   CONFIG.PSU_MIO_27_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_27_SLEW {slow} \
   CONFIG.PSU_MIO_28_DIRECTION {in} \
   CONFIG.PSU_MIO_28_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_28_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_28_POLARITY {Default} \
   CONFIG.PSU_MIO_28_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_28_SLEW {fast} \
   CONFIG.PSU_MIO_29_DIRECTION {out} \
   CONFIG.PSU_MIO_29_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_29_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_29_POLARITY {Default} \
   CONFIG.PSU_MIO_29_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_29_SLEW {slow} \
   CONFIG.PSU_MIO_2_DIRECTION {inout} \
   CONFIG.PSU_MIO_2_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_2_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_2_POLARITY {Default} \
   CONFIG.PSU_MIO_2_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_2_SLEW {slow} \
   CONFIG.PSU_MIO_30_DIRECTION {in} \
   CONFIG.PSU_MIO_30_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_30_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_30_POLARITY {Default} \
   CONFIG.PSU_MIO_30_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_30_SLEW {fast} \
   CONFIG.PSU_MIO_31_DIRECTION {inout} \
   CONFIG.PSU_MIO_31_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_31_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_31_POLARITY {Default} \
   CONFIG.PSU_MIO_31_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_31_SLEW {slow} \
   CONFIG.PSU_MIO_32_DIRECTION {out} \
   CONFIG.PSU_MIO_32_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_32_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_32_POLARITY {Default} \
   CONFIG.PSU_MIO_32_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_32_SLEW {slow} \
   CONFIG.PSU_MIO_33_DIRECTION {out} \
   CONFIG.PSU_MIO_33_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_33_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_33_POLARITY {Default} \
   CONFIG.PSU_MIO_33_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_33_SLEW {slow} \
   CONFIG.PSU_MIO_34_DIRECTION {out} \
   CONFIG.PSU_MIO_34_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_34_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_34_POLARITY {Default} \
   CONFIG.PSU_MIO_34_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_34_SLEW {slow} \
   CONFIG.PSU_MIO_35_DIRECTION {out} \
   CONFIG.PSU_MIO_35_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_35_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_35_POLARITY {Default} \
   CONFIG.PSU_MIO_35_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_35_SLEW {slow} \
   CONFIG.PSU_MIO_36_DIRECTION {out} \
   CONFIG.PSU_MIO_36_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_36_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_36_POLARITY {Default} \
   CONFIG.PSU_MIO_36_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_36_SLEW {slow} \
   CONFIG.PSU_MIO_37_DIRECTION {out} \
   CONFIG.PSU_MIO_37_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_37_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_37_POLARITY {Default} \
   CONFIG.PSU_MIO_37_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_37_SLEW {slow} \
   CONFIG.PSU_MIO_38_DIRECTION {inout} \
   CONFIG.PSU_MIO_38_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_38_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_38_POLARITY {Default} \
   CONFIG.PSU_MIO_38_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_38_SLEW {slow} \
   CONFIG.PSU_MIO_39_DIRECTION {inout} \
   CONFIG.PSU_MIO_39_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_39_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_39_POLARITY {Default} \
   CONFIG.PSU_MIO_39_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_39_SLEW {slow} \
   CONFIG.PSU_MIO_3_DIRECTION {inout} \
   CONFIG.PSU_MIO_3_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_3_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_3_POLARITY {Default} \
   CONFIG.PSU_MIO_3_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_3_SLEW {slow} \
   CONFIG.PSU_MIO_40_DIRECTION {inout} \
   CONFIG.PSU_MIO_40_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_40_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_40_POLARITY {Default} \
   CONFIG.PSU_MIO_40_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_40_SLEW {slow} \
   CONFIG.PSU_MIO_41_DIRECTION {inout} \
   CONFIG.PSU_MIO_41_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_41_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_41_POLARITY {Default} \
   CONFIG.PSU_MIO_41_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_41_SLEW {slow} \
   CONFIG.PSU_MIO_42_DIRECTION {inout} \
   CONFIG.PSU_MIO_42_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_42_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_42_POLARITY {Default} \
   CONFIG.PSU_MIO_42_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_42_SLEW {slow} \
   CONFIG.PSU_MIO_43_DIRECTION {out} \
   CONFIG.PSU_MIO_43_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_43_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_43_POLARITY {Default} \
   CONFIG.PSU_MIO_43_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_43_SLEW {slow} \
   CONFIG.PSU_MIO_44_DIRECTION {in} \
   CONFIG.PSU_MIO_44_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_44_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_44_POLARITY {Default} \
   CONFIG.PSU_MIO_44_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_44_SLEW {fast} \
   CONFIG.PSU_MIO_45_DIRECTION {in} \
   CONFIG.PSU_MIO_45_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_45_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_45_POLARITY {Default} \
   CONFIG.PSU_MIO_45_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_45_SLEW {fast} \
   CONFIG.PSU_MIO_46_DIRECTION {inout} \
   CONFIG.PSU_MIO_46_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_46_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_46_POLARITY {Default} \
   CONFIG.PSU_MIO_46_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_46_SLEW {slow} \
   CONFIG.PSU_MIO_47_DIRECTION {inout} \
   CONFIG.PSU_MIO_47_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_47_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_47_POLARITY {Default} \
   CONFIG.PSU_MIO_47_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_47_SLEW {slow} \
   CONFIG.PSU_MIO_48_DIRECTION {inout} \
   CONFIG.PSU_MIO_48_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_48_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_48_POLARITY {Default} \
   CONFIG.PSU_MIO_48_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_48_SLEW {slow} \
   CONFIG.PSU_MIO_49_DIRECTION {inout} \
   CONFIG.PSU_MIO_49_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_49_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_49_POLARITY {Default} \
   CONFIG.PSU_MIO_49_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_49_SLEW {slow} \
   CONFIG.PSU_MIO_4_DIRECTION {inout} \
   CONFIG.PSU_MIO_4_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_4_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_4_POLARITY {Default} \
   CONFIG.PSU_MIO_4_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_4_SLEW {slow} \
   CONFIG.PSU_MIO_50_DIRECTION {inout} \
   CONFIG.PSU_MIO_50_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_50_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_50_POLARITY {Default} \
   CONFIG.PSU_MIO_50_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_50_SLEW {slow} \
   CONFIG.PSU_MIO_51_DIRECTION {out} \
   CONFIG.PSU_MIO_51_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_51_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_51_POLARITY {Default} \
   CONFIG.PSU_MIO_51_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_51_SLEW {slow} \
   CONFIG.PSU_MIO_52_DIRECTION {in} \
   CONFIG.PSU_MIO_52_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_52_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_52_POLARITY {Default} \
   CONFIG.PSU_MIO_52_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_52_SLEW {fast} \
   CONFIG.PSU_MIO_53_DIRECTION {in} \
   CONFIG.PSU_MIO_53_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_53_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_53_POLARITY {Default} \
   CONFIG.PSU_MIO_53_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_53_SLEW {fast} \
   CONFIG.PSU_MIO_54_DIRECTION {inout} \
   CONFIG.PSU_MIO_54_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_54_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_54_POLARITY {Default} \
   CONFIG.PSU_MIO_54_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_54_SLEW {slow} \
   CONFIG.PSU_MIO_55_DIRECTION {in} \
   CONFIG.PSU_MIO_55_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_55_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_55_POLARITY {Default} \
   CONFIG.PSU_MIO_55_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_55_SLEW {fast} \
   CONFIG.PSU_MIO_56_DIRECTION {inout} \
   CONFIG.PSU_MIO_56_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_56_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_56_POLARITY {Default} \
   CONFIG.PSU_MIO_56_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_56_SLEW {slow} \
   CONFIG.PSU_MIO_57_DIRECTION {inout} \
   CONFIG.PSU_MIO_57_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_57_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_57_POLARITY {Default} \
   CONFIG.PSU_MIO_57_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_57_SLEW {slow} \
   CONFIG.PSU_MIO_58_DIRECTION {out} \
   CONFIG.PSU_MIO_58_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_58_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_58_POLARITY {Default} \
   CONFIG.PSU_MIO_58_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_58_SLEW {slow} \
   CONFIG.PSU_MIO_59_DIRECTION {inout} \
   CONFIG.PSU_MIO_59_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_59_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_59_POLARITY {Default} \
   CONFIG.PSU_MIO_59_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_59_SLEW {slow} \
   CONFIG.PSU_MIO_5_DIRECTION {out} \
   CONFIG.PSU_MIO_5_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_5_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_5_POLARITY {Default} \
   CONFIG.PSU_MIO_5_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_5_SLEW {slow} \
   CONFIG.PSU_MIO_60_DIRECTION {inout} \
   CONFIG.PSU_MIO_60_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_60_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_60_POLARITY {Default} \
   CONFIG.PSU_MIO_60_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_60_SLEW {slow} \
   CONFIG.PSU_MIO_61_DIRECTION {inout} \
   CONFIG.PSU_MIO_61_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_61_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_61_POLARITY {Default} \
   CONFIG.PSU_MIO_61_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_61_SLEW {slow} \
   CONFIG.PSU_MIO_62_DIRECTION {inout} \
   CONFIG.PSU_MIO_62_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_62_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_62_POLARITY {Default} \
   CONFIG.PSU_MIO_62_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_62_SLEW {slow} \
   CONFIG.PSU_MIO_63_DIRECTION {inout} \
   CONFIG.PSU_MIO_63_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_63_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_63_POLARITY {Default} \
   CONFIG.PSU_MIO_63_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_63_SLEW {slow} \
   CONFIG.PSU_MIO_64_DIRECTION {out} \
   CONFIG.PSU_MIO_64_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_64_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_64_POLARITY {Default} \
   CONFIG.PSU_MIO_64_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_64_SLEW {slow} \
   CONFIG.PSU_MIO_65_DIRECTION {out} \
   CONFIG.PSU_MIO_65_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_65_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_65_POLARITY {Default} \
   CONFIG.PSU_MIO_65_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_65_SLEW {slow} \
   CONFIG.PSU_MIO_66_DIRECTION {out} \
   CONFIG.PSU_MIO_66_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_66_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_66_POLARITY {Default} \
   CONFIG.PSU_MIO_66_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_66_SLEW {slow} \
   CONFIG.PSU_MIO_67_DIRECTION {out} \
   CONFIG.PSU_MIO_67_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_67_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_67_POLARITY {Default} \
   CONFIG.PSU_MIO_67_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_67_SLEW {slow} \
   CONFIG.PSU_MIO_68_DIRECTION {out} \
   CONFIG.PSU_MIO_68_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_68_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_68_POLARITY {Default} \
   CONFIG.PSU_MIO_68_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_68_SLEW {slow} \
   CONFIG.PSU_MIO_69_DIRECTION {out} \
   CONFIG.PSU_MIO_69_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_69_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_69_POLARITY {Default} \
   CONFIG.PSU_MIO_69_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_69_SLEW {slow} \
   CONFIG.PSU_MIO_6_DIRECTION {out} \
   CONFIG.PSU_MIO_6_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_6_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_6_POLARITY {Default} \
   CONFIG.PSU_MIO_6_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_6_SLEW {slow} \
   CONFIG.PSU_MIO_70_DIRECTION {in} \
   CONFIG.PSU_MIO_70_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_70_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_70_POLARITY {Default} \
   CONFIG.PSU_MIO_70_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_70_SLEW {fast} \
   CONFIG.PSU_MIO_71_DIRECTION {in} \
   CONFIG.PSU_MIO_71_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_71_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_71_POLARITY {Default} \
   CONFIG.PSU_MIO_71_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_71_SLEW {fast} \
   CONFIG.PSU_MIO_72_DIRECTION {in} \
   CONFIG.PSU_MIO_72_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_72_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_72_POLARITY {Default} \
   CONFIG.PSU_MIO_72_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_72_SLEW {fast} \
   CONFIG.PSU_MIO_73_DIRECTION {in} \
   CONFIG.PSU_MIO_73_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_73_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_73_POLARITY {Default} \
   CONFIG.PSU_MIO_73_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_73_SLEW {fast} \
   CONFIG.PSU_MIO_74_DIRECTION {in} \
   CONFIG.PSU_MIO_74_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_74_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_74_POLARITY {Default} \
   CONFIG.PSU_MIO_74_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_74_SLEW {fast} \
   CONFIG.PSU_MIO_75_DIRECTION {in} \
   CONFIG.PSU_MIO_75_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_75_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_75_POLARITY {Default} \
   CONFIG.PSU_MIO_75_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_75_SLEW {fast} \
   CONFIG.PSU_MIO_76_DIRECTION {out} \
   CONFIG.PSU_MIO_76_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_76_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_76_POLARITY {Default} \
   CONFIG.PSU_MIO_76_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_76_SLEW {slow} \
   CONFIG.PSU_MIO_77_DIRECTION {inout} \
   CONFIG.PSU_MIO_77_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_77_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_77_POLARITY {Default} \
   CONFIG.PSU_MIO_77_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_77_SLEW {slow} \
   CONFIG.PSU_MIO_7_DIRECTION {out} \
   CONFIG.PSU_MIO_7_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_7_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_7_POLARITY {Default} \
   CONFIG.PSU_MIO_7_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_7_SLEW {slow} \
   CONFIG.PSU_MIO_8_DIRECTION {inout} \
   CONFIG.PSU_MIO_8_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_8_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_8_POLARITY {Default} \
   CONFIG.PSU_MIO_8_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_8_SLEW {slow} \
   CONFIG.PSU_MIO_9_DIRECTION {inout} \
   CONFIG.PSU_MIO_9_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_9_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_9_POLARITY {Default} \
   CONFIG.PSU_MIO_9_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_9_SLEW {slow} \
   CONFIG.PSU_MIO_TREE_PERIPHERALS {Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Feedback Clk#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO0 MIO#I2C 0#I2C 0#I2C 1#I2C 1#UART 0#UART 0#UART 1#UART 1#GPIO0 MIO#GPIO0 MIO#CAN 1#CAN 1#GPIO1 MIO#DPAUX#DPAUX#DPAUX#DPAUX#GPIO1 MIO#PMU GPO 0#PMU GPO 1#PMU GPO 2#PMU GPO 3#PMU GPO 4#PMU GPO 5#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#MDIO 3#MDIO 3} \
   CONFIG.PSU_MIO_TREE_SIGNALS {sclk_out#miso_mo1#mo2#mo3#mosi_mi0#n_ss_out#clk_for_lpbk#n_ss_out_upper#mo_upper[0]#mo_upper[1]#mo_upper[2]#mo_upper[3]#sclk_out_upper#gpio0[13]#scl_out#sda_out#scl_out#sda_out#rxd#txd#txd#rxd#gpio0[22]#gpio0[23]#phy_tx#phy_rx#gpio1[26]#dp_aux_data_out#dp_hot_plug_detect#dp_aux_data_oe#dp_aux_data_in#gpio1[31]#gpo[0]#gpo[1]#gpo[2]#gpo[3]#gpo[4]#gpo[5]#gpio1[38]#sdio1_data_out[4]#sdio1_data_out[5]#sdio1_data_out[6]#sdio1_data_out[7]#sdio1_bus_pow#sdio1_wp#sdio1_cd_n#sdio1_data_out[0]#sdio1_data_out[1]#sdio1_data_out[2]#sdio1_data_out[3]#sdio1_cmd_out#sdio1_clk_out#ulpi_clk_in#ulpi_dir#ulpi_tx_data[2]#ulpi_nxt#ulpi_tx_data[0]#ulpi_tx_data[1]#ulpi_stp#ulpi_tx_data[3]#ulpi_tx_data[4]#ulpi_tx_data[5]#ulpi_tx_data[6]#ulpi_tx_data[7]#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#gem3_mdc#gem3_mdio_out} \
   CONFIG.PSU_PERIPHERAL_BOARD_PRESET {} \
   CONFIG.PSU_SD0_INTERNAL_BUS_WIDTH {8} \
   CONFIG.PSU_SD1_INTERNAL_BUS_WIDTH {8} \
   CONFIG.PSU_SMC_CYCLE_T0 {NA} \
   CONFIG.PSU_SMC_CYCLE_T1 {NA} \
   CONFIG.PSU_SMC_CYCLE_T2 {NA} \
   CONFIG.PSU_SMC_CYCLE_T3 {NA} \
   CONFIG.PSU_SMC_CYCLE_T4 {NA} \
   CONFIG.PSU_SMC_CYCLE_T5 {NA} \
   CONFIG.PSU_SMC_CYCLE_T6 {NA} \
   CONFIG.PSU_UIPARAM_GENERATE_SUMMARY {<Select>} \
   CONFIG.PSU_USB3__DUAL_CLOCK_ENABLE {1} \
   CONFIG.PSU_VALUE_SILVERSION {3} \
   CONFIG.PSU__ACPU0__POWER__ON {1} \
   CONFIG.PSU__ACPU1__POWER__ON {1} \
   CONFIG.PSU__ACPU2__POWER__ON {1} \
   CONFIG.PSU__ACPU3__POWER__ON {1} \
   CONFIG.PSU__ACTUAL__IP {1} \
   CONFIG.PSU__ACT_DDR_FREQ_MHZ {1066.560059} \
   CONFIG.PSU__AFI0_COHERENCY {0} \
   CONFIG.PSU__AFI1_COHERENCY {0} \
   CONFIG.PSU__AUX_REF_CLK__FREQMHZ {33.333} \
   CONFIG.PSU__CAN0_LOOP_CAN1__ENABLE {0} \
   CONFIG.PSU__CAN0__GRP_CLK__ENABLE {0} \
   CONFIG.PSU__CAN0__GRP_CLK__IO {<Select>} \
   CONFIG.PSU__CAN0__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__CAN0__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__CAN1__GRP_CLK__ENABLE {0} \
   CONFIG.PSU__CAN1__GRP_CLK__IO {<Select>} \
   CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__CAN1__PERIPHERAL__IO {MIO 24 .. 25} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1199.880127} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__FREQMHZ {1200} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__ACPU__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__ACT_FREQMHZ {667} \
   CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__FREQMHZ {667} \
   CONFIG.PSU__CRF_APB__AFI0_REF_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__AFI0_REF__ENABLE {0} \
   CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__ACT_FREQMHZ {667} \
   CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__FREQMHZ {667} \
   CONFIG.PSU__CRF_APB__AFI1_REF_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__AFI1_REF__ENABLE {0} \
   CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__ACT_FREQMHZ {667} \
   CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__FREQMHZ {667} \
   CONFIG.PSU__CRF_APB__AFI2_REF_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__AFI2_REF__ENABLE {0} \
   CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__ACT_FREQMHZ {667} \
   CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__FREQMHZ {667} \
   CONFIG.PSU__CRF_APB__AFI3_REF_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__AFI3_REF__ENABLE {0} \
   CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__ACT_FREQMHZ {667} \
   CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__FREQMHZ {667} \
   CONFIG.PSU__CRF_APB__AFI4_REF_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__AFI4_REF__ENABLE {0} \
   CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__ACT_FREQMHZ {667} \
   CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__FREQMHZ {667} \
   CONFIG.PSU__CRF_APB__AFI5_REF_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__AFI5_REF__ENABLE {0} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FBDIV {72} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FRACFREQ {27.138} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__APLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__APLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__APM_CTRL__ACT_FREQMHZ {1} \
   CONFIG.PSU__CRF_APB__APM_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRF_APB__APM_CTRL__FREQMHZ {1} \
   CONFIG.PSU__CRF_APB__APM_CTRL__SRCSEL {<Select>} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {249.975021} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__ACT_FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {249.975021} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {533.280029} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1067} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {599.940063} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__FREQMHZ {600} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FBDIV {64} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACFREQ {27.138} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__DPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__DPLL_TO_LPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__ACT_FREQMHZ {24.997501} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__FREQMHZ {25} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRF_APB__DP_AUDIO__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__ACT_FREQMHZ {26.783037} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR0 {14} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__FREQMHZ {27} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__ACT_FREQMHZ {299.970032} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__FREQMHZ {300} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
   CONFIG.PSU__CRF_APB__DP_VIDEO__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {599.940063} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__FREQMHZ {600} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__ACT_FREQMHZ {499.950043} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__ACT_FREQMHZ {-1} \
   CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__DIVISOR0 {-1} \
   CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__FREQMHZ {-1} \
   CONFIG.PSU__CRF_APB__GTGREF0_REF_CTRL__SRCSEL {NA} \
   CONFIG.PSU__CRF_APB__GTGREF0__ENABLE {NA} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__ACT_FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__ACT_FREQMHZ {249.975021} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {99.990005} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {533.280029} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__FREQMHZ {533.33} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACFREQ {27.138} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__VPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__VPLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {499.950043} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__ACT_FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__AFI6__ENABLE {0} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {51.718967} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR0 {29} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__FREQMHZ {52} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__ACT_FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__ACT_FREQMHZ {99.990005} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {499.950043} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__ACT_FREQMHZ {180} \
   CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__FREQMHZ {180} \
   CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__SRCSEL {SysOsc} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {249.975021} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__ACT_FREQMHZ {1000} \
   CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__FREQMHZ {1000} \
   CONFIG.PSU__CRL_APB__DEBUG_R5_ATCLK_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1499.850098} \
   CONFIG.PSU__CRL_APB__DLL_REF_CTRL__FREQMHZ {1500} \
   CONFIG.PSU__CRL_APB__DLL_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__ACT_FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__ACT_FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__ACT_FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__ACT_FREQMHZ {124.987511} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {249.975021} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__ACT_FREQMHZ {99.990005} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {99.990005} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACFREQ {27.138} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRL_APB__IOPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__IOPLL_TO_FPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {249.975021} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {99.990005} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {499.950043} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__ACT_FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__ACT_FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__OCM_MAIN_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.481262} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {99.990005} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__ACT_FREQMHZ {299.970032} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__FREQMHZ {300} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__ACT_FREQMHZ {32.605438} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR0 {46} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__FREQMHZ {33} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__ACT_FREQMHZ {18.290855} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR0 {41} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR1 {2} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__FREQMHZ {18.5} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {124.987511} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FBDIV {45} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACFREQ {27.138} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRL_APB__RPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__RPLL_TO_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__ACT_FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__ACT_FREQMHZ {187.481262} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__ACT_FREQMHZ {199.998} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__ACT_FREQMHZ {214} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {99.990005} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {99.990005} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__ACT_FREQMHZ {99.990005} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__ACT_FREQMHZ {249.975021} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__ACT_FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {19.998001} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR0 {25} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR1 {3} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__FREQMHZ {20} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB3__ENABLE {1} \
   CONFIG.PSU__CSUPMU__PERIPHERAL__VALID {1} \
   CONFIG.PSU__CSU_COHERENCY {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_0__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_0__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_0__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__CSU_TAMPER_10__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_10__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_10__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__CSU_TAMPER_11__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_11__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_11__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__CSU_TAMPER_12__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_12__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_12__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__CSU_TAMPER_1__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_1__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_1__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__CSU_TAMPER_2__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_2__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_2__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__CSU_TAMPER_3__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_3__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_3__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__CSU_TAMPER_4__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_4__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_4__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__CSU_TAMPER_5__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_5__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_5__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__CSU_TAMPER_6__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_6__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_6__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__CSU_TAMPER_7__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_7__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_7__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__CSU_TAMPER_8__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_8__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_8__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__CSU_TAMPER_9__ENABLE {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_9__ERASE_BBRAM {0} \
   CONFIG.PSU__CSU__CSU_TAMPER_9__RESPONSE {<Select>} \
   CONFIG.PSU__CSU__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__CSU__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__DDRC__ADDR_MIRROR {0} \
   CONFIG.PSU__DDRC__AL {0} \
   CONFIG.PSU__DDRC__BANK_ADDR_COUNT {2} \
   CONFIG.PSU__DDRC__BG_ADDR_COUNT {2} \
   CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \
   CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
   CONFIG.PSU__DDRC__CL {15} \
   CONFIG.PSU__DDRC__CLOCK_STOP_EN {0} \
   CONFIG.PSU__DDRC__COL_ADDR_COUNT {10} \
   CONFIG.PSU__DDRC__COMPONENTS {UDIMM} \
   CONFIG.PSU__DDRC__CWL {14} \
   CONFIG.PSU__DDRC__DDR3L_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__DDR3_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {0} \
   CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \
   CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \
   CONFIG.PSU__DDRC__DDR4_MAXPWR_SAVING_EN {0} \
   CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \
   CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \
   CONFIG.PSU__DDRC__DEEP_PWR_DOWN_EN {0} \
   CONFIG.PSU__DDRC__DERATE_INT_D {<Select>} \
   CONFIG.PSU__DDRC__DEVICE_CAPACITY {4096 MBits} \
   CONFIG.PSU__DDRC__DIMM_ADDR_MIRROR {0} \
   CONFIG.PSU__DDRC__DM_DBI {DM_NO_DBI} \
   CONFIG.PSU__DDRC__DQMAP_0_3 {0} \
   CONFIG.PSU__DDRC__DQMAP_12_15 {0} \
   CONFIG.PSU__DDRC__DQMAP_16_19 {0} \
   CONFIG.PSU__DDRC__DQMAP_20_23 {0} \
   CONFIG.PSU__DDRC__DQMAP_24_27 {0} \
   CONFIG.PSU__DDRC__DQMAP_28_31 {0} \
   CONFIG.PSU__DDRC__DQMAP_32_35 {0} \
   CONFIG.PSU__DDRC__DQMAP_36_39 {0} \
   CONFIG.PSU__DDRC__DQMAP_40_43 {0} \
   CONFIG.PSU__DDRC__DQMAP_44_47 {0} \
   CONFIG.PSU__DDRC__DQMAP_48_51 {0} \
   CONFIG.PSU__DDRC__DQMAP_4_7 {0} \
   CONFIG.PSU__DDRC__DQMAP_52_55 {0} \
   CONFIG.PSU__DDRC__DQMAP_56_59 {0} \
   CONFIG.PSU__DDRC__DQMAP_60_63 {0} \
   CONFIG.PSU__DDRC__DQMAP_64_67 {0} \
   CONFIG.PSU__DDRC__DQMAP_68_71 {0} \
   CONFIG.PSU__DDRC__DQMAP_8_11 {0} \
   CONFIG.PSU__DDRC__DRAM_WIDTH {8 Bits} \
   CONFIG.PSU__DDRC__ECC {Disabled} \
   CONFIG.PSU__DDRC__ECC_SCRUB {0} \
   CONFIG.PSU__DDRC__ENABLE {1} \
   CONFIG.PSU__DDRC__ENABLE_2T_TIMING {0} \
   CONFIG.PSU__DDRC__ENABLE_DP_SWITCH {0} \
   CONFIG.PSU__DDRC__ENABLE_LP4_HAS_ECC_COMP {0} \
   CONFIG.PSU__DDRC__ENABLE_LP4_SLOWBOOT {0} \
   CONFIG.PSU__DDRC__EN_2ND_CLK {0} \
   CONFIG.PSU__DDRC__FGRM {1X} \
   CONFIG.PSU__DDRC__FREQ_MHZ {1} \
   CONFIG.PSU__DDRC__HIGH_TEMP {<Select>} \
   CONFIG.PSU__DDRC__LPDDR3_DUALRANK_SDP {0} \
   CONFIG.PSU__DDRC__LPDDR3_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__LPDDR4_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__LP_ASR {manual normal} \
   CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \
   CONFIG.PSU__DDRC__PARITY_ENABLE {0} \
   CONFIG.PSU__DDRC__PARTNO {<Select>} \
   CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \
   CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \
   CONFIG.PSU__DDRC__PLL_BYPASS {0} \
   CONFIG.PSU__DDRC__PWR_DOWN_EN {0} \
   CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \
   CONFIG.PSU__DDRC__RD_DQS_CENTER {0} \
   CONFIG.PSU__DDRC__ROW_ADDR_COUNT {15} \
   CONFIG.PSU__DDRC__SB_TARGET {15-15-15} \
   CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \
   CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2133P} \
   CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \
   CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \
   CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \
   CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \
   CONFIG.PSU__DDRC__T_FAW {30.0} \
   CONFIG.PSU__DDRC__T_RAS_MIN {33} \
   CONFIG.PSU__DDRC__T_RC {47.06} \
   CONFIG.PSU__DDRC__T_RCD {15} \
   CONFIG.PSU__DDRC__T_RP {15} \
   CONFIG.PSU__DDRC__VENDOR_PART {OTHERS} \
   CONFIG.PSU__DDRC__VIDEO_BUFFER_SIZE {0} \
   CONFIG.PSU__DDRC__VREF {1} \
   CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
   CONFIG.PSU__DDR_QOS_ENABLE {0} \
   CONFIG.PSU__DDR_QOS_FIX_HP0_RDQOS {} \
   CONFIG.PSU__DDR_QOS_FIX_HP0_WRQOS {} \
   CONFIG.PSU__DDR_QOS_FIX_HP1_RDQOS {} \
   CONFIG.PSU__DDR_QOS_FIX_HP1_WRQOS {} \
   CONFIG.PSU__DDR_QOS_FIX_HP2_RDQOS {} \
   CONFIG.PSU__DDR_QOS_FIX_HP2_WRQOS {} \
   CONFIG.PSU__DDR_QOS_FIX_HP3_RDQOS {} \
   CONFIG.PSU__DDR_QOS_FIX_HP3_WRQOS {} \
   CONFIG.PSU__DDR_QOS_HP0_RDQOS {} \
   CONFIG.PSU__DDR_QOS_HP0_WRQOS {} \
   CONFIG.PSU__DDR_QOS_HP1_RDQOS {} \
   CONFIG.PSU__DDR_QOS_HP1_WRQOS {} \
   CONFIG.PSU__DDR_QOS_HP2_RDQOS {} \
   CONFIG.PSU__DDR_QOS_HP2_WRQOS {} \
   CONFIG.PSU__DDR_QOS_HP3_RDQOS {} \
   CONFIG.PSU__DDR_QOS_HP3_WRQOS {} \
   CONFIG.PSU__DDR_QOS_PORT0_TYPE {<Select>} \
   CONFIG.PSU__DDR_QOS_PORT1_VN1_TYPE {<Select>} \
   CONFIG.PSU__DDR_QOS_PORT1_VN2_TYPE {<Select>} \
   CONFIG.PSU__DDR_QOS_PORT2_VN1_TYPE {<Select>} \
   CONFIG.PSU__DDR_QOS_PORT2_VN2_TYPE {<Select>} \
   CONFIG.PSU__DDR_QOS_PORT3_TYPE {<Select>} \
   CONFIG.PSU__DDR_QOS_PORT4_TYPE {<Select>} \
   CONFIG.PSU__DDR_QOS_PORT5_TYPE {<Select>} \
   CONFIG.PSU__DDR_QOS_RD_HPR_THRSHLD {} \
   CONFIG.PSU__DDR_QOS_RD_LPR_THRSHLD {} \
   CONFIG.PSU__DDR_QOS_WR_THRSHLD {} \
   CONFIG.PSU__DDR_SW_REFRESH_ENABLED {1} \
   CONFIG.PSU__DDR__INTERFACE__FREQMHZ {533.500} \
   CONFIG.PSU__DEVICE_TYPE {EV} \
   CONFIG.PSU__DISPLAYPORT__LANE0__ENABLE {1} \
   CONFIG.PSU__DISPLAYPORT__LANE0__IO {GT Lane1} \
   CONFIG.PSU__DISPLAYPORT__LANE1__ENABLE {1} \
   CONFIG.PSU__DISPLAYPORT__LANE1__IO {GT Lane0} \
   CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__DLL__ISUSED {1} \
   CONFIG.PSU__DPAUX__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__DPAUX__PERIPHERAL__IO {MIO 27 .. 30} \
   CONFIG.PSU__DP__LANE_SEL {Dual Lower} \
   CONFIG.PSU__DP__REF_CLK_FREQ {27} \
   CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk3} \
   CONFIG.PSU__ENABLE__DDR__REFRESH__SIGNALS {0} \
   CONFIG.PSU__ENET0__FIFO__ENABLE {0} \
   CONFIG.PSU__ENET0__GRP_MDIO__ENABLE {0} \
   CONFIG.PSU__ENET0__GRP_MDIO__IO {<Select>} \
   CONFIG.PSU__ENET0__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__ENET0__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__ENET0__PTP__ENABLE {0} \
   CONFIG.PSU__ENET0__TSU__ENABLE {0} \
   CONFIG.PSU__ENET1__FIFO__ENABLE {0} \
   CONFIG.PSU__ENET1__GRP_MDIO__ENABLE {0} \
   CONFIG.PSU__ENET1__GRP_MDIO__IO {<Select>} \
   CONFIG.PSU__ENET1__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__ENET1__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__ENET1__PTP__ENABLE {0} \
   CONFIG.PSU__ENET1__TSU__ENABLE {0} \
   CONFIG.PSU__ENET2__FIFO__ENABLE {0} \
   CONFIG.PSU__ENET2__GRP_MDIO__ENABLE {0} \
   CONFIG.PSU__ENET2__GRP_MDIO__IO {<Select>} \
   CONFIG.PSU__ENET2__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__ENET2__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__ENET2__PTP__ENABLE {0} \
   CONFIG.PSU__ENET2__TSU__ENABLE {0} \
   CONFIG.PSU__ENET3__FIFO__ENABLE {0} \
   CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \
   CONFIG.PSU__ENET3__GRP_MDIO__IO {MIO 76 .. 77} \
   CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__ENET3__PERIPHERAL__IO {MIO 64 .. 75} \
   CONFIG.PSU__ENET3__PTP__ENABLE {0} \
   CONFIG.PSU__ENET3__TSU__ENABLE {0} \
   CONFIG.PSU__EN_AXI_STATUS_PORTS {0} \
   CONFIG.PSU__EN_EMIO_TRACE {0} \
   CONFIG.PSU__EP__IP {0} \
   CONFIG.PSU__EXPAND__CORESIGHT {0} \
   CONFIG.PSU__EXPAND__FPD_SLAVES {0} \
   CONFIG.PSU__EXPAND__GIC {0} \
   CONFIG.PSU__EXPAND__LOWER_LPS_SLAVES {0} \
   CONFIG.PSU__EXPAND__UPPER_LPS_SLAVES {0} \
   CONFIG.PSU__FPDMASTERS_COHERENCY {0} \
   CONFIG.PSU__FPD_SLCR__WDT1__ACT_FREQMHZ {99.990005} \
   CONFIG.PSU__FPD_SLCR__WDT1__FREQMHZ {99.990005} \
   CONFIG.PSU__FPD_SLCR__WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__FPGA_PL0_ENABLE {1} \
   CONFIG.PSU__FPGA_PL1_ENABLE {1} \
   CONFIG.PSU__FPGA_PL2_ENABLE {1} \
   CONFIG.PSU__FPGA_PL3_ENABLE {1} \
   CONFIG.PSU__FP__POWER__ON {1} \
   CONFIG.PSU__FTM__CTI_IN_0 {0} \
   CONFIG.PSU__FTM__CTI_IN_1 {0} \
   CONFIG.PSU__FTM__CTI_IN_2 {0} \
   CONFIG.PSU__FTM__CTI_IN_3 {0} \
   CONFIG.PSU__FTM__CTI_OUT_0 {0} \
   CONFIG.PSU__FTM__CTI_OUT_1 {0} \
   CONFIG.PSU__FTM__CTI_OUT_2 {0} \
   CONFIG.PSU__FTM__CTI_OUT_3 {0} \
   CONFIG.PSU__FTM__GPI {0} \
   CONFIG.PSU__FTM__GPO {0} \
   CONFIG.PSU__GEM0_COHERENCY {0} \
   CONFIG.PSU__GEM0_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__GEM0__REF_CLK_FREQ {<Select>} \
   CONFIG.PSU__GEM0__REF_CLK_SEL {<Select>} \
   CONFIG.PSU__GEM1_COHERENCY {0} \
   CONFIG.PSU__GEM1_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__GEM1__REF_CLK_FREQ {<Select>} \
   CONFIG.PSU__GEM1__REF_CLK_SEL {<Select>} \
   CONFIG.PSU__GEM2_COHERENCY {0} \
   CONFIG.PSU__GEM2_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__GEM2__REF_CLK_FREQ {<Select>} \
   CONFIG.PSU__GEM2__REF_CLK_SEL {<Select>} \
   CONFIG.PSU__GEM3_COHERENCY {0} \
   CONFIG.PSU__GEM3_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__GEM3__REF_CLK_FREQ {<Select>} \
   CONFIG.PSU__GEM3__REF_CLK_SEL {<Select>} \
   CONFIG.PSU__GEM__TSU__ENABLE {0} \
   CONFIG.PSU__GEM__TSU__IO {<Select>} \
   CONFIG.PSU__GEN_IPI_0__MASTER {APU} \
   CONFIG.PSU__GEN_IPI_10__MASTER {NONE} \
   CONFIG.PSU__GEN_IPI_1__MASTER {RPU0} \
   CONFIG.PSU__GEN_IPI_2__MASTER {RPU1} \
   CONFIG.PSU__GEN_IPI_3__MASTER {PMU} \
   CONFIG.PSU__GEN_IPI_4__MASTER {PMU} \
   CONFIG.PSU__GEN_IPI_5__MASTER {PMU} \
   CONFIG.PSU__GEN_IPI_6__MASTER {PMU} \
   CONFIG.PSU__GEN_IPI_7__MASTER {NONE} \
   CONFIG.PSU__GEN_IPI_8__MASTER {NONE} \
   CONFIG.PSU__GEN_IPI_9__MASTER {NONE} \
   CONFIG.PSU__GEN_IPI__TRUSTZONE {<Select>} \
   CONFIG.PSU__GPIO0_MIO__IO {MIO 0 .. 25} \
   CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GPIO1_MIO__IO {MIO 26 .. 51} \
   CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GPIO2_MIO__IO {<Select>} \
   CONFIG.PSU__GPIO2_MIO__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__GPIO_EMIO_WIDTH {95} \
   CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GPIO_EMIO__PERIPHERAL__IO {95} \
   CONFIG.PSU__GPIO_EMIO__WIDTH {[94:0]} \
   CONFIG.PSU__GPU_PP0__POWER__ON {1} \
   CONFIG.PSU__GPU_PP1__POWER__ON {1} \
   CONFIG.PSU__GT_REF_CLK__FREQMHZ {33.333} \
   CONFIG.PSU__GT__LINK_SPEED {HBR} \
   CONFIG.PSU__GT__PRE_EMPH_LVL_4 {0} \
   CONFIG.PSU__GT__VLT_SWNG_LVL_4 {0} \
   CONFIG.PSU__HIGH_ADDRESS__ENABLE {1} \
   CONFIG.PSU__HPM0_FPD__NUM_READ_THREADS {4} \
   CONFIG.PSU__HPM0_FPD__NUM_WRITE_THREADS {4} \
   CONFIG.PSU__HPM0_LPD__NUM_READ_THREADS {4} \
   CONFIG.PSU__HPM0_LPD__NUM_WRITE_THREADS {4} \
   CONFIG.PSU__HPM1_FPD__NUM_READ_THREADS {4} \
   CONFIG.PSU__HPM1_FPD__NUM_WRITE_THREADS {4} \
   CONFIG.PSU__I2C0_LOOP_I2C1__ENABLE {0} \
   CONFIG.PSU__I2C0__GRP_INT__ENABLE {0} \
   CONFIG.PSU__I2C0__GRP_INT__IO {<Select>} \
   CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 14 .. 15} \
   CONFIG.PSU__I2C1__GRP_INT__ENABLE {0} \
   CONFIG.PSU__I2C1__GRP_INT__IO {<Select>} \
   CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 16 .. 17} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC0_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC1_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC2_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC3_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__TTC0__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC0__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC1__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC1__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC2__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC2__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC3__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC3__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__WDT0__ACT_FREQMHZ {99.990005} \
   CONFIG.PSU__IOU_SLCR__WDT0__FREQMHZ {99.990005} \
   CONFIG.PSU__IOU_SLCR__WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__IRQ_P2F_ADMA_CHAN__INT {0} \
   CONFIG.PSU__IRQ_P2F_AIB_AXI__INT {0} \
   CONFIG.PSU__IRQ_P2F_AMS__INT {0} \
   CONFIG.PSU__IRQ_P2F_APM_FPD__INT {0} \
   CONFIG.PSU__IRQ_P2F_APU_COMM__INT {0} \
   CONFIG.PSU__IRQ_P2F_APU_CPUMNT__INT {0} \
   CONFIG.PSU__IRQ_P2F_APU_CTI__INT {0} \
   CONFIG.PSU__IRQ_P2F_APU_EXTERR__INT {0} \
   CONFIG.PSU__IRQ_P2F_APU_IPI__INT {0} \
   CONFIG.PSU__IRQ_P2F_APU_L2ERR__INT {0} \
   CONFIG.PSU__IRQ_P2F_APU_PMU__INT {0} \
   CONFIG.PSU__IRQ_P2F_APU_REGS__INT {0} \
   CONFIG.PSU__IRQ_P2F_ATB_LPD__INT {0} \
   CONFIG.PSU__IRQ_P2F_CAN0__INT {0} \
   CONFIG.PSU__IRQ_P2F_CAN1__INT {0} \
   CONFIG.PSU__IRQ_P2F_CLKMON__INT {0} \
   CONFIG.PSU__IRQ_P2F_CSUPMU_WDT__INT {0} \
   CONFIG.PSU__IRQ_P2F_CSU_DMA__INT {0} \
   CONFIG.PSU__IRQ_P2F_CSU__INT {0} \
   CONFIG.PSU__IRQ_P2F_DDR_SS__INT {0} \
   CONFIG.PSU__IRQ_P2F_DPDMA__INT {0} \
   CONFIG.PSU__IRQ_P2F_DPORT__INT {0} \
   CONFIG.PSU__IRQ_P2F_EFUSE__INT {0} \
   CONFIG.PSU__IRQ_P2F_ENT0_WAKEUP__INT {0} \
   CONFIG.PSU__IRQ_P2F_ENT0__INT {0} \
   CONFIG.PSU__IRQ_P2F_ENT1_WAKEUP__INT {0} \
   CONFIG.PSU__IRQ_P2F_ENT1__INT {0} \
   CONFIG.PSU__IRQ_P2F_ENT2_WAKEUP__INT {0} \
   CONFIG.PSU__IRQ_P2F_ENT2__INT {0} \
   CONFIG.PSU__IRQ_P2F_ENT3_WAKEUP__INT {0} \
   CONFIG.PSU__IRQ_P2F_ENT3__INT {0} \
   CONFIG.PSU__IRQ_P2F_FPD_APB__INT {0} \
   CONFIG.PSU__IRQ_P2F_FPD_ATB_ERR__INT {0} \
   CONFIG.PSU__IRQ_P2F_FP_WDT__INT {0} \
   CONFIG.PSU__IRQ_P2F_GDMA_CHAN__INT {0} \
   CONFIG.PSU__IRQ_P2F_GPIO__INT {0} \
   CONFIG.PSU__IRQ_P2F_GPU__INT {0} \
   CONFIG.PSU__IRQ_P2F_I2C0__INT {0} \
   CONFIG.PSU__IRQ_P2F_I2C1__INT {0} \
   CONFIG.PSU__IRQ_P2F_LPD_APB__INT {0} \
   CONFIG.PSU__IRQ_P2F_LPD_APM__INT {0} \
   CONFIG.PSU__IRQ_P2F_LP_WDT__INT {0} \
   CONFIG.PSU__IRQ_P2F_NAND__INT {0} \
   CONFIG.PSU__IRQ_P2F_OCM_ERR__INT {0} \
   CONFIG.PSU__IRQ_P2F_PCIE_DMA__INT {0} \
   CONFIG.PSU__IRQ_P2F_PCIE_LEGACY__INT {0} \
   CONFIG.PSU__IRQ_P2F_PCIE_MSC__INT {0} \
   CONFIG.PSU__IRQ_P2F_PCIE_MSI__INT {0} \
   CONFIG.PSU__IRQ_P2F_PL_IPI__INT {0} \
   CONFIG.PSU__IRQ_P2F_QSPI__INT {0} \
   CONFIG.PSU__IRQ_P2F_R5_CORE0_ECC_ERR__INT {0} \
   CONFIG.PSU__IRQ_P2F_R5_CORE1_ECC_ERR__INT {0} \
   CONFIG.PSU__IRQ_P2F_RPU_IPI__INT {0} \
   CONFIG.PSU__IRQ_P2F_RPU_PERMON__INT {0} \
   CONFIG.PSU__IRQ_P2F_RTC_ALARM__INT {0} \
   CONFIG.PSU__IRQ_P2F_RTC_SECONDS__INT {0} \
   CONFIG.PSU__IRQ_P2F_SATA__INT {0} \
   CONFIG.PSU__IRQ_P2F_SDIO0_WAKE__INT {0} \
   CONFIG.PSU__IRQ_P2F_SDIO0__INT {0} \
   CONFIG.PSU__IRQ_P2F_SDIO1_WAKE__INT {0} \
   CONFIG.PSU__IRQ_P2F_SDIO1__INT {0} \
   CONFIG.PSU__IRQ_P2F_SPI0__INT {0} \
   CONFIG.PSU__IRQ_P2F_SPI1__INT {0} \
   CONFIG.PSU__IRQ_P2F_TTC0__INT0 {0} \
   CONFIG.PSU__IRQ_P2F_TTC0__INT1 {0} \
   CONFIG.PSU__IRQ_P2F_TTC0__INT2 {0} \
   CONFIG.PSU__IRQ_P2F_TTC1__INT0 {0} \
   CONFIG.PSU__IRQ_P2F_TTC1__INT1 {0} \
   CONFIG.PSU__IRQ_P2F_TTC1__INT2 {0} \
   CONFIG.PSU__IRQ_P2F_TTC2__INT0 {0} \
   CONFIG.PSU__IRQ_P2F_TTC2__INT1 {0} \
   CONFIG.PSU__IRQ_P2F_TTC2__INT2 {0} \
   CONFIG.PSU__IRQ_P2F_TTC3__INT0 {0} \
   CONFIG.PSU__IRQ_P2F_TTC3__INT1 {0} \
   CONFIG.PSU__IRQ_P2F_TTC3__INT2 {0} \
   CONFIG.PSU__IRQ_P2F_UART0__INT {0} \
   CONFIG.PSU__IRQ_P2F_UART1__INT {0} \
   CONFIG.PSU__IRQ_P2F_USB3_ENDPOINT__INT0 {0} \
   CONFIG.PSU__IRQ_P2F_USB3_ENDPOINT__INT1 {0} \
   CONFIG.PSU__IRQ_P2F_USB3_OTG__INT0 {0} \
   CONFIG.PSU__IRQ_P2F_USB3_OTG__INT1 {0} \
   CONFIG.PSU__IRQ_P2F_USB3_PMU_WAKEUP__INT {0} \
   CONFIG.PSU__IRQ_P2F_XMPU_FPD__INT {0} \
   CONFIG.PSU__IRQ_P2F_XMPU_LPD__INT {0} \
   CONFIG.PSU__IRQ_P2F__INTF_FPD_SMMU__INT {0} \
   CONFIG.PSU__IRQ_P2F__INTF_PPD_CCI__INT {0} \
   CONFIG.PSU__L2_BANK0__POWER__ON {1} \
   CONFIG.PSU__LPDMA0_COHERENCY {0} \
   CONFIG.PSU__LPDMA1_COHERENCY {0} \
   CONFIG.PSU__LPDMA2_COHERENCY {0} \
   CONFIG.PSU__LPDMA3_COHERENCY {0} \
   CONFIG.PSU__LPDMA4_COHERENCY {0} \
   CONFIG.PSU__LPDMA5_COHERENCY {0} \
   CONFIG.PSU__LPDMA6_COHERENCY {0} \
   CONFIG.PSU__LPDMA7_COHERENCY {0} \
   CONFIG.PSU__LPD_SLCR__CSUPMU_WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__LPD_SLCR__CSUPMU__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__LPD_SLCR__CSUPMU__FREQMHZ {100.000000} \
   CONFIG.PSU__MAXIGP0__DATA_WIDTH {128} \
   CONFIG.PSU__MAXIGP1__DATA_WIDTH {128} \
   CONFIG.PSU__MAXIGP2__DATA_WIDTH {128} \
   CONFIG.PSU__M_AXI_GP0_SUPPORTS_NARROW_BURST {1} \
   CONFIG.PSU__M_AXI_GP1_SUPPORTS_NARROW_BURST {1} \
   CONFIG.PSU__M_AXI_GP2_SUPPORTS_NARROW_BURST {1} \
   CONFIG.PSU__NAND_COHERENCY {0} \
   CONFIG.PSU__NAND_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__NAND__CHIP_ENABLE__ENABLE {0} \
   CONFIG.PSU__NAND__CHIP_ENABLE__IO {<Select>} \
   CONFIG.PSU__NAND__DATA_STROBE__ENABLE {0} \
   CONFIG.PSU__NAND__DATA_STROBE__IO {<Select>} \
   CONFIG.PSU__NAND__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__NAND__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__NAND__READY0_BUSY__ENABLE {0} \
   CONFIG.PSU__NAND__READY0_BUSY__IO {<Select>} \
   CONFIG.PSU__NAND__READY1_BUSY__ENABLE {0} \
   CONFIG.PSU__NAND__READY1_BUSY__IO {<Select>} \
   CONFIG.PSU__NAND__READY_BUSY__ENABLE {0} \
   CONFIG.PSU__NAND__READY_BUSY__IO {<Select>} \
   CONFIG.PSU__NUM_FABRIC_RESETS {1} \
   CONFIG.PSU__OCM_BANK0__POWER__ON {1} \
   CONFIG.PSU__OCM_BANK1__POWER__ON {1} \
   CONFIG.PSU__OCM_BANK2__POWER__ON {1} \
   CONFIG.PSU__OCM_BANK3__POWER__ON {1} \
   CONFIG.PSU__OVERRIDE_HPX_QOS {0} \
   CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \
   CONFIG.PSU__PCIE__ACS_VIOLAION {0} \
   CONFIG.PSU__PCIE__ACS_VIOLATION {0} \
   CONFIG.PSU__PCIE__AER_CAPABILITY {0} \
   CONFIG.PSU__PCIE__ATOMICOP_EGRESS_BLOCKED {0} \
   CONFIG.PSU__PCIE__BAR0_64BIT {0} \
   CONFIG.PSU__PCIE__BAR0_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR0_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR0_SCALE {<Select>} \
   CONFIG.PSU__PCIE__BAR0_SIZE {<Select>} \
   CONFIG.PSU__PCIE__BAR0_TYPE {<Select>} \
   CONFIG.PSU__PCIE__BAR0_VAL {} \
   CONFIG.PSU__PCIE__BAR1_64BIT {0} \
   CONFIG.PSU__PCIE__BAR1_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR1_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR1_SCALE {<Select>} \
   CONFIG.PSU__PCIE__BAR1_SIZE {<Select>} \
   CONFIG.PSU__PCIE__BAR1_TYPE {<Select>} \
   CONFIG.PSU__PCIE__BAR1_VAL {} \
   CONFIG.PSU__PCIE__BAR2_64BIT {0} \
   CONFIG.PSU__PCIE__BAR2_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR2_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR2_SCALE {<Select>} \
   CONFIG.PSU__PCIE__BAR2_SIZE {<Select>} \
   CONFIG.PSU__PCIE__BAR2_TYPE {<Select>} \
   CONFIG.PSU__PCIE__BAR2_VAL {} \
   CONFIG.PSU__PCIE__BAR3_64BIT {0} \
   CONFIG.PSU__PCIE__BAR3_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR3_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR3_SCALE {<Select>} \
   CONFIG.PSU__PCIE__BAR3_SIZE {<Select>} \
   CONFIG.PSU__PCIE__BAR3_TYPE {<Select>} \
   CONFIG.PSU__PCIE__BAR3_VAL {} \
   CONFIG.PSU__PCIE__BAR4_64BIT {0} \
   CONFIG.PSU__PCIE__BAR4_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR4_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR4_SCALE {<Select>} \
   CONFIG.PSU__PCIE__BAR4_SIZE {<Select>} \
   CONFIG.PSU__PCIE__BAR4_TYPE {<Select>} \
   CONFIG.PSU__PCIE__BAR4_VAL {} \
   CONFIG.PSU__PCIE__BAR5_64BIT {0} \
   CONFIG.PSU__PCIE__BAR5_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR5_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR5_SCALE {<Select>} \
   CONFIG.PSU__PCIE__BAR5_SIZE {<Select>} \
   CONFIG.PSU__PCIE__BAR5_TYPE {<Select>} \
   CONFIG.PSU__PCIE__BAR5_VAL {} \
   CONFIG.PSU__PCIE__BASE_CLASS_MENU {<Select>} \
   CONFIG.PSU__PCIE__BRIDGE_BAR_INDICATOR {<Select>} \
   CONFIG.PSU__PCIE__CAP_SLOT_IMPLEMENTED {<Select>} \
   CONFIG.PSU__PCIE__CLASS_CODE_BASE {} \
   CONFIG.PSU__PCIE__CLASS_CODE_INTERFACE {} \
   CONFIG.PSU__PCIE__CLASS_CODE_SUB {} \
   CONFIG.PSU__PCIE__CLASS_CODE_VALUE {} \
   CONFIG.PSU__PCIE__COMPLETER_ABORT {0} \
   CONFIG.PSU__PCIE__COMPLTION_TIMEOUT {0} \
   CONFIG.PSU__PCIE__CORRECTABLE_INT_ERR {0} \
   CONFIG.PSU__PCIE__CRS_SW_VISIBILITY {0} \
   CONFIG.PSU__PCIE__DEVICE_ID {} \
   CONFIG.PSU__PCIE__DEVICE_PORT_TYPE {<Select>} \
   CONFIG.PSU__PCIE__ECRC_CHECK {0} \
   CONFIG.PSU__PCIE__ECRC_ERR {0} \
   CONFIG.PSU__PCIE__ECRC_GEN {0} \
   CONFIG.PSU__PCIE__EROM_ENABLE {0} \
   CONFIG.PSU__PCIE__EROM_SCALE {<Select>} \
   CONFIG.PSU__PCIE__EROM_SIZE {<Select>} \
   CONFIG.PSU__PCIE__EROM_VAL {} \
   CONFIG.PSU__PCIE__FLOW_CONTROL_ERR {0} \
   CONFIG.PSU__PCIE__FLOW_CONTROL_PROTOCOL_ERR {0} \
   CONFIG.PSU__PCIE__HEADER_LOG_OVERFLOW {0} \
   CONFIG.PSU__PCIE__INTERFACE_WIDTH {<Select>} \
   CONFIG.PSU__PCIE__INTX_GENERATION {0} \
   CONFIG.PSU__PCIE__INTX_PIN {<Select>} \
   CONFIG.PSU__PCIE__LANE0__ENABLE {0} \
   CONFIG.PSU__PCIE__LANE0__IO {<Select>} \
   CONFIG.PSU__PCIE__LANE1__ENABLE {0} \
   CONFIG.PSU__PCIE__LANE1__IO {<Select>} \
   CONFIG.PSU__PCIE__LANE2__ENABLE {0} \
   CONFIG.PSU__PCIE__LANE2__IO {<Select>} \
   CONFIG.PSU__PCIE__LANE3__ENABLE {0} \
   CONFIG.PSU__PCIE__LANE3__IO {<Select>} \
   CONFIG.PSU__PCIE__LEGACY_INTERRUPT {<Select>} \
   CONFIG.PSU__PCIE__LINK_SPEED {<Select>} \
   CONFIG.PSU__PCIE__MAXIMUM_LINK_WIDTH {<Select>} \
   CONFIG.PSU__PCIE__MAX_PAYLOAD_SIZE {<Select>} \
   CONFIG.PSU__PCIE__MC_BLOCKED_TLP {0} \
   CONFIG.PSU__PCIE__MSIX_BAR_INDICATOR {} \
   CONFIG.PSU__PCIE__MSIX_CAPABILITY {0} \
   CONFIG.PSU__PCIE__MSIX_PBA_BAR_INDICATOR {} \
   CONFIG.PSU__PCIE__MSIX_PBA_OFFSET {0} \
   CONFIG.PSU__PCIE__MSIX_TABLE_OFFSET {0} \
   CONFIG.PSU__PCIE__MSIX_TABLE_SIZE {0} \
   CONFIG.PSU__PCIE__MSI_64BIT_ADDR_CAPABLE {0} \
   CONFIG.PSU__PCIE__MSI_CAPABILITY {0} \
   CONFIG.PSU__PCIE__MSI_MULTIPLE_MSG_CAPABLE {<Select>} \
   CONFIG.PSU__PCIE__MULTIHEADER {0} \
   CONFIG.PSU__PCIE__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__PCIE__PERIPHERAL__ENDPOINT_ENABLE {1} \
   CONFIG.PSU__PCIE__PERIPHERAL__ENDPOINT_IO {<Select>} \
   CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_ENABLE {0} \
   CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_IO {<Select>} \
   CONFIG.PSU__PCIE__PERM_ROOT_ERR_UPDATE {0} \
   CONFIG.PSU__PCIE__RECEIVER_ERR {0} \
   CONFIG.PSU__PCIE__RECEIVER_OVERFLOW {0} \
   CONFIG.PSU__PCIE__REF_CLK_FREQ {<Select>} \
   CONFIG.PSU__PCIE__REF_CLK_SEL {<Select>} \
   CONFIG.PSU__PCIE__RESET__POLARITY {Active Low} \
   CONFIG.PSU__PCIE__REVISION_ID {} \
   CONFIG.PSU__PCIE__SUBSYSTEM_ID {} \
   CONFIG.PSU__PCIE__SUBSYSTEM_VENDOR_ID {} \
   CONFIG.PSU__PCIE__SUB_CLASS_INTERFACE_MENU {<Select>} \
   CONFIG.PSU__PCIE__SURPRISE_DOWN {0} \
   CONFIG.PSU__PCIE__TLP_PREFIX_BLOCKED {0} \
   CONFIG.PSU__PCIE__UNCORRECTABL_INT_ERR {0} \
   CONFIG.PSU__PCIE__USE_CLASS_CODE_LOOKUP_ASSISTANT {<Select>} \
   CONFIG.PSU__PCIE__VENDOR_ID {} \
   CONFIG.PSU__PJTAG__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__PJTAG__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__PL_CLK0_BUF {TRUE} \
   CONFIG.PSU__PL_CLK1_BUF {TRUE} \
   CONFIG.PSU__PL_CLK2_BUF {TRUE} \
   CONFIG.PSU__PL_CLK3_BUF {TRUE} \
   CONFIG.PSU__PL__POWER__ON {1} \
   CONFIG.PSU__PMU_COHERENCY {0} \
   CONFIG.PSU__PMU__AIBACK__ENABLE {0} \
   CONFIG.PSU__PMU__EMIO_GPI__ENABLE {0} \
   CONFIG.PSU__PMU__EMIO_GPO__ENABLE {0} \
   CONFIG.PSU__PMU__GPI0__ENABLE {0} \
   CONFIG.PSU__PMU__GPI0__IO {<Select>} \
   CONFIG.PSU__PMU__GPI1__ENABLE {0} \
   CONFIG.PSU__PMU__GPI1__IO {<Select>} \
   CONFIG.PSU__PMU__GPI2__ENABLE {0} \
   CONFIG.PSU__PMU__GPI2__IO {<Select>} \
   CONFIG.PSU__PMU__GPI3__ENABLE {0} \
   CONFIG.PSU__PMU__GPI3__IO {<Select>} \
   CONFIG.PSU__PMU__GPI4__ENABLE {0} \
   CONFIG.PSU__PMU__GPI4__IO {<Select>} \
   CONFIG.PSU__PMU__GPI5__ENABLE {0} \
   CONFIG.PSU__PMU__GPI5__IO {<Select>} \
   CONFIG.PSU__PMU__GPO0__ENABLE {1} \
   CONFIG.PSU__PMU__GPO0__IO {MIO 32} \
   CONFIG.PSU__PMU__GPO1__ENABLE {1} \
   CONFIG.PSU__PMU__GPO1__IO {MIO 33} \
   CONFIG.PSU__PMU__GPO2__ENABLE {1} \
   CONFIG.PSU__PMU__GPO2__IO {MIO 34} \
   CONFIG.PSU__PMU__GPO2__POLARITY {low} \
   CONFIG.PSU__PMU__GPO3__ENABLE {1} \
   CONFIG.PSU__PMU__GPO3__IO {MIO 35} \
   CONFIG.PSU__PMU__GPO3__POLARITY {low} \
   CONFIG.PSU__PMU__GPO4__ENABLE {1} \
   CONFIG.PSU__PMU__GPO4__IO {MIO 36} \
   CONFIG.PSU__PMU__GPO4__POLARITY {low} \
   CONFIG.PSU__PMU__GPO5__ENABLE {1} \
   CONFIG.PSU__PMU__GPO5__IO {MIO 37} \
   CONFIG.PSU__PMU__GPO5__POLARITY {low} \
   CONFIG.PSU__PMU__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__PMU__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__PMU__PLERROR__ENABLE {0} \
   CONFIG.PSU__PRESET_APPLIED {1} \
   CONFIG.PSU__PROTECTION__DDR_SEGMENTS {NONE} \
   CONFIG.PSU__PROTECTION__DEBUG {0} \
   CONFIG.PSU__PROTECTION__ENABLE {0} \
   CONFIG.PSU__PROTECTION__FPD_SEGMENTS {SA:0xFD1A0000 ;SIZE:1280;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware     |     SA:0xFD000000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware     |     SA:0xFD010000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware     |     SA:0xFD020000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware     |     SA:0xFD030000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware     |     SA:0xFD040000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware     |     SA:0xFD050000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware     |     SA:0xFD610000 ;SIZE:512;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware     |     SA:0xFD5D0000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware} \
   CONFIG.PSU__PROTECTION__LOCK_UNUSED_SEGMENTS {0} \
   CONFIG.PSU__PROTECTION__LPD_SEGMENTS {SA:0xFF980000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF5E0000 ;SIZE:2560;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFFCC0000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF180000 ;SIZE:768;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF410000 ;SIZE:640;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFFA70000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware|SA:0xFF9A0000 ;SIZE:64;UNIT:KB ;RegionTZ:Secure ;WrAllowed:Read/Write;subsystemId:PMU Firmware} \
   CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;0|USB0:NonSecure;1|S_AXI_LPD:NA;0|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;1|S_AXI_HP3_FPD:NA;1|S_AXI_HP2_FPD:NA;1|S_AXI_HP1_FPD:NA;1|S_AXI_HP0_FPD:NA;1|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;1|SD0:NonSecure;0|SATA1:NonSecure;1|SATA0:NonSecure;1|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;1|PMU:NA;1|PCIe:NonSecure;0|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;1|GEM2:NonSecure;0|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;1|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1} \
   CONFIG.PSU__PROTECTION__MASTERS_TZ {GEM0:NonSecure|SD1:NonSecure|GEM2:NonSecure|GEM1:NonSecure|GEM3:NonSecure|PCIe:NonSecure|DP:NonSecure|NAND:NonSecure|GPU:NonSecure|SATA0:NonSecure|SATA1:NonSecure|USB1:NonSecure|USB0:NonSecure|LDMA:NonSecure|FDMA:NonSecure|QSPI:NonSecure|SD0:NonSecure} \
   CONFIG.PSU__PROTECTION__OCM_SEGMENTS {NONE} \
   CONFIG.PSU__PROTECTION__PRESUBSYSTEMS {NONE} \
   CONFIG.PSU__PROTECTION__SLAVES {LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;1|LPD;USB3_0;FF9D0000;FF9DFFFF;1|LPD;UART1;FF010000;FF01FFFF;1|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;1|LPD;TTC2;FF130000;FF13FFFF;1|LPD;TTC1;FF120000;FF12FFFF;1|LPD;TTC0;FF110000;FF11FFFF;1|FPD;SWDT1;FD4D0000;FD4DFFFF;1|LPD;SWDT0;FF150000;FF15FFFF;1|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;1|LPD;SD0;FF160000;FF16FFFF;0|FPD;SATA;FD0C0000;FD0CFFFF;1|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;1|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;0|FPD;PCIE_LOW;E0000000;EFFFFFFF;0|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;0|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;0|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;0|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;0|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;1|LPD;I2C0;FF020000;FF02FFFF;1|FPD;GPU;FD4B0000;FD4BFFFF;1|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;1|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_GPV;FD700000;FD7FFFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display Port;FD4A0000;FD4AFFFF;1|FPD;DPDMA;FD4C0000;FD4CFFFF;1|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;87FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;0|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|FPD;CCI_GPV;FD6E0000;FD6EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;1|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1} \
   CONFIG.PSU__PROTECTION__SUBSYSTEMS {PMU Firmware:PMU} \
   CONFIG.PSU__PSS_ALT_REF_CLK__ENABLE {0} \
   CONFIG.PSU__PSS_ALT_REF_CLK__FREQMHZ {33.333} \
   CONFIG.PSU__PSS_ALT_REF_CLK__IO {<Select>} \
   CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.330} \
   CONFIG.PSU__QSPI_COHERENCY {0} \
   CONFIG.PSU__QSPI_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} \
   CONFIG.PSU__QSPI__GRP_FBCLK__IO {MIO 6} \
   CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
   CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__QSPI__PERIPHERAL__IO {MIO 0 .. 12} \
   CONFIG.PSU__QSPI__PERIPHERAL__MODE {Dual Parallel} \
   CONFIG.PSU__REPORT__DBGLOG {0} \
   CONFIG.PSU__RPU_COHERENCY {0} \
   CONFIG.PSU__RPU__POWER__ON {1} \
   CONFIG.PSU__SATA__LANE0__ENABLE {0} \
   CONFIG.PSU__SATA__LANE0__IO {<Select>} \
   CONFIG.PSU__SATA__LANE1__ENABLE {1} \
   CONFIG.PSU__SATA__LANE1__IO {GT Lane3} \
   CONFIG.PSU__SATA__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SATA__REF_CLK_FREQ {125} \
   CONFIG.PSU__SATA__REF_CLK_SEL {Ref Clk1} \
   CONFIG.PSU__SAXIGP0__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP1__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP3__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP4__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP5__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP6__DATA_WIDTH {128} \
   CONFIG.PSU__SD0_COHERENCY {0} \
   CONFIG.PSU__SD0_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__SD0__DATA_TRANSFER_MODE {<Select>} \
   CONFIG.PSU__SD0__GRP_CD__ENABLE {0} \
   CONFIG.PSU__SD0__GRP_CD__IO {<Select>} \
   CONFIG.PSU__SD0__GRP_POW__ENABLE {0} \
   CONFIG.PSU__SD0__GRP_POW__IO {<Select>} \
   CONFIG.PSU__SD0__GRP_WP__ENABLE {0} \
   CONFIG.PSU__SD0__GRP_WP__IO {<Select>} \
   CONFIG.PSU__SD0__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__SD0__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__SD0__RESET__ENABLE {0} \
   CONFIG.PSU__SD0__SLOT_TYPE {<Select>} \
   CONFIG.PSU__SD1_COHERENCY {0} \
   CONFIG.PSU__SD1_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__SD1__DATA_TRANSFER_MODE {8Bit} \
   CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
   CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \
   CONFIG.PSU__SD1__GRP_POW__ENABLE {1} \
   CONFIG.PSU__SD1__GRP_POW__IO {MIO 43} \
   CONFIG.PSU__SD1__GRP_WP__ENABLE {1} \
   CONFIG.PSU__SD1__GRP_WP__IO {MIO 44} \
   CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 39 .. 51} \
   CONFIG.PSU__SD1__RESET__ENABLE {0} \
   CONFIG.PSU__SD1__SLOT_TYPE {SD 3.0} \
   CONFIG.PSU__SPI0_LOOP_SPI1__ENABLE {0} \
   CONFIG.PSU__SPI0__GRP_SS0__ENABLE {0} \
   CONFIG.PSU__SPI0__GRP_SS0__IO {<Select>} \
   CONFIG.PSU__SPI0__GRP_SS1__ENABLE {0} \
   CONFIG.PSU__SPI0__GRP_SS1__IO {<Select>} \
   CONFIG.PSU__SPI0__GRP_SS2__ENABLE {0} \
   CONFIG.PSU__SPI0__GRP_SS2__IO {<Select>} \
   CONFIG.PSU__SPI0__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__SPI0__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__SPI1__GRP_SS0__ENABLE {0} \
   CONFIG.PSU__SPI1__GRP_SS0__IO {<Select>} \
   CONFIG.PSU__SPI1__GRP_SS1__ENABLE {0} \
   CONFIG.PSU__SPI1__GRP_SS1__IO {<Select>} \
   CONFIG.PSU__SPI1__GRP_SS2__ENABLE {0} \
   CONFIG.PSU__SPI1__GRP_SS2__IO {<Select>} \
   CONFIG.PSU__SPI1__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__SPI1__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__SWDT0__CLOCK__ENABLE {0} \
   CONFIG.PSU__SWDT0__CLOCK__IO {<Select>} \
   CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SWDT0__PERIPHERAL__IO {NA} \
   CONFIG.PSU__SWDT0__RESET__ENABLE {0} \
   CONFIG.PSU__SWDT0__RESET__IO {<Select>} \
   CONFIG.PSU__SWDT1__CLOCK__ENABLE {0} \
   CONFIG.PSU__SWDT1__CLOCK__IO {<Select>} \
   CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SWDT1__PERIPHERAL__IO {NA} \
   CONFIG.PSU__SWDT1__RESET__ENABLE {0} \
   CONFIG.PSU__SWDT1__RESET__IO {<Select>} \
   CONFIG.PSU__TCM0A__POWER__ON {1} \
   CONFIG.PSU__TCM0B__POWER__ON {1} \
   CONFIG.PSU__TCM1A__POWER__ON {1} \
   CONFIG.PSU__TCM1B__POWER__ON {1} \
   CONFIG.PSU__TESTSCAN__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__TRACE_PIPELINE_WIDTH {8} \
   CONFIG.PSU__TRACE__INTERNAL_WIDTH {32} \
   CONFIG.PSU__TRACE__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__TRACE__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__TRACE__WIDTH {<Select>} \
   CONFIG.PSU__TRISTATE__INVERTED {1} \
   CONFIG.PSU__TSU__BUFG_PORT_PAIR {0} \
   CONFIG.PSU__TTC0__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC0__CLOCK__IO {<Select>} \
   CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC0__PERIPHERAL__IO {NA} \
   CONFIG.PSU__TTC0__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC0__WAVEOUT__IO {<Select>} \
   CONFIG.PSU__TTC1__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC1__CLOCK__IO {<Select>} \
   CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC1__PERIPHERAL__IO {NA} \
   CONFIG.PSU__TTC1__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC1__WAVEOUT__IO {<Select>} \
   CONFIG.PSU__TTC2__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC2__CLOCK__IO {<Select>} \
   CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC2__PERIPHERAL__IO {NA} \
   CONFIG.PSU__TTC2__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC2__WAVEOUT__IO {<Select>} \
   CONFIG.PSU__TTC3__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC3__CLOCK__IO {<Select>} \
   CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC3__PERIPHERAL__IO {NA} \
   CONFIG.PSU__TTC3__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC3__WAVEOUT__IO {<Select>} \
   CONFIG.PSU__UART0_LOOP_UART1__ENABLE {0} \
   CONFIG.PSU__UART0__BAUD_RATE {115200} \
   CONFIG.PSU__UART0__MODEM__ENABLE {0} \
   CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 18 .. 19} \
   CONFIG.PSU__UART1__BAUD_RATE {115200} \
   CONFIG.PSU__UART1__MODEM__ENABLE {0} \
   CONFIG.PSU__UART1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART1__PERIPHERAL__IO {MIO 20 .. 21} \
   CONFIG.PSU__USB0_COHERENCY {0} \
   CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB0__PERIPHERAL__IO {MIO 52 .. 63} \
   CONFIG.PSU__USB0__REF_CLK_FREQ {26} \
   CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk2} \
   CONFIG.PSU__USB0__RESET__ENABLE {0} \
   CONFIG.PSU__USB1_COHERENCY {0} \
   CONFIG.PSU__USB1__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__USB1__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__USB1__REF_CLK_FREQ {<Select>} \
   CONFIG.PSU__USB1__REF_CLK_SEL {<Select>} \
   CONFIG.PSU__USB1__RESET__ENABLE {0} \
   CONFIG.PSU__USB2_0__EMIO__ENABLE {0} \
   CONFIG.PSU__USB2_1__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_0__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \
   CONFIG.PSU__USB3_1__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_1__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__USB3_1__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__USB__RESET__MODE {Boot Pin} \
   CONFIG.PSU__USB__RESET__POLARITY {Active Low} \
   CONFIG.PSU__USE_DIFF_RW_CLK_GP0 {0} \
   CONFIG.PSU__USE_DIFF_RW_CLK_GP1 {0} \
   CONFIG.PSU__USE_DIFF_RW_CLK_GP2 {0} \
   CONFIG.PSU__USE_DIFF_RW_CLK_GP3 {0} \
   CONFIG.PSU__USE_DIFF_RW_CLK_GP4 {0} \
   CONFIG.PSU__USE_DIFF_RW_CLK_GP5 {0} \
   CONFIG.PSU__USE_DIFF_RW_CLK_GP6 {0} \
   CONFIG.PSU__USE__ADMA {0} \
   CONFIG.PSU__USE__APU_LEGACY_INTERRUPT {0} \
   CONFIG.PSU__USE__AUDIO {0} \
   CONFIG.PSU__USE__CLK {0} \
   CONFIG.PSU__USE__CLK0 {0} \
   CONFIG.PSU__USE__CLK1 {0} \
   CONFIG.PSU__USE__CLK2 {0} \
   CONFIG.PSU__USE__CLK3 {0} \
   CONFIG.PSU__USE__CROSS_TRIGGER {0} \
   CONFIG.PSU__USE__DDR_INTF_REQUESTED {0} \
   CONFIG.PSU__USE__DEBUG__TEST {0} \
   CONFIG.PSU__USE__EVENT_RPU {0} \
   CONFIG.PSU__USE__FABRIC__RST {1} \
   CONFIG.PSU__USE__FTM {0} \
   CONFIG.PSU__USE__GDMA {0} \
   CONFIG.PSU__USE__IRQ {0} \
   CONFIG.PSU__USE__IRQ0 {1} \
   CONFIG.PSU__USE__IRQ1 {1} \
   CONFIG.PSU__USE__M_AXI_GP0 {1} \
   CONFIG.PSU__USE__M_AXI_GP1 {1} \
   CONFIG.PSU__USE__M_AXI_GP2 {0} \
   CONFIG.PSU__USE__PROC_EVENT_BUS {0} \
   CONFIG.PSU__USE__RPU_LEGACY_INTERRUPT {0} \
   CONFIG.PSU__USE__RST0 {0} \
   CONFIG.PSU__USE__RST1 {0} \
   CONFIG.PSU__USE__RST2 {0} \
   CONFIG.PSU__USE__RST3 {0} \
   CONFIG.PSU__USE__RTC {0} \
   CONFIG.PSU__USE__STM {0} \
   CONFIG.PSU__USE__S_AXI_ACE {0} \
   CONFIG.PSU__USE__S_AXI_ACP {0} \
   CONFIG.PSU__USE__S_AXI_GP0 {1} \
   CONFIG.PSU__USE__S_AXI_GP1 {0} \
   CONFIG.PSU__USE__S_AXI_GP2 {1} \
   CONFIG.PSU__USE__S_AXI_GP3 {1} \
   CONFIG.PSU__USE__S_AXI_GP4 {1} \
   CONFIG.PSU__USE__S_AXI_GP5 {1} \
   CONFIG.PSU__USE__S_AXI_GP6 {0} \
   CONFIG.PSU__USE__USB3_0_HUB {0} \
   CONFIG.PSU__USE__USB3_1_HUB {0} \
   CONFIG.PSU__USE__VIDEO {0} \
   CONFIG.PSU__VIDEO_REF_CLK__ENABLE {0} \
   CONFIG.PSU__VIDEO_REF_CLK__FREQMHZ {33.333} \
   CONFIG.PSU__VIDEO_REF_CLK__IO {<Select>} \
   CONFIG.QSPI_BOARD_INTERFACE {custom} \
   CONFIG.SATA_BOARD_INTERFACE {custom} \
   CONFIG.SD0_BOARD_INTERFACE {custom} \
   CONFIG.SD1_BOARD_INTERFACE {custom} \
   CONFIG.SPI0_BOARD_INTERFACE {custom} \
   CONFIG.SPI1_BOARD_INTERFACE {custom} \
   CONFIG.SUBPRESET1 {Custom} \
   CONFIG.SUBPRESET2 {Custom} \
   CONFIG.SWDT0_BOARD_INTERFACE {custom} \
   CONFIG.SWDT1_BOARD_INTERFACE {custom} \
   CONFIG.TRACE_BOARD_INTERFACE {custom} \
   CONFIG.TTC0_BOARD_INTERFACE {custom} \
   CONFIG.TTC1_BOARD_INTERFACE {custom} \
   CONFIG.TTC2_BOARD_INTERFACE {custom} \
   CONFIG.TTC3_BOARD_INTERFACE {custom} \
   CONFIG.UART0_BOARD_INTERFACE {custom} \
   CONFIG.UART1_BOARD_INTERFACE {custom} \
   CONFIG.USB0_BOARD_INTERFACE {custom} \
   CONFIG.USB1_BOARD_INTERFACE {custom} \
 ] $zynq_us

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M01_AXI_0] [get_bd_intf_pins axi_interconnect_1/M01_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M04_AXI_0] [get_bd_intf_pins axi_interconnect_1/M04_AXI]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins M00_AXI_0] [get_bd_intf_pins axi_interconnect_1/M00_AXI]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins M11_AXI] [get_bd_intf_pins axi_interconnect_1/M11_AXI]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins CLK_IN1_D] [get_bd_intf_pins clk_wiz_0/CLK_IN1_D]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins S_AXI_HPC0_FPD] [get_bd_intf_pins zynq_us/S_AXI_HPC0_FPD]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins M06_AXI_0] [get_bd_intf_pins axi_interconnect_1/M06_AXI]
  connect_bd_intf_net -intf_net Conn8 [get_bd_intf_pins M03_AXI_0] [get_bd_intf_pins axi_interconnect_1/M03_AXI]
  connect_bd_intf_net -intf_net Conn9 [get_bd_intf_pins S_AXI_HP1_FPD] [get_bd_intf_pins zynq_us/S_AXI_HP1_FPD]
  connect_bd_intf_net -intf_net Conn10 [get_bd_intf_pins S_AXI_HP2_FPD] [get_bd_intf_pins zynq_us/S_AXI_HP2_FPD]
  connect_bd_intf_net -intf_net Conn11 [get_bd_intf_pins S_AXI_HP0_FPD] [get_bd_intf_pins zynq_us/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net Conn12 [get_bd_intf_pins M02_AXI_0] [get_bd_intf_pins axi_interconnect_1/M02_AXI]
  connect_bd_intf_net -intf_net Conn13 [get_bd_intf_pins M05_AXI_0] [get_bd_intf_pins axi_interconnect_1/M05_AXI]
  connect_bd_intf_net -intf_net Conn14 [get_bd_intf_pins M08_AXI_0] [get_bd_intf_pins axi_interconnect_1/M08_AXI]
  connect_bd_intf_net -intf_net Conn15 [get_bd_intf_pins S_AXI_HP3_FPD] [get_bd_intf_pins zynq_us/S_AXI_HP3_FPD]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins M00_AXI1] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins M01_AXI1] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M07_AXI [get_bd_intf_pins M07_AXI_0] [get_bd_intf_pins axi_interconnect_1/M07_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M09_AXI [get_bd_intf_pins M09_AXI] [get_bd_intf_pins axi_interconnect_1/M09_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M10_AXI [get_bd_intf_pins M10_AXI] [get_bd_intf_pins axi_interconnect_1/M10_AXI]
  connect_bd_intf_net -intf_net zynq_us_M_AXI_HPM0_FPD [get_bd_intf_pins axi_interconnect_1/S00_AXI] [get_bd_intf_pins zynq_us/M_AXI_HPM0_FPD]
  connect_bd_intf_net -intf_net [get_bd_intf_nets zynq_us_M_AXI_HPM0_FPD] [get_bd_intf_pins S00_AXI] [get_bd_intf_pins zynq_us/M_AXI_HPM0_FPD]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets zynq_us_M_AXI_HPM0_FPD]
  connect_bd_intf_net -intf_net zynq_us_M_AXI_HPM0_LPD [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins zynq_us/M_AXI_HPM1_FPD]
  connect_bd_intf_net -intf_net [get_bd_intf_nets zynq_us_M_AXI_HPM0_LPD] [get_bd_intf_pins S00_AXI1] [get_bd_intf_pins zynq_us/M_AXI_HPM1_FPD]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_intf_nets zynq_us_M_AXI_HPM0_LPD]

  # Create port connections
  connect_bd_net -net ARESETN_1 [get_bd_pins ARESETN] [get_bd_pins axi_interconnect_1/ARESETN]
  connect_bd_net -net In2_1 [get_bd_pins In2] [get_bd_pins xlconcat0/In2]
  connect_bd_net -net In3_1 [get_bd_pins In3] [get_bd_pins xlconcat0/In3]
  connect_bd_net -net In4_1 [get_bd_pins In4] [get_bd_pins xlconcat0/In6]
  connect_bd_net -net In5_1 [get_bd_pins In5] [get_bd_pins xlconcat0/In5]
  connect_bd_net -net In6_1 [get_bd_pins In6] [get_bd_pins xlconcat0/In4]
  connect_bd_net -net In7_1 [get_bd_pins In7] [get_bd_pins zynq_us/pl_ps_irq1]
  connect_bd_net -net M00_ARESETN_1 [get_bd_pins M00_ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_1/M08_ARESETN]
  connect_bd_net -net net_bdry_in_hdmi_rx_irq [get_bd_pins uhdsdi_tx_irq] [get_bd_pins xlconcat0/In1]
  connect_bd_net -net net_bdry_in_vphy_irq [get_bd_pins uhdsdi_rx_irq] [get_bd_pins xlconcat0/In0]
  connect_bd_net -net net_xlconcat0_dout [get_bd_pins xlconcat0/dout] [get_bd_pins zynq_us/pl_ps_irq0]
  connect_bd_net -net net_zynq_us_pl_clk0 [get_bd_pins s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_1/M01_ACLK] [get_bd_pins axi_interconnect_1/M02_ACLK] [get_bd_pins axi_interconnect_1/M03_ACLK] [get_bd_pins axi_interconnect_1/M04_ACLK] [get_bd_pins axi_interconnect_1/M05_ACLK] [get_bd_pins axi_interconnect_1/M06_ACLK] [get_bd_pins axi_interconnect_1/M07_ACLK] [get_bd_pins axi_interconnect_1/M09_ACLK] [get_bd_pins axi_interconnect_1/M10_ACLK] [get_bd_pins axi_interconnect_1/M11_ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins zynq_us/maxihpm0_fpd_aclk] [get_bd_pins zynq_us/maxihpm1_fpd_aclk] [get_bd_pins zynq_us/pl_clk0]
  connect_bd_net -net net_zynq_us_pl_clk1 [get_bd_pins sys_clk] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_1/M08_ACLK] [get_bd_pins zynq_us/pl_clk1] [get_bd_pins zynq_us/saxihp0_fpd_aclk] [get_bd_pins zynq_us/saxihp1_fpd_aclk] [get_bd_pins zynq_us/saxihp2_fpd_aclk] [get_bd_pins zynq_us/saxihp3_fpd_aclk] [get_bd_pins zynq_us/saxihpc0_fpd_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_1/M01_ARESETN] [get_bd_pins axi_interconnect_1/M02_ARESETN] [get_bd_pins axi_interconnect_1/M03_ARESETN] [get_bd_pins axi_interconnect_1/M04_ARESETN] [get_bd_pins axi_interconnect_1/M05_ARESETN] [get_bd_pins axi_interconnect_1/M06_ARESETN] [get_bd_pins axi_interconnect_1/M07_ARESETN] [get_bd_pins axi_interconnect_1/M09_ARESETN] [get_bd_pins axi_interconnect_1/M10_ARESETN] [get_bd_pins axi_interconnect_1/M11_ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins dcm_locked] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net zynq_us_emio_gpio_o [get_bd_pins emio_gpio_o] [get_bd_pins zynq_us/emio_gpio_o]
  connect_bd_net -net zynq_us_pl_clk2 [get_bd_pins clk_out3] [get_bd_pins zynq_us/pl_clk2]
  connect_bd_net -net zynq_us_pl_clk3 [get_bd_pins pl_clk3] [get_bd_pins zynq_us/pl_clk3]
  connect_bd_net -net zynq_us_pl_resetn0 [get_bd_pins pl_resetn0] [get_bd_pins zynq_us/pl_resetn0]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: sdi_tx_output
proc create_hier_cell_sdi_tx_output { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_sdi_tx_output() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_CTRL_SB_TX

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_TX

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:sdi_native_rtl:2.0 SDI_TX_ANC_DS_IN

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:sdi_native_rtl:2.0 SDI_TX_ANC_DS_OUT

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_STS_SB_TX

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_tx_ss

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_frm_rd

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_mixer


  # Create pins
  create_bd_pin -dir I -type rst frm_rd_rst_n
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir O -from 0 -to 0 -type intr interrupt1
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_arstn
  create_bd_pin -dir O -from 31 -to 0 sdi_tx_anc_ctrl_out
  create_bd_pin -dir O -type intr sdi_tx_irq
  create_bd_pin -dir I -type rst sdi_tx_rst
  create_bd_pin -dir I -from 0 -to 0 -type rst tx_mixer_rst
  create_bd_pin -dir I -type clk txoutclk
  create_bd_pin -dir I -type rst video_in_arstn
  create_bd_pin -dir I -type clk video_in_clk

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter axis_subset_converter_0 ]
  set_property -dict [ list \
   CONFIG.M_HAS_TKEEP {1} \
   CONFIG.M_HAS_TLAST {1} \
   CONFIG.M_HAS_TSTRB {1} \
   CONFIG.M_TDATA_NUM_BYTES {8} \
   CONFIG.M_TDEST_WIDTH {1} \
   CONFIG.M_TID_WIDTH {1} \
   CONFIG.M_TUSER_WIDTH {1} \
   CONFIG.S_HAS_TKEEP {1} \
   CONFIG.S_HAS_TLAST {1} \
   CONFIG.S_HAS_TSTRB {1} \
   CONFIG.S_TDATA_NUM_BYTES {6} \
   CONFIG.S_TDEST_WIDTH {1} \
   CONFIG.S_TID_WIDTH {1} \
   CONFIG.S_TUSER_WIDTH {1} \
   CONFIG.TDATA_REMAP {4'b0000,tdata[47:40],2'b00,tdata[39:32],2'b00,tdata[31:24],2'b00,tdata[23:16],2'b00,tdata[15:8],2'b00,tdata[7:0],2'b00} \
   CONFIG.TDEST_REMAP {tdest[0:0]} \
   CONFIG.TID_REMAP {tid[0:0]} \
   CONFIG.TKEEP_REMAP {2'b11,tkeep[5:0]} \
   CONFIG.TLAST_REMAP {tlast[0]} \
   CONFIG.TSTRB_REMAP {2'b11,tstrb[5:0]} \
   CONFIG.TUSER_REMAP {tuser[0:0]} \
 ] $axis_subset_converter_0

  # Create instance: v_frmbuf_rd_0, and set properties
  set v_frmbuf_rd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_rd v_frmbuf_rd_0 ]
  set_property -dict [ list \
   CONFIG.HAS_BGR8 {1} \
   CONFIG.HAS_BGRX8 {1} \
   CONFIG.HAS_INTERLACED {1} \
   CONFIG.HAS_RGB8 {1} \
   CONFIG.HAS_RGBX8 {1} \
   CONFIG.HAS_RGBX10 {0} \
   CONFIG.HAS_UYVY8 {1} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_YUV8 {1} \
   CONFIG.HAS_YUVX8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV10 {0} \
   CONFIG.HAS_Y_UV10_420 {0} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_COLS {3840} \
   CONFIG.MAX_DATA_WIDTH {8} \
   CONFIG.MAX_NR_PLANES {2} \
 ] $v_frmbuf_rd_0

  # Create instance: v_mix_0, and set properties
  set v_mix_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_mix v_mix_0 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {64} \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO1_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO2_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO3_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO4_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO5_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO6_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO7_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO8_DATA_WIDTH {128} \
   CONFIG.LAYER1_ALPHA {true} \
   CONFIG.LAYER1_VIDEO_FORMAT {19} \
   CONFIG.LAYER2_ALPHA {true} \
   CONFIG.LAYER2_VIDEO_FORMAT {19} \
   CONFIG.LAYER3_ALPHA {true} \
   CONFIG.LAYER3_VIDEO_FORMAT {26} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
   CONFIG.VIDEO_FORMAT {2} \
 ] $v_mix_0

  # Create instance: v_smpte_uhdsdi_tx_ss, and set properties
  set v_smpte_uhdsdi_tx_ss [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_smpte_uhdsdi_tx_ss v_smpte_uhdsdi_tx_ss ]
  set_property -dict [ list \
   CONFIG.C_EXDES_CONFIG {Pass-through_with_Picxo} \
   CONFIG.C_INCLUDE_ADV_FEATURES {true} \
 ] $v_smpte_uhdsdi_tx_ss

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axi_mm_video1] [get_bd_intf_pins v_mix_0/m_axi_mm_video1]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axi_mm_video2] [get_bd_intf_pins v_mix_0/m_axi_mm_video2]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axi_mm_video3] [get_bd_intf_pins v_mix_0/m_axi_mm_video3]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins SDI_TX_ANC_DS_IN] [get_bd_intf_pins v_smpte_uhdsdi_tx_ss/SDI_TX_ANC_DS_IN]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins v_smpte_uhdsdi_tx_ss/VIDEO_IN]
  connect_bd_intf_net -intf_net s_axi_CTRL2_1 [get_bd_intf_pins s_axi_mixer] [get_bd_intf_pins v_mix_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net v_frmbuf_rd_0_m_axi_mm_video [get_bd_intf_pins m_axi_mm_video] [get_bd_intf_pins v_frmbuf_rd_0/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_frmbuf_rd_0_m_axis_video [get_bd_intf_pins v_frmbuf_rd_0/m_axis_video] [get_bd_intf_pins v_mix_0/s_axis_video]
  connect_bd_intf_net -intf_net v_mix_0_m_axis_video [get_bd_intf_pins axis_subset_converter_0/S_AXIS] [get_bd_intf_pins v_mix_0/m_axis_video]
  connect_bd_intf_net -intf_net v_smpte_uhdsdi_tx_ss_0_M_AXIS_TX [get_bd_intf_pins M_AXIS_TX] [get_bd_intf_pins v_smpte_uhdsdi_tx_ss/M_AXIS_TX]
  connect_bd_intf_net -intf_net v_smpte_uhdsdi_tx_ss_M_AXIS_CTRL_SB_TX [get_bd_intf_pins M_AXIS_CTRL_SB_TX] [get_bd_intf_pins v_smpte_uhdsdi_tx_ss/M_AXIS_CTRL_SB_TX]
  connect_bd_intf_net -intf_net v_smpte_uhdsdi_tx_ss_SDI_TX_ANC_DS_OUT [get_bd_intf_pins SDI_TX_ANC_DS_OUT] [get_bd_intf_pins v_smpte_uhdsdi_tx_ss/SDI_TX_ANC_DS_OUT]
  connect_bd_intf_net -intf_net vid_phy_controller_0_intf_0_stat_sb_tx [get_bd_intf_pins S_AXIS_STS_SB_TX] [get_bd_intf_pins v_smpte_uhdsdi_tx_ss/S_AXIS_STS_SB_TX]
  connect_bd_intf_net -intf_net zynq_us_ss_M00_AXI [get_bd_intf_pins S_AXI_tx_ss] [get_bd_intf_pins v_smpte_uhdsdi_tx_ss/S_AXI_CTRL]
  connect_bd_intf_net -intf_net zynq_us_ss_M00_AXI1 [get_bd_intf_pins s_axi_frm_rd] [get_bd_intf_pins v_frmbuf_rd_0/s_axi_CTRL]

  # Create port connections
  connect_bd_net -net ap_rst_n2_1 [get_bd_pins tx_mixer_rst] [get_bd_pins v_mix_0/ap_rst_n]
  connect_bd_net -net mb_ss_0_clk_out2 [get_bd_pins video_in_clk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins v_frmbuf_rd_0/ap_clk] [get_bd_pins v_mix_0/ap_clk] [get_bd_pins v_smpte_uhdsdi_tx_ss/video_in_clk]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins s_axi_aclk] [get_bd_pins v_smpte_uhdsdi_tx_ss/s_axi_aclk]
  connect_bd_net -net reset_frm_buf_rd_Dout [get_bd_pins frm_rd_rst_n] [get_bd_pins v_frmbuf_rd_0/ap_rst_n]
  connect_bd_net -net reset_generator_peripheral_aresetn [get_bd_pins video_in_arstn] [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins v_smpte_uhdsdi_tx_ss/video_in_arstn]
  connect_bd_net -net reset_generator_peripheral_aresetn1 [get_bd_pins s_axi_arstn] [get_bd_pins v_smpte_uhdsdi_tx_ss/s_axi_arstn]
  connect_bd_net -net v_frmbuf_rd_0_field_id [get_bd_pins v_frmbuf_rd_0/field_id] [get_bd_pins v_smpte_uhdsdi_tx_ss/fid]
  connect_bd_net -net v_frmbuf_rd_0_interrupt [get_bd_pins interrupt] [get_bd_pins v_frmbuf_rd_0/interrupt]
  connect_bd_net -net v_mix_0_interrupt [get_bd_pins interrupt1] [get_bd_pins v_mix_0/interrupt]
  connect_bd_net -net v_smpte_uhdsdi_tx_ss_sdi_tx_anc_ctrl_out [get_bd_pins sdi_tx_anc_ctrl_out] [get_bd_pins v_smpte_uhdsdi_tx_ss/sdi_tx_anc_ctrl_out]
  connect_bd_net -net v_smpte_uhdsdi_tx_ss_sdi_tx_irq [get_bd_pins sdi_tx_irq] [get_bd_pins v_smpte_uhdsdi_tx_ss/sdi_tx_irq]
  connect_bd_net -net vid_phy_controller_0_intf_0_txoutclk [get_bd_pins txoutclk] [get_bd_pins v_smpte_uhdsdi_tx_ss/sdi_tx_clk]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins sdi_tx_rst] [get_bd_pins v_smpte_uhdsdi_tx_ss/sdi_tx_rst]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: sdi_rx_input
proc create_hier_cell_sdi_rx_input { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_sdi_rx_input() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_CTRL_SB_RX

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:sdi_native_rtl:2.0 SDI_RX_ANS_DS_OUT

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_RX

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_STS_SB_RX

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_rx_ss

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_frm_wr

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_vpss


  # Create pins
  create_bd_pin -dir I -type rst ap_rst_n
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn_ctrl1
  create_bd_pin -dir O -from 0 -to 0 -type rst aresetn_io_axis1
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir I -type clk rxoutclk
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_arstn
  create_bd_pin -dir O -from 31 -to 0 sdi_rx_anc_ctrl_out
  create_bd_pin -dir O -type intr sdi_rx_irq
  create_bd_pin -dir I -type rst sdi_rx_rst
  create_bd_pin -dir I -type rst video_out_arstn
  create_bd_pin -dir I -type clk video_out_clk

  # Create instance: v_frmbuf_wr_0, and set properties
  set v_frmbuf_wr_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr v_frmbuf_wr_0 ]
  set_property -dict [ list \
   CONFIG.HAS_BGR8 {1} \
   CONFIG.HAS_BGRX8 {1} \
   CONFIG.HAS_INTERLACED {1} \
   CONFIG.HAS_RGB8 {1} \
   CONFIG.HAS_RGBX8 {1} \
   CONFIG.HAS_RGBX10 {1} \
   CONFIG.HAS_UYVY8 {1} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_Y10 {1} \
   CONFIG.HAS_YUV8 {1} \
   CONFIG.HAS_YUVX8 {1} \
   CONFIG.HAS_YUVX10 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV10 {1} \
   CONFIG.HAS_Y_UV10_420 {1} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_COLS {4096} \
   CONFIG.MAX_DATA_WIDTH {10} \
   CONFIG.MAX_NR_PLANES {2} \
 ] $v_frmbuf_wr_0

  # Create instance: v_proc_ss_0, and set properties
  set v_proc_ss_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss v_proc_ss_0 ]
  set_property -dict [ list \
   CONFIG.C_ENABLE_CSC {true} \
   CONFIG.C_H_SCALER_TAPS {8} \
   CONFIG.C_TOPOLOGY {0} \
   CONFIG.C_V_SCALER_TAPS {8} \
 ] $v_proc_ss_0

  # Create instance: v_smpte_uhdsdi_rx_ss, and set properties
  set v_smpte_uhdsdi_rx_ss [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_smpte_uhdsdi_rx_ss v_smpte_uhdsdi_rx_ss ]
  set_property -dict [ list \
   CONFIG.C_INCLUDE_ADV_FEATURES {true} \
   CONFIG.C_LINE_RATE {12G_SDI_8DS} \
 ] $v_smpte_uhdsdi_rx_ss

  # Create interface connections
  connect_bd_intf_net -intf_net s_axi_ctrl_1 [get_bd_intf_pins s_axi_vpss] [get_bd_intf_pins v_proc_ss_0/s_axi_ctrl]
  connect_bd_intf_net -intf_net v_frmbuf_wr_0_m_axi_mm_video [get_bd_intf_pins m_axi_mm_video] [get_bd_intf_pins v_frmbuf_wr_0/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_proc_ss_0_m_axis [get_bd_intf_pins v_frmbuf_wr_0/s_axis_video] [get_bd_intf_pins v_proc_ss_0/m_axis]
  connect_bd_intf_net -intf_net v_smpte_uhdsdi_rx_ss_M_AXIS_CTRL_SB_RX [get_bd_intf_pins M_AXIS_CTRL_SB_RX] [get_bd_intf_pins v_smpte_uhdsdi_rx_ss/M_AXIS_CTRL_SB_RX]
  connect_bd_intf_net -intf_net v_smpte_uhdsdi_rx_ss_SDI_RX_ANC_DS_OUT [get_bd_intf_pins SDI_RX_ANS_DS_OUT] [get_bd_intf_pins v_smpte_uhdsdi_rx_ss/SDI_RX_ANC_DS_OUT]
  connect_bd_intf_net -intf_net v_smpte_uhdsdi_rx_ss_VIDEO_OUT [get_bd_intf_pins v_proc_ss_0/s_axis] [get_bd_intf_pins v_smpte_uhdsdi_rx_ss/VIDEO_OUT]
  connect_bd_intf_net -intf_net vid_phy_controller_0_intf_0_rx_axi4s_ch0 [get_bd_intf_pins S_AXIS_RX] [get_bd_intf_pins v_smpte_uhdsdi_rx_ss/S_AXIS_RX]
  connect_bd_intf_net -intf_net vid_phy_controller_0_intf_0_stat_sb_rx [get_bd_intf_pins S_AXIS_STS_SB_RX] [get_bd_intf_pins v_smpte_uhdsdi_rx_ss/S_AXIS_STS_SB_RX]
  connect_bd_intf_net -intf_net zynq_us_ss_M01_AXI [get_bd_intf_pins S_AXI_rx_ss] [get_bd_intf_pins v_smpte_uhdsdi_rx_ss/S_AXI_CTRL]
  connect_bd_intf_net -intf_net zynq_us_ss_M01_AXI1 [get_bd_intf_pins s_axi_frm_wr] [get_bd_intf_pins v_frmbuf_wr_0/s_axi_CTRL]

  # Create port connections
  connect_bd_net -net ap_rst_n_1 [get_bd_pins ap_rst_n] [get_bd_pins v_frmbuf_wr_0/ap_rst_n]
  connect_bd_net -net aresetn_ctrl1_1 [get_bd_pins aresetn_ctrl1] [get_bd_pins v_proc_ss_0/aresetn_ctrl]
  connect_bd_net -net aresetn_io_axis [get_bd_pins aresetn_io_axis1] [get_bd_pins v_proc_ss_0/aresetn_io_axis]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets aresetn_io_axis]
  connect_bd_net -net mb_ss_0_clk_out2 [get_bd_pins video_out_clk] [get_bd_pins v_frmbuf_wr_0/ap_clk] [get_bd_pins v_proc_ss_0/aclk_axis] [get_bd_pins v_smpte_uhdsdi_rx_ss/video_out_clk]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins s_axi_aclk] [get_bd_pins v_proc_ss_0/aclk_ctrl] [get_bd_pins v_smpte_uhdsdi_rx_ss/s_axi_aclk]
  connect_bd_net -net reset_generator_peripheral_aresetn [get_bd_pins video_out_arstn] [get_bd_pins v_smpte_uhdsdi_rx_ss/video_out_arstn]
  connect_bd_net -net reset_generator_peripheral_aresetn1 [get_bd_pins s_axi_arstn] [get_bd_pins v_smpte_uhdsdi_rx_ss/s_axi_arstn]
  connect_bd_net -net v_frmbuf_wr_0_interrupt [get_bd_pins interrupt] [get_bd_pins v_frmbuf_wr_0/interrupt]
  connect_bd_net -net v_smpte_uhdsdi_rx_ss_fid [get_bd_pins v_frmbuf_wr_0/field_id] [get_bd_pins v_smpte_uhdsdi_rx_ss/fid]
  connect_bd_net -net v_smpte_uhdsdi_rx_ss_sdi_rx_anc_ctrl_out [get_bd_pins sdi_rx_anc_ctrl_out] [get_bd_pins v_smpte_uhdsdi_rx_ss/sdi_rx_anc_ctrl_out]
  connect_bd_net -net v_smpte_uhdsdi_rx_ss_sdi_rx_irq [get_bd_pins sdi_rx_irq] [get_bd_pins v_smpte_uhdsdi_rx_ss/sdi_rx_irq]
  connect_bd_net -net vid_phy_controller_0_intf_0_rxoutclk [get_bd_pins rxoutclk] [get_bd_pins v_smpte_uhdsdi_rx_ss/sdi_rx_clk]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins sdi_rx_rst] [get_bd_pins v_smpte_uhdsdi_rx_ss/sdi_rx_rst]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: reset_generator
proc create_hier_cell_reset_generator { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_reset_generator() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir O -from 0 -to 0 axis_fifo_resetn
  create_bd_pin -dir I -from 0 -to 0 axis_fifo_resetn_gpio
  create_bd_pin -dir I dcm_locked
  create_bd_pin -dir I -from 0 -to 0 gt_qpll0lock
  create_bd_pin -dir I -from 0 -to 0 gt_qpll1lock
  create_bd_pin -dir O -from 0 -to 0 -type rst interconnect_aresetn_lite
  create_bd_pin -dir O -from 0 -to 0 -type rst interconnect_aresetn_sys_clk
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn_lite
  create_bd_pin -dir O -from 0 -to 0 peripheral_aresetn_sys_clk
  create_bd_pin -dir I -type rst pl_resetn
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type clk sys_clk
  create_bd_pin -dir O -from 0 -to 0 -type rst sys_rstn

  # Create instance: and_1bit, and set properties
  set and_1bit [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic and_1bit ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {and} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_andgate.png} \
 ] $and_1bit

  # Create instance: and_1bit_1, and set properties
  set and_1bit_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic and_1bit_1 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {and} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_andgate.png} \
 ] $and_1bit_1

  # Create instance: reset_axilite_clk, and set properties
  set reset_axilite_clk [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset reset_axilite_clk ]
  set_property -dict [ list \
   CONFIG.C_AUX_RESET_HIGH {0} \
 ] $reset_axilite_clk

  # Create instance: reset_sys_clk, and set properties
  set reset_sys_clk [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset reset_sys_clk ]
  set_property -dict [ list \
   CONFIG.C_AUX_RESET_HIGH {0} \
 ] $reset_sys_clk

  # Create instance: reset_sys_clk1, and set properties
  set reset_sys_clk1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset reset_sys_clk1 ]
  set_property -dict [ list \
   CONFIG.C_AUX_RESET_HIGH {0} \
 ] $reset_sys_clk1

  # Create port connections
  connect_bd_net -net Op1_1 [get_bd_pins gt_qpll0lock] [get_bd_pins and_1bit/Op1]
  connect_bd_net -net Op2_1 [get_bd_pins gt_qpll1lock] [get_bd_pins and_1bit/Op2]
  connect_bd_net -net Op2_2 [get_bd_pins axis_fifo_resetn_gpio] [get_bd_pins and_1bit_1/Op2]
  connect_bd_net -net and_1bit_1_Res [get_bd_pins axis_fifo_resetn] [get_bd_pins and_1bit_1/Res]
  connect_bd_net -net and_1bit_Res [get_bd_pins and_1bit/Res] [get_bd_pins reset_sys_clk/aux_reset_in]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets and_1bit_Res]
  connect_bd_net -net dcm_locked_1 [get_bd_pins dcm_locked] [get_bd_pins reset_axilite_clk/dcm_locked] [get_bd_pins reset_sys_clk/dcm_locked] [get_bd_pins reset_sys_clk1/dcm_locked]
  connect_bd_net -net pl_resetn [get_bd_pins pl_resetn] [get_bd_pins reset_axilite_clk/ext_reset_in] [get_bd_pins reset_sys_clk/ext_reset_in] [get_bd_pins reset_sys_clk1/ext_reset_in]
  connect_bd_net -net proc_sys_reset_sys_clk_peripheral_aresetn [get_bd_pins sys_rstn] [get_bd_pins and_1bit_1/Op1] [get_bd_pins reset_sys_clk/peripheral_aresetn]
  connect_bd_net -net reset_axilite_clk_interconnect_aresetn [get_bd_pins interconnect_aresetn_lite] [get_bd_pins reset_axilite_clk/interconnect_aresetn]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets reset_axilite_clk_interconnect_aresetn]
  connect_bd_net -net reset_axilite_clk_peripheral_aresetn [get_bd_pins peripheral_aresetn_lite] [get_bd_pins reset_axilite_clk/peripheral_aresetn]
  connect_bd_net -net reset_sys_clk1_interconnect_aresetn [get_bd_pins interconnect_aresetn_sys_clk] [get_bd_pins reset_sys_clk1/interconnect_aresetn]
  connect_bd_net -net reset_sys_clk1_peripheral_aresetn [get_bd_pins peripheral_aresetn_sys_clk] [get_bd_pins reset_sys_clk1/peripheral_aresetn]
  connect_bd_net -net slowest_sync_clk1_2 [get_bd_pins sys_clk] [get_bd_pins reset_sys_clk/slowest_sync_clk] [get_bd_pins reset_sys_clk1/slowest_sync_clk]
  connect_bd_net -net slowest_sync_clk_1 [get_bd_pins s_axi_aclk] [get_bd_pins reset_axilite_clk/slowest_sync_clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: peripheral_aresetn_lite
proc create_hier_cell_peripheral_aresetn_lite { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_peripheral_aresetn_lite() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 94 -to 0 Din
  create_bd_pin -dir O -from 0 -to 0 -type rst mixer_rst
  create_bd_pin -dir O -from 0 -to 0 -type rst scaler_rst
  create_bd_pin -dir O -from 0 -to 0 vcu_rst

  # Create instance: reset_mixer, and set properties
  set reset_mixer [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_mixer ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {20} \
   CONFIG.DIN_TO {20} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_mixer

  # Create instance: reset_scaler, and set properties
  set reset_scaler [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_scaler ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_scaler

  # Create instance: reset_vcu, and set properties
  set reset_vcu [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_vcu ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {41} \
   CONFIG.DIN_TO {41} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_vcu

  # Create port connections
  connect_bd_net -net Din_1 [get_bd_pins Din] [get_bd_pins reset_mixer/Din] [get_bd_pins reset_scaler/Din] [get_bd_pins reset_vcu/Din]
  connect_bd_net -net reset_mixer_Dout [get_bd_pins mixer_rst] [get_bd_pins reset_mixer/Dout]
  connect_bd_net -net reset_scaler_Dout [get_bd_pins scaler_rst] [get_bd_pins reset_scaler/Dout]
  connect_bd_net -net reset_vcu_Dout [get_bd_pins vcu_rst] [get_bd_pins reset_vcu/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: gpio_resets
proc create_hier_cell_gpio_resets { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_gpio_resets() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 -type rst Dout2
  create_bd_pin -dir O -from 0 -to 0 -type rst Dout3
  create_bd_pin -dir O -from 0 -to 0 frm_rd_rst
  create_bd_pin -dir O -from 0 -to 0 frm_wr_rst
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_gpio_resets, and set properties
  set axi_gpio_resets [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axi_gpio_resets ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_DOUT_DEFAULT {0x00000003} \
   CONFIG.C_GPIO_WIDTH {4} \
 ] $axi_gpio_resets

  # Create instance: reset_frm_buf_rd, and set properties
  set reset_frm_buf_rd [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_frm_buf_rd ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {4} \
 ] $reset_frm_buf_rd

  # Create instance: reset_frm_buf_wr, and set properties
  set reset_frm_buf_wr [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_frm_buf_wr ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_frm_buf_wr

  # Create instance: reset_mixer, and set properties
  set reset_mixer [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_mixer ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_mixer

  # Create instance: reset_scaler, and set properties
  set reset_scaler [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice reset_scaler ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DIN_TO {3} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $reset_scaler

  # Create interface connections
  connect_bd_intf_net -intf_net zynq_us_ss_M04_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_gpio_resets/S_AXI]

  # Create port connections
  connect_bd_net -net axi_gpio_1_gpio_io_o [get_bd_pins axi_gpio_resets/gpio_io_o] [get_bd_pins reset_frm_buf_rd/Din] [get_bd_pins reset_frm_buf_wr/Din] [get_bd_pins reset_mixer/Din] [get_bd_pins reset_scaler/Din]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins s_axi_aclk] [get_bd_pins axi_gpio_resets/s_axi_aclk]
  connect_bd_net -net reset_frm_buf_rd_Dout [get_bd_pins frm_rd_rst] [get_bd_pins reset_frm_buf_rd/Dout]
  connect_bd_net -net reset_frm_buf_wr_Dout [get_bd_pins frm_wr_rst] [get_bd_pins reset_frm_buf_wr/Dout]
  connect_bd_net -net reset_generator_peripheral_aresetn1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_gpio_resets/s_axi_aresetn]
  connect_bd_net -net reset_mixer_Dout [get_bd_pins Dout2] [get_bd_pins reset_mixer/Dout]
  connect_bd_net -net reset_scaler_Dout [get_bd_pins Dout3] [get_bd_pins reset_scaler/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: gpio_register
proc create_hier_cell_gpio_register { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_gpio_register() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_axis_fifo

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_si5324


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 axis_fifo_resetn
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir I -from 0 -to 0 si5324_lol

  # Create instance: axis_fifo_gpio, and set properties
  set axis_fifo_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axis_fifo_gpio ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {0} \
   CONFIG.C_ALL_INPUTS_2 {0} \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_GPIO2_WIDTH {32} \
   CONFIG.C_GPIO_WIDTH {1} \
   CONFIG.C_IS_DUAL {0} \
 ] $axis_fifo_gpio

  # Create instance: si5324_lol_gpio, and set properties
  set si5324_lol_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio si5324_lol_gpio ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_GPIO_WIDTH {1} \
 ] $si5324_lol_gpio

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_si5324_1 [get_bd_intf_pins S_AXI_si5324] [get_bd_intf_pins si5324_lol_gpio/S_AXI]
  connect_bd_intf_net -intf_net mb_ss_0_M08_AXI [get_bd_intf_pins S_AXI_axis_fifo] [get_bd_intf_pins axis_fifo_gpio/S_AXI]

  # Create port connections
  connect_bd_net -net gpio_register_axis_fifo_resetn [get_bd_pins axis_fifo_resetn] [get_bd_pins axis_fifo_gpio/gpio_io_o]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins s_axi_aclk] [get_bd_pins axis_fifo_gpio/s_axi_aclk] [get_bd_pins si5324_lol_gpio/s_axi_aclk]
  connect_bd_net -net reset_generator_peripheral_aresetn1 [get_bd_pins s_axi_aresetn] [get_bd_pins axis_fifo_gpio/s_axi_aresetn] [get_bd_pins si5324_lol_gpio/s_axi_aresetn]
  connect_bd_net -net si5324_lol_1 [get_bd_pins si5324_lol] [get_bd_pins si5324_lol_gpio/gpio_io_i]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: compact_gt_wrapper
proc create_hier_cell_compact_gt_wrapper { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_compact_gt_wrapper() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 intf_0_ctrl_sb_rx

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 intf_0_ctrl_sb_tx

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 intf_0_rx_axi4s_ch0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 intf_0_stat_sb_rx

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 intf_0_stat_sb_tx

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 intf_0_tx_axi4s_ch0


  # Create pins
  create_bd_pin -dir I SI5324_LOL
  create_bd_pin -dir O -from 63 -to 0 cmp_gt_sts
  create_bd_pin -dir I -type clk drpclk
  create_bd_pin -dir I fmc_init_done
  create_bd_pin -dir O -from 0 -to 0 gt_cmn_qpll0lock
  create_bd_pin -dir O -from 0 -to 0 gt_cmn_qpll1lock
  create_bd_pin -dir I -from 0 -to 0 intf_0_rxn
  create_bd_pin -dir O -type clk intf_0_rxoutclk
  create_bd_pin -dir I -from 0 -to 0 intf_0_rxp
  create_bd_pin -dir I -type rst intf_0_sb_rx_rst
  create_bd_pin -dir O -from 0 -to 0 intf_0_txn
  create_bd_pin -dir O -type clk intf_0_txoutclk
  create_bd_pin -dir O -from 0 -to 0 intf_0_txp
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir O si5324_lol_db
  create_bd_pin -dir I x0y8_gtsouthrefclk1_0

  # Create instance: compact_gt
  create_hier_cell_compact_gt $hier_obj compact_gt

  # Create instance: compact_gt_ctrl_0, and set properties
  set block_name compact_gt_ctrl
  set block_cell_name compact_gt_ctrl_0
  if { [catch {set compact_gt_ctrl_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $compact_gt_ctrl_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create interface connections
  connect_bd_intf_net -intf_net v_smpte_uhdsdi_rx_ss_M_AXIS_CTRL_SB_RX [get_bd_intf_pins intf_0_ctrl_sb_rx] [get_bd_intf_pins compact_gt/intf_0_ctrl_sb_rx]
  connect_bd_intf_net -intf_net v_smpte_uhdsdi_tx_ss_0_M_AXIS_TX [get_bd_intf_pins intf_0_tx_axi4s_ch0] [get_bd_intf_pins compact_gt/intf_0_tx_axi4s_ch0]
  connect_bd_intf_net -intf_net v_smpte_uhdsdi_tx_ss_M_AXIS_CTRL_SB_TX [get_bd_intf_pins intf_0_ctrl_sb_tx] [get_bd_intf_pins compact_gt/intf_0_ctrl_sb_tx]
  connect_bd_intf_net -intf_net vid_phy_controller_0_intf_0_rx_axi4s_ch0 [get_bd_intf_pins intf_0_rx_axi4s_ch0] [get_bd_intf_pins compact_gt/intf_0_rx_axi4s_ch0]
  connect_bd_intf_net -intf_net vid_phy_controller_0_intf_0_stat_sb_rx [get_bd_intf_pins intf_0_stat_sb_rx] [get_bd_intf_pins compact_gt/intf_0_stat_sb_rx]
  connect_bd_intf_net -intf_net vid_phy_controller_0_intf_0_stat_sb_tx [get_bd_intf_pins intf_0_stat_sb_tx] [get_bd_intf_pins compact_gt/intf_0_stat_sb_tx]

  # Create port connections
  connect_bd_net -net compact_gt_cmp_gt_sts [get_bd_pins cmp_gt_sts] [get_bd_pins compact_gt/cmp_gt_sts] [get_bd_pins compact_gt_ctrl_0/cmp_gt_sts]
  connect_bd_net -net compact_gt_ctrl_0_cmp_gt_ctrl [get_bd_pins compact_gt/cmp_gt_ctrl] [get_bd_pins compact_gt_ctrl_0/cmp_gt_ctrl]
  connect_bd_net -net compact_gt_ctrl_0_si5324_lol_db [get_bd_pins si5324_lol_db] [get_bd_pins compact_gt_ctrl_0/si5324_lol_db]
  connect_bd_net -net compact_gt_gt_cmn_qpll0lock [get_bd_pins gt_cmn_qpll0lock] [get_bd_pins compact_gt/gt_cmn_qpll0lock]
  connect_bd_net -net compact_gt_gt_cmn_qpll1lock [get_bd_pins gt_cmn_qpll1lock] [get_bd_pins compact_gt/gt_cmn_qpll1lock]
  connect_bd_net -net fmc_init_done_1 [get_bd_pins fmc_init_done] [get_bd_pins compact_gt_ctrl_0/fmc_init_done]
  connect_bd_net -net gpio_io_i_1 [get_bd_pins SI5324_LOL] [get_bd_pins compact_gt_ctrl_0/SI5324_LOL]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins drpclk] [get_bd_pins compact_gt/drpclk] [get_bd_pins compact_gt_ctrl_0/s_axi_aclk]
  connect_bd_net -net reset_generator_peripheral_aresetn1 [get_bd_pins s_axi_aresetn] [get_bd_pins compact_gt_ctrl_0/s_axi_aresetn]
  connect_bd_net -net rxn_1 [get_bd_pins intf_0_rxn] [get_bd_pins compact_gt/intf_0_rxn]
  connect_bd_net -net rxp_1 [get_bd_pins intf_0_rxp] [get_bd_pins compact_gt/intf_0_rxp]
  create_bd_net vid_phy_controller_0_intf_0_rxoutclk
  connect_bd_net -net [get_bd_nets vid_phy_controller_0_intf_0_rxoutclk] [get_bd_pins intf_0_rxoutclk] [get_bd_pins compact_gt/intf_0_rx_axi4s_aclk] [get_bd_pins compact_gt/intf_0_rxoutclk] [get_bd_pins compact_gt/intf_0_sb_rx_clk]
  connect_bd_net -net vid_phy_controller_0_intf_0_txn [get_bd_pins intf_0_txn] [get_bd_pins compact_gt/intf_0_txn]
  create_bd_net vid_phy_controller_0_intf_0_txoutclk
  connect_bd_net -net [get_bd_nets vid_phy_controller_0_intf_0_txoutclk] [get_bd_pins intf_0_txoutclk] [get_bd_pins compact_gt/intf_0_sb_tx_clk] [get_bd_pins compact_gt/intf_0_tx_axi4s_aclk] [get_bd_pins compact_gt/intf_0_txoutclk]
  connect_bd_net -net vid_phy_controller_0_intf_0_txp [get_bd_pins intf_0_txp] [get_bd_pins compact_gt/intf_0_txp]
  connect_bd_net -net x0y8_gtsouthrefclk1_0_1 [get_bd_pins x0y8_gtsouthrefclk1_0] [get_bd_pins compact_gt/x0y8_gtsouthrefclk1_0]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins intf_0_sb_rx_rst] [get_bd_pins compact_gt/intf_0_rx_axi4s_rst] [get_bd_pins compact_gt/intf_0_sb_rx_rst] [get_bd_pins compact_gt/intf_0_sb_tx_rst] [get_bd_pins compact_gt/intf_0_tx_axi4s_rst]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: audio_ss
proc create_hier_cell_audio_ss { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_audio_ss() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:sdi_native_rtl:2.0 SDI_EMBED_ANC_DS_IN

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:sdi_native_rtl:2.0 SDI_EMBED_ANC_DS_OUT

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:sdi_native_rtl:2.0 SDI_EXTRACT_ANC_DS_IN

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CTRL

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CTRL1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_s2mm

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_lite


  # Create pins
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir I -type clk S01_ACLK
  create_bd_pin -dir I -type rst ext_reset_in
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir O -from 1 -to 0 -type intr irq_Audio_Format
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir I -from 31 -to 0 sdi_embed_anc_ctrl_in
  create_bd_pin -dir I -type clk sdi_embed_clk
  create_bd_pin -dir I -from 31 -to 0 sdi_extract_anc_ctrl_in
  create_bd_pin -dir I -type clk sdi_extract_clk
  create_bd_pin -dir I -type rst sdi_extract_reset
  create_bd_pin -dir I -type clk slowest_sync_clk

  # Create instance: audio_formatter_0, and set properties
  set audio_formatter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:audio_formatter audio_formatter_0 ]

  # Create instance: axi_interconnect_5, and set properties
  set axi_interconnect_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_interconnect_5 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {1} \
 ] $axi_interconnect_5

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset proc_sys_reset_0 ]

  # Create instance: v_uhdsdi_audio_0_embed, and set properties
  set v_uhdsdi_audio_0_embed [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_uhdsdi_audio v_uhdsdi_audio_0_embed ]
  set_property -dict [ list \
   CONFIG.C_AUDIO_FUNCTION {Embed} \
 ] $v_uhdsdi_audio_0_embed

  # Create instance: v_uhdsdi_audio_1_extract, and set properties
  set v_uhdsdi_audio_1_extract [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_uhdsdi_audio v_uhdsdi_audio_1_extract ]
  set_property -dict [ list \
   CONFIG.C_AUDIO_FUNCTION {Extract} \
 ] $v_uhdsdi_audio_1_extract

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_lite] [get_bd_intf_pins audio_formatter_0/s_axi_lite]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axi_s2mm] [get_bd_intf_pins audio_formatter_0/m_axi_s2mm]
  connect_bd_intf_net -intf_net SDI_EMBED_ANC_DS_IN_1 [get_bd_intf_pins SDI_EMBED_ANC_DS_IN] [get_bd_intf_pins v_uhdsdi_audio_0_embed/SDI_EMBED_ANC_DS_IN]
  connect_bd_intf_net -intf_net SDI_EXTRACT_ANC_DS_IN_1 [get_bd_intf_pins SDI_EXTRACT_ANC_DS_IN] [get_bd_intf_pins v_uhdsdi_audio_1_extract/SDI_EXTRACT_ANC_DS_IN]
  connect_bd_intf_net -intf_net S_AXI_CTRL1_1 [get_bd_intf_pins S_AXI_CTRL1] [get_bd_intf_pins v_uhdsdi_audio_0_embed/S_AXI_CTRL]
  connect_bd_intf_net -intf_net S_AXI_CTRL_1 [get_bd_intf_pins S_AXI_CTRL] [get_bd_intf_pins v_uhdsdi_audio_1_extract/S_AXI_CTRL]
  connect_bd_intf_net -intf_net audio_formatter_0_m_axi_mm2s [get_bd_intf_pins audio_formatter_0/m_axi_mm2s] [get_bd_intf_pins axi_interconnect_5/S00_AXI]
  connect_bd_intf_net -intf_net audio_formatter_0_m_axis_mm2s [get_bd_intf_pins audio_formatter_0/m_axis_mm2s] [get_bd_intf_pins v_uhdsdi_audio_0_embed/S_AXIS_DATA]
  connect_bd_intf_net -intf_net axi_interconnect_5_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi_interconnect_5/M00_AXI]
  connect_bd_intf_net -intf_net v_uhdsdi_audio_0_SDI_EMBED_ANC_DS_OUT [get_bd_intf_pins SDI_EMBED_ANC_DS_OUT] [get_bd_intf_pins v_uhdsdi_audio_0_embed/SDI_EMBED_ANC_DS_OUT]
  connect_bd_intf_net -intf_net v_uhdsdi_audio_1_extract_M_AXIS_DATA [get_bd_intf_pins audio_formatter_0/s_axis_s2mm] [get_bd_intf_pins v_uhdsdi_audio_1_extract/M_AXIS_DATA]

  # Create port connections
  connect_bd_net -net ARESETN_1 [get_bd_pins ARESETN] [get_bd_pins axi_interconnect_5/ARESETN]
  connect_bd_net -net Net [get_bd_pins S01_ACLK] [get_bd_pins audio_formatter_0/m_axis_mm2s_aclk] [get_bd_pins audio_formatter_0/s_axi_lite_aclk] [get_bd_pins audio_formatter_0/s_axis_s2mm_aclk] [get_bd_pins axi_interconnect_5/ACLK] [get_bd_pins axi_interconnect_5/M00_ACLK] [get_bd_pins axi_interconnect_5/S00_ACLK] [get_bd_pins v_uhdsdi_audio_0_embed/s_axi_aclk] [get_bd_pins v_uhdsdi_audio_0_embed/s_axis_clk] [get_bd_pins v_uhdsdi_audio_1_extract/m_axis_clk] [get_bd_pins v_uhdsdi_audio_1_extract/s_axi_aclk]
  connect_bd_net -net Net1 [get_bd_pins slowest_sync_clk] [get_bd_pins audio_formatter_0/aud_mclk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins s_axi_aresetn] [get_bd_pins audio_formatter_0/m_axis_mm2s_aresetn] [get_bd_pins audio_formatter_0/s_axi_lite_aresetn] [get_bd_pins audio_formatter_0/s_axis_s2mm_aresetn] [get_bd_pins axi_interconnect_5/M00_ARESETN] [get_bd_pins axi_interconnect_5/S00_ARESETN] [get_bd_pins v_uhdsdi_audio_0_embed/s_axi_aresetn] [get_bd_pins v_uhdsdi_audio_0_embed/s_axis_resetn] [get_bd_pins v_uhdsdi_audio_1_extract/m_axis_resetn] [get_bd_pins v_uhdsdi_audio_1_extract/s_axi_aresetn]
  connect_bd_net -net audio_formatter_0_irq_mm2s [get_bd_pins audio_formatter_0/irq_mm2s] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net audio_formatter_0_irq_s2mm [get_bd_pins audio_formatter_0/irq_s2mm] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net ext_reset_in_1 [get_bd_pins ext_reset_in] [get_bd_pins proc_sys_reset_0/ext_reset_in]
  connect_bd_net -net proc_sys_reset_0_peripheral_reset [get_bd_pins audio_formatter_0/aud_mreset] [get_bd_pins proc_sys_reset_0/peripheral_reset]
  connect_bd_net -net sdi_embed_anc_ctrl_in_1 [get_bd_pins sdi_embed_anc_ctrl_in] [get_bd_pins v_uhdsdi_audio_0_embed/sdi_embed_anc_ctrl_in]
  connect_bd_net -net sdi_embed_clk_1 [get_bd_pins sdi_embed_clk] [get_bd_pins v_uhdsdi_audio_0_embed/sdi_embed_clk]
  connect_bd_net -net sdi_extract_anc_ctrl_in_1 [get_bd_pins sdi_extract_anc_ctrl_in] [get_bd_pins v_uhdsdi_audio_1_extract/sdi_extract_anc_ctrl_in]
  connect_bd_net -net sdi_extract_clk_1 [get_bd_pins sdi_extract_clk] [get_bd_pins v_uhdsdi_audio_1_extract/sdi_extract_clk]
  connect_bd_net -net v_uhdsdi_audio_1_extract_interrupt [get_bd_pins interrupt] [get_bd_pins v_uhdsdi_audio_1_extract/interrupt]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins irq_Audio_Format] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins sdi_extract_reset] [get_bd_pins v_uhdsdi_audio_0_embed/sdi_embed_reset] [get_bd_pins v_uhdsdi_audio_1_extract/sdi_extract_reset]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

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
  set SYS_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 SYS_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {300000000} \
   ] $SYS_CLK


  # Create ports
  set GTSOUTHREFCLK1_D_clk_n [ create_bd_port -dir I -type clk GTSOUTHREFCLK1_D_clk_n ]
  set GTSOUTHREFCLK1_D_clk_p [ create_bd_port -dir I -type clk GTSOUTHREFCLK1_D_clk_p ]
  set cmp_gt_sts [ create_bd_port -dir O -from 63 -to 0 cmp_gt_sts ]
  set dcm_locked [ create_bd_port -dir O -from 0 -to 0 dcm_locked ]
  set ext_rst [ create_bd_port -dir I -type rst ext_rst ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $ext_rst
  set rxn [ create_bd_port -dir I -from 0 -to 0 rxn ]
  set rxoutclk [ create_bd_port -dir O -type clk rxoutclk ]
  set rxp [ create_bd_port -dir I -from 0 -to 0 rxp ]
  set txn [ create_bd_port -dir O -from 0 -to 0 txn ]
  set txoutclk [ create_bd_port -dir O -type clk txoutclk ]
  set txp [ create_bd_port -dir O -from 0 -to 0 txp ]

  # Create instance: GTSOUTHREFCLK1_CLK, and set properties
  set GTSOUTHREFCLK1_CLK [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf GTSOUTHREFCLK1_CLK ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $GTSOUTHREFCLK1_CLK

  # Create instance: audio_ss
  create_hier_cell_audio_ss [current_bd_instance .] audio_ss

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_DOUT_DEFAULT {0x00000001} \
   CONFIG.C_GPIO_WIDTH {2} \
 ] $axi_gpio_0

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {3} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
   CONFIG.S00_HAS_REGSLICE {3} \
   CONFIG.S01_HAS_REGSLICE {3} \
   CONFIG.S02_HAS_REGSLICE {3} \
   CONFIG.S03_HAS_REGSLICE {3} \
   CONFIG.S04_HAS_REGSLICE {3} \
 ] $axi_interconnect_0

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_interconnect_1 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {3} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_interconnect_1

  # Create instance: axi_interconnect_2, and set properties
  set axi_interconnect_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_interconnect_2 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {3} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_interconnect_2

  # Create instance: axi_interconnect_3, and set properties
  set axi_interconnect_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_interconnect_3 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_REGSLICE {3} \
 ] $axi_interconnect_3

  # Create instance: axi_interconnect_4, and set properties
  set axi_interconnect_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_interconnect_4 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {3} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {5} \
   CONFIG.S00_HAS_REGSLICE {3} \
   CONFIG.S01_HAS_REGSLICE {3} \
   CONFIG.S02_HAS_REGSLICE {3} \
   CONFIG.S03_HAS_REGSLICE {3} \
 ] $axi_interconnect_4

  # Create instance: compact_gt_wrapper
  create_hier_cell_compact_gt_wrapper [current_bd_instance .] compact_gt_wrapper

  # Create instance: gpio_register
  create_hier_cell_gpio_register [current_bd_instance .] gpio_register

  # Create instance: gpio_resets
  create_hier_cell_gpio_resets [current_bd_instance .] gpio_resets

  # Create instance: lol, and set properties
  set lol [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice lol ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {2} \
   CONFIG.DOUT_WIDTH {1} \
 ] $lol

  # Create instance: nfmc_init, and set properties
  set nfmc_init [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice nfmc_init ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {2} \
 ] $nfmc_init

  # Create instance: peripheral_aresetn_lite
  create_hier_cell_peripheral_aresetn_lite [current_bd_instance .] peripheral_aresetn_lite

  # Create instance: reset_generator
  create_hier_cell_reset_generator [current_bd_instance .] reset_generator

  # Create instance: sdi_rx_input
  create_hier_cell_sdi_rx_input [current_bd_instance .] sdi_rx_input

  # Create instance: sdi_tx_output
  create_hier_cell_sdi_tx_output [current_bd_instance .] sdi_tx_output

  # Create instance: vcu_0, and set properties
  set vcu_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vcu vcu_0 ]
  set_property -dict [ list \
   CONFIG.DEC_COLOR_DEPTH {0} \
   CONFIG.DEC_COLOR_FORMAT {0} \
   CONFIG.ENC_BUFFER_B_FRAME {1} \
   CONFIG.ENC_BUFFER_EN {true} \
   CONFIG.ENC_BUFFER_MOTION_VEC_RANGE {1} \
   CONFIG.ENC_BUFFER_SIZE {1285} \
   CONFIG.ENC_BUFFER_SIZE_ACTUAL {1445} \
   CONFIG.ENC_CODING_TYPE {1} \
   CONFIG.ENC_COLOR_DEPTH {0} \
   CONFIG.ENC_COLOR_FORMAT {0} \
   CONFIG.ENC_MEM_URAM_USED {1445} \
   CONFIG.TABLE_NO {2} \
 ] $vcu_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create instance: zynq_us_ss
  create_hier_cell_zynq_us_ss [current_bd_instance .] zynq_us_ss

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN1_D_1 [get_bd_intf_ports SYS_CLK] [get_bd_intf_pins zynq_us_ss/CLK_IN1_D]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_interconnect_1/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_ENC0]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins axi_interconnect_2/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_DEC0]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins axi_interconnect_1/S01_AXI] [get_bd_intf_pins vcu_0/M_AXI_ENC1]
  connect_bd_intf_net -intf_net S01_AXI_2 [get_bd_intf_pins axi_interconnect_2/S01_AXI] [get_bd_intf_pins vcu_0/M_AXI_DEC1]
  connect_bd_intf_net -intf_net S01_AXI_3 [get_bd_intf_pins audio_ss/m_axi_s2mm] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net audio_ss_M00_AXI [get_bd_intf_pins audio_ss/M00_AXI] [get_bd_intf_pins axi_interconnect_4/S04_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins zynq_us_ss/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI1 [get_bd_intf_pins axi_interconnect_1/M00_AXI] [get_bd_intf_pins zynq_us_ss/S_AXI_HP1_FPD]
  connect_bd_intf_net -intf_net axi_interconnect_2_M00_AXI1 [get_bd_intf_pins axi_interconnect_2/M00_AXI] [get_bd_intf_pins zynq_us_ss/S_AXI_HP2_FPD]
  connect_bd_intf_net -intf_net axi_interconnect_3_M00_AXI [get_bd_intf_pins axi_interconnect_3/M00_AXI] [get_bd_intf_pins zynq_us_ss/S_AXI_HPC0_FPD]
  connect_bd_intf_net -intf_net axi_interconnect_4_M00_AXI [get_bd_intf_pins axi_interconnect_4/M00_AXI] [get_bd_intf_pins zynq_us_ss/S_AXI_HP3_FPD]
  connect_bd_intf_net -intf_net s_axi_lite_1 [get_bd_intf_pins audio_ss/s_axi_lite] [get_bd_intf_pins zynq_us_ss/M11_AXI]
  connect_bd_intf_net -intf_net s_axi_mixer_1 [get_bd_intf_pins sdi_tx_output/s_axi_mixer] [get_bd_intf_pins zynq_us_ss/M08_AXI_0]
  connect_bd_intf_net -intf_net sdi_rx_input_SDI_TS_DET_OUT [get_bd_intf_pins audio_ss/SDI_EXTRACT_ANC_DS_IN] [get_bd_intf_pins sdi_rx_input/SDI_RX_ANS_DS_OUT]
  connect_bd_intf_net -intf_net sdi_rx_input_m_axi_mm_video [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins sdi_rx_input/m_axi_mm_video]
  connect_bd_intf_net -intf_net sdi_tx_output_SDI_TX_ANC_DS_OUT [get_bd_intf_pins audio_ss/SDI_EMBED_ANC_DS_IN] [get_bd_intf_pins sdi_tx_output/SDI_TX_ANC_DS_OUT]
  connect_bd_intf_net -intf_net sdi_tx_output_m_axi_mm_video [get_bd_intf_pins axi_interconnect_4/S00_AXI] [get_bd_intf_pins sdi_tx_output/m_axi_mm_video]
  connect_bd_intf_net -intf_net sdi_tx_output_m_axi_mm_video1 [get_bd_intf_pins axi_interconnect_4/S01_AXI] [get_bd_intf_pins sdi_tx_output/m_axi_mm_video1]
  connect_bd_intf_net -intf_net sdi_tx_output_m_axi_mm_video2 [get_bd_intf_pins axi_interconnect_4/S02_AXI] [get_bd_intf_pins sdi_tx_output/m_axi_mm_video2]
  connect_bd_intf_net -intf_net sdi_tx_output_m_axi_mm_video3 [get_bd_intf_pins axi_interconnect_4/S03_AXI] [get_bd_intf_pins sdi_tx_output/m_axi_mm_video3]
  connect_bd_intf_net -intf_net v_smpte_uhdsdi_rx_ss_M_AXIS_CTRL_SB_RX [get_bd_intf_pins compact_gt_wrapper/intf_0_ctrl_sb_rx] [get_bd_intf_pins sdi_rx_input/M_AXIS_CTRL_SB_RX]
  connect_bd_intf_net -intf_net v_smpte_uhdsdi_tx_ss_0_M_AXIS_TX [get_bd_intf_pins compact_gt_wrapper/intf_0_tx_axi4s_ch0] [get_bd_intf_pins sdi_tx_output/M_AXIS_TX]
  connect_bd_intf_net -intf_net v_smpte_uhdsdi_tx_ss_M_AXIS_CTRL_SB_TX [get_bd_intf_pins compact_gt_wrapper/intf_0_ctrl_sb_tx] [get_bd_intf_pins sdi_tx_output/M_AXIS_CTRL_SB_TX]
  connect_bd_intf_net -intf_net v_uhdsdi_audio_0_SDI_EMBED_ANC_DS_OUT [get_bd_intf_pins audio_ss/SDI_EMBED_ANC_DS_OUT] [get_bd_intf_pins sdi_tx_output/SDI_TX_ANC_DS_IN]
  connect_bd_intf_net -intf_net vcu_0_M_AXI_MCU [get_bd_intf_pins axi_interconnect_3/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_MCU]
  connect_bd_intf_net -intf_net vid_phy_controller_0_intf_0_rx_axi4s_ch0 [get_bd_intf_pins compact_gt_wrapper/intf_0_rx_axi4s_ch0] [get_bd_intf_pins sdi_rx_input/S_AXIS_RX]
  connect_bd_intf_net -intf_net vid_phy_controller_0_intf_0_stat_sb_rx [get_bd_intf_pins compact_gt_wrapper/intf_0_stat_sb_rx] [get_bd_intf_pins sdi_rx_input/S_AXIS_STS_SB_RX]
  connect_bd_intf_net -intf_net vid_phy_controller_0_intf_0_stat_sb_tx [get_bd_intf_pins compact_gt_wrapper/intf_0_stat_sb_tx] [get_bd_intf_pins sdi_tx_output/S_AXIS_STS_SB_TX]
  connect_bd_intf_net -intf_net zynq_us_ss_M00_AXI1 [get_bd_intf_pins sdi_tx_output/s_axi_frm_rd] [get_bd_intf_pins zynq_us_ss/M00_AXI1]
  connect_bd_intf_net -intf_net zynq_us_ss_M00_AXI_0 [get_bd_intf_pins gpio_register/S_AXI_si5324] [get_bd_intf_pins zynq_us_ss/M00_AXI_0]
  connect_bd_intf_net -intf_net zynq_us_ss_M01_AXI1 [get_bd_intf_pins sdi_rx_input/s_axi_frm_wr] [get_bd_intf_pins zynq_us_ss/M01_AXI1]
  connect_bd_intf_net -intf_net zynq_us_ss_M01_AXI_0 [get_bd_intf_pins gpio_resets/S_AXI] [get_bd_intf_pins zynq_us_ss/M01_AXI_0]
  connect_bd_intf_net -intf_net zynq_us_ss_M02_AXI_0 [get_bd_intf_pins sdi_rx_input/s_axi_vpss] [get_bd_intf_pins zynq_us_ss/M02_AXI_0]
  connect_bd_intf_net -intf_net zynq_us_ss_M03_AXI_0 [get_bd_intf_pins sdi_rx_input/S_AXI_rx_ss] [get_bd_intf_pins zynq_us_ss/M03_AXI_0]
  connect_bd_intf_net -intf_net zynq_us_ss_M04_AXI_0 [get_bd_intf_pins gpio_register/S_AXI_axis_fifo] [get_bd_intf_pins zynq_us_ss/M04_AXI_0]
  connect_bd_intf_net -intf_net zynq_us_ss_M05_AXI_0 [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins zynq_us_ss/M05_AXI_0]
  connect_bd_intf_net -intf_net zynq_us_ss_M06_AXI_0 [get_bd_intf_pins sdi_tx_output/S_AXI_tx_ss] [get_bd_intf_pins zynq_us_ss/M06_AXI_0]
  connect_bd_intf_net -intf_net zynq_us_ss_M07_AXI_0 [get_bd_intf_pins vcu_0/S_AXI_LITE] [get_bd_intf_pins zynq_us_ss/M07_AXI_0]
  connect_bd_intf_net -intf_net zynq_us_ss_M09_AXI [get_bd_intf_pins audio_ss/S_AXI_CTRL] [get_bd_intf_pins zynq_us_ss/M09_AXI]
  connect_bd_intf_net -intf_net zynq_us_ss_M10_AXI [get_bd_intf_pins audio_ss/S_AXI_CTRL1] [get_bd_intf_pins zynq_us_ss/M10_AXI]

  # Create port connections
  connect_bd_net -net GTSOUTHREFCLK1_D_clk_n_1 [get_bd_ports GTSOUTHREFCLK1_D_clk_n] [get_bd_pins GTSOUTHREFCLK1_CLK/IBUF_DS_N]
  connect_bd_net -net GTSOUTHREFCLK1_D_clk_p_1 [get_bd_ports GTSOUTHREFCLK1_D_clk_p] [get_bd_pins GTSOUTHREFCLK1_CLK/IBUF_DS_P]
  connect_bd_net -net In4_1 [get_bd_pins sdi_tx_output/interrupt1] [get_bd_pins zynq_us_ss/In4]
  connect_bd_net -net audio_ss_interrupt [get_bd_pins audio_ss/interrupt] [get_bd_pins zynq_us_ss/In6]
  connect_bd_net -net audio_ss_irq_mm2s [get_bd_pins audio_ss/irq_Audio_Format] [get_bd_pins zynq_us_ss/In7]
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins axi_gpio_0/gpio_io_o] [get_bd_pins lol/Din] [get_bd_pins nfmc_init/Din]
  connect_bd_net -net compact_gt_cmp_gt_sts [get_bd_ports cmp_gt_sts] [get_bd_pins compact_gt_wrapper/cmp_gt_sts]
  connect_bd_net -net compact_gt_ctrl_0_si5324_lol_db [get_bd_pins compact_gt_wrapper/si5324_lol_db] [get_bd_pins gpio_register/si5324_lol]
  connect_bd_net -net compact_gt_gt_cmn_qpll0lock [get_bd_pins compact_gt_wrapper/gt_cmn_qpll0lock] [get_bd_pins reset_generator/gt_qpll0lock]
  connect_bd_net -net compact_gt_gt_cmn_qpll1lock [get_bd_pins compact_gt_wrapper/gt_cmn_qpll1lock] [get_bd_pins reset_generator/gt_qpll1lock]
  connect_bd_net -net gpio_register_axis_fifo_resetn [get_bd_pins gpio_register/axis_fifo_resetn] [get_bd_pins reset_generator/axis_fifo_resetn_gpio]
  connect_bd_net -net interconnect_aresetn_sys_clk [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_1/S01_ARESETN] [get_bd_pins axi_interconnect_2/ARESETN] [get_bd_pins axi_interconnect_2/M00_ARESETN] [get_bd_pins axi_interconnect_2/S00_ARESETN] [get_bd_pins axi_interconnect_2/S01_ARESETN] [get_bd_pins axi_interconnect_3/ARESETN] [get_bd_pins axi_interconnect_3/M00_ARESETN] [get_bd_pins axi_interconnect_3/S00_ARESETN] [get_bd_pins axi_interconnect_4/ARESETN] [get_bd_pins axi_interconnect_4/M00_ARESETN] [get_bd_pins axi_interconnect_4/S00_ARESETN] [get_bd_pins axi_interconnect_4/S01_ARESETN] [get_bd_pins axi_interconnect_4/S02_ARESETN] [get_bd_pins axi_interconnect_4/S03_ARESETN] [get_bd_pins reset_generator/interconnect_aresetn_sys_clk]
  connect_bd_net -net mb_ss_0_dcm_locked [get_bd_ports dcm_locked] [get_bd_pins reset_generator/dcm_locked] [get_bd_pins zynq_us_ss/dcm_locked]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins audio_ss/S01_ACLK] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_interconnect_4/S04_ACLK] [get_bd_pins compact_gt_wrapper/drpclk] [get_bd_pins gpio_register/s_axi_aclk] [get_bd_pins gpio_resets/s_axi_aclk] [get_bd_pins reset_generator/s_axi_aclk] [get_bd_pins sdi_rx_input/s_axi_aclk] [get_bd_pins sdi_tx_output/s_axi_aclk] [get_bd_pins vcu_0/s_axi_lite_aclk] [get_bd_pins zynq_us_ss/s_axi_aclk]
  connect_bd_net -net peripheral_aresetn_sys_clk [get_bd_pins reset_generator/peripheral_aresetn_sys_clk] [get_bd_pins zynq_us_ss/M00_ARESETN]
  connect_bd_net -net reset_frm_buf_rd_Dout [get_bd_pins gpio_resets/frm_rd_rst] [get_bd_pins sdi_tx_output/frm_rd_rst_n]
  connect_bd_net -net reset_frm_buf_wr_Dout [get_bd_pins gpio_resets/frm_wr_rst] [get_bd_pins sdi_rx_input/ap_rst_n]
  connect_bd_net -net reset_generator_interconnect_aresetn_lite [get_bd_pins audio_ss/ARESETN] [get_bd_pins reset_generator/interconnect_aresetn_lite] [get_bd_pins zynq_us_ss/ARESETN]
  connect_bd_net -net reset_generator_peripheral_aresetn [get_bd_pins reset_generator/sys_rstn] [get_bd_pins sdi_rx_input/video_out_arstn] [get_bd_pins sdi_tx_output/video_in_arstn]
  connect_bd_net -net reset_generator_peripheral_aresetn1 [get_bd_pins audio_ss/s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_interconnect_4/S04_ARESETN] [get_bd_pins compact_gt_wrapper/s_axi_aresetn] [get_bd_pins gpio_register/s_axi_aresetn] [get_bd_pins gpio_resets/s_axi_aresetn] [get_bd_pins reset_generator/peripheral_aresetn_lite] [get_bd_pins sdi_rx_input/s_axi_arstn] [get_bd_pins sdi_tx_output/s_axi_arstn] [get_bd_pins zynq_us_ss/s_axi_aresetn]
  connect_bd_net -net rxn_1 [get_bd_ports rxn] [get_bd_pins compact_gt_wrapper/intf_0_rxn]
  connect_bd_net -net rxp_1 [get_bd_ports rxp] [get_bd_pins compact_gt_wrapper/intf_0_rxp]
  connect_bd_net -net scaler_rst [get_bd_pins peripheral_aresetn_lite/scaler_rst] [get_bd_pins sdi_rx_input/aresetn_ctrl1]
  connect_bd_net -net sdi_embed_anc_ctrl_in_1 [get_bd_pins audio_ss/sdi_embed_anc_ctrl_in] [get_bd_pins sdi_tx_output/sdi_tx_anc_ctrl_out]
  connect_bd_net -net sdi_extract_anc_ctrl_in_1 [get_bd_pins audio_ss/sdi_extract_anc_ctrl_in] [get_bd_pins sdi_rx_input/sdi_rx_anc_ctrl_out]
  connect_bd_net -net sys_clk [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_1/S01_ACLK] [get_bd_pins axi_interconnect_2/ACLK] [get_bd_pins axi_interconnect_2/M00_ACLK] [get_bd_pins axi_interconnect_2/S00_ACLK] [get_bd_pins axi_interconnect_2/S01_ACLK] [get_bd_pins axi_interconnect_3/ACLK] [get_bd_pins axi_interconnect_3/M00_ACLK] [get_bd_pins axi_interconnect_3/S00_ACLK] [get_bd_pins axi_interconnect_4/ACLK] [get_bd_pins axi_interconnect_4/M00_ACLK] [get_bd_pins axi_interconnect_4/S00_ACLK] [get_bd_pins axi_interconnect_4/S01_ACLK] [get_bd_pins axi_interconnect_4/S02_ACLK] [get_bd_pins axi_interconnect_4/S03_ACLK] [get_bd_pins reset_generator/sys_clk] [get_bd_pins sdi_rx_input/video_out_clk] [get_bd_pins sdi_tx_output/video_in_clk] [get_bd_pins vcu_0/m_axi_dec_aclk] [get_bd_pins vcu_0/m_axi_enc_aclk] [get_bd_pins vcu_0/m_axi_mcu_aclk] [get_bd_pins zynq_us_ss/sys_clk]
  connect_bd_net -net sys_rst_1 [get_bd_ports ext_rst] [get_bd_pins zynq_us_ss/reset]
  connect_bd_net -net tx_mixer_rst [get_bd_pins peripheral_aresetn_lite/mixer_rst] [get_bd_pins sdi_tx_output/tx_mixer_rst]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins GTSOUTHREFCLK1_CLK/IBUF_OUT] [get_bd_pins compact_gt_wrapper/x0y8_gtsouthrefclk1_0]
  connect_bd_net -net v_frmbuf_rd_0_interrupt [get_bd_pins sdi_tx_output/interrupt] [get_bd_pins zynq_us_ss/In2]
  connect_bd_net -net v_frmbuf_wr_0_interrupt [get_bd_pins sdi_rx_input/interrupt] [get_bd_pins zynq_us_ss/In3]
  connect_bd_net -net v_smpte_uhdsdi_rx_ss_sdi_rx_irq [get_bd_pins sdi_rx_input/sdi_rx_irq] [get_bd_pins zynq_us_ss/uhdsdi_rx_irq]
  connect_bd_net -net v_smpte_uhdsdi_tx_ss_sdi_tx_irq [get_bd_pins sdi_tx_output/sdi_tx_irq] [get_bd_pins zynq_us_ss/uhdsdi_tx_irq]
  connect_bd_net -net vcu_0_vcu_host_interrupt [get_bd_pins vcu_0/vcu_host_interrupt] [get_bd_pins zynq_us_ss/In5]
  connect_bd_net -net vcu_resetn_1 [get_bd_pins audio_ss/ext_reset_in] [get_bd_pins reset_generator/pl_resetn] [get_bd_pins zynq_us_ss/pl_resetn0]
  connect_bd_net -net vcu_rst [get_bd_pins peripheral_aresetn_lite/vcu_rst] [get_bd_pins vcu_0/vcu_resetn]
  connect_bd_net -net vid_phy_controller_0_intf_0_rxoutclk [get_bd_ports rxoutclk] [get_bd_pins audio_ss/sdi_extract_clk] [get_bd_pins compact_gt_wrapper/intf_0_rxoutclk] [get_bd_pins sdi_rx_input/rxoutclk]
  connect_bd_net -net vid_phy_controller_0_intf_0_txn [get_bd_ports txn] [get_bd_pins compact_gt_wrapper/intf_0_txn]
  connect_bd_net -net vid_phy_controller_0_intf_0_txoutclk [get_bd_ports txoutclk] [get_bd_pins audio_ss/sdi_embed_clk] [get_bd_pins compact_gt_wrapper/intf_0_txoutclk] [get_bd_pins sdi_tx_output/txoutclk]
  connect_bd_net -net vid_phy_controller_0_intf_0_txp [get_bd_ports txp] [get_bd_pins compact_gt_wrapper/intf_0_txp]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins audio_ss/sdi_extract_reset] [get_bd_pins compact_gt_wrapper/intf_0_sb_rx_rst] [get_bd_pins sdi_rx_input/sdi_rx_rst] [get_bd_pins sdi_tx_output/sdi_tx_rst] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins compact_gt_wrapper/fmc_init_done] [get_bd_pins nfmc_init/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins compact_gt_wrapper/SI5324_LOL] [get_bd_pins lol/Dout]
  connect_bd_net -net zynq_us_ss_clk_out3 [get_bd_pins vcu_0/pll_ref_clk] [get_bd_pins zynq_us_ss/clk_out3]
  connect_bd_net -net zynq_us_ss_emio_gpio_o [get_bd_pins peripheral_aresetn_lite/Din] [get_bd_pins zynq_us_ss/emio_gpio_o]
  connect_bd_net -net zynq_us_ss_pl_clk3 [get_bd_pins audio_ss/slowest_sync_clk] [get_bd_pins zynq_us_ss/pl_clk3]

  # Create address segments
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/EncData1] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP3/HP1_DDR_HIGH] SEG_zynq_us_HP1_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/EncData0] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP3/HP1_DDR_HIGH] SEG_zynq_us_HP1_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/EncData1] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP3/HP1_DDR_LOW] SEG_zynq_us_HP1_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/EncData0] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP3/HP1_DDR_LOW] SEG_zynq_us_HP1_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/EncData1] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP3/HP1_LPS_OCM] SEG_zynq_us_HP1_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/EncData0] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP3/HP1_LPS_OCM] SEG_zynq_us_HP1_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/EncData1] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP3/HP1_QSPI] SEG_zynq_us_HP1_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/EncData0] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP3/HP1_QSPI] SEG_zynq_us_HP1_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP4/HP2_DDR_HIGH] SEG_zynq_us_HP2_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP4/HP2_DDR_HIGH] SEG_zynq_us_HP2_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP4/HP2_DDR_LOW] SEG_zynq_us_HP2_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP4/HP2_DDR_LOW] SEG_zynq_us_HP2_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP4/HP2_LPS_OCM] SEG_zynq_us_HP2_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP4/HP2_LPS_OCM] SEG_zynq_us_HP2_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP4/HP2_QSPI] SEG_zynq_us_HP2_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP4/HP2_QSPI] SEG_zynq_us_HP2_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP0/HPC0_DDR_HIGH] SEG_zynq_us_HPC0_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP0/HPC0_DDR_LOW] SEG_zynq_us_HPC0_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP0/HPC0_LPS_OCM] SEG_zynq_us_HPC0_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP0/HPC0_QSPI] SEG_zynq_us_HPC0_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces audio_ss/audio_formatter_0/m_axi_s2mm] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP2/HP0_DDR_HIGH] SEG_zynq_us_HP0_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces audio_ss/audio_formatter_0/m_axi_s2mm] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP2/HP0_DDR_LOW] SEG_zynq_us_HP0_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces audio_ss/audio_formatter_0/m_axi_s2mm] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP2/HP0_LPS_OCM] SEG_zynq_us_HP0_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces audio_ss/audio_formatter_0/m_axi_s2mm] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP2/HP0_QSPI] SEG_zynq_us_HP0_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces audio_ss/audio_formatter_0/m_axi_mm2s] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_DDR_HIGH] SEG_zynq_us_HP3_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces audio_ss/audio_formatter_0/m_axi_mm2s] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_DDR_LOW] SEG_zynq_us_HP3_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces audio_ss/audio_formatter_0/m_axi_mm2s] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_LPS_OCM] SEG_zynq_us_HP3_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces audio_ss/audio_formatter_0/m_axi_mm2s] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_QSPI] SEG_zynq_us_HP3_QSPI
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces sdi_rx_input/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP2/HP0_DDR_LOW] SEG_zynq_us_HP0_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces sdi_rx_input/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP2/HP0_LPS_OCM] SEG_zynq_us_HP0_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces sdi_rx_input/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP2/HP0_QSPI] SEG_zynq_us_HP0_QSPI
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces sdi_tx_output/v_frmbuf_rd_0/Data_m_axi_mm_video] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_DDR_LOW] SEG_zynq_us_HP3_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces sdi_tx_output/v_frmbuf_rd_0/Data_m_axi_mm_video] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_LPS_OCM] SEG_zynq_us_HP3_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces sdi_tx_output/v_frmbuf_rd_0/Data_m_axi_mm_video] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_QSPI] SEG_zynq_us_HP3_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces sdi_tx_output/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_DDR_HIGH] SEG_zynq_us_HP3_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces sdi_tx_output/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_DDR_HIGH] SEG_zynq_us_HP3_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces sdi_tx_output/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_DDR_HIGH] SEG_zynq_us_HP3_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces sdi_tx_output/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_DDR_LOW] SEG_zynq_us_HP3_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces sdi_tx_output/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_DDR_LOW] SEG_zynq_us_HP3_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces sdi_tx_output/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_DDR_LOW] SEG_zynq_us_HP3_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces sdi_tx_output/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_LPS_OCM] SEG_zynq_us_HP3_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces sdi_tx_output/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_LPS_OCM] SEG_zynq_us_HP3_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces sdi_tx_output/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_LPS_OCM] SEG_zynq_us_HP3_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces sdi_tx_output/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_QSPI] SEG_zynq_us_HP3_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces sdi_tx_output/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_QSPI] SEG_zynq_us_HP3_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces sdi_tx_output/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs zynq_us_ss/zynq_us/SAXIGP5/HP3_QSPI] SEG_zynq_us_HP3_QSPI
  create_bd_addr_seg -range 0x00001000 -offset 0xA0000000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs audio_ss/audio_formatter_0/s_axi_lite/reg0] SEG_audio_formatter_0_reg0
  create_bd_addr_seg -range 0x00001000 -offset 0xA0060000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0063000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs gpio_resets/axi_gpio_resets/S_AXI/Reg] SEG_axi_gpio_resets_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0061000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs gpio_register/axis_fifo_gpio/S_AXI/Reg] SEG_axis_fifo_gpio_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0062000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs gpio_register/si5324_lol_gpio/S_AXI/Reg] SEG_si5324_lol_gpio_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xB0010000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs sdi_tx_output/v_frmbuf_rd_0/s_axi_CTRL/Reg] SEG_v_frmbuf_rd_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xB0000000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs sdi_rx_input/v_frmbuf_wr_0/s_axi_CTRL/Reg] SEG_v_frmbuf_wr_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0070000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs sdi_tx_output/v_mix_0/s_axi_CTRL/Reg] SEG_v_mix_0_Reg
  create_bd_addr_seg -range 0x00040000 -offset 0xA0080000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs sdi_rx_input/v_proc_ss_0/s_axi_ctrl/Reg] SEG_v_proc_ss_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0030000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs sdi_rx_input/v_smpte_uhdsdi_rx_ss/S_AXI_CTRL/Reg] SEG_v_smpte_uhdsdi_rx_ss_Reg
  create_bd_addr_seg -range 0x00020000 -offset 0xA0040000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs sdi_tx_output/v_smpte_uhdsdi_tx_ss/S_AXI_CTRL/Reg] SEG_v_smpte_uhdsdi_tx_ss_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0010000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs audio_ss/v_uhdsdi_audio_0_embed/S_AXI_CTRL/reg0] SEG_v_uhdsdi_audio_0_embed_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0xA0020000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs audio_ss/v_uhdsdi_audio_1_extract/S_AXI_CTRL/reg0] SEG_v_uhdsdi_audio_1_extract_reg0
  create_bd_addr_seg -range 0x00100000 -offset 0xA0100000 [get_bd_addr_spaces zynq_us_ss/zynq_us/Data] [get_bd_addr_segs vcu_0/S_AXI_LITE/Reg] SEG_vcu_0_Reg


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


