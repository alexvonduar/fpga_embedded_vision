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
set project  "fmchc_python1300c"
set hw_name  "fmchc_python1300c_hw"
set bsp_name "fmchc_python1300c_bsp"
set app_name "fmchc_python1300c_app"

# Set workspace and import hardware platform
setws ${project}.sdk

puts "\n#\n#\n# Adding local user repository ...\n#\n#\n"
repo -set ../software/sw_repository

puts "\n#\n#\n# Importing hardware definition ${hw_name} from impl_1 folder ...\n#\n#\n"
file copy -force ${project}.runs/impl_1/${project}_wrapper.sysdef ${project}.sdk/${hw_name}.hdf
puts "\n#\n#\n# Create hardware definition project ...\n#\n#\n"
sdk createhw -name ${hw_name} -hwspec ${project}.sdk/${hw_name}.hdf

# Generate BSP
puts "\n#\n#\n# Creating ${bsp_name} ...\n#\n#\n"
createbsp -name ${bsp_name} -proc ps7_cortexa9_0 -hwproject ${hw_name} -os standalone
# add libraries for FSBL
setlib -bsp ${bsp_name} -lib xilffs
setlib -bsp ${bsp_name} -lib xilrsa
# add libraries for APP
setlib -bsp ${bsp_name} -lib fmc_iic_sw
setlib -bsp ${bsp_name} -lib fmc_hdmi_cam_sw
setlib -bsp ${bsp_name} -lib onsemi_python_sw
# regen and build
regenbsp -hw ${hw_name} -bsp ${bsp_name}
projects -build -type bsp -name ${bsp_name}

# Create APP
puts "\n#\n#\n# Creating ${app_name} ...\n#\n#\n"
createapp -name ${app_name} -hwproject ${hw_name} -proc ps7_cortexa9_0 -os standalone -lang C -app {Empty Application} -bsp ${bsp_name} 

# APP : copy sources to empty application
importsources -name ${app_name} -path ../software/${app_name}/src
configapp -app ${app_name} include-path {../src}
configapp -app ${app_name} include-path {../src/TX}
configapp -app ${app_name} include-path {../src/TX/HAL/COMMON}
configapp -app ${app_name} include-path {../src/TX/HAL/WIRED/ADV7511}
configapp -app ${app_name} include-path {../src/TX/HAL/WIRED/ADV7511/MACROS}
configapp -app ${app_name} include-path {../src/TX/LIB}

# build APP
puts "\n#\n#\n# Build ${app_name} ...\n#\n#\n"
projects -build -type app -name ${app_name}

# Create Zynq FSBL application
puts "\n#\n#\n# Creating zynq_fsbl ...\n#\n#\n"
#createapp -name zynq_fsbl_app -hwproject ${hw_name} -proc ps7_cortexa9_0 -os standalone -lang C -app {Zynq FSBL} -bsp zynq_fsbl_bsp
createapp -name zynq_fsbl_app -hwproject ${hw_name} -proc ps7_cortexa9_0 -os standalone -lang C -app {Zynq FSBL} -bsp ${bsp_name}

# Set the build type to release
#configapp -app zynq_fsbl_app build-config release

# Build FSBL application
puts "\n#\n#\n Building zynq_fsbl ...\n#\n#\n"
#projects -build -type bsp -name zynq_fsbl_bsp
projects -build -type app -name zynq_fsbl_app

# done
exit