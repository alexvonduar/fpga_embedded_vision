# global variables
set ::platform "zcu106"
set ::silicon "e"

# local variables
set project_dir "vcu_hdmitx"
set ip_dir "srcs/ip"
set constrs_dir "constrs"
set scripts_dir "scripts"

# set variable names
set part "xczu7ev-ffvc1156-2-${::silicon}"
set design_name "vcu_hdmitx"
puts "INFO: Target part selected: '$part'"

# set up project
create_project $design_name $project_dir -part $part -force
set_property board_part xilinx.com:zcu106:part0:2.3 [current_project]

# set up IP repo
set_property ip_repo_paths $ip_dir [current_fileset]
update_ip_catalog -rebuild

# set up bd design
create_bd_design $design_name
source $scripts_dir/vcu_hdmitx_bd.tcl

regenerate_bd_layout -layout_file $scripts_dir/bd_layout.tcl
assign_bd_address

# add hdl sources to project
make_wrapper -files [get_files ./$project_dir/vcu_hdmitx.srcs/sources_1/bd/vcu_hdmitx/vcu_hdmitx.bd] -top

add_files -norecurse ./$project_dir/vcu_hdmitx.srcs/sources_1/bd/vcu_hdmitx/hdl/vcu_hdmitx_wrapper.v
set_property top vcu_hdmitx_wrapper [current_fileset]
add_files -fileset constrs_1 -norecurse $constrs_dir/vcu_hdmitx.xdc
update_compile_order -fileset sources_1
set_property strategy Performance_Explore [get_runs impl_1]       

validate_bd_design
save_bd_design

#supress critical warnings in hdmitx
set_msg_config -suppress -id "Common 17-55"
set_msg_config -suppress -id {Vivado 12-259} 
set_msg_config -suppress -id {Vivado 12-4739}  


