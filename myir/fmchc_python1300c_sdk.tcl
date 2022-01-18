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
set repo_folder [lindex $argv 1]
set project_folder [lindex $argv 2]
set board [lindex $argv 3]
set vivado_ver [lindex $argv 4]
set hw_file [lindex $argv 5]
set hw_name [lindex $argv 6]
set project  "fmchc_python1300c"
#set hw_name  "fmchc_python1300c_hw"
set bsp_name "fmchc_python1300c_bsp"
set app_name "${project}_app"
set system_project "${project}_system"


puts "\n#\n#"
puts "# repo: ${repo_folder}"
puts "# project folder: ${project_folder}"
puts "# project: ${project}"
puts "# vivado: ${vivado_ver}"
puts "# board: ${board}"
puts "# hw: ${hw_name}"
puts "# hw file: ${hw_file}"
puts "#\n#"

# Set workspace and import hardware platform
set workspace ${project_folder}/${project}.vitis
setws ${workspace}

puts "\n#\n#\n# Adding local user repository ...\n#\n#\n"
repo -set ${repo_folder}/avnet/Projects/${project}/software/sw_repository

# Generate Platform
set platform_name ${project}_platform
puts "\n#\n#\n# Creating Platform ${platform_name} ...\n#\n#\n"
if {[catch {platform remove ${platform_name}} errmsg]} {
    puts "**** ${platform_name} ${errmsg}"
} else {
    puts "**** ${platform_name} removed"
}
platform create -name ${platform_name} -hw ${hw_file} -proc {ps7_cortexa9_0} -os standalone
#platform write
#platform read {${workspace}/${project}/platform.spr}
#platform active ${project}

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
if {[catch {sysproj remove ${system_project}} errmsg]} {
    puts "**** ${system_project} ${errmsg}"
} else {
    puts "**** ${system_project} removed"
}
app create -name ${app_name} -sysproj ${system_project} -platform ${platform_name} -domain standalone_domain -proc ps7_cortexa9_0 -os standalone -lang C -template {Empty Application(C)}

# APP : copy sources to empty application
set app_src_dir ${repo_folder}/avnet/Projects/${project}/software/${app_name}/src
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

# build APP
puts "\n#\n#\n# Build ${app_name}, ${system_project} and generate BOOT.bin ...\n#\n#\n"
#app build -name ${app_name}
sysproj build -name ${system_project}

# done
exit
