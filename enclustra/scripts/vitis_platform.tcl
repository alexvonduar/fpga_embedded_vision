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
set top [lindex $argv 2]
set workspace [lindex $argv 3]
set hw_file [lindex $argv 4]

puts "\n#\n#"
puts "# project: ${project}"
puts "# platform: ${platform_name}"
puts "# top folder: ${top}"
puts "# workspace: ${workspace}"
puts "# hw file: ${hw_file}"
puts "#\n#"

# Set workspace and import hardware platform
setws ${workspace}

#puts "\n#\n#\n# Adding local user repository ...\n#\n#\n"
#repo -set ${top}/avnet/Projects/${project}/software/sw_repository

# Generate Platform

set plist [platform list]
set platform_exist [string match "*$platform_name *" $plist]

puts "\n#\n#\n# Creating Platform ${platform_name} ...\n#\n#\n"
if {$platform_exist} {
    platform remove ${platform_name}
    puts "**** ${platform_name} removed"
}
platform create -name ${platform_name} -hw ${hw_file} -proc {psu_cortexa53_0} -os standalone
platform write

# done
exit
