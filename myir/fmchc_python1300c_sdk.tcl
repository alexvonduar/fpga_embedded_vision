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
set board [lindex $argv 2]
set vivado_ver [lindex $argv 3]
set hw_file [lindex $argv 4]
set hw_name [lindex $argv 5]
set project  "fmchc_python1300c"
#set hw_name  "fmchc_python1300c_hw"
set bsp_name "fmchc_python1300c_bsp"
set app_name "fmchc_python1300c_app"
set app_system "fmchc_python1300c_system"

# Set workspace and import hardware platform
set workspace ${repo_folder}/${project}_vitis
setws ${workspace}

puts "\n#\n#\n# Vivado ${vivado_ver} Board ${board} hw ${hw_name} file ${hw_file}\n#\n#\n"

puts "\n#\n#\n# Adding local user repository ...\n#\n#\n"
#repo -set ../software/sw_repository
repo -set ${repo_folder}/avnet/Projects/${project}/software/sw_repository

#puts "\n#\n#\n# Importing hardware definition ${hw_name} from impl_1 folder ...\n#\n#\n"
#file copy -force ${project}.runs/impl_1/${project}_wrapper.sysdef ${project}.sdk/${hw_name}.hdf
#puts "\n#\n#\n# Create hardware definition project ...\n#\n#\n"
#sdk createhw -name ${hw_name} -hwspec ${project}.sdk/${hw_name}.hdf
#openhw ${hw_file}

# Generate BSP
puts "\n#\n#\n# Creating ${bsp_name} ...\n#\n#\n"
platform create -name ${project} -hw ${hw_file} -proc {ps7_cortexa9_0} -os standalone
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
#regenbsp -hw ${hw_name} -bsp ${bsp_name}
bsp regenerate
#projects -build -type bsp -name ${bsp_name}
platform generate

# Create APP
puts "\n#\n#\n# Creating ${app_name} ...\n#\n#\n"
#createapp -name ${app_name} -hwproject ${hw_name} -proc ps7_cortexa9_0 -os standalone -lang C -app {Empty Application} -bsp ${bsp_name} 
app create -name ${app_name} -sysproj ${app_system} -platform ${project} -domain standalone_domain -proc ps7_cortexa9_0 -os standalone -lang C -template {Empty Application(C)}

# APP : copy sources to empty application
importsources -name ${app_name} -path ../../../avnet/Projects/${project}/software/${app_name}/src
app config -add -name ${app_name} include-path {../src}
app config -add -name ${app_name} include-path {../src/TX}
app config -add -name ${app_name} include-path {../src/TX/HAL/COMMON}
app config -add -name ${app_name} include-path {../src/TX/HAL/WIRED/ADV7511}
app config -add -name ${app_name} include-path {../src/TX/HAL/WIRED/ADV7511/MACROS}
app config -add -name ${app_name} include-path {../src/TX/LIB}

# build APP
puts "\n#\n#\n# Build ${app_name} ...\n#\n#\n"
#projects -build -type app -name ${app_name}
app build -name ${app_name}
sysproj build -name ${app_system}

# Create Zynq FSBL application
#puts "\n#\n#\n# Creating zynq_fsbl ...\n#\n#\n"
#createapp -name zynq_fsbl_app -hwproject ${hw_name} -proc ps7_cortexa9_0 -os standalone -lang C -app {Zynq FSBL} -bsp zynq_fsbl_bsp
#createapp -name zynq_fsbl_app -hwproject ${hw_name} -proc ps7_cortexa9_0 -os standalone -lang C -app {Zynq FSBL} -bsp ${bsp_name}

# Set the build type to release
#configapp -app zynq_fsbl_app build-config release

# Build FSBL application
#puts "\n#\n#\n Building zynq_fsbl ...\n#\n#\n"
#projects -build -type bsp -name zynq_fsbl_bsp
#projects -build -type app -name zynq_fsbl_app

# done
exit
