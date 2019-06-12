# global variables
set ::platform "zcu106"
set ::silicon "e"

# local variables
set project_dir "vcu_hdmirx"
set ip_dir "srcs/ip"
set constrs_dir "constrs"
set scripts_dir "scripts"

# set variable names
set part "xczu7ev-ffvc1156-2-${::silicon}"
set design_name "vcu_hdmirx"
puts "INFO: Target part selected: '$part'"

# set up project
create_project $design_name $project_dir -part $part -force
set_property board_part xilinx.com:zcu106:part0:2.3 [current_project]

# set up IP repo
set_property ip_repo_paths $ip_dir [current_fileset]
update_ip_catalog -rebuild

# set up bd design
create_bd_design $design_name
source $scripts_dir/vcu_hdmirx_bd.tcl

# add hdl sources to project
make_wrapper -files [get_files ./$project_dir/vcu_hdmirx.srcs/sources_1/bd/vcu_hdmirx/vcu_hdmirx.bd] -top

add_files -norecurse ./$project_dir/vcu_hdmirx.srcs/sources_1/bd/vcu_hdmirx/hdl/vcu_hdmirx_wrapper.v
set_property top vcu_hdmirx_wrapper [current_fileset]
add_files -fileset constrs_1 -norecurse $constrs_dir/vcu_hdmirx.xdc
update_compile_order -fileset sources_1
set_property strategy Performance_NetDelay_low [get_runs impl_1]       

validate_bd_design
update_compile_order -fileset sources_1
regenerate_bd_layout
save_bd_design
report_ip_status -file ./IP_versions.txt
update_compile_order -fileset sources_1
regenerate_bd_layout
save_bd_design


