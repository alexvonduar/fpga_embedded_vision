#------------------------------------------------------------------------------
#    ____  ____
#  /   /\/   /
# /___/  \  /    Vendor: Xilinx
# \   \   \/     Version: $Revision: #1 $
# #  /   /         Filename: $File: zcu102_uhdsdi_demo_timing.xdc $
# /___/   /\     Timestamp: $DateTime: 2015/04/16 10:29:23 $
# \   \  /
#  \___\/\___
#
# Description:
#   This is the Vivado timing constraints file for the zcu102 UHD-SDI demo.
#------------------------------------------------------------------------------
#148.5 MHz Clock
create_clock -period 6.734 -waveform {0.000 3.367} [get_ports USER_MGT_SI570_CLOCK1_C_P]

####################################
# syncing from r/tx_outclk[0-2] to axi4lite domain
####################################	-- baoshan: fixed xdc including the value > 100Mhz
####################################
# syncing from axi4lite to r/tx_outclk[0-2]
####################################	-- baoshan: fixed xdc

####################################
# syncing from sys_clk(300Mhz) to axi4lite_clk domain
####################################	-- baoshan: fixed xdc

####################################
# syncing from axi4lite_clk(100Mhz) to sys_clk(300Mhz)
####################################	-- baoshan: fixed xdc

##START# Include if CPLL is activated
#set_max_delay $max_delay_clk_27M -datapath_only # -from [get_clocks uhdsdi_demo/v_uhdsdi_support_CSL/v_uhdsdi_CL/uhdsdi_gtwiz_i*GTHE3_CHANNEL_PRIM_INST/TXOUTCLK] # -to [get_clocks clk_27M]
##END# Include if CPLL is activated

##START# Include if CPLL is activated
#set_max_delay $max_delay_txusrclk -datapath_only # -from [get_clocks clk_27M] # -to [get_clocks uhdsdi_demo/v_uhdsdi_support_CSL/v_uhdsdi_CL/uhdsdi_gtwiz_i*GTHE3_CHANNEL_PRIM_INST/TXOUTCLK]
##END# Include if CPLL is activated

#
# Create a hierarchical clock to constrain the timing of the NI-DRU and EDH. This
# module is driven by rx0_outclk, but is only active when that clock is 148.5
# MHz and never when it is 297 MHz.
#
## SDI Wrapper Support Ch0	-- baoshan: fixed xdc
set_property KEEP_HIERARCHY true [get_cells -hierarchical -filter {name =~*/compact_gt_wrapper/compact_gt/uhdsdi_gt_0/inst/uhdsdi_ctrl_0/GEN_NIDRU.NIDRU}]

#set_max_delay -datapath_only -from [get_clocks clk_out2_system_basic_clk_wiz_0_0] -to [get_clocks clk_out1_system_basic_clk_wiz_0_0] 9.899
#set_max_delay -datapath_only -from [get_clocks clk_out1_system_basic_clk_wiz_0_0] -to [get_clocks clk_out2_system_basic_clk_wiz_0_0] -0.100
#create_generated_clock -name nidru_clk0 -source [get_pins {uhdsdi_demo/i_system_basic/system_basic_i/compact_gt_wrapper/compact_gt/uhdsdi_gt_0/inst/GT_WRAPPER_INST/gen_multi_gt_channel[0].gt_channel_gthe4_inst.uhdsdi_link/inst/gen_gtwizard_gthe4_top.uhdsdi_gtwiz_gtwizard_gthe4_inst/gen_gtwizard_gthe4.gen_channel_container[0].gen_enabled_channel.gthe4_channel_wrapper_inst/channel_inst/gthe4_channel_gen.gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST/RXOUTCLK}] -divide_by 2 [get_pins uhdsdi_demo/i_system_basic/system_basic_i/compact_gt_wrapper/compact_gt/uhdsdi_gt_0/inst/uhdsdi_ctrl_0/GEN_NIDRU.NIDRU/Inst_dru/CLK]
create_generated_clock -name nidru_clk0 -source [get_pins -hier -filter name=~*GTHE4_CHANNEL_PRIM_INST/RXOUTCLK] -divide_by 2 [get_pins uhdsdi_demo/i_system_basic/system_basic_i/compact_gt_wrapper/compact_gt/uhdsdi_gt_0/inst/uhdsdi_ctrl_0/GEN_NIDRU.NIDRU/Inst_dru/CLK]

#set_clock_groups -name async_grp4 -asynchronous -group [get_clocks clk_pl_0] -group [get_clocks [list  [get_clocks -of_objects [get_pins {uhdsdi_demo/i_system_basic/system_basic_i/compact_gt_wrapper/compact_gt/uhdsdi_gt_0/inst/GT_WRAPPER_INST/gen_multi_gt_channel[0].gt_channel_gthe4_inst.uhdsdi_link/inst/gen_gtwizard_gthe4_top.uhdsdi_gtwiz_gtwizard_gthe4_inst/gen_gtwizard_gthe4.gen_channel_container[0].gen_enabled_channel.gthe4_channel_wrapper_inst/channel_inst/gthe4_channel_gen.gen_gthe4_channel_inst[0].GTHE4_CHANNEL_PRIM_INST/RXOUTCLK}]]]]
set_clock_groups -name async_grp4 -asynchronous -group [get_clocks clk_pl_0] -group [get_clocks [list  [get_clocks -of_objects [get_pins -hier -filter name=~*GTHE4_CHANNEL_PRIM_INST/RXOUTCLK]]]]