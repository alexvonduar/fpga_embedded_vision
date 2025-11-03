set BD_SRC [lindex $argv 0]
set XDC_SRC [lindex $argv 1]
set BOARD [lindex $argv 2]
set OUTPUT_DIR [lindex $argv 3]
set PROJECT_NAME [lindex $argv 4]

proc numberOfCPUs {} {
    # Windows puts it in an environment variable
    global tcl_platform env
    if {$tcl_platform(platform) eq "windows"} {
        return $env(NUMBER_OF_PROCESSORS)
    }

    # Check for sysctl (OSX, BSD)
    set sysctl [auto_execok "sysctl"]
    if {[llength $sysctl]} {
        if {![catch {exec {*}$sysctl -n "hw.ncpu"} cores]} {
            return $cores
        }
    }

    # Assume Linux, which has /proc/cpuinfo, but be careful
    if {![catch {open "/proc/cpuinfo"} f]} {
        set cores [regexp -all -line {^processor\s} [read $f]]
        close $f
        if {$cores > 0} {
            return $cores
        }
    }

    # No idea what the actual number of cores is; exhausted all our options
    # Fall back to returning 1; there must be at least that because we're running on it!
    return 1
}

set numberOfCores [numberOfCPUs]
set numberOfJobs numberOfCores

if {$numberOfCores > 16} {
    set numberOfJobs [expr $numberOfCores - 10]
    puts "CPU: $numberOfCores jobs: $numberOfJobs"
}

if {[string equal ${BOARD} "ultra96v2"]} {
    create_project ${PROJECT_NAME} ${OUTPUT_DIR} -part xczu3eg-sbva484-1-e -force 
    set_property board_part em.avnet.com:ultra96v2:part0:1.0 [current_project]	
} elseif {[string equal ${BOARD} "kv260"]} {
    create_project ${PROJECT_NAME} ${OUTPUT_DIR} -part xck26-sfvc784-2LV-c -force 
    set_property board_part xilinx.com:kv260_som:part0:1.4 [current_project]
    set_property board_connections {som240_1_connector xilinx.com:kv260_carrier:som240_1_connector:1.3} [current_project]
}
set_property target_language Verilog [current_project]
set_property default_lib work [current_project]

add_files -fileset constrs_1 -norecurse ${XDC_SRC}

create_bd_design -dir ${OUTPUT_DIR} -name designe_1

source ${BD_SRC}

make_wrapper -files [get_files ${OUTPUT_DIR}/designe_1/designe_1.bd] -top
add_files -norecurse ${OUTPUT_DIR}/designe_1/hdl/designe_1_wrapper.v

#save_bd_design_as -dir ${OUTPUT_DIR} -force design_1.bd

set runlist [get_runs -filter {PROGRESS < 100}]
puts "**** unfinished runs ${runlist} ****"

set impl_out_of_date 0
if {[regexp -- synth_1 $runlist]} {
    puts "**** launch synthesize ****"
    set impl_out_of_date 1
    puts "set impl_1 out of date"
    reset_runs synth_1
    launch_runs -jobs $numberOfJobs synth_1
    wait_on_run synth_1
}

if {[regexp -- impl_1 $runlist]} {
    set impl_out_of_date 1
}

if {$impl_out_of_date} {
    puts "**** launch implementation ****"
    reset_runs impl_1
    launch_runs -jobs $numberOfJobs impl_1 -to_step write_bitstream
    wait_on_runs impl_1
}

set bit_stream_file ${OUTPUT_DIR}/${PROJECT_NAME}.runs/impl_1/${PROJECT_NAME}_wrapper.bit
if {![file exists ${bit_stream_file} ]} {
    puts "***** Generating bit stream..."
    open_run impl_1
    wait_on_run impl_1
    write_bitstream ${bit_stream_file}
} else {
    puts "**** bit stream already generated..."
}

puts "**** export xsa ****"
write_hw_platform -fixed -include_bit -force -file ${OUTPUT_DIR}/${PROJECT_NAME}.xsa
