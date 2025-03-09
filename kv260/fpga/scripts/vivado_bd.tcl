set BD_SRC [lindex $argv 0]
set BOARD [lindex $argv 1]
set OUTPUT_DIR [lindex $argv 2]
set PROJECT_NAME [lindex $argv 3]

if {[string equal ${BOARD} "ultra96v2"]} {
    create_project -part xczu3eg-sbva484-1-e -in_memory ${PROJECT_NAME} ${OUTPUT_DIR}
    set_property board_part em.avnet.com:ultra96v2:part0:1.0 [current_project]	
} elseif {[string equal ${BOARD} "kv260"]} {
    create_project -part xck26-sfvc784-2LV-c -in_memory ${PROJECT_NAME} ${OUTPUT_DIR}
    set_property board_part xilinx.com:kv260_som:part0:1.4 [current_project]
    set_property board_connections {som240_1_connector xilinx.com:kv260_carrier:som240_1_connector:1.3} [current_project]
}
set_property target_language Verilog [current_project]
set_property default_lib work [current_project]
create_bd_design -dir ${OUTPUT_DIR} -name design_1

source ${BD_SRC}

#save_bd_design_as -dir ${OUTPUT_DIR} -force design_1.bd
