# global variables
set ::platform "zcu106"
set ::silicon "e"

# local variables
set project_dir "hdmi_plddr"
set ip_dir "srcs/ip_repo/"
set constrs_dir "constrs"
set scripts_dir "scripts"

# set variable names
set part "xczu7ev-ffvc1156-2-${::silicon}"
set pin_xdc_file "pin_${::platform}_${::silicon}.xdc"
set design_name "hdmi_plddr"
puts "INFO: Target part selected: '$part'"

# set up project
create_project $design_name $project_dir -part $part -force
set_property board_part xilinx.com:zcu106:part0:2.0 [current_project]

# set up IP repo
set_property ip_repo_paths $ip_dir [current_fileset]
update_ip_catalog -rebuild

# set up bd design
create_bd_design $design_name
source $scripts_dir/hdmi_plddr_bd.tcl

assign_bd_address

# add hdl sources to project
make_wrapper -files [get_files ./$project_dir/hdmi_plddr.srcs/sources_1/bd/hdmi_plddr/hdmi_plddr.bd] -top

add_files -norecurse ./$project_dir/hdmi_plddr.srcs/sources_1/bd/hdmi_plddr/hdl/hdmi_plddr_wrapper.v
set_property top hdmi_plddr_wrapper [current_fileset]
add_files -fileset constrs_1 -norecurse $constrs_dir/hdmi_plddr.xdc
update_compile_order -fileset sources_1

validate_bd_design
save_bd_design
set_msg_config -suppress -id {BD 41-1265} 
set_msg_config -suppress -id "Common 17-55"
set_msg_config -suppress -id {Vivado 12-259} 
set_msg_config -suppress -id {Vivado 12-4739} 

set_property strategy {Vivado Synthesis Defaults} [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.RETIMING true [get_runs synth_1]
set_property strategy Performance_NetDelay_low [get_runs impl_1]
set_property STEPS.PHYS_OPT_DESIGN.ARGS.DIRECTIVE AlternateFlowWithRetiming [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.ARGS.DIRECTIVE AddRetime [get_runs impl_1] 
 

