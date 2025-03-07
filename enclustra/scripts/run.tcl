# ----------------------------------------------------------------------------
#
#        ** **        **          **  ****      **  **********  ********** ®
#       **   **        **        **   ** **     **  **              **
#      **     **        **      **    **  **    **  **              **
#     **       **        **    **     **   **   **  *********       **
#    **         **        **  **      **    **  **  **              **
#   **           **        ****       **     ** **  **              **
#  **  .........  **        **        **      ****  **********      **
#     ...........
#                                     Reach Further?
#
# ----------------------------------------------------------------------------
#
#  This design is the property of Avnet.  Publication of this
#  design is not authorized without written consent from Avnet.
#
#  Please direct any questions or issues to the MicroZed Community Forums:
#      http://www.microzed.org
#
#  Disclaimer:
#     Avnet, Inc. makes no warranty for the use of this code or design.
#     This code is provided  "As Is". Avnet, Inc assumes no responsibility for
#     any errors, which may appear in this code, nor does it make a commitment
#     to update the information contained herein. Avnet, Inc specifically
#     disclaims any implied warranties of fitness for a particular purpose.
#                      Copyright(c) 2014 Avnet, Inc.
#                              All rights reserved.
#
# ----------------------------------------------------------------------------
#
#  Create Date:         June 16, 2015
#  Design Name:
#  Module Name:
#  Project Name:
#  Target Devices:
#  Hardware Boards:     FMC-HDMI-CAM + PYTHON-1300-C Camera
#
#  Tool versions:       Vivado 2021.2
#
#  Description:         Build Script for FMC-HDMI-CAM + PYTHON-1300-C Getting Started design
#
#  Dependencies:        make.tcl
#
# ----------------------------------------------------------------------------

set required_version 2024.2
set top "init"
set board "init"
#"MYIR7020_FMC"
set project "init"
#"fmchc_python1300c"
set version_override "yes"
set vivado_ver "${required_version}"
set output "init"
set step "init"

