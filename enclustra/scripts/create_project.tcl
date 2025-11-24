#
# create_project.tcl: Tcl script for re-creating Vivado project
#
# requires sourcing the settings.tcl to define the following variables:
# part, PS_DDR, project_name, vivado_dir
# ########################################################################################

for {set i 0} {$i < [llength $argv]} {incr i} {
    # check for PROJECT_NAME parameter
    if {[string match -nocase "project_name=*" [lindex $argv $i]]} {
        set project_name [string range [lindex $argv $i] 13 end]
    }

    # check for VIVADO_DIR parameter
    if {[string match -nocase "vivado_dir=*" [lindex $argv $i]]} {
        set vivado_dir [string range [lindex $argv $i] 11 end]
    }

    # check for FMC board
    if {[string match -nocase "fmc_board=*" [lindex $argv $i]]} {
        set fmc_board [string range [lindex $argv $i] 10 end]
    }

    # check for MIPI port selection
    if {[string match -nocase "mipi_port=*" [lindex $argv $i]]} {
        set mipi_port [string range [lindex $argv $i] 10 end]
    }
}

# validate input parameters
# if no FMC camera board is given, MIPI port selection only supports '0' (MIPI port 0) and '1' (MIPI port 1)
# if FMC camera board is 'opsero', MIPI port selection only supports '1' (MIPI port 1) and '2' (MIPI port 2)
# other FMC camera boards do not supported right now
if {[info exists fmc_board]} {
    if {[string equal $fmc_board "opsero"]} {
        if {![string match "1" $mipi_port] && ![string match "2" $mipi_port]} {
            puts "ERROR: For FMC board 'opsero', only MIPI port selection '1' and '2' are supported!"
            exit 1
        }
        set generics [list FMC_BOARD=$fmc_board MIPI_PORT=$mipi_port]
    } else {
        # other FMC boards are not supported right now
        puts "ERROR: FMC board '$fmc_board' not supported right now! Settings will be ignored."
        set fmc_board "none"
        #exit 1
    }
} else {
    set fmc_board "none"
}

if { ${fmc_board} eq "none"} {
    if {![string match "0" $mipi_port] && ![string match "1" $mipi_port]} {
        puts "ERROR: Unsupported onboard '$mipi_port', only '0' and '1' are supported!"
        exit 1
    }
    set generics [list MIPI_PORT=$mipi_port]
}

if {[file exists [file join scripts settings.tcl]] } { source [file join scripts settings.tcl] }

# Create project
create_project ${project_name} ${vivado_dir} -part ${part} -force

# Set project directory
set proj_dir [get_property directory [current_project]]

# Set project properties
set_property "default_lib"        "xil_defaultlib" [current_project]
set_property "part"               "${part}"        [current_project]
set_property "simulator_language" "Mixed"          [current_project]
set_property "target_language"    "VHDL"           [current_project]

# Create filesets (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
    create_fileset -srcset sources_1
}
if {[string equal [get_filesets -quiet constrs_1] ""]} {
    create_fileset -srcset constrs_1
}

# add source and constraints to corresponding fileset
if {$fmc_board eq "opsero"} {
    puts "INFO: Adding timing constraints for FMC board 'opsero'"
    add_files -norecurse -fileset sources_1 [glob -type f -directory src opsero_*.{vhd,edn}]
    add_files -norecurse -fileset constrs_1 [glob -type f -directory src opsero_*.{tcl,xdc}]
} else {
    puts "INFO: Adding timing constraints for default configuration (no FMC board)"
    add_files -norecurse -fileset sources_1 [glob -type f -directory src Mercury_*.{vhd,edn}]
    add_files -norecurse -fileset constrs_1 [glob -type f -directory src Mercury_*.{tcl,xdc}]
}

# re-create block design
# contains PS settings, IP instances, DDR settings
# ################################################
source scripts/Mercury_XU6_ST1_bd.tcl
# ################################################


# add the settings.tcl file to synth and implementation tcl.pre
set settings_file [file join scripts settings.tcl]
set norm_settings_file [file normalize $settings_file]
add_files -fileset utils_1 -norecurse $settings_file
set_property STEPS.SYNTH_DESIGN.TCL.PRE [ get_files $norm_settings_file -of [get_fileset utils_1] ] [get_runs synth_1]
set_property STEPS.INIT_DESIGN.TCL.PRE [ get_files $norm_settings_file -of [get_fileset utils_1] ] [get_runs impl_1]

# handle list of generics at level top
if {[info exists generics]} {
    set list [get_property "generic" [current_fileset]]
    #lappend list ${generics}
    set_property "generic" [concat ${list} ${generics}] [current_fileset]
}

# timing constraints are only relevant for implementation
set_property used_in_synthesis false [get_files -filter {NAME =~ *_timing.tcl}]

puts "INFO: END of [info script]"

#exit
