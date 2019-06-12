################################################################################
#
# Copyright (c) 2017 Adeas B.V. All rights reserved.
#
# This file contains the clock constraints for the I2S Transmitter.
#
# MODIFICATION HISTORY:
#
# Ver   Who Date         Changes
# ----- --- ----------   -----------------------------------------------
# X.XX  XX  YYYY/MM/DD
# 1.00  RHe 2017/03/01   First release
#
################################################################################

# 36.864 MHz
create_clock -period 27.1267 -name m_clk [get_ports aud_mclk]
#create_clock -period 6.732 -name ref_clk [get_ports ref_clk]
create_clock -period 3.333 -name ref_clk [get_ports ref_clk]

# 100 MHz 
create_clock -period 10.000 -name axi_clk [get_ports s_axi_ctrl_aclk]

# 98 MHz
create_clock -period 10.200 -name aud_clk [get_ports acr_clk]

set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks ref_clk] \
                               -group [get_clocks -include_generated_clocks axi_clk] \
                               -group [get_clocks -include_generated_clocks aud_clk] \
                               -group [get_clocks -include_generated_clocks m_clk]  