set start_time [clock seconds]
set build_params ""
# to adjust the width of the chart, need to adjust this as well as the "predefined"
# chart elements below (there are 4 lines that need to be adjusted)
set chart_wdith 30
# need to add debug printing to a log
for {set i 0} {$i < [llength $argv]} {incr i} {
    # check for BOARD parameter
    if {[string match -nocase "*help*" [lindex $argv $i]]} {
        puts "Parameters are:"
        puts "top=<top_dir>\n top directory for the repository"
        puts "board=<board_name>\n boards are listed in the /Boards folder"
        puts "project=<project_name>\n project names are listed in the /Scripts/ProjectScripts folder"
        puts "vivado_ver=${vivado_ver}\n vivado version to use"
        puts "step=<syn|place|route>\n set step to run"
        puts "version_override=yes\n ***************************** \n CAUTION: \n Override the Version Check\n and attempt to make project\n *****************************"
        return -code ok
    }
    # check for TOP parameter
    if {[string match -nocase "top=*" [lindex $argv $i]]} {
        set top [string range [lindex $argv $i] 4 end]
        puts "******* $top ********"
        set printmessage $top
        for {set j 0} {$j < [expr $chart_wdith - [string length $board]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Top            |     $printmessage |\n"
    }
    # check for Output parameter
    if {[string match -nocase "output=*" [lindex $argv $i]]} {
        set output [string range [lindex $argv $i] 7 end]
        puts "******* $output ********"
        set printmessage $output
        for {set j 0} {$j < [expr $chart_wdith - [string length $board]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Output            |     $printmessage |\n"
    }
    # check for BOARD parameter
    if {[string match -nocase "board=*" [lindex $argv $i]]} {
        set board [string range [lindex $argv $i] 6 end]
        set printmessage $board
        for {set j 0} {$j < [expr $chart_wdith - [string length $board]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Board            |     $printmessage |\n"
    }
    # check for PROJECT parameter
    if {[string match -nocase "project=*" [lindex $argv $i]]} {
        set project [string range [lindex $argv $i] 8 end]
        set printmessage $project
        for {set j 0} {$j < [expr $chart_wdith - [string length $project]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Project          |     $printmessage |\n"
    }
    # check for Version Override parameter
    if {[string match -nocase "version_override=*" [lindex $argv $i]]} {
        set version_override [string range [lindex $argv $i] 17 end]
        set printmessage $version_override
        for {set j 0} {$j < [expr $chart_wdith - [string length $version_override]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Version override |     $printmessage |\n"
    }
    # check for VIVADO_VER parameter
    if {[string match -nocase "vivado_ver=*" [lindex $argv $i]]} {
        set vivado_ver [string range [lindex $argv $i] 11 end]
        set printmessage $vivado_ver
        for {set j 0} {$j < [expr $chart_wdith - [string length $vivado_ver]]} {incr j} {
            append printmessage " "
        }
        append build_params "| Vivado Version   |     $printmessage |\n"
    }
    append build_params "+------------------+------------------------------------+\n"
}
append build_params "\n\n"
puts $build_params

#version check
set version [version -short]
if {[string match -nocase "yes" $version_override]} {
    puts "Overriding Version Check, Please Check the Design for Validity!"
} else {
    if { [string first $required_version $version] == -1 } {
        puts "Version $version of Vivado not acceptable, please run with Vivado $required_version to continue"
        return -code ok
    } else {
        puts "Version of Vivado acceptable, continuing..."
    }
}

# If variables do not exist, exit script
if {[string match -nocase "init" $top]} {
    puts "Top directory was not defined, please define and try again!"
    return -code ok
}

if {[string match -nocase "init" $output]} {
    puts "output xsa was not defined, please define and try again!"
    return -code ok
}

if {[string match -nocase "init" $board]} {
    puts "Board was not defined, please define and try again!"
    #return -code ok
}
if {[string match -nocase "init" $project]} {
    puts "Project was not defined, please define and try again!"
    #return -code ok
}

set scriptdir "${top}/myir"

source ${scriptdir}/utils.tcl -notrace
set numberOfCores [numberOfCPUs]
set numberOfJobs numberOfCores

if {$numberOfCores > 2} {
    set numberOfJobs [expr $numberOfCores - 2]
    puts "CPU: $numberOfCores jobs: $numberOfJobs"
}

# create variables with absolute folders for all necessary folders
#set projects_folder [file normalize ${top}/${project}_${board}_${vivado_ver}]
set projects_folder [file normalize ${top}/enclustra/Vivado/ME-XU6-2CG-1E-D10H]


puts "\n\n*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
puts " Selected Board and Project as:\n$board and $project"
puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\n\n"


puts "***** open project ${project}"
open_project ${projects_folder}/${project}.xpr
#open_project ${projects_folder}/Mercury_XU6_ST1.xpr
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

set bit_stream_file ${projects_folder}/${project}.runs/impl_1/${project}_wrapper.bit
if {![file exists ${bit_stream_file} ]} {
    puts "***** Generating bit stream..."
    open_run impl_1
    wait_on_run impl_1
    write_bitstream ${bit_stream_file}
} else {
    puts "**** bit stream already generated..."
}

puts "**** export ${output} ****"
write_hw_platform -fixed -include_bit -force -file ${output}

set end_time [clock seconds]
set number_seconds [expr {$end_time - $start_time}]
set time_string "Your Build Took\nseconds [$number_seconds]\n\nor a total of:\n\ndays [[expr {$number_seconds/86400}]]\nhrs  [[expr {($number_seconds%86400)/3600}]]\nmin  [[expr {(($number_seconds%86400)%3600)/60}]]\nsec  [[expr {(($number_seconds%86400)%3600)%60}]]\n\nto complete"

append build_params "\n"
append build_params $time_string
set out [open $projects_folder/buildInfo.log w]
puts -nonewline $out $build_params
close $out

puts "
$time_string

*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*-                                                     -*
*-            Finished Running Script                  -*
*-                                                     -*
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
"
unset out
unset build_params
unset start_time
unset end_time
unset number_seconds
unset time_string
