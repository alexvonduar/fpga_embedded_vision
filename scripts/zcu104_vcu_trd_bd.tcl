
################################################################
# This is a generated script based on design: vcu_trd
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
set scripts_vivado_version 2024.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source vcu_trd_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu7ev-ffvc1156-2-e
   set_property BOARD_PART xilinx.com:zcu104:part0:1.1 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name vcu_trd

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
  set_property USER_COMMENTS.comment_0 "Zynq UltraScale+ VCU TRD" [get_bd_designs $design_name]

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
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:axi_timer:2.0\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:user:hdmi_hb:1.0\
xilinx.com:ip:axi_iic:2.1\
xilinx.com:ip:v_scenechange:1.1\
xilinx.com:ip:vcu:1.2\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:vid_phy_controller:2.2\
xilinx.com:ip:util_ds_buf:2.2\
xilinx.com:ip:axi_data_fifo:2.1\
xilinx.com:ip:axis_broadcaster:1.1\
xilinx.com:ip:axis_data_fifo:2.0\
xilinx.com:ip:axis_register_slice:1.1\
xilinx.com:ip:axis_subset_converter:1.1\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:v_frmbuf_wr:3.0\
xilinx.com:ip:v_hdmi_rx_ss:3.2\
xilinx.com:ip:v_proc_ss:2.3\
xilinx.com:ip:v_frmbuf_rd:3.0\
xilinx.com:ip:v_hdmi_tx_ss:3.2\
xilinx.com:ip:v_mix:5.2\
xilinx.com:ip:mipi_csi2_rx_subsystem:6.0\
xilinx.com:ip:v_demosaic:1.1\
xilinx.com:ip:v_gamma_lut:1.1\
xilinx.com:ip:zynq_ultra_ps_e:3.5\
xilinx.com:user:clock_mux:2.0\
xilinx.com:ip:v_tc:6.2\
xilinx.com:ip:v_tpg:8.2\
xilinx.com:ip:v_vid_in_axi4s:5.0\
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

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: tpg_input
proc create_hier_cell_tpg_input { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_tpg_input() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_frm_wr

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_tpg

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_vtc


  # Create pins
  create_bd_pin -dir I -from 94 -to 0 Din
  create_bd_pin -dir I clk_in_1_0
  create_bd_pin -dir I clk_in_2_0
  create_bd_pin -dir O -type intr interrupt
  create_bd_pin -dir I -type clk m_axi_s2mm_aclk
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst tpg_rst_n

  # Create instance: axi_data_fifo_0, and set properties
  set axi_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_data_fifo:2.1 axi_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.DATA_WIDTH {128} \
   CONFIG.WRITE_FIFO_DELAY {1} \
   CONFIG.WRITE_FIFO_DEPTH {512} \
 ] $axi_data_fifo_0

  # Create instance: clk_sel, and set properties
  set clk_sel [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 clk_sel ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {42} \
   CONFIG.DIN_TO {42} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $clk_sel

  # Create instance: clock_mux_0, and set properties
  set clock_mux_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:clock_mux:2.0 clock_mux_0 ]

  # Create instance: tpg_0_VTP_reset, and set properties
  set tpg_0_VTP_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 tpg_0_VTP_reset ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {18} \
   CONFIG.DIN_TO {18} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $tpg_0_VTP_reset

  # Create instance: v_frmbuf_wr_0, and set properties
  set v_frmbuf_wr_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr:3.0 v_frmbuf_wr_0 ]
  set_property -dict [ list \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_frmbuf_wr_0

  # Create instance: v_tc_1, and set properties
  set v_tc_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.2 v_tc_1 ]
  set_property -dict [ list \
   CONFIG.GEN_F0_VBLANK_HEND {1920} \
   CONFIG.GEN_F0_VBLANK_HSTART {1920} \
   CONFIG.GEN_F0_VFRAME_SIZE {1125} \
   CONFIG.GEN_F0_VSYNC_HEND {1920} \
   CONFIG.GEN_F0_VSYNC_HSTART {1920} \
   CONFIG.GEN_F0_VSYNC_VEND {1088} \
   CONFIG.GEN_F0_VSYNC_VSTART {1083} \
   CONFIG.GEN_F1_VBLANK_HEND {1920} \
   CONFIG.GEN_F1_VBLANK_HSTART {1920} \
   CONFIG.GEN_F1_VFRAME_SIZE {1125} \
   CONFIG.GEN_F1_VSYNC_HEND {1920} \
   CONFIG.GEN_F1_VSYNC_HSTART {1920} \
   CONFIG.GEN_F1_VSYNC_VEND {1088} \
   CONFIG.GEN_F1_VSYNC_VSTART {1083} \
   CONFIG.GEN_HACTIVE_SIZE {1920} \
   CONFIG.GEN_HFRAME_SIZE {2200} \
   CONFIG.GEN_HSYNC_END {2052} \
   CONFIG.GEN_HSYNC_START {2008} \
   CONFIG.GEN_VACTIVE_SIZE {1080} \
   CONFIG.VIDEO_MODE {1080p} \
   CONFIG.enable_detection {false} \
   CONFIG.horizontal_sync_detection {true} \
   CONFIG.max_clocks_per_line {8192} \
   CONFIG.max_lines_per_frame {8192} \
   CONFIG.vertical_blank_generation {true} \
   CONFIG.vertical_sync_detection {true} \
 ] $v_tc_1

  # Create instance: v_tpg_1, and set properties
  set v_tpg_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tpg:8.2 v_tpg_1 ]
  set_property -dict [ list \
   CONFIG.HAS_AXI4S_SLAVE {1} \
   CONFIG.MAX_COLS {3840} \
   CONFIG.MAX_ROWS {2160} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_tpg_1

  # Create instance: v_vid_in_axi4s_0, and set properties
  set v_vid_in_axi4s_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_vid_in_axi4s:5.0 v_vid_in_axi4s_0 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_WIDTH {5} \
   CONFIG.C_HAS_ASYNC_CLK {1} \
   CONFIG.C_M_AXIS_VIDEO_FORMAT {2} \
   CONFIG.C_PIXELS_PER_CLOCK {2} \
 ] $v_vid_in_axi4s_0

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {16} \
   CONFIG.DIN_TO {16} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_0

  # Create instance: zero_48bit, and set properties
  set zero_48bit [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 zero_48bit ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {48} \
 ] $zero_48bit

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_LITE_1 [get_bd_intf_pins s_axi_frm_wr] [get_bd_intf_pins v_frmbuf_wr_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net axi_data_fifo_0_M_AXI [get_bd_intf_pins m_axi_mm_video] [get_bd_intf_pins axi_data_fifo_0/M_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M00_AXI [get_bd_intf_pins s_axi_vtc] [get_bd_intf_pins v_tc_1/ctrl]
  connect_bd_intf_net -intf_net axi_interconnect_gp0_M04_AXI [get_bd_intf_pins s_axi_tpg] [get_bd_intf_pins v_tpg_1/s_axi_CTRL]
  connect_bd_intf_net -intf_net v_frmbuf_wr_0_m_axi_mm_video [get_bd_intf_pins axi_data_fifo_0/S_AXI] [get_bd_intf_pins v_frmbuf_wr_0/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_tpg_1_m_axis_video [get_bd_intf_pins v_frmbuf_wr_0/s_axis_video] [get_bd_intf_pins v_tpg_1/m_axis_video]
  connect_bd_intf_net -intf_net v_vid_in_axi4s_0_video_out [get_bd_intf_pins v_tpg_1/s_axis_video] [get_bd_intf_pins v_vid_in_axi4s_0/video_out]

  # Create port connections
  connect_bd_net -net Din_1 [get_bd_pins Din] [get_bd_pins clk_sel/Din] [get_bd_pins tpg_0_VTP_reset/Din] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net clk_50mhz [get_bd_pins s_axi_aclk] [get_bd_pins v_tc_1/s_axi_aclk]
  connect_bd_net -net clk_in_1_0_1 [get_bd_pins clk_in_1_0] [get_bd_pins clock_mux_0/clk_in_1]
  connect_bd_net -net clk_in_2_0_1 [get_bd_pins clk_in_2_0] [get_bd_pins clock_mux_0/clk_in_2]
  connect_bd_net -net fmc_hdmi_input_clk_out [get_bd_pins clock_mux_0/clk_out] [get_bd_pins v_tc_1/clk] [get_bd_pins v_vid_in_axi4s_0/vid_io_in_clk]
  connect_bd_net -net m_axi_s2mm_aclk_1 [get_bd_pins m_axi_s2mm_aclk] [get_bd_pins axi_data_fifo_0/aclk] [get_bd_pins v_frmbuf_wr_0/ap_clk] [get_bd_pins v_tpg_1/ap_clk] [get_bd_pins v_vid_in_axi4s_0/aclk]
  connect_bd_net -net tpg_0_VTP_reset_Dout [get_bd_pins tpg_0_VTP_reset/Dout] [get_bd_pins v_tpg_1/ap_rst_n]
  connect_bd_net -net v_frmbuf_wr_0_interrupt [get_bd_pins interrupt] [get_bd_pins v_frmbuf_wr_0/interrupt]
  connect_bd_net -net v_tc_1_active_video_out [get_bd_pins v_tc_1/active_video_out] [get_bd_pins v_vid_in_axi4s_0/vid_active_video]
  connect_bd_net -net v_tc_1_hblank_out [get_bd_pins v_tc_1/hblank_out] [get_bd_pins v_vid_in_axi4s_0/vid_hblank]
  connect_bd_net -net v_tc_1_hsync_out [get_bd_pins v_tc_1/hsync_out] [get_bd_pins v_vid_in_axi4s_0/vid_hsync]
  connect_bd_net -net v_tc_1_vblank_out [get_bd_pins v_tc_1/vblank_out] [get_bd_pins v_vid_in_axi4s_0/vid_vblank]
  connect_bd_net -net v_tc_1_vsync_out [get_bd_pins v_tc_1/vsync_out] [get_bd_pins v_vid_in_axi4s_0/vid_vsync]
  connect_bd_net -net vcu_rst_Dout [get_bd_pins clk_sel/Dout] [get_bd_pins clock_mux_0/sel]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins axi_data_fifo_0/aresetn] [get_bd_pins v_frmbuf_wr_0/ap_rst_n] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net zero_24bit_dout [get_bd_pins v_vid_in_axi4s_0/vid_data] [get_bd_pins zero_48bit/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mpsoc_ss
proc create_hier_cell_mpsoc_ss { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_mpsoc_ss() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M03_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M05_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M06_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M07_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M08_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M09_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M10_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M11_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M12_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M13_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M14_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M15_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M16_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M17_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M18_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M19_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M20_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M21_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M22_AXI_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M23_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M24_AXI_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HP0_FPD

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HP1_FPD_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HP2_FPD_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HP3_FPD_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HPC0_FPD_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HPC1_FPD_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 scn_chg_ctrl

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 time_ctrl


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 -type rst aresetn_100M
  create_bd_pin -dir O -type clk clk_100M
  create_bd_pin -dir O -type clk clk_149
  create_bd_pin -dir O -type clk clk_300M
  create_bd_pin -dir O -from 0 -to 0 -type rst clk_300_aresetn
  create_bd_pin -dir O -from 94 -to 0 gpio
  create_bd_pin -dir O -type intr iic2intc_irpt
  create_bd_pin -dir I -from 7 -to 0 -type intr pl_ps_irq0
  create_bd_pin -dir I -from 6 -to 0 -type intr pl_ps_irq1
  create_bd_pin -dir O -type rst pl_resetn0_0
  create_bd_pin -dir I -type rst reset_333
  create_bd_pin -dir I -type clk s_axi_hpc0_fpd_aclk

  # Create instance: axi_interconnect, and set properties
  set axi_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {28} \
 ] $axi_interconnect

  # Create instance: hdmi_ctrl_iic, and set properties
  set hdmi_ctrl_iic [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 hdmi_ctrl_iic ]
  set_property -dict [ list \
   CONFIG.IIC_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $hdmi_ctrl_iic

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: proc_sys_reset_1, and set properties
  set proc_sys_reset_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1 ]

  # Create instance: zynq_ultra_ps_e_0, and set properties
  source zcu104_vcu_trd_ps.tcl -notrace
  add_ps_preset "zynq_ultra_ps_e_0"

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins IIC] [get_bd_intf_pins hdmi_ctrl_iic/IIC]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M06_AXI] [get_bd_intf_pins axi_interconnect/M06_AXI]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins S_AXI_HP2_FPD_0] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP2_FPD]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins S_AXI_HP1_FPD_0] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP1_FPD]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins S_AXI_HPC0_FPD_0] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HPC0_FPD]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins S_AXI_HP3_FPD_0] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP3_FPD]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins M10_AXI_0] [get_bd_intf_pins axi_interconnect/M10_AXI]
  connect_bd_intf_net -intf_net Conn8 [get_bd_intf_pins M08_AXI_0] [get_bd_intf_pins axi_interconnect/M08_AXI]
  connect_bd_intf_net -intf_net Conn9 [get_bd_intf_pins M09_AXI_0] [get_bd_intf_pins axi_interconnect/M09_AXI]
  connect_bd_intf_net -intf_net Conn10 [get_bd_intf_pins M07_AXI_0] [get_bd_intf_pins axi_interconnect/M07_AXI]
  connect_bd_intf_net -intf_net Conn11 [get_bd_intf_pins M11_AXI_0] [get_bd_intf_pins axi_interconnect/M11_AXI]
  connect_bd_intf_net -intf_net Conn12 [get_bd_intf_pins M12_AXI_0] [get_bd_intf_pins axi_interconnect/M12_AXI]
  connect_bd_intf_net -intf_net Conn13 [get_bd_intf_pins M13_AXI_0] [get_bd_intf_pins axi_interconnect/M13_AXI]
  connect_bd_intf_net -intf_net Conn14 [get_bd_intf_pins M14_AXI_0] [get_bd_intf_pins axi_interconnect/M14_AXI]
  connect_bd_intf_net -intf_net Conn15 [get_bd_intf_pins M15_AXI_0] [get_bd_intf_pins axi_interconnect/M15_AXI]
  connect_bd_intf_net -intf_net Conn16 [get_bd_intf_pins M16_AXI_0] [get_bd_intf_pins axi_interconnect/M16_AXI]
  connect_bd_intf_net -intf_net Conn17 [get_bd_intf_pins M17_AXI_0] [get_bd_intf_pins axi_interconnect/M17_AXI]
  connect_bd_intf_net -intf_net Conn18 [get_bd_intf_pins M18_AXI_0] [get_bd_intf_pins axi_interconnect/M18_AXI]
  connect_bd_intf_net -intf_net Conn19 [get_bd_intf_pins M24_AXI_0] [get_bd_intf_pins axi_interconnect/M24_AXI]
  connect_bd_intf_net -intf_net Conn20 [get_bd_intf_pins M20_AXI_0] [get_bd_intf_pins axi_interconnect/M20_AXI]
  connect_bd_intf_net -intf_net Conn21 [get_bd_intf_pins M19_AXI_0] [get_bd_intf_pins axi_interconnect/M19_AXI]
  connect_bd_intf_net -intf_net Conn22 [get_bd_intf_pins M21_AXI_0] [get_bd_intf_pins axi_interconnect/M21_AXI]
  connect_bd_intf_net -intf_net Conn23 [get_bd_intf_pins M22_AXI_0] [get_bd_intf_pins axi_interconnect/M22_AXI]
  connect_bd_intf_net -intf_net S_AXI_HP0_FPD_1 [get_bd_intf_pins S_AXI_HP0_FPD] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net axi_interconnect_M03_AXI [get_bd_intf_pins M03_AXI] [get_bd_intf_pins axi_interconnect/M03_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_M05_AXI [get_bd_intf_pins M05_AXI] [get_bd_intf_pins axi_interconnect/M05_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_M23_AXI [get_bd_intf_pins M23_AXI] [get_bd_intf_pins axi_interconnect/M23_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_M25_AXI [get_bd_intf_pins M01_AXI1] [get_bd_intf_pins axi_interconnect/M25_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_M26_AXI [get_bd_intf_pins scn_chg_ctrl] [get_bd_intf_pins axi_interconnect/M26_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_M27_AXI [get_bd_intf_pins time_ctrl] [get_bd_intf_pins axi_interconnect/M27_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M01_AXI [get_bd_intf_pins M01_AXI] [get_bd_intf_pins axi_interconnect/M01_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M02_AXI [get_bd_intf_pins M02_AXI] [get_bd_intf_pins axi_interconnect/M02_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M04_AXI [get_bd_intf_pins axi_interconnect/M04_AXI] [get_bd_intf_pins hdmi_ctrl_iic/S_AXI]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_FPD [get_bd_intf_pins axi_interconnect/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_FPD]

  # Create port connections
  connect_bd_net -net ARESETN_1 [get_bd_pins axi_interconnect/ARESETN] [get_bd_pins proc_sys_reset_0/interconnect_aresetn]
  connect_bd_net -net M17_ARESETN_1 [get_bd_pins reset_333] [get_bd_pins axi_interconnect/M03_ARESETN] [get_bd_pins axi_interconnect/M05_ARESETN] [get_bd_pins axi_interconnect/M06_ARESETN] [get_bd_pins axi_interconnect/M07_ARESETN] [get_bd_pins axi_interconnect/M09_ARESETN] [get_bd_pins axi_interconnect/M10_ARESETN] [get_bd_pins axi_interconnect/M19_ARESETN] [get_bd_pins axi_interconnect/M20_ARESETN] [get_bd_pins axi_interconnect/M21_ARESETN] [get_bd_pins axi_interconnect/M22_ARESETN] [get_bd_pins axi_interconnect/M23_ARESETN] [get_bd_pins axi_interconnect/M24_ARESETN] [get_bd_pins axi_interconnect/M25_ARESETN] [get_bd_pins axi_interconnect/M26_ARESETN]
  connect_bd_net -net hdmi_ctrl_iic_iic2intc_irpt [get_bd_pins iic2intc_irpt] [get_bd_pins hdmi_ctrl_iic/iic2intc_irpt]
  connect_bd_net -net net_clk_wiz_clk_out1 [get_bd_pins clk_100M] [get_bd_pins axi_interconnect/ACLK] [get_bd_pins axi_interconnect/M00_ACLK] [get_bd_pins axi_interconnect/M01_ACLK] [get_bd_pins axi_interconnect/M02_ACLK] [get_bd_pins axi_interconnect/M04_ACLK] [get_bd_pins axi_interconnect/M08_ACLK] [get_bd_pins axi_interconnect/M11_ACLK] [get_bd_pins axi_interconnect/M12_ACLK] [get_bd_pins axi_interconnect/M18_ACLK] [get_bd_pins axi_interconnect/M27_ACLK] [get_bd_pins axi_interconnect/S00_ACLK] [get_bd_pins hdmi_ctrl_iic/s_axi_aclk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
  connect_bd_net -net net_rst_processor_1_100M_peripheral_aresetn [get_bd_pins aresetn_100M] [get_bd_pins axi_interconnect/M00_ARESETN] [get_bd_pins axi_interconnect/M01_ARESETN] [get_bd_pins axi_interconnect/M02_ARESETN] [get_bd_pins axi_interconnect/M04_ARESETN] [get_bd_pins axi_interconnect/M08_ARESETN] [get_bd_pins axi_interconnect/M11_ARESETN] [get_bd_pins axi_interconnect/M12_ARESETN] [get_bd_pins axi_interconnect/M18_ARESETN] [get_bd_pins axi_interconnect/M27_ARESETN] [get_bd_pins axi_interconnect/S00_ARESETN] [get_bd_pins hdmi_ctrl_iic/s_axi_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net pl_ps_irq0_1 [get_bd_pins pl_ps_irq0] [get_bd_pins zynq_ultra_ps_e_0/pl_ps_irq0]
  connect_bd_net -net pl_ps_irq1_0_1 [get_bd_pins pl_ps_irq1] [get_bd_pins zynq_ultra_ps_e_0/pl_ps_irq1]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn [get_bd_pins clk_300_aresetn] [get_bd_pins axi_interconnect/M13_ARESETN] [get_bd_pins axi_interconnect/M14_ARESETN] [get_bd_pins axi_interconnect/M15_ARESETN] [get_bd_pins axi_interconnect/M16_ARESETN] [get_bd_pins axi_interconnect/M17_ARESETN] [get_bd_pins proc_sys_reset_1/interconnect_aresetn]
  connect_bd_net -net saxihp2_fpd_aclk_0_1 [get_bd_pins s_axi_hpc0_fpd_aclk] [get_bd_pins axi_interconnect/M03_ACLK] [get_bd_pins axi_interconnect/M05_ACLK] [get_bd_pins axi_interconnect/M06_ACLK] [get_bd_pins axi_interconnect/M07_ACLK] [get_bd_pins axi_interconnect/M09_ACLK] [get_bd_pins axi_interconnect/M10_ACLK] [get_bd_pins axi_interconnect/M19_ACLK] [get_bd_pins axi_interconnect/M20_ACLK] [get_bd_pins axi_interconnect/M21_ACLK] [get_bd_pins axi_interconnect/M22_ACLK] [get_bd_pins axi_interconnect/M23_ACLK] [get_bd_pins axi_interconnect/M24_ACLK] [get_bd_pins axi_interconnect/M25_ACLK] [get_bd_pins axi_interconnect/M26_ACLK] [get_bd_pins zynq_ultra_ps_e_0/saxihp0_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/saxihp1_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/saxihp2_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/saxihp3_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/saxihpc0_fpd_aclk]
  connect_bd_net -net zynq_ultra_ps_e_0_emio_gpio_o [get_bd_pins gpio] [get_bd_pins zynq_ultra_ps_e_0/emio_gpio_o]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk1 [get_bd_pins clk_300M] [get_bd_pins axi_interconnect/M13_ACLK] [get_bd_pins axi_interconnect/M14_ACLK] [get_bd_pins axi_interconnect/M15_ACLK] [get_bd_pins axi_interconnect/M16_ACLK] [get_bd_pins axi_interconnect/M17_ACLK] [get_bd_pins proc_sys_reset_1/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk1]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk2 [get_bd_pins clk_149] [get_bd_pins zynq_ultra_ps_e_0/pl_clk2]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_resetn0 [get_bd_pins pl_resetn0_0] [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins proc_sys_reset_1/ext_reset_in] [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mipi_csi2_rx
proc create_hier_cell_mipi_csi2_rx { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_mipi_csi2_rx() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_S2MM

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 csirxss_s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_domisaic

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_gamma_lut

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_mipi_frm_wr

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_scalar

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_v_proc_ss_csc


  # Create pins
  create_bd_pin -dir I -from 94 -to 0 Din
  create_bd_pin -dir O -from 0 -to 0 Dout
  create_bd_pin -dir I bg1_pin0_nc
  create_bd_pin -dir I bg3_pin0_nc
  create_bd_pin -dir O -type intr csirxss_csi_irq
  create_bd_pin -dir O -from 0 -to 0 dout1
  create_bd_pin -dir I -type clk dphy_clk_200M
  create_bd_pin -dir I -type rst lite_aresetn_0
  create_bd_pin -dir I -type clk m_axi_s2mm_aclk
  create_bd_pin -dir O -type intr s2mm_introut
  create_bd_pin -dir I -type clk s_axi_lite_aclk
  create_bd_pin -dir I -type rst video_aresetn

  # Create instance: axi_data_fifo_0, and set properties
  set axi_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_data_fifo:2.1 axi_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.WRITE_FIFO_DELAY {1} \
   CONFIG.WRITE_FIFO_DEPTH {512} \
 ] $axi_data_fifo_0

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {2} \
   CONFIG.S_TDATA_NUM_BYTES {3} \
   CONFIG.TDATA_REMAP {tdata[19:12],tdata[9:2]} \
 ] $axis_subset_converter_0

  # Create instance: demosaic_rst_gpio, and set properties
  set demosaic_rst_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 demosaic_rst_gpio ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {7} \
   CONFIG.DIN_TO {7} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $demosaic_rst_gpio

  # Create instance: frmbuf_wr_rst_gpio, and set properties
  set frmbuf_wr_rst_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 frmbuf_wr_rst_gpio ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $frmbuf_wr_rst_gpio

  # Create instance: gamma_rst_gpio, and set properties
  set gamma_rst_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 gamma_rst_gpio ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {8} \
   CONFIG.DIN_TO {8} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $gamma_rst_gpio

  # Create instance: mipi_csi2_rx_subsystem_0, and set properties
  set mipi_csi2_rx_subsystem_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mipi_csi2_rx_subsystem:6.0 mipi_csi2_rx_subsystem_0 ]
  set_property -dict [ list \
   CONFIG.AXIS_TDEST_WIDTH {4} \
   CONFIG.CLK_LANE_IO_LOC {F17} \
   CONFIG.CLK_LANE_IO_LOC_NAME {IO_L13P_T2L_N0_GC_QBC_67} \
   CONFIG.CMN_NUM_LANES {4} \
   CONFIG.CMN_NUM_PIXELS {2} \
   CONFIG.CMN_PXL_FORMAT {RAW10} \
   CONFIG.CMN_VC {All} \
   CONFIG.CSI_BUF_DEPTH {4096} \
   CONFIG.C_CLK_LANE_IO_POSITION {26} \
   CONFIG.C_CSI_EN_ACTIVELANES {true} \
   CONFIG.C_CSI_FILTER_USERDATATYPE {true} \
   CONFIG.C_DATA_LANE0_IO_POSITION {45} \
   CONFIG.C_DATA_LANE1_IO_POSITION {32} \
   CONFIG.C_DATA_LANE2_IO_POSITION {17} \
   CONFIG.C_DATA_LANE3_IO_POSITION {41} \
   CONFIG.C_DPHY_LANES {4} \
   CONFIG.C_EN_BG0_PIN0 {false} \
   CONFIG.C_EN_BG1_PIN0 {true} \
   CONFIG.C_EN_BG3_PIN0 {true} \
   CONFIG.C_HS_LINE_RATE {1440} \
   CONFIG.C_HS_SETTLE_NS {141} \
   CONFIG.DATA_LANE0_IO_LOC {L15} \
   CONFIG.DATA_LANE0_IO_LOC_NAME {IO_L22P_T3U_N6_DBC_AD0P_67} \
   CONFIG.DATA_LANE1_IO_LOC {H18} \
   CONFIG.DATA_LANE1_IO_LOC_NAME {IO_L16P_T2U_N6_QBC_AD3P_67} \
   CONFIG.DATA_LANE2_IO_LOC {E18} \
   CONFIG.DATA_LANE2_IO_LOC_NAME {IO_L9P_T1L_N4_AD12P_67} \
   CONFIG.DATA_LANE3_IO_LOC {J16} \
   CONFIG.DATA_LANE3_IO_LOC_NAME {IO_L20P_T3L_N2_AD1P_67} \
   CONFIG.DPY_LINE_RATE {1440} \
   CONFIG.HP_IO_BANK_SELECTION {67} \
   CONFIG.SupportLevel {1} \
 ] $mipi_csi2_rx_subsystem_0

  # Create instance: sensor_rst_gpio, and set properties
  set sensor_rst_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 sensor_rst_gpio ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {12} \
   CONFIG.DIN_TO {12} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $sensor_rst_gpio

  # Create instance: v_demosaic_0, and set properties
  set v_demosaic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_demosaic:1.1 v_demosaic_0 ]
  set_property -dict [ list \
   CONFIG.ENABLE_ZIPPER_REMOVAL {false} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_demosaic_0

  # Create instance: v_frmbuf_wr_0, and set properties
  set v_frmbuf_wr_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr:3.0 v_frmbuf_wr_0 ]
  set_property -dict [ list \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_BGRX8 {1} \
   CONFIG.HAS_RGB8 {1} \
   CONFIG.HAS_RGBX8 {1} \
   CONFIG.HAS_UYVY8 {1} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_YUV8 {1} \
   CONFIG.HAS_YUVX8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_frmbuf_wr_0

  # Create instance: v_gamma_lut_0, and set properties
  set v_gamma_lut_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_gamma_lut:1.1 v_gamma_lut_0 ]
  set_property -dict [ list \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_gamma_lut_0

  # Create instance: v_proc_ss_csc, and set properties
  set v_proc_ss_csc [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss:2.3 v_proc_ss_csc ]
  set_property -dict [ list \
   CONFIG.C_COLORSPACE_SUPPORT {0} \
   CONFIG.C_CSC_ENABLE_WINDOW {false} \
   CONFIG.C_ENABLE_CSC {true} \
   CONFIG.C_MAX_DATA_WIDTH {8} \
   CONFIG.C_SAMPLES_PER_CLK {2} \
   CONFIG.C_TOPOLOGY {3} \
 ] $v_proc_ss_csc

  # Create instance: v_proc_ss_scaler, and set properties
  set v_proc_ss_scaler [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss:2.3 v_proc_ss_scaler ]
  set_property -dict [ list \
   CONFIG.C_COLORSPACE_SUPPORT {0} \
   CONFIG.C_ENABLE_CSC {true} \
   CONFIG.C_H_SCALER_TAPS {8} \
   CONFIG.C_MAX_DATA_WIDTH {8} \
   CONFIG.C_SAMPLES_PER_CLK {2} \
   CONFIG.C_TOPOLOGY {0} \
   CONFIG.C_V_SCALER_TAPS {8} \
 ] $v_proc_ss_scaler

  # Create instance: vcc, and set properties
  set vcc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 vcc ]

  # Create instance: vpss_csc_rst_gpio, and set properties
  set vpss_csc_rst_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 vpss_csc_rst_gpio ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {6} \
   CONFIG.DIN_TO {6} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $vpss_csc_rst_gpio

  # Create instance: vpss_scaler_rst_gpio, and set properties
  set vpss_scaler_rst_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 vpss_scaler_rst_gpio ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {4} \
   CONFIG.DIN_TO {4} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $vpss_scaler_rst_gpio

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_scalar] [get_bd_intf_pins v_proc_ss_scaler/s_axi_ctrl]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins s_axi_gamma_lut] [get_bd_intf_pins v_gamma_lut_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axi_mipi_frm_wr] [get_bd_intf_pins v_frmbuf_wr_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins s_axi_v_proc_ss_csc] [get_bd_intf_pins v_proc_ss_csc/s_axi_ctrl]
  connect_bd_intf_net -intf_net axi_data_fifo_0_M_AXI [get_bd_intf_pins M_AXI_S2MM] [get_bd_intf_pins axi_data_fifo_0/M_AXI]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_subset_converter_0/M_AXIS] [get_bd_intf_pins v_demosaic_0/s_axis_video]
  connect_bd_intf_net -intf_net csirxss_s_axi_1 [get_bd_intf_pins csirxss_s_axi] [get_bd_intf_pins mipi_csi2_rx_subsystem_0/csirxss_s_axi]
  connect_bd_intf_net -intf_net ctrl_1 [get_bd_intf_pins s_axi_domisaic] [get_bd_intf_pins v_demosaic_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net mipi_csi2_rx_subsystem_0_video_out [get_bd_intf_pins axis_subset_converter_0/S_AXIS] [get_bd_intf_pins mipi_csi2_rx_subsystem_0/video_out]
  connect_bd_intf_net -intf_net mipi_phy_if_0_1 [get_bd_intf_pins mipi_phy_if_0] [get_bd_intf_pins mipi_csi2_rx_subsystem_0/mipi_phy_if]
  connect_bd_intf_net -intf_net v_demosaic_0_m_axis_video [get_bd_intf_pins v_demosaic_0/m_axis_video] [get_bd_intf_pins v_gamma_lut_0/s_axis_video]
  connect_bd_intf_net -intf_net v_frmbuf_wr_0_m_axi_mm_video [get_bd_intf_pins axi_data_fifo_0/S_AXI] [get_bd_intf_pins v_frmbuf_wr_0/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_gamma_lut_0_m_axis_video [get_bd_intf_pins v_gamma_lut_0/m_axis_video] [get_bd_intf_pins v_proc_ss_csc/s_axis]
  connect_bd_intf_net -intf_net v_proc_ss_0_m_axis [get_bd_intf_pins v_frmbuf_wr_0/s_axis_video] [get_bd_intf_pins v_proc_ss_scaler/m_axis]
  connect_bd_intf_net -intf_net v_proc_ss_1_m_axis [get_bd_intf_pins v_proc_ss_csc/m_axis] [get_bd_intf_pins v_proc_ss_scaler/s_axis]

  # Create port connections
  connect_bd_net -net Din_1 [get_bd_pins Din] [get_bd_pins demosaic_rst_gpio/Din] [get_bd_pins frmbuf_wr_rst_gpio/Din] [get_bd_pins gamma_rst_gpio/Din] [get_bd_pins sensor_rst_gpio/Din] [get_bd_pins vpss_csc_rst_gpio/Din] [get_bd_pins vpss_scaler_rst_gpio/Din]
  connect_bd_net -net M06_ARESETN_1 [get_bd_pins video_aresetn] [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins mipi_csi2_rx_subsystem_0/video_aresetn]
  connect_bd_net -net bg1_pin0_nc_0_1 [get_bd_pins bg1_pin0_nc] [get_bd_pins mipi_csi2_rx_subsystem_0/bg1_pin0_nc]
  connect_bd_net -net bg3_pin0_nc_0_1 [get_bd_pins bg3_pin0_nc] [get_bd_pins mipi_csi2_rx_subsystem_0/bg3_pin0_nc]
  connect_bd_net -net clk_150mhz [get_bd_pins m_axi_s2mm_aclk] [get_bd_pins axi_data_fifo_0/aclk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins mipi_csi2_rx_subsystem_0/video_aclk] [get_bd_pins v_demosaic_0/ap_clk] [get_bd_pins v_frmbuf_wr_0/ap_clk] [get_bd_pins v_gamma_lut_0/ap_clk] [get_bd_pins v_proc_ss_csc/aclk] [get_bd_pins v_proc_ss_scaler/aclk_axis] [get_bd_pins v_proc_ss_scaler/aclk_ctrl]
  connect_bd_net -net demosaic_rst_gpio_Dout [get_bd_pins demosaic_rst_gpio/Dout] [get_bd_pins v_demosaic_0/ap_rst_n]
  connect_bd_net -net dphy_clk_200M_1 [get_bd_pins dphy_clk_200M] [get_bd_pins mipi_csi2_rx_subsystem_0/dphy_clk_200M]
  connect_bd_net -net frmbuf_wr_rst_gpio1_Dout [get_bd_pins v_proc_ss_scaler/aresetn_ctrl] [get_bd_pins vpss_scaler_rst_gpio/Dout]
  connect_bd_net -net gamma_rst_gpio_Dout [get_bd_pins gamma_rst_gpio/Dout] [get_bd_pins v_gamma_lut_0/ap_rst_n]
  connect_bd_net -net lite_aresetn_0_1 [get_bd_pins lite_aresetn_0] [get_bd_pins mipi_csi2_rx_subsystem_0/lite_aresetn]
  connect_bd_net -net mipi_csi2_rx_subsystem_0_csirxss_csi_irq [get_bd_pins csirxss_csi_irq] [get_bd_pins mipi_csi2_rx_subsystem_0/csirxss_csi_irq]
  connect_bd_net -net s_axi_lite_aclk_1 [get_bd_pins s_axi_lite_aclk] [get_bd_pins mipi_csi2_rx_subsystem_0/lite_aclk]
  connect_bd_net -net sensor_rst_gpio_Dout [get_bd_pins Dout] [get_bd_pins sensor_rst_gpio/Dout]
  connect_bd_net -net tpg_rst_gpio_Dout [get_bd_pins axi_data_fifo_0/aresetn] [get_bd_pins frmbuf_wr_rst_gpio/Dout] [get_bd_pins v_frmbuf_wr_0/ap_rst_n]
  connect_bd_net -net v_frmbuf_wr_0_interrupt [get_bd_pins s2mm_introut] [get_bd_pins v_frmbuf_wr_0/interrupt]
  connect_bd_net -net vcc_dout [get_bd_pins dout1] [get_bd_pins vcc/dout]
  connect_bd_net -net vpss_csc_rst_gpio_Dout [get_bd_pins v_proc_ss_csc/aresetn] [get_bd_pins vpss_csc_rst_gpio/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hdmi_output
proc create_hier_cell_hdmi_output { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_hdmi_output() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 DDC

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 LINK_DATA0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 LINK_DATA1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 LINK_DATA2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 SB_STATUS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CPU

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video1_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video2_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video3_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video4_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video5_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video6_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video7_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video8_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 m_axi_mm_video_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_ctrl_frm_rd

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_ctrl_mixer


  # Create pins
  create_bd_pin -dir I -from 94 -to 0 Din
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn_100M
  create_bd_pin -dir I -type rst aresetn_300M
  create_bd_pin -dir I -type clk clk_100M
  create_bd_pin -dir I -type clk clk_300M
  create_bd_pin -dir I -type rst frmbuf_aresetn
  create_bd_pin -dir I hpd
  create_bd_pin -dir O -type intr interrupt_frm_rd
  create_bd_pin -dir O -type intr interrupt_hdmi_tx
  create_bd_pin -dir O -type intr interrupt_mixer
  create_bd_pin -dir I -type clk link_clk
  create_bd_pin -dir O locked
  create_bd_pin -dir I -type clk video_clk

  # Create instance: mixer_rst, and set properties
  set mixer_rst [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 mixer_rst ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {20} \
   CONFIG.DIN_TO {20} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $mixer_rst

  # Create instance: v_frmbuf_rd_0, and set properties
  set v_frmbuf_rd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_rd:3.0 v_frmbuf_rd_0 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {64} \
   CONFIG.HAS_BGRX8 {1} \
   CONFIG.HAS_RGBX8 {1} \
   CONFIG.HAS_UYVY8 {1} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_YUV8 {1} \
   CONFIG.HAS_YUVX8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_DATA_WIDTH {8} \
   CONFIG.MAX_NR_PLANES {2} \
 ] $v_frmbuf_rd_0

  # Create instance: v_hdmi_tx_ss_0, and set properties
  set v_hdmi_tx_ss_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_hdmi_tx_ss:3.2 v_hdmi_tx_ss_0 ]
  set_property -dict [ list \
   CONFIG.C_HDMI_FAST_SWITCH {true} \
   CONFIG.C_INCLUDE_YUV420_SUP {true} \
   CONFIG.C_INPUT_PIXELS_PER_CLOCK {2} \
   CONFIG.C_MAX_BITS_PER_COMPONENT {8} \
   CONFIG.C_VID_INTERFACE {0} \
 ] $v_hdmi_tx_ss_0

  # Create instance: v_mix_0, and set properties
  set v_mix_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_mix:5.2 v_mix_0 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {64} \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.AXIMM_NUM_OUTSTANDING {16} \
   CONFIG.C_M_AXI_MM_VIDEO1_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO2_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO3_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO4_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO5_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO6_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO7_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO8_DATA_WIDTH {128} \
   CONFIG.LAYER1_VIDEO_FORMAT {19} \
   CONFIG.LAYER2_VIDEO_FORMAT {19} \
   CONFIG.LAYER3_VIDEO_FORMAT {19} \
   CONFIG.LAYER4_VIDEO_FORMAT {19} \
   CONFIG.LAYER5_VIDEO_FORMAT {19} \
   CONFIG.LAYER6_VIDEO_FORMAT {19} \
   CONFIG.LAYER7_ALPHA {false} \
   CONFIG.LAYER7_VIDEO_FORMAT {19} \
   CONFIG.LAYER8_ALPHA {false} \
   CONFIG.LAYER8_VIDEO_FORMAT {19} \
   CONFIG.NR_LAYERS {9} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_mix_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_ctrl_mixer] [get_bd_intf_pins v_mix_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axi_mm_video1_0] [get_bd_intf_pins v_mix_0/m_axi_mm_video1]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axi_mm_video2_0] [get_bd_intf_pins v_mix_0/m_axi_mm_video2]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axi_mm_video6_0] [get_bd_intf_pins v_mix_0/m_axi_mm_video6]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axi_mm_video4_0] [get_bd_intf_pins v_mix_0/m_axi_mm_video4]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axi_mm_video5_0] [get_bd_intf_pins v_mix_0/m_axi_mm_video5]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axi_mm_video3_0] [get_bd_intf_pins v_mix_0/m_axi_mm_video3]
  connect_bd_intf_net -intf_net Conn8 [get_bd_intf_pins m_axi_mm_video7_0] [get_bd_intf_pins v_mix_0/m_axi_mm_video7]
  connect_bd_intf_net -intf_net Conn9 [get_bd_intf_pins m_axi_mm_video_0] [get_bd_intf_pins v_frmbuf_rd_0/m_axi_mm_video]
  connect_bd_intf_net -intf_net Conn10 [get_bd_intf_pins m_axi_mm_video8_0] [get_bd_intf_pins v_mix_0/m_axi_mm_video8]
  connect_bd_intf_net -intf_net DDC [get_bd_intf_pins DDC] [get_bd_intf_pins v_hdmi_tx_ss_0/DDC_OUT]
  connect_bd_intf_net -intf_net LINK_DATA0 [get_bd_intf_pins LINK_DATA0] [get_bd_intf_pins v_hdmi_tx_ss_0/LINK_DATA0_OUT]
  connect_bd_intf_net -intf_net LINK_DATA1 [get_bd_intf_pins LINK_DATA1] [get_bd_intf_pins v_hdmi_tx_ss_0/LINK_DATA1_OUT]
  connect_bd_intf_net -intf_net LINK_DATA2 [get_bd_intf_pins LINK_DATA2] [get_bd_intf_pins v_hdmi_tx_ss_0/LINK_DATA2_OUT]
  connect_bd_intf_net -intf_net SB_STATUS [get_bd_intf_pins SB_STATUS] [get_bd_intf_pins v_hdmi_tx_ss_0/SB_STATUS_IN]
  connect_bd_intf_net -intf_net S_AXI_CPU [get_bd_intf_pins S_AXI_CPU] [get_bd_intf_pins v_hdmi_tx_ss_0/S_AXI_CPU_IN]
  connect_bd_intf_net -intf_net s_axi_CTRL [get_bd_intf_pins s_axi_ctrl_frm_rd] [get_bd_intf_pins v_frmbuf_rd_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net v_frmbuf_rd_0_m_axis_video [get_bd_intf_pins v_frmbuf_rd_0/m_axis_video] [get_bd_intf_pins v_mix_0/s_axis_video]
  connect_bd_intf_net -intf_net v_mix_0_m_axis_video [get_bd_intf_pins v_hdmi_tx_ss_0/VIDEO_IN] [get_bd_intf_pins v_mix_0/m_axis_video]

  # Create port connections
  connect_bd_net -net Din_1 [get_bd_pins Din] [get_bd_pins mixer_rst/Din]
  connect_bd_net -net aresetn_100M [get_bd_pins aresetn_100M] [get_bd_pins v_hdmi_tx_ss_0/s_axi_cpu_aresetn]
  connect_bd_net -net aresetn_300M [get_bd_pins aresetn_300M] [get_bd_pins v_hdmi_tx_ss_0/s_axis_video_aresetn]
  connect_bd_net -net clk_100M [get_bd_pins clk_100M] [get_bd_pins v_hdmi_tx_ss_0/s_axi_cpu_aclk] [get_bd_pins v_hdmi_tx_ss_0/s_axis_audio_aclk]
  connect_bd_net -net clk_300M [get_bd_pins clk_300M] [get_bd_pins v_frmbuf_rd_0/ap_clk] [get_bd_pins v_hdmi_tx_ss_0/s_axis_video_aclk] [get_bd_pins v_mix_0/ap_clk]
  connect_bd_net -net frmbuf_aresetn [get_bd_pins frmbuf_aresetn] [get_bd_pins v_frmbuf_rd_0/ap_rst_n]
  connect_bd_net -net hpd_1 [get_bd_pins hpd] [get_bd_pins v_hdmi_tx_ss_0/hpd]
  connect_bd_net -net mixer_rst_Dout [get_bd_pins mixer_rst/Dout] [get_bd_pins v_mix_0/ap_rst_n]
  connect_bd_net -net v_frmbuf_rd_0_interrupt [get_bd_pins interrupt_frm_rd] [get_bd_pins v_frmbuf_rd_0/interrupt]
  connect_bd_net -net v_hdmi_tx_ss_0_irq [get_bd_pins interrupt_hdmi_tx] [get_bd_pins v_hdmi_tx_ss_0/irq]
  connect_bd_net -net v_hdmi_tx_ss_0_locked [get_bd_pins locked] [get_bd_pins v_hdmi_tx_ss_0/locked]
  connect_bd_net -net v_mix_0_interrupt [get_bd_pins interrupt_mixer] [get_bd_pins v_mix_0/interrupt]
  connect_bd_net -net vid_phy_controller_0_tx_video_clk [get_bd_pins video_clk] [get_bd_pins v_hdmi_tx_ss_0/video_clk]
  connect_bd_net -net vid_phy_controller_0_txoutclk [get_bd_pins link_clk] [get_bd_pins v_hdmi_tx_ss_0/link_clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hdmi_input
proc create_hier_cell_hdmi_input { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_hdmi_input() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 DDC

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 LINK_DATA0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 LINK_DATA1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 LINK_DATA2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI5

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI6

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 SB_STATUS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CPU_IN

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL6

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_CTRL7

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_ctrl4


  # Create pins
  create_bd_pin -dir I -from 94 -to 0 Din
  create_bd_pin -dir I -from 0 -to 0 -type rst aresetn_300M
  create_bd_pin -dir I cable_detect
  create_bd_pin -dir I -type clk clk_300M
  create_bd_pin -dir O -from 6 -to 0 dout
  create_bd_pin -dir I -type rst frmbuf_aresetn
  create_bd_pin -dir O hpd
  create_bd_pin -dir O -type intr irq
  create_bd_pin -dir I -type clk link_clk
  create_bd_pin -dir I -type clk s_axi_cpu_aclk
  create_bd_pin -dir I -type rst s_axi_cpu_aresetn
  create_bd_pin -dir I -type clk video_clk

  # Create instance: axi_data_fifo_0, and set properties
  set axi_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_data_fifo:2.1 axi_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.WRITE_FIFO_DELAY {1} \
   CONFIG.WRITE_FIFO_DEPTH {512} \
 ] $axi_data_fifo_0

  # Create instance: axi_data_fifo_1, and set properties
  set axi_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_data_fifo:2.1 axi_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.WRITE_FIFO_DELAY {1} \
   CONFIG.WRITE_FIFO_DEPTH {512} \
 ] $axi_data_fifo_1

  # Create instance: axi_data_fifo_2, and set properties
  set axi_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_data_fifo:2.1 axi_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.WRITE_FIFO_DELAY {1} \
   CONFIG.WRITE_FIFO_DEPTH {512} \
 ] $axi_data_fifo_2

  # Create instance: axi_data_fifo_3, and set properties
  set axi_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_data_fifo:2.1 axi_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.WRITE_FIFO_DELAY {1} \
   CONFIG.WRITE_FIFO_DEPTH {512} \
 ] $axi_data_fifo_3

  # Create instance: axi_data_fifo_4, and set properties
  set axi_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_data_fifo:2.1 axi_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.WRITE_FIFO_DELAY {1} \
   CONFIG.WRITE_FIFO_DEPTH {512} \
 ] $axi_data_fifo_4

  # Create instance: axi_data_fifo_5, and set properties
  set axi_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_data_fifo:2.1 axi_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.WRITE_FIFO_DELAY {1} \
   CONFIG.WRITE_FIFO_DEPTH {512} \
 ] $axi_data_fifo_5

  # Create instance: axi_data_fifo_6, and set properties
  set axi_data_fifo_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_data_fifo:2.1 axi_data_fifo_6 ]
  set_property -dict [ list \
   CONFIG.WRITE_FIFO_DELAY {1} \
   CONFIG.WRITE_FIFO_DEPTH {512} \
 ] $axi_data_fifo_6

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {7} \
 ] $axis_broadcaster_0

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {1024} \
   CONFIG.HAS_RD_DATA_COUNT {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {1024} \
   CONFIG.HAS_RD_DATA_COUNT {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {1024} \
   CONFIG.HAS_RD_DATA_COUNT {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {1024} \
   CONFIG.HAS_RD_DATA_COUNT {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {1024} \
   CONFIG.HAS_RD_DATA_COUNT {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {1024} \
   CONFIG.HAS_RD_DATA_COUNT {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
 ] $axis_data_fifo_5

  # Create instance: axis_data_fifo_6, and set properties
  set axis_data_fifo_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_6 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {1024} \
   CONFIG.HAS_RD_DATA_COUNT {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
 ] $axis_data_fifo_6

  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]

  # Create instance: axis_register_slice_1, and set properties
  set axis_register_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_1 ]

  # Create instance: axis_register_slice_2, and set properties
  set axis_register_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_2 ]

  # Create instance: axis_register_slice_3, and set properties
  set axis_register_slice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_3 ]

  # Create instance: axis_register_slice_4, and set properties
  set axis_register_slice_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_4 ]

  # Create instance: axis_register_slice_5, and set properties
  set axis_register_slice_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_5 ]

  # Create instance: axis_register_slice_6, and set properties
  set axis_register_slice_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_6 ]

  # Create instance: axis_subset_converter_0, and set properties
  set axis_subset_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter:1.1 axis_subset_converter_0 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {6} \
   CONFIG.S_TDATA_NUM_BYTES {6} \
   CONFIG.TDATA_REMAP {tdata[47:40],tdata[39:32],tdata[15:8],tdata[23:16],tdata[31:24],tdata[7:0]} \
 ] $axis_subset_converter_0

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_0

  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_1

  # Create instance: util_vector_logic_2, and set properties
  set util_vector_logic_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_2 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_2

  # Create instance: util_vector_logic_3, and set properties
  set util_vector_logic_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_3 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_3

  # Create instance: util_vector_logic_4, and set properties
  set util_vector_logic_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_4 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_4

  # Create instance: util_vector_logic_5, and set properties
  set util_vector_logic_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_5 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_5

  # Create instance: v_frmbuf_wr_0, and set properties
  set v_frmbuf_wr_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr:3.0 v_frmbuf_wr_0 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {64} \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_BGRX8 {1} \
   CONFIG.HAS_RGBX8 {1} \
   CONFIG.HAS_UYVY8 {1} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_YUV8 {1} \
   CONFIG.HAS_YUVX8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_DATA_WIDTH {8} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_frmbuf_wr_0

  # Create instance: v_frmbuf_wr_1, and set properties
  set v_frmbuf_wr_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr:3.0 v_frmbuf_wr_1 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {64} \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_BGRX8 {1} \
   CONFIG.HAS_RGBX8 {1} \
   CONFIG.HAS_UYVY8 {1} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_YUV8 {1} \
   CONFIG.HAS_YUVX8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_DATA_WIDTH {8} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_frmbuf_wr_1

  # Create instance: v_frmbuf_wr_2, and set properties
  set v_frmbuf_wr_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr:3.0 v_frmbuf_wr_2 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {64} \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_BGRX8 {1} \
   CONFIG.HAS_RGBX8 {1} \
   CONFIG.HAS_UYVY8 {1} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_YUV8 {1} \
   CONFIG.HAS_YUVX8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_DATA_WIDTH {8} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_frmbuf_wr_2

  # Create instance: v_frmbuf_wr_3, and set properties
  set v_frmbuf_wr_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr:3.0 v_frmbuf_wr_3 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {64} \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_BGRX8 {1} \
   CONFIG.HAS_RGBX8 {1} \
   CONFIG.HAS_UYVY8 {1} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_YUV8 {1} \
   CONFIG.HAS_YUVX8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_DATA_WIDTH {8} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_frmbuf_wr_3

  # Create instance: v_frmbuf_wr_4, and set properties
  set v_frmbuf_wr_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr:3.0 v_frmbuf_wr_4 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {64} \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_BGRX8 {1} \
   CONFIG.HAS_RGBX8 {1} \
   CONFIG.HAS_UYVY8 {1} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_YUV8 {1} \
   CONFIG.HAS_YUVX8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_DATA_WIDTH {8} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_frmbuf_wr_4

  # Create instance: v_frmbuf_wr_5, and set properties
  set v_frmbuf_wr_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr:3.0 v_frmbuf_wr_5 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {64} \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_BGRX8 {1} \
   CONFIG.HAS_RGBX8 {1} \
   CONFIG.HAS_UYVY8 {1} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_YUV8 {1} \
   CONFIG.HAS_YUVX8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_DATA_WIDTH {8} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_frmbuf_wr_5

  # Create instance: v_frmbuf_wr_6, and set properties
  set v_frmbuf_wr_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr:3.0 v_frmbuf_wr_6 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {64} \
   CONFIG.AXIMM_DATA_WIDTH {128} \
   CONFIG.C_M_AXI_MM_VIDEO_DATA_WIDTH {128} \
   CONFIG.HAS_BGRX8 {1} \
   CONFIG.HAS_RGBX8 {1} \
   CONFIG.HAS_UYVY8 {1} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_YUV8 {1} \
   CONFIG.HAS_YUVX8 {1} \
   CONFIG.HAS_YUYV8 {1} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_DATA_WIDTH {8} \
   CONFIG.MAX_NR_PLANES {2} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
 ] $v_frmbuf_wr_6

  # Create instance: v_hdmi_rx_ss_0, and set properties
  set v_hdmi_rx_ss_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_hdmi_rx_ss:3.2 v_hdmi_rx_ss_0 ]
  set_property -dict [ list \
   CONFIG.C_CD_INVERT {true} \
   CONFIG.C_HDMI_FAST_SWITCH {true} \
   CONFIG.C_INCLUDE_YUV420_SUP {true} \
   CONFIG.C_INPUT_PIXELS_PER_CLOCK {2} \
   CONFIG.C_MAX_BITS_PER_COMPONENT {8} \
 ] $v_hdmi_rx_ss_0

  # Create instance: v_proc_ss_0, and set properties
  set v_proc_ss_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_proc_ss:2.3 v_proc_ss_0 ]
  set_property -dict [ list \
   CONFIG.C_ENABLE_CSC {true} \
   CONFIG.C_H_SCALER_TAPS {8} \
   CONFIG.C_MAX_DATA_WIDTH {8} \
   CONFIG.C_TOPOLOGY {0} \
   CONFIG.C_V_SCALER_TAPS {8} \
 ] $v_proc_ss_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {7} \
 ] $xlconcat_0

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {14} \
   CONFIG.DIN_TO {14} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DIN_TO {15} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_1

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {21} \
   CONFIG.DIN_TO {21} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_2

  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {37} \
   CONFIG.DIN_TO {37} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_3

  # Create instance: xlslice_4, and set properties
  set xlslice_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_4 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {38} \
   CONFIG.DIN_TO {38} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_4

  # Create instance: xlslice_5, and set properties
  set xlslice_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_5 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {39} \
   CONFIG.DIN_TO {39} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_5

  # Create instance: xlslice_6, and set properties
  set xlslice_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_6 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {40} \
   CONFIG.DIN_TO {40} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_6

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_CTRL] [get_bd_intf_pins v_frmbuf_wr_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_data_fifo_1/M_AXI]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axi_CTRL1] [get_bd_intf_pins v_frmbuf_wr_5/s_axi_CTRL]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins M_AXI1] [get_bd_intf_pins axi_data_fifo_2/M_AXI]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins s_axi_CTRL2] [get_bd_intf_pins v_frmbuf_wr_2/s_axi_CTRL]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins S_AXI_CPU_IN] [get_bd_intf_pins v_hdmi_rx_ss_0/S_AXI_CPU_IN]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins s_axi_CTRL3] [get_bd_intf_pins v_frmbuf_wr_1/s_axi_CTRL]
  connect_bd_intf_net -intf_net Conn8 [get_bd_intf_pins s_axi_ctrl4] [get_bd_intf_pins v_proc_ss_0/s_axi_ctrl]
  connect_bd_intf_net -intf_net Conn9 [get_bd_intf_pins s_axi_CTRL5] [get_bd_intf_pins v_frmbuf_wr_4/s_axi_CTRL]
  connect_bd_intf_net -intf_net Conn10 [get_bd_intf_pins s_axi_CTRL6] [get_bd_intf_pins v_frmbuf_wr_3/s_axi_CTRL]
  connect_bd_intf_net -intf_net Conn11 [get_bd_intf_pins s_axi_CTRL7] [get_bd_intf_pins v_frmbuf_wr_6/s_axi_CTRL]
  connect_bd_intf_net -intf_net Conn12 [get_bd_intf_pins M_AXI2] [get_bd_intf_pins axi_data_fifo_0/M_AXI]
  connect_bd_intf_net -intf_net Conn13 [get_bd_intf_pins M_AXI3] [get_bd_intf_pins axi_data_fifo_4/M_AXI]
  connect_bd_intf_net -intf_net Conn14 [get_bd_intf_pins M_AXI4] [get_bd_intf_pins axi_data_fifo_3/M_AXI]
  connect_bd_intf_net -intf_net Conn15 [get_bd_intf_pins M_AXI5] [get_bd_intf_pins axi_data_fifo_5/M_AXI]
  connect_bd_intf_net -intf_net Conn16 [get_bd_intf_pins M_AXI6] [get_bd_intf_pins axi_data_fifo_6/M_AXI]
  connect_bd_intf_net -intf_net DDC [get_bd_intf_pins DDC] [get_bd_intf_pins v_hdmi_rx_ss_0/DDC_OUT]
  connect_bd_intf_net -intf_net LINK_DATA0 [get_bd_intf_pins LINK_DATA0] [get_bd_intf_pins v_hdmi_rx_ss_0/LINK_DATA0_IN]
  connect_bd_intf_net -intf_net LINK_DATA1 [get_bd_intf_pins LINK_DATA1] [get_bd_intf_pins v_hdmi_rx_ss_0/LINK_DATA1_IN]
  connect_bd_intf_net -intf_net LINK_DATA2 [get_bd_intf_pins LINK_DATA2] [get_bd_intf_pins v_hdmi_rx_ss_0/LINK_DATA2_IN]
  connect_bd_intf_net -intf_net SB_STATUS [get_bd_intf_pins SB_STATUS] [get_bd_intf_pins v_hdmi_rx_ss_0/SB_STATUS_IN]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M03_AXIS [get_bd_intf_pins axis_broadcaster_0/M03_AXIS] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M04_AXIS [get_bd_intf_pins axis_broadcaster_0/M04_AXIS] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M05_AXIS [get_bd_intf_pins axis_broadcaster_0/M05_AXIS] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M06_AXIS [get_bd_intf_pins axis_broadcaster_0/M06_AXIS] [get_bd_intf_pins axis_data_fifo_6/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins axis_register_slice_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins axis_data_fifo_1/M_AXIS] [get_bd_intf_pins axis_subset_converter_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins axis_data_fifo_2/M_AXIS] [get_bd_intf_pins axis_register_slice_2/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins axis_data_fifo_3/M_AXIS] [get_bd_intf_pins axis_register_slice_3/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins axis_data_fifo_4/M_AXIS] [get_bd_intf_pins axis_register_slice_4/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins axis_data_fifo_5/M_AXIS] [get_bd_intf_pins axis_register_slice_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_6_M_AXIS [get_bd_intf_pins axis_data_fifo_6/M_AXIS] [get_bd_intf_pins axis_register_slice_6/S_AXIS]
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins axis_register_slice_0/M_AXIS] [get_bd_intf_pins v_frmbuf_wr_0/s_axis_video]
  connect_bd_intf_net -intf_net axis_register_slice_1_M_AXIS [get_bd_intf_pins axis_register_slice_1/M_AXIS] [get_bd_intf_pins v_frmbuf_wr_1/s_axis_video]
  connect_bd_intf_net -intf_net axis_register_slice_2_M_AXIS [get_bd_intf_pins axis_register_slice_2/M_AXIS] [get_bd_intf_pins v_frmbuf_wr_2/s_axis_video]
  connect_bd_intf_net -intf_net axis_register_slice_3_M_AXIS [get_bd_intf_pins axis_register_slice_3/M_AXIS] [get_bd_intf_pins v_frmbuf_wr_3/s_axis_video]
  connect_bd_intf_net -intf_net axis_register_slice_4_M_AXIS [get_bd_intf_pins axis_register_slice_4/M_AXIS] [get_bd_intf_pins v_frmbuf_wr_4/s_axis_video]
  connect_bd_intf_net -intf_net axis_register_slice_5_M_AXIS [get_bd_intf_pins axis_register_slice_5/M_AXIS] [get_bd_intf_pins v_frmbuf_wr_5/s_axis_video]
  connect_bd_intf_net -intf_net axis_register_slice_6_M_AXIS [get_bd_intf_pins axis_register_slice_6/M_AXIS] [get_bd_intf_pins v_frmbuf_wr_6/s_axis_video]
  connect_bd_intf_net -intf_net axis_subset_converter_0_M_AXIS [get_bd_intf_pins axis_register_slice_1/S_AXIS] [get_bd_intf_pins axis_subset_converter_0/M_AXIS]
  connect_bd_intf_net -intf_net f_0_M02_AXIS [get_bd_intf_pins axis_broadcaster_0/M02_AXIS] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net v_frmbuf_wr_0_m_axi_mm_video [get_bd_intf_pins axi_data_fifo_0/S_AXI] [get_bd_intf_pins v_frmbuf_wr_0/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_frmbuf_wr_1_m_axi_mm_video [get_bd_intf_pins axi_data_fifo_1/S_AXI] [get_bd_intf_pins v_frmbuf_wr_1/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_frmbuf_wr_2_m_axi_mm_video [get_bd_intf_pins axi_data_fifo_2/S_AXI] [get_bd_intf_pins v_frmbuf_wr_2/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_frmbuf_wr_3_m_axi_mm_video [get_bd_intf_pins axi_data_fifo_3/S_AXI] [get_bd_intf_pins v_frmbuf_wr_3/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_frmbuf_wr_4_m_axi_mm_video [get_bd_intf_pins axi_data_fifo_4/S_AXI] [get_bd_intf_pins v_frmbuf_wr_4/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_frmbuf_wr_5_m_axi_mm_video [get_bd_intf_pins axi_data_fifo_5/S_AXI] [get_bd_intf_pins v_frmbuf_wr_5/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_frmbuf_wr_6_m_axi_mm_video [get_bd_intf_pins axi_data_fifo_6/S_AXI] [get_bd_intf_pins v_frmbuf_wr_6/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_hdmi_rx_ss_0_VIDEO_OUT [get_bd_intf_pins v_hdmi_rx_ss_0/VIDEO_OUT] [get_bd_intf_pins v_proc_ss_0/s_axis]
  connect_bd_intf_net -intf_net v_proc_ss_0_m_axis [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins v_proc_ss_0/m_axis]

  # Create port connections
  connect_bd_net -net Din_1 [get_bd_pins Din] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_2/Din] [get_bd_pins xlslice_3/Din] [get_bd_pins xlslice_4/Din] [get_bd_pins xlslice_5/Din] [get_bd_pins xlslice_6/Din]
  connect_bd_net -net aresetn_300M [get_bd_pins aresetn_300M] [get_bd_pins axis_register_slice_0/aresetn] [get_bd_pins axis_register_slice_1/aresetn] [get_bd_pins axis_register_slice_2/aresetn] [get_bd_pins axis_register_slice_3/aresetn] [get_bd_pins axis_register_slice_4/aresetn] [get_bd_pins axis_register_slice_5/aresetn] [get_bd_pins axis_register_slice_6/aresetn] [get_bd_pins axis_subset_converter_0/aresetn] [get_bd_pins v_hdmi_rx_ss_0/s_axis_video_aresetn]
  connect_bd_net -net cable_detect [get_bd_pins cable_detect] [get_bd_pins v_hdmi_rx_ss_0/cable_detect]
  connect_bd_net -net clk_300M [get_bd_pins clk_300M] [get_bd_pins axi_data_fifo_0/aclk] [get_bd_pins axi_data_fifo_1/aclk] [get_bd_pins axi_data_fifo_2/aclk] [get_bd_pins axi_data_fifo_3/aclk] [get_bd_pins axi_data_fifo_4/aclk] [get_bd_pins axi_data_fifo_5/aclk] [get_bd_pins axi_data_fifo_6/aclk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk] [get_bd_pins axis_data_fifo_6/s_axis_aclk] [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins axis_register_slice_1/aclk] [get_bd_pins axis_register_slice_2/aclk] [get_bd_pins axis_register_slice_3/aclk] [get_bd_pins axis_register_slice_4/aclk] [get_bd_pins axis_register_slice_5/aclk] [get_bd_pins axis_register_slice_6/aclk] [get_bd_pins axis_subset_converter_0/aclk] [get_bd_pins v_frmbuf_wr_0/ap_clk] [get_bd_pins v_frmbuf_wr_1/ap_clk] [get_bd_pins v_frmbuf_wr_2/ap_clk] [get_bd_pins v_frmbuf_wr_3/ap_clk] [get_bd_pins v_frmbuf_wr_4/ap_clk] [get_bd_pins v_frmbuf_wr_5/ap_clk] [get_bd_pins v_frmbuf_wr_6/ap_clk] [get_bd_pins v_hdmi_rx_ss_0/s_axis_video_aclk] [get_bd_pins v_proc_ss_0/aclk_axis] [get_bd_pins v_proc_ss_0/aclk_ctrl]
  connect_bd_net -net link_clk [get_bd_pins link_clk] [get_bd_pins v_hdmi_rx_ss_0/link_clk]
  connect_bd_net -net mpsoc_ss_aresetn_100M [get_bd_pins s_axi_cpu_aresetn] [get_bd_pins v_hdmi_rx_ss_0/s_axi_cpu_aresetn]
  connect_bd_net -net mpsoc_ss_clk_100M [get_bd_pins s_axi_cpu_aclk] [get_bd_pins v_hdmi_rx_ss_0/s_axi_cpu_aclk] [get_bd_pins v_hdmi_rx_ss_0/s_axis_audio_aclk]
  connect_bd_net -net rx_scaler_reset [get_bd_pins frmbuf_aresetn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn] [get_bd_pins axis_data_fifo_6/s_axis_aresetn] [get_bd_pins v_proc_ss_0/aresetn_ctrl]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins util_vector_logic_0/Res] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins util_vector_logic_1/Res] [get_bd_pins util_vector_logic_2/Op1]
  connect_bd_net -net util_vector_logic_2_Res [get_bd_pins util_vector_logic_2/Res] [get_bd_pins util_vector_logic_3/Op1]
  connect_bd_net -net util_vector_logic_3_Res [get_bd_pins util_vector_logic_3/Res] [get_bd_pins util_vector_logic_4/Op1]
  connect_bd_net -net util_vector_logic_4_Res [get_bd_pins util_vector_logic_4/Res] [get_bd_pins util_vector_logic_5/Op1]
  connect_bd_net -net util_vector_logic_5_Res [get_bd_pins axis_register_slice_0/m_axis_tready] [get_bd_pins axis_register_slice_1/m_axis_tready] [get_bd_pins axis_register_slice_2/m_axis_tready] [get_bd_pins axis_register_slice_3/m_axis_tready] [get_bd_pins axis_register_slice_4/m_axis_tready] [get_bd_pins axis_register_slice_5/m_axis_tready] [get_bd_pins axis_register_slice_6/m_axis_tready] [get_bd_pins util_vector_logic_5/Res]
  connect_bd_net -net v_frmbuf_wr_0_interrupt [get_bd_pins v_frmbuf_wr_0/interrupt] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net v_frmbuf_wr_0_s_axis_video_TREADY [get_bd_pins util_vector_logic_0/Op1] [get_bd_pins v_frmbuf_wr_0/s_axis_video_TREADY]
  connect_bd_net -net v_frmbuf_wr_1_interrupt [get_bd_pins v_frmbuf_wr_1/interrupt] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net v_frmbuf_wr_1_s_axis_video_TREADY [get_bd_pins util_vector_logic_0/Op2] [get_bd_pins v_frmbuf_wr_1/s_axis_video_TREADY]
  connect_bd_net -net v_frmbuf_wr_2_interrupt [get_bd_pins v_frmbuf_wr_2/interrupt] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net v_frmbuf_wr_2_s_axis_video_TREADY [get_bd_pins util_vector_logic_1/Op2] [get_bd_pins v_frmbuf_wr_2/s_axis_video_TREADY]
  connect_bd_net -net v_frmbuf_wr_3_interrupt [get_bd_pins v_frmbuf_wr_3/interrupt] [get_bd_pins xlconcat_0/In3]
  connect_bd_net -net v_frmbuf_wr_3_s_axis_video_TREADY [get_bd_pins util_vector_logic_2/Op2] [get_bd_pins v_frmbuf_wr_3/s_axis_video_TREADY]
  connect_bd_net -net v_frmbuf_wr_4_interrupt [get_bd_pins v_frmbuf_wr_4/interrupt] [get_bd_pins xlconcat_0/In4]
  connect_bd_net -net v_frmbuf_wr_4_s_axis_video_TREADY [get_bd_pins util_vector_logic_3/Op2] [get_bd_pins v_frmbuf_wr_4/s_axis_video_TREADY]
  connect_bd_net -net v_frmbuf_wr_5_interrupt [get_bd_pins v_frmbuf_wr_5/interrupt] [get_bd_pins xlconcat_0/In5]
  connect_bd_net -net v_frmbuf_wr_5_s_axis_video_TREADY [get_bd_pins util_vector_logic_4/Op2] [get_bd_pins v_frmbuf_wr_5/s_axis_video_TREADY]
  connect_bd_net -net v_frmbuf_wr_6_interrupt [get_bd_pins v_frmbuf_wr_6/interrupt] [get_bd_pins xlconcat_0/In6]
  connect_bd_net -net v_frmbuf_wr_6_s_axis_video_TREADY [get_bd_pins util_vector_logic_5/Op2] [get_bd_pins v_frmbuf_wr_6/s_axis_video_TREADY]
  connect_bd_net -net v_hdmi_rx_ss_0_hpd [get_bd_pins hpd] [get_bd_pins v_hdmi_rx_ss_0/hpd]
  connect_bd_net -net v_hdmi_rx_ss_0_irq [get_bd_pins irq] [get_bd_pins v_hdmi_rx_ss_0/irq]
  connect_bd_net -net video_clk [get_bd_pins video_clk] [get_bd_pins v_hdmi_rx_ss_0/video_clk]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins dout] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins axi_data_fifo_1/aresetn] [get_bd_pins v_frmbuf_wr_1/ap_rst_n] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins axi_data_fifo_0/aresetn] [get_bd_pins v_frmbuf_wr_0/ap_rst_n] [get_bd_pins xlslice_1/Dout]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins axi_data_fifo_2/aresetn] [get_bd_pins v_frmbuf_wr_2/ap_rst_n] [get_bd_pins xlslice_2/Dout]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins axi_data_fifo_3/aresetn] [get_bd_pins v_frmbuf_wr_3/ap_rst_n] [get_bd_pins xlslice_3/Dout]
  connect_bd_net -net xlslice_4_Dout [get_bd_pins axi_data_fifo_4/aresetn] [get_bd_pins v_frmbuf_wr_4/ap_rst_n] [get_bd_pins xlslice_4/Dout]
  connect_bd_net -net xlslice_5_Dout [get_bd_pins axi_data_fifo_5/aresetn] [get_bd_pins v_frmbuf_wr_5/ap_rst_n] [get_bd_pins xlslice_5/Dout]
  connect_bd_net -net xlslice_6_Dout [get_bd_pins axi_data_fifo_6/aresetn] [get_bd_pins v_frmbuf_wr_6/ap_rst_n] [get_bd_pins xlslice_6/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: gt_refclk_buf
proc create_hier_cell_gt_refclk_buf { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_gt_refclk_buf() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 CLK_IN_D


  # Create pins
  create_bd_pin -dir O -from 0 -to 0 -type clk BUFG_GT_O
  create_bd_pin -dir O -from 0 -to 0 -type clk IBUF_OUT

  # Create instance: const_vcc, and set properties
  set const_vcc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_vcc ]

  # Create instance: ibufds_gt, and set properties
  set ibufds_gt [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 ibufds_gt ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $ibufds_gt

  # Create instance: ibufds_gt_odiv2, and set properties
  set ibufds_gt_odiv2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 ibufds_gt_odiv2 ]
  set_property -dict [ list \
   CONFIG.C_BUFGCE_DIV {2} \
   CONFIG.C_BUF_TYPE {BUFG_GT} \
 ] $ibufds_gt_odiv2

  # Create interface connections
  connect_bd_intf_net -intf_net DRU_CLK_IN_1 [get_bd_intf_pins CLK_IN_D] [get_bd_intf_pins ibufds_gt/CLK_IN_D]

  # Create port connections
  connect_bd_net -net const_vcc_dout [get_bd_pins const_vcc/dout] [get_bd_pins ibufds_gt_odiv2/BUFG_GT_CE]
  connect_bd_net -net ibufds_gt_IBUF_DS_ODIV2 [get_bd_pins ibufds_gt/IBUF_DS_ODIV2] [get_bd_pins ibufds_gt_odiv2/BUFG_GT_I]
  connect_bd_net -net ibufds_gt_IBUF_OUT [get_bd_pins IBUF_OUT] [get_bd_pins ibufds_gt/IBUF_OUT]
  connect_bd_net -net ibufds_gt_odiv2_BUFG_GT_O [get_bd_pins BUFG_GT_O] [get_bd_pins ibufds_gt_odiv2/BUFG_GT_O]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: gpio_aresetn
proc create_hier_cell_gpio_aresetn { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_gpio_aresetn() - Empty argument(s)!"}
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
  create_bd_pin -dir O -from 0 -to 0 Dout
  create_bd_pin -dir O -from 0 -to 0 -type rst gpio_0
  create_bd_pin -dir O -from 0 -to 0 gpio_1

  # Create instance: rx_scaler_reset, and set properties
  set rx_scaler_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 rx_scaler_reset ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $rx_scaler_reset

  # Create instance: tx_frmbuf_rd_aresetn_1, and set properties
  set tx_frmbuf_rd_aresetn_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 tx_frmbuf_rd_aresetn_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $tx_frmbuf_rd_aresetn_1

  # Create instance: tx_frmbuf_rd_aresetn_2, and set properties
  set tx_frmbuf_rd_aresetn_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 tx_frmbuf_rd_aresetn_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {90} \
   CONFIG.DIN_TO {90} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $tx_frmbuf_rd_aresetn_2

  # Create port connections
  connect_bd_net -net frmbuf_rd_rst_gpio_Dout [get_bd_pins gpio_1] [get_bd_pins tx_frmbuf_rd_aresetn_1/Dout]
  connect_bd_net -net frmbuf_wr_rst_gpio_Dout [get_bd_pins gpio_0] [get_bd_pins rx_scaler_reset/Dout]
  connect_bd_net -net tx_frmbuf_rd_aresetn_2_Dout [get_bd_pins Dout] [get_bd_pins tx_frmbuf_rd_aresetn_2/Dout]
  connect_bd_net -net zynq_ultra_ps_e_0_emio_gpio_o [get_bd_pins Din] [get_bd_pins rx_scaler_reset/Din] [get_bd_pins tx_frmbuf_rd_aresetn_1/Din] [get_bd_pins tx_frmbuf_rd_aresetn_2/Din]

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
  set DRU_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 DRU_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $DRU_CLK

  set HDMI_CTRL_IIC [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 HDMI_CTRL_IIC ]

  set RX_DDC [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 RX_DDC ]

  set TX_DDC [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 TX_DDC ]

  set mipi_phy_if_0_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:mipi_phy_rtl:1.0 mipi_phy_if_0_0 ]

  set sensor_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 sensor_iic ]

  set CLK_300_C_P [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 CLK_300_C_P ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {300000000} \
   ] $CLK_300_C_P


  # Create ports
  set HDMI_RX_CLK_N [ create_bd_port -dir I HDMI_RX_CLK_N ]
  set HDMI_RX_CLK_P [ create_bd_port -dir I HDMI_RX_CLK_P ]
  set HDMI_RX_DAT_N [ create_bd_port -dir I -from 2 -to 0 HDMI_RX_DAT_N ]
  set HDMI_RX_DAT_P [ create_bd_port -dir I -from 2 -to 0 HDMI_RX_DAT_P ]
  set HDMI_TX_CLK_N [ create_bd_port -dir O HDMI_TX_CLK_N ]
  set HDMI_TX_CLK_P [ create_bd_port -dir O HDMI_TX_CLK_P ]
  set HDMI_TX_DAT_N [ create_bd_port -dir O -from 2 -to 0 HDMI_TX_DAT_N ]
  set HDMI_TX_DAT_P [ create_bd_port -dir O -from 2 -to 0 HDMI_TX_DAT_P ]
  set LED0 [ create_bd_port -dir O LED0 ]
  set LED1 [ create_bd_port -dir O -from 0 -to 0 LED1 ]
  #set LED2 [ create_bd_port -dir O -from 0 -to 0 LED2 ]
  #set LED3 [ create_bd_port -dir O -from 0 -to 0 LED3 ]
  #set LED4 [ create_bd_port -dir O -from 0 -to 0 LED4 ]
  #set LED5 [ create_bd_port -dir O -from 0 -to 0 LED5 ]
  set LED2 [ create_bd_port -dir O LED2 ]
  set LED3 [ create_bd_port -dir O LED3 ]
  set RX_DET [ create_bd_port -dir I RX_DET ]
  set RX_HPD [ create_bd_port -dir O -from 0 -to 0 RX_HPD ]
  set RX_REFCLK_N [ create_bd_port -dir O RX_REFCLK_N ]
  set RX_REFCLK_P [ create_bd_port -dir O RX_REFCLK_P ]
  set SI5319_LOL [ create_bd_port -dir I SI5319_LOL ]
  set SI5319_RST [ create_bd_port -dir O -from 0 -to 0 SI5319_RST ]
  set TX_EN [ create_bd_port -dir O -from 0 -to 0 TX_EN ]
  set TX_HPD [ create_bd_port -dir I TX_HPD ]
  set TX_REFCLK_N [ create_bd_port -dir I TX_REFCLK_N ]
  set TX_REFCLK_P [ create_bd_port -dir I TX_REFCLK_P ]
  set bg1_pin0_nc_0 [ create_bd_port -dir I bg1_pin0_nc_0 ]
  set bg3_pin0_nc_0 [ create_bd_port -dir I bg3_pin0_nc_0 ]
  set sensor_gpio_flash [ create_bd_port -dir O -from 0 -to 0 sensor_gpio_flash ]
  set sensor_gpio_rst [ create_bd_port -dir O -from 0 -to 0 sensor_gpio_rst ]
  set sensor_gpio_spi_cs_n [ create_bd_port -dir O -from 0 -to 0 sensor_gpio_spi_cs_n ]

  # Create instance: axi_intc_0, and set properties
  set axi_intc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 axi_intc_0 ]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {10} \
 ] $axi_interconnect_0

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_interconnect_1

  # Create instance: axi_interconnect_2, and set properties
  set axi_interconnect_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_2 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_interconnect_2

  # Create instance: axi_interconnect_4, and set properties
  set axi_interconnect_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_4 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {9} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_interconnect_4

  # Create instance: axi_interconnect_5, and set properties
  set axi_interconnect_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_5 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
 ] $axi_interconnect_5

  # Create instance: axi_timer_0, and set properties
  set axi_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0 ]

  # Create instance: clk_wiz_1, and set properties
  set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_1 ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {100.000} \
   CONFIG.CLKIN1_UI_JITTER {100.000} \
   CONFIG.CLKIN2_JITTER_PS {100.000} \
   CONFIG.CLKIN2_UI_JITTER {100.000} \
   CONFIG.CLKOUT1_JITTER {130.356} \
   CONFIG.CLKOUT1_PHASE_ERROR {77.836} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {33.33} \
   CONFIG.CLKOUT2_JITTER {83.751} \
   CONFIG.CLKOUT2_PHASE_ERROR {77.836} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {300} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_JITTER {90.370} \
   CONFIG.CLKOUT3_PHASE_ERROR {77.836} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {200.000} \
   CONFIG.CLKOUT3_USED {true} \
   CONFIG.CLKOUT4_JITTER {103.044} \
   CONFIG.CLKOUT4_PHASE_ERROR {77.836} \
   CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {100.000} \
   CONFIG.CLKOUT4_USED {false} \
   CONFIG.ENABLE_CLOCK_MONITOR {false} \
   CONFIG.JITTER_OPTIONS {PS} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {4.000} \
   CONFIG.MMCM_CLKIN1_PERIOD {3.333} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {36.000} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {4} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {6} \
   CONFIG.MMCM_CLKOUT3_DIVIDE {1} \
   CONFIG.MMCM_DIVCLK_DIVIDE {1} \
   CONFIG.MMCM_REF_JITTER1 {0.030} \
   CONFIG.MMCM_REF_JITTER2 {0.010} \
   CONFIG.NUM_OUT_CLKS {3} \
   CONFIG.PRIMITIVE {MMCM} \
   CONFIG.PRIM_IN_FREQ {300.000} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
   CONFIG.USE_INCLK_SWITCHOVER {false} \
   CONFIG.USE_PHASE_ALIGNMENT {true} \
   CONFIG.USE_RESET {false} \
 ] $clk_wiz_1

  # Create instance: gnd_const, and set properties
  set gnd_const [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 gnd_const ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $gnd_const

  # Create instance: gpio_aresetn
  create_hier_cell_gpio_aresetn [current_bd_instance .] gpio_aresetn

  # Create instance: gt_refclk_buf
  create_hier_cell_gt_refclk_buf [current_bd_instance .] gt_refclk_buf

  # Create instance: hdmi_input
  create_hier_cell_hdmi_input [current_bd_instance .] hdmi_input

  # Create instance: hdmi_output
  create_hier_cell_hdmi_output [current_bd_instance .] hdmi_output

  # Create instance: interrupts, and set properties
  set interrupts [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 interrupts ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {8} \
 ] $interrupts

  # Create instance: interrupts1, and set properties
  set interrupts1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 interrupts1 ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {7} \
 ] $interrupts1

  # Create instance: mipi_csi2_rx
  create_hier_cell_mipi_csi2_rx [current_bd_instance .] mipi_csi2_rx

  # Create instance: mpsoc_ss
  create_hier_cell_mpsoc_ss [current_bd_instance .] mpsoc_ss

  # Create instance: proc_sys_reset_1, and set properties
  set proc_sys_reset_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1 ]

  # Create instance: rx_hdmi_hb_0, and set properties
  set rx_hdmi_hb_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:hdmi_hb:1.0 rx_hdmi_hb_0 ]

  # Create instance: sensor_iic_0, and set properties
  set sensor_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 sensor_iic_0 ]
  set_property -dict [ list \
   CONFIG.IIC_FREQ_KHZ {400} \
 ] $sensor_iic_0

  # Create instance: tpg_input
  create_hier_cell_tpg_input [current_bd_instance .] tpg_input

  # Create instance: tx_hdmi_hb_0, and set properties
  set tx_hdmi_hb_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:hdmi_hb:1.0 tx_hdmi_hb_0 ]

  # Create instance: v_scenechange_0, and set properties
  set v_scenechange_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_scenechange:1.1 v_scenechange_0 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {64} \
   CONFIG.AXIMM_BURST_LENGTH {16} \
   CONFIG.AXIMM_DATA_WIDTH {32} \
   CONFIG.AXIMM_NUM_OUTSTANDING {4} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_Y10 {1} \
   CONFIG.HISTOGRAM_BITS {6} \
   CONFIG.MAX_COLS {3840} \
   CONFIG.MAX_DATA_WIDTH {8} \
   CONFIG.MAX_NR_STREAMS {8} \
   CONFIG.MAX_ROWS {2160} \
   CONFIG.MEMORY_BASED {1} \
   CONFIG.SAMPLES_PER_CLOCK {1} \
 ] $v_scenechange_0

  # Create instance: vcc_const, and set properties
  set vcc_const [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 vcc_const ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
 ] $vcc_const

  # Create instance: vcu_0, and set properties
  set vcu_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vcu:1.2 vcu_0 ]
  set_property -dict [ list \
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

  # Create instance: vcu_rst, and set properties
  set vcu_rst [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 vcu_rst ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {41} \
   CONFIG.DIN_TO {41} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $vcu_rst

  # Create instance: vid_phy_controller, and set properties
  set vid_phy_controller [ create_bd_cell -type ip -vlnv xilinx.com:ip:vid_phy_controller:2.2 vid_phy_controller ]
  set_property -dict [ list \
   CONFIG.CHANNEL_ENABLE {X0Y16 X0Y17 X0Y18} \
   CONFIG.CHANNEL_SITE {X0Y16} \
   CONFIG.C_FOR_UPGRADE_ARCHITECTURE {placeholder} \
   CONFIG.C_FOR_UPGRADE_DEVICE {placeholder} \
   CONFIG.C_FOR_UPGRADE_MAXOPTVOL {0.00} \
   CONFIG.C_FOR_UPGRADE_PACKAGE {placeholder} \
   CONFIG.C_FOR_UPGRADE_PART {placeholder} \
   CONFIG.C_FOR_UPGRADE_REFVOL {0.00} \
   CONFIG.C_FOR_UPGRADE_SPEEDGRADE {0} \
   CONFIG.C_INPUT_PIXELS_PER_CLOCK {2} \
   CONFIG.C_INT_HDMI_VER_CMPTBLE {3} \
   CONFIG.C_NIDRU {true} \
   CONFIG.C_NIDRU_REFCLK_SEL {3} \
   CONFIG.C_RX_PLL_SELECTION {0} \
   CONFIG.C_RX_REFCLK_SEL {1} \
   CONFIG.C_Rx_No_Of_Channels {3} \
   CONFIG.C_Rx_Protocol {HDMI} \
   CONFIG.C_TX_PLL_SELECTION {6} \
   CONFIG.C_TX_REFCLK_SEL {0} \
   CONFIG.C_Tx_No_Of_Channels {3} \
   CONFIG.C_Tx_Protocol {HDMI} \
   CONFIG.C_Txrefclk_Rdy_Invert {true} \
   CONFIG.C_Use_Oddr_for_Tmds_Clkout {true} \
   CONFIG.C_vid_phy_rx_axi4s_ch_INT_TDATA_WIDTH {20} \
   CONFIG.C_vid_phy_rx_axi4s_ch_TDATA_WIDTH {20} \
   CONFIG.C_vid_phy_rx_axi4s_ch_TUSER_WIDTH {1} \
   CONFIG.C_vid_phy_tx_axi4s_ch_INT_TDATA_WIDTH {20} \
   CONFIG.C_vid_phy_tx_axi4s_ch_TDATA_WIDTH {20} \
   CONFIG.C_vid_phy_tx_axi4s_ch_TUSER_WIDTH {1} \
   CONFIG.DRPCLK_FREQ {100.0} \
   CONFIG.Rx_GT_Line_Rate {5.94} \
   CONFIG.Rx_GT_Ref_Clock_Freq {297} \
   CONFIG.Rx_Max_GT_Line_Rate {5.94} \
   CONFIG.Tx_Buffer_Bypass {true} \
   CONFIG.Tx_GT_Line_Rate {5.94} \
   CONFIG.Tx_GT_Ref_Clock_Freq {297} \
   CONFIG.Tx_Max_GT_Line_Rate {5.94} \
 ] $vid_phy_controller

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN1_D_0_2 [get_bd_intf_ports CLK_300_C_P] [get_bd_intf_pins clk_wiz_1/CLK_IN1_D]
  connect_bd_intf_net -intf_net DRU_CLK [get_bd_intf_ports DRU_CLK] [get_bd_intf_pins gt_refclk_buf/CLK_IN_D]
  connect_bd_intf_net -intf_net RX_DDC [get_bd_intf_ports RX_DDC] [get_bd_intf_pins hdmi_input/DDC]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins axi_interconnect_4/S00_AXI] [get_bd_intf_pins hdmi_input/M_AXI2]
  connect_bd_intf_net -intf_net S03_AXI_1 [get_bd_intf_pins axi_interconnect_4/S03_AXI] [get_bd_intf_pins hdmi_input/M_AXI4]
  connect_bd_intf_net -intf_net S04_AXI_1 [get_bd_intf_pins axi_interconnect_4/S04_AXI] [get_bd_intf_pins hdmi_input/M_AXI]
  connect_bd_intf_net -intf_net S05_AXI_1 [get_bd_intf_pins axi_interconnect_4/S05_AXI] [get_bd_intf_pins hdmi_input/M_AXI1]
  connect_bd_intf_net -intf_net S06_AXI_1 [get_bd_intf_pins axi_interconnect_4/S06_AXI] [get_bd_intf_pins hdmi_input/M_AXI3]
  connect_bd_intf_net -intf_net S07_AXI_1 [get_bd_intf_pins axi_interconnect_4/S07_AXI] [get_bd_intf_pins hdmi_input/M_AXI5]
  connect_bd_intf_net -intf_net S08_AXI_1 [get_bd_intf_pins axi_interconnect_4/S08_AXI] [get_bd_intf_pins hdmi_input/M_AXI6]
  connect_bd_intf_net -intf_net S09_AXI_1 [get_bd_intf_pins axi_interconnect_0/S09_AXI] [get_bd_intf_pins v_scenechange_0/m_axi_mm_video]
  connect_bd_intf_net -intf_net SB_STATUS_IN_1 [get_bd_intf_pins hdmi_output/SB_STATUS] [get_bd_intf_pins vid_phy_controller/vid_phy_status_sb_tx]
connect_bd_intf_net -intf_net [get_bd_intf_nets SB_STATUS_IN_1] [get_bd_intf_pins hdmi_output/SB_STATUS] [get_bd_intf_pins tx_hdmi_hb_0/status_sb]
  connect_bd_intf_net -intf_net S_AXI_CPU_1 [get_bd_intf_pins hdmi_output/S_AXI_CPU] [get_bd_intf_pins mpsoc_ss/M02_AXI]
  connect_bd_intf_net -intf_net S_AXI_HP1_FPD_0_1 [get_bd_intf_pins axi_interconnect_4/M00_AXI] [get_bd_intf_pins mpsoc_ss/S_AXI_HP1_FPD_0]
  connect_bd_intf_net -intf_net TX_DDC [get_bd_intf_ports TX_DDC] [get_bd_intf_pins hdmi_output/DDC]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins mpsoc_ss/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins axi_interconnect_1/M00_AXI] [get_bd_intf_pins mpsoc_ss/S_AXI_HP2_FPD_0]
  connect_bd_intf_net -intf_net axi_interconnect_2_M00_AXI [get_bd_intf_pins axi_interconnect_2/M00_AXI] [get_bd_intf_pins mpsoc_ss/S_AXI_HP3_FPD_0]
  connect_bd_intf_net -intf_net axi_interconnect_5_M00_AXI [get_bd_intf_pins axi_interconnect_5/M00_AXI] [get_bd_intf_pins mpsoc_ss/S_AXI_HPC0_FPD_0]
  connect_bd_intf_net -intf_net csirxss_s_axi_1 [get_bd_intf_pins mipi_csi2_rx/csirxss_s_axi] [get_bd_intf_pins mpsoc_ss/M12_AXI_0]
  connect_bd_intf_net -intf_net hdmi_output_LINK_DATA0 [get_bd_intf_pins hdmi_output/LINK_DATA0] [get_bd_intf_pins vid_phy_controller/vid_phy_tx_axi4s_ch0]
  connect_bd_intf_net -intf_net hdmi_output_LINK_DATA1 [get_bd_intf_pins hdmi_output/LINK_DATA1] [get_bd_intf_pins vid_phy_controller/vid_phy_tx_axi4s_ch1]
  connect_bd_intf_net -intf_net hdmi_output_LINK_DATA2 [get_bd_intf_pins hdmi_output/LINK_DATA2] [get_bd_intf_pins vid_phy_controller/vid_phy_tx_axi4s_ch2]
  connect_bd_intf_net -intf_net hdmi_output_m_axi_mm_video1_0 [get_bd_intf_pins axi_interconnect_0/S01_AXI] [get_bd_intf_pins hdmi_output/m_axi_mm_video1_0]
  connect_bd_intf_net -intf_net hdmi_output_m_axi_mm_video2_0 [get_bd_intf_pins axi_interconnect_0/S02_AXI] [get_bd_intf_pins hdmi_output/m_axi_mm_video2_0]
  connect_bd_intf_net -intf_net hdmi_output_m_axi_mm_video3_0 [get_bd_intf_pins axi_interconnect_0/S03_AXI] [get_bd_intf_pins hdmi_output/m_axi_mm_video3_0]
  connect_bd_intf_net -intf_net hdmi_output_m_axi_mm_video4_0 [get_bd_intf_pins axi_interconnect_0/S04_AXI] [get_bd_intf_pins hdmi_output/m_axi_mm_video4_0]
  connect_bd_intf_net -intf_net hdmi_output_m_axi_mm_video5_0 [get_bd_intf_pins axi_interconnect_0/S05_AXI] [get_bd_intf_pins hdmi_output/m_axi_mm_video5_0]
  connect_bd_intf_net -intf_net hdmi_output_m_axi_mm_video6_0 [get_bd_intf_pins axi_interconnect_0/S06_AXI] [get_bd_intf_pins hdmi_output/m_axi_mm_video6_0]
  connect_bd_intf_net -intf_net hdmi_output_m_axi_mm_video7_0 [get_bd_intf_pins axi_interconnect_0/S07_AXI] [get_bd_intf_pins hdmi_output/m_axi_mm_video7_0]
  connect_bd_intf_net -intf_net hdmi_output_m_axi_mm_video8_0 [get_bd_intf_pins axi_interconnect_0/S08_AXI] [get_bd_intf_pins hdmi_output/m_axi_mm_video8_0]
  connect_bd_intf_net -intf_net hdmi_output_m_axi_mm_video_0 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins hdmi_output/m_axi_mm_video_0]
  connect_bd_intf_net -intf_net mipi_csi2_rx_M_AXI_S2MM [get_bd_intf_pins axi_interconnect_4/S02_AXI] [get_bd_intf_pins mipi_csi2_rx/M_AXI_S2MM]
  connect_bd_intf_net -intf_net mipi_phy_if_0_0_1 [get_bd_intf_ports mipi_phy_if_0_0] [get_bd_intf_pins mipi_csi2_rx/mipi_phy_if_0]
  connect_bd_intf_net -intf_net mpsoc_ss_IIC [get_bd_intf_ports HDMI_CTRL_IIC] [get_bd_intf_pins mpsoc_ss/IIC]
  connect_bd_intf_net -intf_net mpsoc_ss_M00_AXI [get_bd_intf_pins mpsoc_ss/M00_AXI] [get_bd_intf_pins vid_phy_controller/vid_phy_axi4lite]
  connect_bd_intf_net -intf_net mpsoc_ss_M01_AXI [get_bd_intf_pins hdmi_input/S_AXI_CPU_IN] [get_bd_intf_pins mpsoc_ss/M01_AXI]
  connect_bd_intf_net -intf_net mpsoc_ss_M01_AXI1 [get_bd_intf_pins axi_intc_0/s_axi] [get_bd_intf_pins mpsoc_ss/M01_AXI1]
  connect_bd_intf_net -intf_net mpsoc_ss_M03_AXI [get_bd_intf_pins hdmi_input/s_axi_CTRL] [get_bd_intf_pins mpsoc_ss/M03_AXI]
  connect_bd_intf_net -intf_net mpsoc_ss_M06_AXI [get_bd_intf_pins hdmi_input/s_axi_ctrl4] [get_bd_intf_pins mpsoc_ss/M06_AXI]
  connect_bd_intf_net -intf_net mpsoc_ss_M08_AXI_0 [get_bd_intf_pins mpsoc_ss/M08_AXI_0] [get_bd_intf_pins vcu_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net mpsoc_ss_M18_AXI_0 [get_bd_intf_pins mpsoc_ss/M18_AXI_0] [get_bd_intf_pins sensor_iic_0/S_AXI]
  connect_bd_intf_net -intf_net mpsoc_ss_M19_AXI_0 [get_bd_intf_pins hdmi_input/s_axi_CTRL5] [get_bd_intf_pins mpsoc_ss/M19_AXI_0]
  connect_bd_intf_net -intf_net mpsoc_ss_M20_AXI_0 [get_bd_intf_pins hdmi_input/s_axi_CTRL6] [get_bd_intf_pins mpsoc_ss/M20_AXI_0]
  connect_bd_intf_net -intf_net mpsoc_ss_M21_AXI_0 [get_bd_intf_pins hdmi_input/s_axi_CTRL1] [get_bd_intf_pins mpsoc_ss/M21_AXI_0]
  connect_bd_intf_net -intf_net mpsoc_ss_M22_AXI_0 [get_bd_intf_pins hdmi_input/s_axi_CTRL3] [get_bd_intf_pins mpsoc_ss/M22_AXI_0]
  connect_bd_intf_net -intf_net mpsoc_ss_M23_AXI [get_bd_intf_pins hdmi_input/s_axi_CTRL2] [get_bd_intf_pins mpsoc_ss/M23_AXI]
  connect_bd_intf_net -intf_net mpsoc_ss_M24_AXI_0 [get_bd_intf_pins hdmi_input/s_axi_CTRL7] [get_bd_intf_pins mpsoc_ss/M24_AXI_0]
  connect_bd_intf_net -intf_net mpsoc_ss_scn_chg_ctrl [get_bd_intf_pins mpsoc_ss/scn_chg_ctrl] [get_bd_intf_pins v_scenechange_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net mpsoc_ss_time_ctrl [get_bd_intf_pins axi_timer_0/S_AXI] [get_bd_intf_pins mpsoc_ss/time_ctrl]
  connect_bd_intf_net -intf_net s_axi_ctrl_frm_rd_1 [get_bd_intf_pins hdmi_output/s_axi_ctrl_frm_rd] [get_bd_intf_pins mpsoc_ss/M05_AXI]
  connect_bd_intf_net -intf_net s_axi_ctrl_mixer_1 [get_bd_intf_pins hdmi_output/s_axi_ctrl_mixer] [get_bd_intf_pins mpsoc_ss/M07_AXI_0]
  connect_bd_intf_net -intf_net s_axi_domisaic_1 [get_bd_intf_pins mipi_csi2_rx/s_axi_domisaic] [get_bd_intf_pins mpsoc_ss/M13_AXI_0]
  connect_bd_intf_net -intf_net s_axi_frm_wr_1 [get_bd_intf_pins mpsoc_ss/M09_AXI_0] [get_bd_intf_pins tpg_input/s_axi_frm_wr]
  connect_bd_intf_net -intf_net s_axi_gamma_lut_1 [get_bd_intf_pins mipi_csi2_rx/s_axi_gamma_lut] [get_bd_intf_pins mpsoc_ss/M14_AXI_0]
  connect_bd_intf_net -intf_net s_axi_mipi_frm_wr_1 [get_bd_intf_pins mipi_csi2_rx/s_axi_mipi_frm_wr] [get_bd_intf_pins mpsoc_ss/M15_AXI_0]
  connect_bd_intf_net -intf_net s_axi_scalar_1 [get_bd_intf_pins mipi_csi2_rx/s_axi_scalar] [get_bd_intf_pins mpsoc_ss/M16_AXI_0]
  connect_bd_intf_net -intf_net s_axi_tpg_1 [get_bd_intf_pins mpsoc_ss/M10_AXI_0] [get_bd_intf_pins tpg_input/s_axi_tpg]
  connect_bd_intf_net -intf_net s_axi_v_proc_ss_csc_1 [get_bd_intf_pins mipi_csi2_rx/s_axi_v_proc_ss_csc] [get_bd_intf_pins mpsoc_ss/M17_AXI_0]
  connect_bd_intf_net -intf_net s_axi_vtc_1 [get_bd_intf_pins mpsoc_ss/M11_AXI_0] [get_bd_intf_pins tpg_input/s_axi_vtc]
  connect_bd_intf_net -intf_net sensor_iic_0_IIC [get_bd_intf_ports sensor_iic] [get_bd_intf_pins sensor_iic_0/IIC]
  connect_bd_intf_net -intf_net tpg_input_m_axi_mm_video [get_bd_intf_pins axi_interconnect_4/S01_AXI] [get_bd_intf_pins tpg_input/m_axi_mm_video]
  connect_bd_intf_net -intf_net vcu_0_M_AXI_DEC0 [get_bd_intf_pins axi_interconnect_2/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_DEC0]
  connect_bd_intf_net -intf_net vcu_0_M_AXI_DEC1 [get_bd_intf_pins axi_interconnect_2/S01_AXI] [get_bd_intf_pins vcu_0/M_AXI_DEC1]
  connect_bd_intf_net -intf_net vcu_0_M_AXI_ENC0 [get_bd_intf_pins axi_interconnect_1/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_ENC0]
  connect_bd_intf_net -intf_net vcu_0_M_AXI_ENC1 [get_bd_intf_pins axi_interconnect_1/S01_AXI] [get_bd_intf_pins vcu_0/M_AXI_ENC1]
  connect_bd_intf_net -intf_net vcu_0_M_AXI_MCU [get_bd_intf_pins axi_interconnect_5/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_MCU]
  connect_bd_intf_net -intf_net vid_phy_controller_vid_phy_rx_axi4s_ch0 [get_bd_intf_pins hdmi_input/LINK_DATA0] [get_bd_intf_pins vid_phy_controller/vid_phy_rx_axi4s_ch0]
  connect_bd_intf_net -intf_net vid_phy_controller_vid_phy_rx_axi4s_ch1 [get_bd_intf_pins hdmi_input/LINK_DATA1] [get_bd_intf_pins vid_phy_controller/vid_phy_rx_axi4s_ch1]
  connect_bd_intf_net -intf_net vid_phy_controller_vid_phy_rx_axi4s_ch2 [get_bd_intf_pins hdmi_input/LINK_DATA2] [get_bd_intf_pins vid_phy_controller/vid_phy_rx_axi4s_ch2]
  connect_bd_intf_net -intf_net vid_phy_controller_vid_phy_status_sb_rx [get_bd_intf_pins hdmi_input/SB_STATUS] [get_bd_intf_pins vid_phy_controller/vid_phy_status_sb_rx]
connect_bd_intf_net -intf_net [get_bd_intf_nets vid_phy_controller_vid_phy_status_sb_rx] [get_bd_intf_pins hdmi_input/SB_STATUS] [get_bd_intf_pins rx_hdmi_hb_0/status_sb]

  # Create port connections
  connect_bd_net -net HDMI_RX_CLK_N [get_bd_ports HDMI_RX_CLK_N] [get_bd_pins vid_phy_controller/mgtrefclk1_pad_n_in]
  connect_bd_net -net HDMI_RX_CLK_P [get_bd_ports HDMI_RX_CLK_P] [get_bd_pins vid_phy_controller/mgtrefclk1_pad_p_in]
  connect_bd_net -net HDMI_RX_DAT_N [get_bd_ports HDMI_RX_DAT_N] [get_bd_pins vid_phy_controller/phy_rxn_in]
  connect_bd_net -net HDMI_RX_DAT_P [get_bd_ports HDMI_RX_DAT_P] [get_bd_pins vid_phy_controller/phy_rxp_in]
  connect_bd_net -net HDMI_TX_CLK_N [get_bd_ports HDMI_TX_CLK_N] [get_bd_pins vid_phy_controller/tx_tmds_clk_n]
  connect_bd_net -net HDMI_TX_CLK_P [get_bd_ports HDMI_TX_CLK_P] [get_bd_pins vid_phy_controller/tx_tmds_clk_p]
  connect_bd_net -net HDMI_TX_DAT_N [get_bd_ports HDMI_TX_DAT_N] [get_bd_pins vid_phy_controller/phy_txn_out]
  connect_bd_net -net HDMI_TX_DAT_P [get_bd_ports HDMI_TX_DAT_P] [get_bd_pins vid_phy_controller/phy_txp_out]
  connect_bd_net -net LED0 [get_bd_ports LED0] [get_bd_pins hdmi_output/locked]
  connect_bd_net -net LED2 [get_bd_ports LED2] [get_bd_pins tx_hdmi_hb_0/hdmi_hb]
  connect_bd_net -net LED3 [get_bd_ports LED3] [get_bd_pins rx_hdmi_hb_0/hdmi_hb]
  connect_bd_net -net Net [get_bd_pins axi_intc_0/s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_interconnect_0/S02_ACLK] [get_bd_pins axi_interconnect_0/S03_ACLK] [get_bd_pins axi_interconnect_0/S04_ACLK] [get_bd_pins axi_interconnect_0/S05_ACLK] [get_bd_pins axi_interconnect_0/S06_ACLK] [get_bd_pins axi_interconnect_0/S07_ACLK] [get_bd_pins axi_interconnect_0/S08_ACLK] [get_bd_pins axi_interconnect_0/S09_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_1/S01_ACLK] [get_bd_pins axi_interconnect_2/ACLK] [get_bd_pins axi_interconnect_2/M00_ACLK] [get_bd_pins axi_interconnect_2/S00_ACLK] [get_bd_pins axi_interconnect_2/S01_ACLK] [get_bd_pins axi_interconnect_4/ACLK] [get_bd_pins axi_interconnect_4/M00_ACLK] [get_bd_pins axi_interconnect_4/S00_ACLK] [get_bd_pins axi_interconnect_4/S01_ACLK] [get_bd_pins axi_interconnect_4/S03_ACLK] [get_bd_pins axi_interconnect_4/S04_ACLK] [get_bd_pins axi_interconnect_4/S05_ACLK] [get_bd_pins axi_interconnect_4/S06_ACLK] [get_bd_pins axi_interconnect_4/S07_ACLK] [get_bd_pins axi_interconnect_4/S08_ACLK] [get_bd_pins axi_interconnect_5/ACLK] [get_bd_pins axi_interconnect_5/M00_ACLK] [get_bd_pins axi_interconnect_5/S00_ACLK] [get_bd_pins clk_wiz_1/clk_out2] [get_bd_pins hdmi_input/clk_300M] [get_bd_pins hdmi_output/clk_300M] [get_bd_pins mpsoc_ss/s_axi_hpc0_fpd_aclk] [get_bd_pins proc_sys_reset_1/slowest_sync_clk] [get_bd_pins tpg_input/clk_in_1_0] [get_bd_pins tpg_input/m_axi_s2mm_aclk] [get_bd_pins v_scenechange_0/ap_clk] [get_bd_pins vcu_0/m_axi_dec_aclk] [get_bd_pins vcu_0/m_axi_enc_aclk] [get_bd_pins vcu_0/m_axi_mcu_aclk]
  connect_bd_net -net RX_DET [get_bd_ports RX_DET] [get_bd_pins hdmi_input/cable_detect]
  connect_bd_net -net RX_HPD [get_bd_ports RX_HPD] [get_bd_pins hdmi_input/hpd]
  connect_bd_net -net RX_REFCLK_N [get_bd_ports RX_REFCLK_N] [get_bd_pins vid_phy_controller/rx_tmds_clk_n]
  connect_bd_net -net RX_REFCLK_P [get_bd_ports RX_REFCLK_P] [get_bd_pins vid_phy_controller/rx_tmds_clk_p]
  connect_bd_net -net SI5319_LOL [get_bd_ports SI5319_LOL] [get_bd_pins vid_phy_controller/tx_refclk_rdy]
  connect_bd_net -net TX_HPD [get_bd_ports TX_HPD] [get_bd_pins hdmi_output/hpd]
  connect_bd_net -net TX_REFCLK_N [get_bd_ports TX_REFCLK_N] [get_bd_pins vid_phy_controller/mgtrefclk0_pad_n_in]
  connect_bd_net -net TX_REFCLK_P [get_bd_ports TX_REFCLK_P] [get_bd_pins vid_phy_controller/mgtrefclk0_pad_p_in]
  connect_bd_net -net aresetn_100M [get_bd_ports SI5319_RST] [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins hdmi_input/s_axi_cpu_aresetn] [get_bd_pins hdmi_output/aresetn_100M] [get_bd_pins mipi_csi2_rx/lite_aresetn_0] [get_bd_pins mpsoc_ss/aresetn_100M] [get_bd_pins sensor_iic_0/s_axi_aresetn] [get_bd_pins vid_phy_controller/vid_phy_axi4lite_aresetn] [get_bd_pins vid_phy_controller/vid_phy_sb_aresetn]
  connect_bd_net -net axi_intc_0_irq [get_bd_pins axi_intc_0/irq] [get_bd_pins interrupts1/In4]
  connect_bd_net -net axi_timer_0_interrupt [get_bd_pins axi_timer_0/interrupt] [get_bd_pins interrupts1/In6]
  connect_bd_net -net bg1_pin0_nc_0_1 [get_bd_ports bg1_pin0_nc_0] [get_bd_pins mipi_csi2_rx/bg1_pin0_nc]
  connect_bd_net -net bg3_pin0_nc_0_1 [get_bd_ports bg3_pin0_nc_0] [get_bd_pins mipi_csi2_rx/bg3_pin0_nc]
  connect_bd_net -net clk_100M [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins hdmi_input/s_axi_cpu_aclk] [get_bd_pins hdmi_output/clk_100M] [get_bd_pins mipi_csi2_rx/s_axi_lite_aclk] [get_bd_pins mpsoc_ss/clk_100M] [get_bd_pins rx_hdmi_hb_0/status_sb_aclk] [get_bd_pins sensor_iic_0/s_axi_aclk] [get_bd_pins tpg_input/s_axi_aclk] [get_bd_pins tx_hdmi_hb_0/status_sb_aclk] [get_bd_pins vcu_0/s_axi_lite_aclk] [get_bd_pins vid_phy_controller/drpclk] [get_bd_pins vid_phy_controller/vid_phy_axi4lite_aclk] [get_bd_pins vid_phy_controller/vid_phy_sb_aclk]
  connect_bd_net -net clk_wiz_1_clk_out1 [get_bd_pins clk_wiz_1/clk_out1] [get_bd_pins vcu_0/pll_ref_clk]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins clk_wiz_1/locked] [get_bd_pins proc_sys_reset_1/dcm_locked]
  connect_bd_net -net dphy_clk_200M_1 [get_bd_pins clk_wiz_1/clk_out3] [get_bd_pins mipi_csi2_rx/dphy_clk_200M]
  #connect_bd_net -net gnd [get_bd_ports LED1] [get_bd_ports LED2] [get_bd_ports LED3] [get_bd_ports LED4] [get_bd_ports LED5] [get_bd_pins gnd_const/dout]
  connect_bd_net -net gnd [get_bd_ports LED1] [get_bd_pins gnd_const/dout]
  connect_bd_net -net gpio_0 [get_bd_pins gpio_aresetn/gpio_0] [get_bd_pins hdmi_input/frmbuf_aresetn]
  connect_bd_net -net gpio_1 [get_bd_pins gpio_aresetn/gpio_1] [get_bd_pins hdmi_output/frmbuf_aresetn]
  connect_bd_net -net gpio_aresetn_Dout [get_bd_pins gpio_aresetn/Dout] [get_bd_pins v_scenechange_0/ap_rst_n]
  connect_bd_net -net gt_efclk_buf_BUFG_GT_O [get_bd_pins gt_refclk_buf/BUFG_GT_O] [get_bd_pins vid_phy_controller/gtnorthrefclk1_odiv2_in]
  connect_bd_net -net gt_efclk_buf_IBUF_OUT [get_bd_pins gt_refclk_buf/IBUF_OUT] [get_bd_pins vid_phy_controller/gtnorthrefclk1_in]
  connect_bd_net -net hdmi_input_dout [get_bd_pins axi_intc_0/intr] [get_bd_pins hdmi_input/dout]
  connect_bd_net -net hdmi_input_irq [get_bd_pins hdmi_input/irq] [get_bd_pins interrupts/In2]
  connect_bd_net -net hdmi_output_interrupt [get_bd_pins hdmi_output/interrupt_frm_rd] [get_bd_pins interrupts/In0]
  connect_bd_net -net hdmi_output_interrupt_mixer [get_bd_pins hdmi_output/interrupt_mixer] [get_bd_pins interrupts/In6]
  connect_bd_net -net hdmi_output_irq [get_bd_pins hdmi_output/interrupt_hdmi_tx] [get_bd_pins interrupts/In4]
  connect_bd_net -net interrupts1_dout [get_bd_pins interrupts1/dout] [get_bd_pins mpsoc_ss/pl_ps_irq1]
  connect_bd_net -net interrupts_dout [get_bd_pins interrupts/dout] [get_bd_pins mpsoc_ss/pl_ps_irq0]
  connect_bd_net -net mipi_csi2_rx_Dout [get_bd_ports sensor_gpio_rst] [get_bd_pins mipi_csi2_rx/Dout]
  connect_bd_net -net mipi_csi2_rx_csirxss_csi_irq [get_bd_pins interrupts1/In1] [get_bd_pins mipi_csi2_rx/csirxss_csi_irq]
  connect_bd_net -net mipi_csi2_rx_dout1 [get_bd_ports sensor_gpio_flash] [get_bd_ports sensor_gpio_spi_cs_n] [get_bd_pins mipi_csi2_rx/dout1]
  connect_bd_net -net mipi_csi2_rx_s2mm_introut [get_bd_pins interrupts1/In2] [get_bd_pins mipi_csi2_rx/s2mm_introut]
  connect_bd_net -net mpsoc_ss_clk_149 [get_bd_pins mpsoc_ss/clk_149] [get_bd_pins tpg_input/clk_in_2_0]
  connect_bd_net -net mpsoc_ss_clk_300M [get_bd_pins axi_interconnect_4/S02_ACLK] [get_bd_pins mipi_csi2_rx/m_axi_s2mm_aclk] [get_bd_pins mpsoc_ss/clk_300M]
  connect_bd_net -net mpsoc_ss_clk_300_aresetn [get_bd_pins axi_interconnect_4/S02_ARESETN] [get_bd_pins mipi_csi2_rx/video_aresetn] [get_bd_pins mpsoc_ss/clk_300_aresetn]
  connect_bd_net -net mpsoc_ss_gpio [get_bd_pins gpio_aresetn/Din] [get_bd_pins hdmi_input/Din] [get_bd_pins hdmi_output/Din] [get_bd_pins mipi_csi2_rx/Din] [get_bd_pins mpsoc_ss/gpio] [get_bd_pins tpg_input/Din] [get_bd_pins vcu_rst/Din]
  connect_bd_net -net mpsoc_ss_iic2intc_irpt [get_bd_pins interrupts/In5] [get_bd_pins mpsoc_ss/iic2intc_irpt]
  connect_bd_net -net mpsoc_ss_pl_resetn0_0 [get_bd_pins mpsoc_ss/pl_resetn0_0] [get_bd_pins proc_sys_reset_1/ext_reset_in]
  connect_bd_net -net net_vid_phy_controller_tx_video_clk [get_bd_pins hdmi_output/video_clk] [get_bd_pins vid_phy_controller/tx_video_clk]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins axi_intc_0/s_axi_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_interconnect_0/S02_ARESETN] [get_bd_pins axi_interconnect_0/S03_ARESETN] [get_bd_pins axi_interconnect_0/S04_ARESETN] [get_bd_pins axi_interconnect_0/S05_ARESETN] [get_bd_pins axi_interconnect_0/S06_ARESETN] [get_bd_pins axi_interconnect_0/S07_ARESETN] [get_bd_pins axi_interconnect_0/S08_ARESETN] [get_bd_pins axi_interconnect_0/S09_ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_1/S01_ARESETN] [get_bd_pins axi_interconnect_2/ARESETN] [get_bd_pins axi_interconnect_2/M00_ARESETN] [get_bd_pins axi_interconnect_2/S00_ARESETN] [get_bd_pins axi_interconnect_2/S01_ARESETN] [get_bd_pins axi_interconnect_4/ARESETN] [get_bd_pins axi_interconnect_4/M00_ARESETN] [get_bd_pins axi_interconnect_4/S00_ARESETN] [get_bd_pins axi_interconnect_4/S01_ARESETN] [get_bd_pins axi_interconnect_4/S03_ARESETN] [get_bd_pins axi_interconnect_4/S04_ARESETN] [get_bd_pins axi_interconnect_4/S05_ARESETN] [get_bd_pins axi_interconnect_4/S06_ARESETN] [get_bd_pins axi_interconnect_4/S07_ARESETN] [get_bd_pins axi_interconnect_4/S08_ARESETN] [get_bd_pins axi_interconnect_5/ARESETN] [get_bd_pins axi_interconnect_5/M00_ARESETN] [get_bd_pins axi_interconnect_5/S00_ARESETN] [get_bd_pins hdmi_input/aresetn_300M] [get_bd_pins hdmi_output/aresetn_300M] [get_bd_pins mpsoc_ss/reset_333] [get_bd_pins proc_sys_reset_1/peripheral_aresetn] [get_bd_pins tpg_input/tpg_rst_n]
  connect_bd_net -net rx_video_clk [get_bd_pins hdmi_input/video_clk] [get_bd_pins vid_phy_controller/rx_video_clk]
  connect_bd_net -net rxoutclk [get_bd_pins hdmi_input/link_clk] [get_bd_pins rx_hdmi_hb_0/link_clk] [get_bd_pins vid_phy_controller/rxoutclk] [get_bd_pins vid_phy_controller/vid_phy_rx_axi4s_aclk]
  connect_bd_net -net sensor_iic_0_iic2intc_irpt [get_bd_pins interrupts1/In3] [get_bd_pins sensor_iic_0/iic2intc_irpt]
  connect_bd_net -net tpg_input_interrupt [get_bd_pins interrupts1/In0] [get_bd_pins tpg_input/interrupt]
  connect_bd_net -net txoutclk [get_bd_pins hdmi_output/link_clk] [get_bd_pins tx_hdmi_hb_0/link_clk] [get_bd_pins vid_phy_controller/txoutclk] [get_bd_pins vid_phy_controller/vid_phy_tx_axi4s_aclk]
  connect_bd_net -net v_scenechange_0_interrupt [get_bd_pins axi_timer_0/capturetrig0] [get_bd_pins interrupts1/In5] [get_bd_pins v_scenechange_0/interrupt]
  connect_bd_net -net vcc [get_bd_ports TX_EN] [get_bd_pins vcc_const/dout] [get_bd_pins vid_phy_controller/vid_phy_rx_axi4s_aresetn] [get_bd_pins vid_phy_controller/vid_phy_tx_axi4s_aresetn]
  connect_bd_net -net vcu_0_vcu_host_interrupt [get_bd_pins interrupts/In7] [get_bd_pins vcu_0/vcu_host_interrupt]
  connect_bd_net -net vid_phy_controller_irq [get_bd_pins interrupts/In3] [get_bd_pins vid_phy_controller/irq]
  connect_bd_net -net xlslice_4_Dout [get_bd_pins vcu_0/vcu_resetn] [get_bd_pins vcu_rst/Dout]

  # Create address segments
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces v_scenechange_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP0_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces v_scenechange_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP0_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces v_scenechange_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP0_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces v_scenechange_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_0_HP0_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/EncData1] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP4/HP2_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP2_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/EncData0] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP4/HP2_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP2_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/EncData1] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP4/HP2_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP2_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/EncData0] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP4/HP2_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP2_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/EncData1] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP4/HP2_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP2_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/EncData0] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP4/HP2_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP2_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/EncData1] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP4/HP2_QSPI] SEG_zynq_ultra_ps_e_0_HP2_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/EncData0] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP4/HP2_QSPI] SEG_zynq_ultra_ps_e_0_HP2_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP3_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP3_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP3_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP5/HP3_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP3_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP5/HP3_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP3_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP5/HP3_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP3_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP5/HP3_QSPI] SEG_zynq_ultra_ps_e_0_HP3_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP5/HP3_QSPI] SEG_zynq_ultra_ps_e_0_HP3_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HPC0_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] SEG_zynq_ultra_ps_e_0_HPC0_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM] SEG_zynq_ultra_ps_e_0_HPC0_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] SEG_zynq_ultra_ps_e_0_HPC0_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP1_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP1_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_QSPI] SEG_zynq_ultra_ps_e_0_HP1_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_1/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP1_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_1/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP1_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_1/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_1/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_QSPI] SEG_zynq_ultra_ps_e_0_HP1_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_2/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP1_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_2/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP1_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_2/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_2/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_QSPI] SEG_zynq_ultra_ps_e_0_HP1_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_3/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP1_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_3/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP1_DDR_LOW
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_3/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_QSPI] SEG_zynq_ultra_ps_e_0_HP1_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_4/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP1_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_4/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP1_DDR_LOW
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_4/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_QSPI] SEG_zynq_ultra_ps_e_0_HP1_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_5/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP1_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_5/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP1_DDR_LOW
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_5/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_QSPI] SEG_zynq_ultra_ps_e_0_HP1_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_6/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP1_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_6/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP1_DDR_LOW
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_6/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_QSPI] SEG_zynq_ultra_ps_e_0_HP1_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_output/v_frmbuf_rd_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP0_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_output/v_frmbuf_rd_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP0_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_output/v_frmbuf_rd_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP0_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_output/v_frmbuf_rd_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_0_HP0_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP0_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video8] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP0_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP0_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video7] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP0_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP0_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video6] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP0_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video5] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP0_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video4] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_HIGH] SEG_zynq_ultra_ps_e_0_HP0_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP0_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video8] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP0_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video7] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP0_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video6] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP0_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video5] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP0_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video4] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP0_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP0_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP0_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video4] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP0_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video8] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP0_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP0_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video7] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP0_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP0_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video6] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP0_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video5] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP0_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP0_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video2] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_0_HP0_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video6] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_0_HP0_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video5] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_0_HP0_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video7] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_0_HP0_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video1] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_0_HP0_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video3] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_0_HP0_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video4] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_0_HP0_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces hdmi_output/v_mix_0/Data_m_axi_mm_video8] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_0_HP0_QSPI
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces mipi_csi2_rx/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP1_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces mipi_csi2_rx/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces mipi_csi2_rx/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_QSPI] SEG_zynq_ultra_ps_e_0_HP1_QSPI
  create_bd_addr_seg -range 0x00001000 -offset 0xA0052000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_intc_0/S_AXI/Reg] SEG_axi_intc_0_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0053000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_timer_0/S_AXI/Reg] SEG_axi_timer_0_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0050000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mpsoc_ss/hdmi_ctrl_iic/S_AXI/Reg] SEG_hdmi_ctrl_iic_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA00F0000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_csi2_rx/mipi_csi2_rx_subsystem_0/csirxss_s_axi/Reg] SEG_mipi_csi2_rx_subsystem_0_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0051000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs sensor_iic_0/S_AXI/Reg] SEG_sensor_iic_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0250000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_csi2_rx/v_demosaic_0/s_axi_CTRL/Reg] SEG_v_demosaic_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0040000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs hdmi_output/v_frmbuf_rd_0/s_axi_CTRL/Reg] SEG_v_frmbuf_rd_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0010000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs hdmi_input/v_frmbuf_wr_0/s_axi_CTRL/Reg] SEG_v_frmbuf_wr_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA00C0000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs tpg_input/v_frmbuf_wr_0/s_axi_CTRL/Reg] SEG_v_frmbuf_wr_0_Reg1
  create_bd_addr_seg -range 0x00010000 -offset 0xA0260000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_csi2_rx/v_frmbuf_wr_0/s_axi_CTRL/Reg] SEG_v_frmbuf_wr_0_Reg2
  create_bd_addr_seg -range 0x00010000 -offset 0xA02B0000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs hdmi_input/v_frmbuf_wr_1/s_axi_CTRL/Reg] SEG_v_frmbuf_wr_1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA02C0000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs hdmi_input/v_frmbuf_wr_2/s_axi_CTRL/Reg] SEG_v_frmbuf_wr_2_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0280000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs hdmi_input/v_frmbuf_wr_3/s_axi_CTRL/Reg] SEG_v_frmbuf_wr_3_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0290000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs hdmi_input/v_frmbuf_wr_4/s_axi_CTRL/Reg] SEG_v_frmbuf_wr_4_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA02A0000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs hdmi_input/v_frmbuf_wr_5/s_axi_CTRL/Reg] SEG_v_frmbuf_wr_5_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA02D0000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs hdmi_input/v_frmbuf_wr_6/s_axi_CTRL/Reg] SEG_v_frmbuf_wr_6_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0270000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_csi2_rx/v_gamma_lut_0/s_axi_CTRL/Reg] SEG_v_gamma_lut_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0000000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs hdmi_input/v_hdmi_rx_ss_0/S_AXI_CPU_IN/Reg] SEG_v_hdmi_rx_ss_0_Reg
  create_bd_addr_seg -range 0x00020000 -offset 0xA0020000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs hdmi_output/v_hdmi_tx_ss_0/S_AXI_CPU_IN/Reg] SEG_v_hdmi_tx_ss_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0070000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs hdmi_output/v_mix_0/s_axi_CTRL/Reg] SEG_v_mix_0_Reg
  create_bd_addr_seg -range 0x00040000 -offset 0xA0080000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs hdmi_input/v_proc_ss_0/s_axi_ctrl/Reg] SEG_v_proc_ss_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0240000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_csi2_rx/v_proc_ss_csc/s_axi_ctrl/Reg] SEG_v_proc_ss_csc_Reg
  create_bd_addr_seg -range 0x00040000 -offset 0xA0200000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs mipi_csi2_rx/v_proc_ss_scaler/s_axi_ctrl/Reg] SEG_v_proc_ss_scaler_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA02E0000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs v_scenechange_0/s_axi_CTRL/Reg] SEG_v_scenechange_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA00D0000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs tpg_input/v_tc_1/ctrl/Reg] SEG_v_tc_1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA00E0000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs tpg_input/v_tpg_1/s_axi_CTRL/Reg] SEG_v_tpg_1_Reg
  create_bd_addr_seg -range 0x00100000 -offset 0xA0100000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs vcu_0/S_AXI_LITE/Reg] SEG_vcu_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0060000 [get_bd_addr_spaces mpsoc_ss/zynq_ultra_ps_e_0/Data] [get_bd_addr_segs vid_phy_controller/vid_phy_axi4lite/Reg] SEG_vid_phy_controller_Reg
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces tpg_input/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP1_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces tpg_input/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces tpg_input/v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_QSPI] SEG_zynq_ultra_ps_e_0_HP1_QSPI

  # Exclude Address Segments
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_3/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM
  exclude_bd_addr_seg [get_bd_addr_segs hdmi_input/v_frmbuf_wr_3/Data_m_axi_mm_video/SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM]

  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_4/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM
  exclude_bd_addr_seg [get_bd_addr_segs hdmi_input/v_frmbuf_wr_4/Data_m_axi_mm_video/SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM]

  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_5/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM
  exclude_bd_addr_seg [get_bd_addr_segs hdmi_input/v_frmbuf_wr_5/Data_m_axi_mm_video/SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM]

  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces hdmi_input/v_frmbuf_wr_6/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/zynq_ultra_ps_e_0/SAXIGP3/HP1_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM
  exclude_bd_addr_seg [get_bd_addr_segs hdmi_input/v_frmbuf_wr_6/Data_m_axi_mm_video/SEG_zynq_ultra_ps_e_0_HP1_LPS_OCM]



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


