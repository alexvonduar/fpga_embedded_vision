# global variables
set ::platform "zcu106"
set ::silicon "e"

# local variables
set project_dir "vcu_sdirxtx"
set ip_dir "srcs/ip"
set constrs_dir "constrs"
set scripts_dir "scripts"

# set variable names
set part "xczu7ev-ffvc1156-2-${::silicon}"
set design_name "vcu_sdirxtx"
puts "INFO: Target part selected: '$part'"

# set up project
create_project $design_name $project_dir -part $part -force
set_property board_part xilinx.com:zcu106:part0:2.3 [current_project]

# set up IP repo

# set up bd design
create_bd_design "system_basic"
add_files -norecurse ./srcs/hdl/compact_gt_ctrl.v
add_files -norecurse ./srcs/hdl/vcu_sdirxtx_top.v
add_files -norecurse ./srcs/hdl/zugth_uhdsdi_demo.v
source $scripts_dir/vcu_sdirxtx_bd.tcl

# add hdl sources to project
make_wrapper -files [get_files ./$project_dir/vcu_sdirxtx.srcs/sources_1/bd/system_basic/system_basic.bd] -top
add_files -norecurse ./$project_dir/vcu_sdirxtx.srcs/sources_1/bd/system_basic/hdl/system_basic_wrapper.v
set_property top vcu_sdirxtx_top [current_fileset]
add_files -fileset constrs_1 -norecurse $constrs_dir/vcu_sdirxtx_place.xdc
add_files -fileset constrs_1 -norecurse $constrs_dir/vcu_sdirxtx_timing.xdc
update_compile_order -fileset sources_1
set_property strategy Performance_Explore [get_runs impl_1]       

validate_bd_design
update_compile_order -fileset sources_1
regenerate_bd_layout
save_bd_design



