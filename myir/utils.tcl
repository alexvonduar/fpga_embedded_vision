# create GREP process
# From: http://wiki.tcl.tk/9395
# Modified to set a variable, instead of only printing locations
proc grep {pattern args} {
    global found
    set found "false"
    if {[llength $args] == 0} {
        grep0 "" $pattern stdin
    } else {
        foreach filename $args {
            if {[file exists $filename]} {
                set file [open $filename r]
                grep0 ${filename}: $pattern $file
                close $file
            } else {
                puts "File $filename does not exist"
            }
        }
    }
}

proc grep0 {prefix pattern handle} {
    set lnum 0
    while {[gets $handle line] >= 0} {
        incr lnum
        if {[regexp $pattern $line]} {
            global found
            set found "true"
            puts "$prefix${lnum}:${line}"
        }
    }
}

# From StackOverflow
# https://stackoverflow.com/questions/29482303/how-to-find-the-number-of-cpus-in-tcl

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

proc validate_core_licenses { core_list ip_report_filename } {
    set valid_cores 0
    set invalid_cores 0

    puts ""
    puts "+------------------+------------------------------------+"
    puts "| Video IP Core    | License Status                     |"
    puts "+------------------+------------------------------------+"

    foreach core $core_list {

        # Format core name for display
        set core_name $core
        for {set j 0} {$j < [expr 16 - [string length $core]]} {incr j} {
            append core_name " "
        }

        # Search for core license status in ip status report
        set file [open $ip_report_filename r]
        set ip_status ""
        while {[gets $file line] >= 0} {
            if {[regexp $core $line]} {
                set ip_status $line
            break
            }
        }
        close $file
        #puts "ip_status = ${ip_status}"

        # Validate and display status of core license
        if {[regexp "Included" ${ip_status}]} {
            puts "| ${core_name} | VALID (Full License)               |"
            incr valid_cores
        } elseif {[regexp "Hardware_E" ${ip_status}]} {
            puts "| ${core_name} | VALID (Hardware Evaluation)        |"
            incr valid_cores
        } elseif {[regexp "Purchased" ${ip_status}]} {
            puts "| ${core_name} | VALID (Purchased)                  |"
            incr valid_cores
        } else {
            puts "| ${core_name} | INVALID                            |"
            incr invalid_cores
        }
        puts "+------------------+------------------------------------+"

    }
    return $valid_cores
}

proc avnet_generate_ip {ip_name} {
    puts "Making $ip_name..."
    source ../IP/$ip_name/$ip_name.tcl -notrace
    cd ../IP/$ip_name
    make_ip $ip_name
    cd ../../Scripts
}
