# ----------------------------------------------------------------------------------------------------
# Copyright (c) 2024 by Enclustra GmbH, Switzerland.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this hardware, software, firmware, and associated documentation files (the
# "Product"), to deal in the Product without restriction, including without
# limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Product, and to permit persons to whom the
# Product is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Product.
#
# THE PRODUCT IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# PRODUCT OR THE USE OR OTHER DEALINGS IN THE PRODUCT.
# ----------------------------------------------------------------------------------------------------

# Project settings for Mercury XU6 Reference Design
# Valid module codes
# ME-XU6-2CG-1E-D10H
# ME-XU6-2EG-1I-D13E
# ME-XU6-3EG-2I-D11
# ME-XU6-4CG-1E-D12
# ME-XU6-4CG-1E-D13
# ME-XU6-4EV-1I-D12E
# ME-XU6-4EV-1I-D13E
# ME-XU6-5EV-2I-D12E

# ----------------------------------------------------------------------------------------------------
# Modify this variable to select your module
if {![info exists module_name]} {set module_name ME-XU6-2CG-1E-D10H}
if {![info exists baseboard]}   {set baseboard ST1}
if {![info exists vivado_dir]}   {set vivado_dir [file join Vivado ${module_name}] }
# ----------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------
# Don't modify anything beyond this line
# ----------------------------------------------------------------------------------------------------

#if any file argument are present, use this value
if {[lindex $argv 0] != ""} { set module_name [lindex $argv 0] }

set module Mercury_XU6
set family zynqmp

switch $module_name {
  ME-XU6-2CG-1E-D10H {
    set part xczu2cg-sfvc784-1-e 
    set PS_DDR PS_D10H
  }
  ME-XU6-2EG-1I-D13E {
    set part xczu2eg-sfvc784-1-i 
    set PS_DDR PS_D13E
  }
  ME-XU6-3EG-2I-D11 {
    set part xczu3eg-sfvc784-2-i 
    set PS_DDR PS_D11
  }
  ME-XU6-4CG-1E-D12 {
    set part xczu4cg-sfvc784-1-e 
    set PS_DDR PS_D12
  }
  ME-XU6-4CG-1E-D13 {
    set part xczu4cg-sfvc784-1-e 
    set PS_DDR PS_D13
  }
  ME-XU6-4EV-1I-D12E {
    set part xczu4ev-sfvc784-1-i 
    set PS_DDR PS_D12E
  }
  ME-XU6-4EV-1I-D13E {
    set part xczu4ev-sfvc784-1-i 
    set PS_DDR PS_D13E
  }
  ME-XU6-5EV-2I-D12E {
    set part xczu5ev-sfvc784-2-i 
    set PS_DDR PS_D12E
  }
  default {
    puts "$module_name not available"
    break
  }
}

#create project name for design
if {![info exists project_name]} {
  set project_name ${module}
  if {[info exists baseboard]} {
    lappend project_name ${baseboard}
  }
  set project_name [string map {" " "_"} "${project_name}"]
}

puts "INFO: settings.tcl file loaded."
