# global variables
set ::platform "zcu104"
set ::silicon "e"

# local variables
set project_dir "../projects/zcu104_vcu_trd"
set ip_dir "../zcu106_vcu_trd/pl/srcs/ip"
set constrs_dir "../zcu106_vcu_trd/pl/constrs"
set scripts_dir "../zcu106_vcu_trd/pl/scripts"

# set variable names
set part "xczu7ev-ffvc1156-2-${::silicon}"
set pin_xdc_file "pin_${::platform}_${::silicon}.xdc"
set design_name "zcu104_vcu_trd"
puts "INFO: Target part selected: '$part'"

# set up project
create_project $design_name $project_dir -part $part -force
set_property board_part xilinx.com:zcu104:part0:1.1 [current_project]

# set up IP repo
set_property ip_repo_paths $ip_dir [current_fileset]
update_ip_catalog -rebuild

# set up bd design
create_bd_design $design_name
source zcu104_vcu_trd_bd.tcl

regenerate_bd_layout -layout_file $scripts_dir/bd_layout.tcl
assign_bd_address

# add hdl sources to project
make_wrapper -files [get_files ./$project_dir/$design_name.srcs/sources_1/bd/$design_name/$design_name.bd] -top

add_files -norecurse ./$project_dir/$design_name.srcs/sources_1/bd/$design_name/hdl/$design_name\_wrapper.v
set_property top $design_name\_wrapper [current_fileset]
add_files -fileset constrs_1 -norecurse $constrs_dir/zcu104_vcu_trd.xdc
add_files -fileset constrs_1 -norecurse $constrs_dir/zcu104_vcu_trd_async.xdc
set_property used_in_synthesis false [get_files  zcu104_vcu_trd_async.xdc]
update_compile_order -fileset sources_1
set_property strategy Performance_ExtraTimingOpt [get_runs impl_1]       

validate_bd_design
save_bd_design
update_compile_order -fileset sources_1
regenerate_bd_layout
save_bd_design

#supress critical warnings in hdmitx
set_msg_config -suppress -id "Common 17-55"
set_msg_config -suppress -id {Vivado 12-259} 
set_msg_config -suppress -id {Vivado 12-4739}  


