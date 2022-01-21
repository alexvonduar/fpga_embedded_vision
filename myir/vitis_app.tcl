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
#                                     Reach Further™ 
#  
# ----------------------------------------------------------------------------
# 
# This design is the property of Avnet.  Publication of this 
# design is not authorized without written consent from Avnet. 
# 
# Please direct any questions to the PicoZed community support forum: 
#    http://www.zedboard.org/forum 
# 
# Disclaimer: 
#    Avnet, Inc. makes no warranty for the use of this code or design. 
#    This code is provided  "As Is". Avnet, Inc assumes no responsibility for 
#    any errors, which may appear in this code, nor does it make a commitment 
#    to update the information contained herein. Avnet, Inc specifically 
#    disclaims any implied warranties of fitness for a particular purpose. 
#                     Copyright(c) 2017 Avnet, Inc. 
#                             All rights reserved. 
# 
# ----------------------------------------------------------------------------
# 
#  Create Date:         June 22, 2015
#  Design Name:         
#  Module Name:         
#  Project Name:        
#  Target Devices:      
#  Hardware Boards:     FMC-HDMI-CAM + PYTHON-1300-C
# 
#  Tool versions:       Vivado 2016.4
# 
#  Description:         SDK Build Script for FMC-HDMI-CAM + PYTHON-1300-C Design
# 
#  Dependencies:        To be called from a configured make script call

#
#  Revision:            Jun 22, 2015: 1.00 Initial version for Vivado 2014.4
#                       Nov 16, 2015: 1.01 Updated for Vivado 2015.2
#                       May 29, 2017: 1.02 Updated for Vivado 2016.4
# 
# ----------------------------------------------------------------------------


#!/usr/bin/tclsh
set project [lindex $argv 0]
set platform_name [lindex $argv 1]
set app_name [lindex $argv 2]
set sysproj_name [lindex $argv 3]
set top [lindex $argv 4]
set workspace [lindex $argv 5]
set build_type [lindex $argv 6]


puts "\n#\n#"
puts "# project: ${project}"
puts "# platform_name: ${platform_name}"
puts "# app_name: ${app_name}"
puts "# sysproj_name: ${sysproj_name}"
puts "# top: ${top}"
puts "# workspace: ${workspace}"
puts "# build_type: ${build_type}"
puts "#\n#"

# Set workspace and import hardware platform
setws ${workspace}

puts "\n#\n#\n# Adding local user repository ...\n#\n#\n"
repo -set ${top}/avnet/Projects/${project}/software/sw_repository

set plist [platform list]
set platform_exist [string match "*$platform_name *" $plist]
if {!$platform_exist} {
    puts "Platform $platform_name does not exist.  Exiting."
    exit
}

platform active ${platform_name}
puts "**** ${platform_name} opened ****"

puts "\n#\n#\n# Updating BSP ...\n#\n#\n"

# add libraries for FSBL
bsp setlib -name xilffs
bsp setlib -name xilrsa
# add libraries for APP
bsp setlib -name fmc_iic_sw
bsp setlib -name fmc_hdmi_cam_sw
bsp setlib -name onsemi_python_sw
# regen and build
bsp regenerate
bsp config -append extra_compiler_flags "-Wno-comment -Wno-unused-but-set-variable -Wno-unused-variable"
#platform generate

# Create APP
puts "\n#\n#\n# Creating ${app_name} ...\n#\n#\n"
if {[catch {app remove ${app_name}} errmsg]} {
    puts "**** ${app_name} ${errmsg}"
} else {
    puts "**** ${app_name} removed"
}
if {[catch {sysproj remove ${sysproj_name}} errmsg]} {
    puts "**** ${sysproj_name} ${errmsg}"
} else {
    puts "**** ${sysproj_name} removed"
}
app create -name ${app_name} -sysproj ${sysproj_name} -platform ${platform_name} -domain standalone_domain -proc ps7_cortexa9_0 -os standalone -lang C -template {Empty Application(C)}

if {[string match -nocase "debug" $build_type]} {
    app config -name ${app_name} -set build-config Debug
}
if {[string match -nocase "release" $build_type]} {
    app config -name ${app_name} -set build-config Release
}

# APP : copy sources to empty application
set app_src_dir ${top}/avnet/Projects/${project}/software/${project}_app/src
importsources -name ${app_name} -path ${app_src_dir} -soft-link
app config -add -name ${app_name} include-path ${app_src_dir}
app config -add -name ${app_name} include-path ${app_src_dir}/adi_adv7511_hal
app config -add -name ${app_name} include-path ${app_src_dir}/adi_adv7511_hal/TX
app config -add -name ${app_name} include-path ${app_src_dir}/adi_adv7511_hal/TX/HAL/COMMON
app config -add -name ${app_name} include-path ${app_src_dir}/adi_adv7511_hal/TX/HAL/WIRED/ADV7511
app config -add -name ${app_name} include-path ${app_src_dir}/adi_adv7511_hal/TX/HAL/WIRED/ADV7511/MACROS
app config -add -name ${app_name} include-path ${app_src_dir}/adi_adv7511_hal/TX/LIB
app config -add -name ${app_name} compiler-misc {-Wno-comment}
app config -set -name ${app_name} linker-script ${app_src_dir}/lscript.ld
app report ${app_name}

# build APP
puts "\n#\n#\n# Build ${app_name}, ${sysproj_name} and generate BOOT.bin ...\n#\n#\n"
#app build -name ${app_name}
sysproj build -name ${sysproj_name}

# done
exit
