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

set_property BITSTREAM.CONFIG.OVERTEMPSHUTDOWN ENABLE [current_design]

# ----------------------------------------------------------------------------------
# Important! Do not remove this constraint!
# This property ensures that all unused pins are set to high impedance.
# If the constraint is removed, all unused pins have to be set to HiZ in the top level file.
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLNONE [current_design]
# ----------------------------------------------------------------------------------

# Anios 0
# Bank 24 VCC_IO_BN VCC_IO_A ZU2/3
set_property -dict {PACKAGE_PIN AB15  IOSTANDARD LVCMOS18  } [get_ports {IO0_D0_P}]
set_property -dict {PACKAGE_PIN AB14  IOSTANDARD LVCMOS18  } [get_ports {IO0_D1_N}]
set_property -dict {PACKAGE_PIN W12   IOSTANDARD LVCMOS18  } [get_ports {IO0_D2_P}]
set_property -dict {PACKAGE_PIN W11   IOSTANDARD LVCMOS18  } [get_ports {IO0_D3_N}]
set_property -dict {PACKAGE_PIN AE15  IOSTANDARD LVCMOS18  } [get_ports {IO0_D4_P}]
set_property -dict {PACKAGE_PIN AE14  IOSTANDARD LVCMOS18  } [get_ports {IO0_D5_N}]
set_property -dict {PACKAGE_PIN AE13  IOSTANDARD LVCMOS18  } [get_ports {IO0_D6_P}]
set_property -dict {PACKAGE_PIN AF13  IOSTANDARD LVCMOS18  } [get_ports {IO0_D7_N}]
set_property -dict {PACKAGE_PIN AG13  IOSTANDARD LVCMOS18  } [get_ports {IO0_D8_P}]
set_property -dict {PACKAGE_PIN AH13  IOSTANDARD LVCMOS18  } [get_ports {IO0_D9_N}]
# Bank 44 VCC_IO_BO VCC_IO_A ZU2/3
set_property -dict {PACKAGE_PIN AB11  IOSTANDARD LVCMOS18  } [get_ports {IO0_D10_P}]
set_property -dict {PACKAGE_PIN AC11  IOSTANDARD LVCMOS18  } [get_ports {IO0_D11_N}]
# Bank 24 VCC_IO_BN VCC_IO_A ZU2/3
set_property -dict {PACKAGE_PIN AA13  IOSTANDARD LVCMOS18  } [get_ports {IO0_D12_P}]
set_property -dict {PACKAGE_PIN AB13  IOSTANDARD LVCMOS18  } [get_ports {IO0_D13_N}]
set_property -dict {PACKAGE_PIN W14   IOSTANDARD LVCMOS18  } [get_ports {IO0_D14_P}]
set_property -dict {PACKAGE_PIN W13   IOSTANDARD LVCMOS18  } [get_ports {IO0_D15_N}]
set_property -dict {PACKAGE_PIN Y14   IOSTANDARD LVCMOS18  } [get_ports {IO0_D16_P}]
set_property -dict {PACKAGE_PIN Y13   IOSTANDARD LVCMOS18  } [get_ports {IO0_D17_N}]
set_property -dict {PACKAGE_PIN Y12   IOSTANDARD LVCMOS18  } [get_ports {IO0_D18_P}]
set_property -dict {PACKAGE_PIN AA12  IOSTANDARD LVCMOS18  } [get_ports {IO0_D19_N}]
set_property -dict {PACKAGE_PIN AG14  IOSTANDARD LVCMOS18  } [get_ports {IO0_D20_P}]
set_property -dict {PACKAGE_PIN AH14  IOSTANDARD LVCMOS18  } [get_ports {IO0_D21_N}]
set_property -dict {PACKAGE_PIN AD15  IOSTANDARD LVCMOS18  } [get_ports {IO0_D22_P}]
set_property -dict {PACKAGE_PIN AD14  IOSTANDARD LVCMOS18  } [get_ports {IO0_D23_N}]
# Bank 44 VCC_IO_BO VCC_IO_A ZU2/3
set_property -dict {PACKAGE_PIN AD10  IOSTANDARD LVCMOS18  } [get_ports {IO0_CLK_N}]
set_property -dict {PACKAGE_PIN AD11  IOSTANDARD LVCMOS18  } [get_ports {IO0_CLK_P}]

# Anios 1
# Bank 64 VCC_IO_B64 VCC_IO_C
set_property -dict {PACKAGE_PIN AD5   IOSTANDARD LVCMOS12  } [get_ports {IO1_D0_P}]
set_property -dict {PACKAGE_PIN AD4   IOSTANDARD LVCMOS12  } [get_ports {IO1_D1_N}]
set_property -dict {PACKAGE_PIN AB4   IOSTANDARD LVCMOS12  } [get_ports {IO1_D2_P}]
set_property -dict {PACKAGE_PIN AB3   IOSTANDARD LVCMOS12  } [get_ports {IO1_D3_N}]
set_property -dict {PACKAGE_PIN AG6   IOSTANDARD LVCMOS12  } [get_ports {IO1_D4_P}]
set_property -dict {PACKAGE_PIN AG5   IOSTANDARD LVCMOS12  } [get_ports {IO1_D5_N}]
set_property -dict {PACKAGE_PIN AH8   IOSTANDARD LVCMOS12  } [get_ports {IO1_D6_P}]
set_property -dict {PACKAGE_PIN AH7   IOSTANDARD LVCMOS12  } [get_ports {IO1_D7_N}]
set_property -dict {PACKAGE_PIN AB2   IOSTANDARD LVCMOS12  } [get_ports {IO1_D8_P}]
set_property -dict {PACKAGE_PIN AC2   IOSTANDARD LVCMOS12  } [get_ports {IO1_D9_N}]
set_property -dict {PACKAGE_PIN AB1   IOSTANDARD LVCMOS12  } [get_ports {IO1_D10_P}]
set_property -dict {PACKAGE_PIN AC1   IOSTANDARD LVCMOS12  } [get_ports {IO1_D11_N}]
set_property -dict {PACKAGE_PIN AG4   IOSTANDARD LVCMOS12  } [get_ports {IO1_D12_P}]
set_property -dict {PACKAGE_PIN AH4   IOSTANDARD LVCMOS12  } [get_ports {IO1_D13_N}]
set_property -dict {PACKAGE_PIN AG3   IOSTANDARD LVCMOS12  } [get_ports {IO1_D14_P}]
set_property -dict {PACKAGE_PIN AH3   IOSTANDARD LVCMOS12  } [get_ports {IO1_D15_N}]
set_property -dict {PACKAGE_PIN AE3   IOSTANDARD LVCMOS12  } [get_ports {IO1_D16_P}]
set_property -dict {PACKAGE_PIN AF3   IOSTANDARD LVCMOS12  } [get_ports {IO1_D17_N}]
set_property -dict {PACKAGE_PIN AE2   IOSTANDARD LVCMOS12  } [get_ports {IO1_D18_P}]
set_property -dict {PACKAGE_PIN AF2   IOSTANDARD LVCMOS12  } [get_ports {IO1_D19_N}]
set_property -dict {PACKAGE_PIN AH2   IOSTANDARD LVCMOS12  } [get_ports {IO1_D20_P}]
set_property -dict {PACKAGE_PIN AH1   IOSTANDARD LVCMOS12  } [get_ports {IO1_D21_N}]
set_property -dict {PACKAGE_PIN AF1   IOSTANDARD LVCMOS12  } [get_ports {IO1_D22_P}]
set_property -dict {PACKAGE_PIN AG1   IOSTANDARD LVCMOS12  } [get_ports {IO1_D23_N}]
set_property -dict {PACKAGE_PIN AC3   IOSTANDARD LVCMOS12  } [get_ports {IO1_CLK_N}]
set_property -dict {PACKAGE_PIN AC4   IOSTANDARD LVCMOS12  } [get_ports {IO1_CLK_P}]

# BUTTONS
# Bank 44 VCC_IO_BO VCC_IO_A ZU2/3
set_property -dict {PACKAGE_PIN AA11  IOSTANDARD LVCMOS18  } [get_ports {BTN1_N}]

# Optional reference oscillator
# Bank 26 VCC_IO_BE_BF VCC_IO_C ZU2/3
set_property -dict {PACKAGE_PIN D14   IOSTANDARD DIFF_SSTL12} [get_ports {CLK_REF_N}]
set_property -dict {PACKAGE_PIN D15   IOSTANDARD DIFF_SSTL12} [get_ports {CLK_REF_P}]

# Clock Generator CLK2
# Bank 26 VCC_IO_BE_BF VCC_IO_C ZU2/3
set_property -dict {PACKAGE_PIN E15   IOSTANDARD DIFF_SSTL12} [get_ports {CLK_REF1_N}]
set_property -dict {PACKAGE_PIN F15   IOSTANDARD DIFF_SSTL12} [get_ports {CLK_REF1_P}]

# Clock Generator CLK3
# Bank 26 VCC_IO_BE_BF VCC_IO_C ZU2/3
set_property -dict {PACKAGE_PIN E13   IOSTANDARD DIFF_SSTL12} [get_ports {CLK_REF2_N}]
set_property -dict {PACKAGE_PIN E14   IOSTANDARD DIFF_SSTL12} [get_ports {CLK_REF2_P}]

# Clock Generator CLK0
# Bank 24 VCC_IO_BN VCC_IO_A ZU2/3
set_property -dict {PACKAGE_PIN AC13  IOSTANDARD DIFF_SSTL18_I} [get_ports {CLK_USR_N}]
set_property -dict {PACKAGE_PIN AC14  IOSTANDARD DIFF_SSTL18_I} [get_ports {CLK_USR_P}]

# Display Port
# Bank 64 VCC_IO_B64 VCC_IO_C
set_property -dict {PACKAGE_PIN AH6   IOSTANDARD LVCMOS12  } [get_ports {DP_HPD}]
set_property -dict {PACKAGE_PIN AB5   IOSTANDARD LVCMOS12  } [get_ports {DP_AUX_IN}]
set_property -dict {PACKAGE_PIN AD6   IOSTANDARD LVCMOS12  } [get_ports {DP_AUX_OE}]
set_property -dict {PACKAGE_PIN AE4   IOSTANDARD LVCMOS12  } [get_ports {DP_AUX_OUT}]

# FMC HPC Connector VCC_IO_C VCC_IO_B
# Bank 66 VCC_IO_B66 VCC_IO_B
set_property -dict {PACKAGE_PIN E3    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA02_N}]
set_property -dict {PACKAGE_PIN E4    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA02_P}]
# Bank 65 VCC_IO_B65 VCC_IO_B
set_property -dict {PACKAGE_PIN T7    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA03_N}]
set_property -dict {PACKAGE_PIN R7    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA03_P}]
# Bank 66 VCC_IO_B66 VCC_IO_B
set_property -dict {PACKAGE_PIN F3    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA04_N}]
set_property -dict {PACKAGE_PIN G3    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA04_P}]
# Bank 65 VCC_IO_B65 VCC_IO_B
set_property -dict {PACKAGE_PIN T8    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA05_N}]
set_property -dict {PACKAGE_PIN R8    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA05_P}]
set_property -dict {PACKAGE_PIN V8    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA06_N}]
set_property -dict {PACKAGE_PIN U8    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA06_P}]
# Bank 66 VCC_IO_B66 VCC_IO_B
set_property -dict {PACKAGE_PIN E2    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA07_N}]
set_property -dict {PACKAGE_PIN F2    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA07_P}]
# Bank 65 VCC_IO_B65 VCC_IO_B
set_property -dict {PACKAGE_PIN V9    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA08_N}]
set_property -dict {PACKAGE_PIN U9    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA08_P}]
# Bank 66 VCC_IO_B66 VCC_IO_B
set_property -dict {PACKAGE_PIN D1    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA09_N}]
set_property -dict {PACKAGE_PIN E1    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA09_P}]
# Bank 65 VCC_IO_B65 VCC_IO_B
set_property -dict {PACKAGE_PIN Y8    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA10_N}]
set_property -dict {PACKAGE_PIN W8    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA10_P}]
# Bank 66 VCC_IO_B66 VCC_IO_B
set_property -dict {PACKAGE_PIN F1    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA11_N}]
set_property -dict {PACKAGE_PIN G1    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA11_P}]
# Bank 26 VCC_IO_BE_BF VCC_IO_C ZU2/3
set_property -dict {PACKAGE_PIN D10   IOSTANDARD LVCMOS12  } [get_ports {FMC_HA12_N}]
set_property -dict {PACKAGE_PIN E10   IOSTANDARD LVCMOS12  } [get_ports {FMC_HA12_P}]
set_property -dict {PACKAGE_PIN F10   IOSTANDARD LVCMOS12  } [get_ports {FMC_HA13_N}]
set_property -dict {PACKAGE_PIN G11   IOSTANDARD LVCMOS12  } [get_ports {FMC_HA13_P}]
set_property -dict {PACKAGE_PIN A10   IOSTANDARD LVCMOS12  } [get_ports {FMC_HA14_N}]
set_property -dict {PACKAGE_PIN B11   IOSTANDARD LVCMOS12  } [get_ports {FMC_HA14_P}]
set_property -dict {PACKAGE_PIN A11   IOSTANDARD LVCMOS12  } [get_ports {FMC_HA15_N}]
set_property -dict {PACKAGE_PIN A12   IOSTANDARD LVCMOS12  } [get_ports {FMC_HA15_P}]
set_property -dict {PACKAGE_PIN C12   IOSTANDARD LVCMOS12  } [get_ports {FMC_HA16_N}]
set_property -dict {PACKAGE_PIN D12   IOSTANDARD LVCMOS12  } [get_ports {FMC_HA16_P}]
# Bank 65 VCC_IO_B65 VCC_IO_B
set_property -dict {PACKAGE_PIN N8    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA02_N}]
set_property -dict {PACKAGE_PIN N9    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA02_P}]
set_property -dict {PACKAGE_PIN N6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA03_N}]
set_property -dict {PACKAGE_PIN N7    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA03_P}]
set_property -dict {PACKAGE_PIN L8    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA04_N}]
set_property -dict {PACKAGE_PIN M8    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA04_P}]
set_property -dict {PACKAGE_PIN J9    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA05_N}]
set_property -dict {PACKAGE_PIN K9    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA05_P}]
set_property -dict {PACKAGE_PIN K7    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA06_N}]
set_property -dict {PACKAGE_PIN K8    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA06_P}]
set_property -dict {PACKAGE_PIN H8    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA07_N}]
set_property -dict {PACKAGE_PIN H9    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA07_P}]
set_property -dict {PACKAGE_PIN H7    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA08_N}]
set_property -dict {PACKAGE_PIN J7    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA08_P}]
set_property -dict {PACKAGE_PIN H6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA09_N}]
set_property -dict {PACKAGE_PIN J6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA09_P}]
set_property -dict {PACKAGE_PIN J4    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA10_N}]
set_property -dict {PACKAGE_PIN J5    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA10_P}]
set_property -dict {PACKAGE_PIN H3    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA11_N}]
set_property -dict {PACKAGE_PIN H4    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA11_P}]
set_property -dict {PACKAGE_PIN P6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA12_N}]
set_property -dict {PACKAGE_PIN P7    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA12_P}]
set_property -dict {PACKAGE_PIN J2    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA13_N}]
set_property -dict {PACKAGE_PIN K2    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA13_P}]
set_property -dict {PACKAGE_PIN H1    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA14_N}]
set_property -dict {PACKAGE_PIN J1    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA14_P}]
set_property -dict {PACKAGE_PIN K1    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA15_N}]
set_property -dict {PACKAGE_PIN L1    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA15_P}]
set_property -dict {PACKAGE_PIN T6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA16_N}]
set_property -dict {PACKAGE_PIN R6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA16_P}]
# Bank 66 VCC_IO_B66 VCC_IO_B
set_property -dict {PACKAGE_PIN F6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA19_N}]
set_property -dict {PACKAGE_PIN G6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA19_P}]
set_property -dict {PACKAGE_PIN F7    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA20_N}]
set_property -dict {PACKAGE_PIN G8    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA20_P}]
set_property -dict {PACKAGE_PIN E8    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA21_N}]
set_property -dict {PACKAGE_PIN F8    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA21_P}]
set_property -dict {PACKAGE_PIN D9    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA22_N}]
set_property -dict {PACKAGE_PIN E9    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA22_P}]
set_property -dict {PACKAGE_PIN B9    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA23_N}]
set_property -dict {PACKAGE_PIN C9    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA23_P}]
set_property -dict {PACKAGE_PIN B8    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA24_N}]
set_property -dict {PACKAGE_PIN C8    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA24_P}]
set_property -dict {PACKAGE_PIN A8    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA25_N}]
set_property -dict {PACKAGE_PIN A9    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA25_P}]
set_property -dict {PACKAGE_PIN A6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA26_N}]
set_property -dict {PACKAGE_PIN A7    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA26_P}]
set_property -dict {PACKAGE_PIN B6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA27_N}]
set_property -dict {PACKAGE_PIN C6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA27_P}]
set_property -dict {PACKAGE_PIN A5    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA28_N}]
set_property -dict {PACKAGE_PIN B5    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA28_P}]
set_property -dict {PACKAGE_PIN A4    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA29_N}]
set_property -dict {PACKAGE_PIN B4    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA29_P}]
set_property -dict {PACKAGE_PIN A3    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA30_N}]
set_property -dict {PACKAGE_PIN B3    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA30_P}]
set_property -dict {PACKAGE_PIN A1    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA31_N}]
set_property -dict {PACKAGE_PIN A2    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA31_P}]
set_property -dict {PACKAGE_PIN F5    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA32_N}]
set_property -dict {PACKAGE_PIN G5    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA32_P}]
set_property -dict {PACKAGE_PIN B1    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA33_N}]
set_property -dict {PACKAGE_PIN C1    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA33_P}]
# Bank 224
set_property -dict {PACKAGE_PIN U3    IOSTANDARD LVCMOS12  } [get_ports {FMC_DP1_C2M_N}]
set_property -dict {PACKAGE_PIN U4    IOSTANDARD LVCMOS12  } [get_ports {FMC_DP1_C2M_P}]
set_property -dict {PACKAGE_PIN V1    IOSTANDARD LVCMOS12  } [get_ports {FMC_DP1_M2C_N}]
set_property -dict {PACKAGE_PIN V2    IOSTANDARD LVCMOS12  } [get_ports {FMC_DP1_M2C_P}]
set_property -dict {PACKAGE_PIN R3    IOSTANDARD LVCMOS12  } [get_ports {FMC_DP2_C2M_N}]
set_property -dict {PACKAGE_PIN R4    IOSTANDARD LVCMOS12  } [get_ports {FMC_DP2_C2M_P}]
set_property -dict {PACKAGE_PIN T1    IOSTANDARD LVCMOS12  } [get_ports {FMC_DP2_M2C_N}]
set_property -dict {PACKAGE_PIN T2    IOSTANDARD LVCMOS12  } [get_ports {FMC_DP2_M2C_P}]
set_property -dict {PACKAGE_PIN N3    IOSTANDARD LVCMOS12  } [get_ports {FMC_DP3_C2M_N}]
set_property -dict {PACKAGE_PIN N4    IOSTANDARD LVCMOS12  } [get_ports {FMC_DP3_C2M_P}]
set_property -dict {PACKAGE_PIN P1    IOSTANDARD LVCMOS12  } [get_ports {FMC_DP3_M2C_N}]
set_property -dict {PACKAGE_PIN P2    IOSTANDARD LVCMOS12  } [get_ports {FMC_DP3_M2C_P}]
# Bank 26 VCC_IO_BE_BF VCC_IO_C ZU2/3
set_property -dict {PACKAGE_PIN C13   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP4_C2M_N}]
set_property -dict {PACKAGE_PIN C14   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP4_C2M_P}]
set_property -dict {PACKAGE_PIN G14   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP4_M2C_N}]
set_property -dict {PACKAGE_PIN G15   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP4_M2C_P}]
set_property -dict {PACKAGE_PIN A13   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP5_C2M_N}]
set_property -dict {PACKAGE_PIN B13   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP5_C2M_P}]
set_property -dict {PACKAGE_PIN H13   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP5_M2C_N}]
set_property -dict {PACKAGE_PIN H14   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP5_M2C_P}]
set_property -dict {PACKAGE_PIN A14   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP6_C2M_N}]
set_property -dict {PACKAGE_PIN B14   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP6_C2M_P}]
set_property -dict {PACKAGE_PIN J14   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP6_M2C_N}]
set_property -dict {PACKAGE_PIN K14   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP6_M2C_P}]
# Bank 25 VCC_IO_BE_BF VCC_IO_C ZU2/3
set_property -dict {PACKAGE_PIN F11   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP7_C2M_N}]
set_property -dict {PACKAGE_PIN F12   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP7_C2M_P}]
set_property -dict {PACKAGE_PIN D11   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP7_M2C_N}]
set_property -dict {PACKAGE_PIN E12   IOSTANDARD LVCMOS12  } [get_ports {FMC_DP7_M2C_P}]
# Bank 65 VCC_IO_B65 VCC_IO_B
set_property -dict {PACKAGE_PIN K3    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA00_CC_N}]
set_property -dict {PACKAGE_PIN K4    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA00_CC_P}]
# Bank 66 VCC_IO_B66 VCC_IO_B
set_property -dict {PACKAGE_PIN C4    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA01_CC_N}]
set_property -dict {PACKAGE_PIN D4    IOSTANDARD LVCMOS18  } [get_ports {FMC_HA01_CC_P}]
# Bank 64 VCC_IO_B64 VCC_IO_C
set_property -dict {PACKAGE_PIN AD1   IOSTANDARD LVCMOS12  } [get_ports {FMC_HA17_N}]
set_property -dict {PACKAGE_PIN AD2   IOSTANDARD LVCMOS12  } [get_ports {FMC_HA17_P}]
# Bank 65 VCC_IO_B65 VCC_IO_B
set_property -dict {PACKAGE_PIN L5    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA00_CC_N}]
set_property -dict {PACKAGE_PIN M6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA00_CC_P}]
set_property -dict {PACKAGE_PIN L6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA01_CC_N}]
set_property -dict {PACKAGE_PIN L7    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA01_CC_P}]
# Bank 66 VCC_IO_B66 VCC_IO_B
set_property -dict {PACKAGE_PIN D5    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA17_CC_N}]
set_property -dict {PACKAGE_PIN E5    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA17_CC_P}]
set_property -dict {PACKAGE_PIN D6    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA18_CC_N}]
set_property -dict {PACKAGE_PIN D7    IOSTANDARD LVCMOS18  } [get_ports {FMC_LA18_CC_P}]
# Bank 65 VCC_IO_B65 VCC_IO_B
set_property -dict {PACKAGE_PIN L2    IOSTANDARD LVCMOS18  } [get_ports {FMC_CLK0_M2C_N}]
set_property -dict {PACKAGE_PIN L3    IOSTANDARD LVCMOS18  } [get_ports {FMC_CLK0_M2C_P}]
# Bank 66 VCC_IO_B66 VCC_IO_B
set_property -dict {PACKAGE_PIN C2    IOSTANDARD LVCMOS18  } [get_ports {FMC_CLK1_M2C_N}]
set_property -dict {PACKAGE_PIN C3    IOSTANDARD LVCMOS18  } [get_ports {FMC_CLK1_M2C_P}]
# Bank 26 VCC_IO_BE_BF VCC_IO_C ZU2/3
set_property -dict {PACKAGE_PIN F13   IOSTANDARD LVCMOS12  } [get_ports {FMC_GCLK1_M2C_N}]
set_property -dict {PACKAGE_PIN G13   IOSTANDARD LVCMOS12  } [get_ports {FMC_GCLK1_M2C_P}]

# HDMI VCC_IO_A VCC_IO_C
# Bank 44 VCC_IO_BO VCC_IO_A ZU2/3
set_property -dict {PACKAGE_PIN AE10  IOSTANDARD LVCMOS18  } [get_ports {HDMI_HPD}]
# Bank 25 VCC_IO_BE_BF VCC_IO_C ZU2/3
set_property -dict {PACKAGE_PIN J10   IOSTANDARD LVCMOS12  } [get_ports {HDMI_D0_N}]
set_property -dict {PACKAGE_PIN J11   IOSTANDARD LVCMOS12  } [get_ports {HDMI_D0_P}]
set_property -dict {PACKAGE_PIN K12   IOSTANDARD LVCMOS12  } [get_ports {HDMI_D1_N}]
set_property -dict {PACKAGE_PIN K13   IOSTANDARD LVCMOS12  } [get_ports {HDMI_D1_P}]
set_property -dict {PACKAGE_PIN G10   IOSTANDARD LVCMOS12  } [get_ports {HDMI_D2_N}]
set_property -dict {PACKAGE_PIN H11   IOSTANDARD LVCMOS12  } [get_ports {HDMI_D2_P}]
# Bank 64 VCC_IO_B64 VCC_IO_C
set_property -dict {PACKAGE_PIN AG8   IOSTANDARD DIFF_SSTL12  } [get_ports {HDMI_CLK_N}]
set_property -dict {PACKAGE_PIN AF8   IOSTANDARD DIFF_SSTL12  } [get_ports {HDMI_CLK_P}]

# I2C FPGA
# Bank 44 VCC_IO_BO VCC_IO_A ZU2/3
set_property -dict {PACKAGE_PIN AG10  IOSTANDARD LVCMOS18  } [get_ports {I2C_SCL_FPGA}]
set_property -dict {PACKAGE_PIN AH10  IOSTANDARD LVCMOS18  } [get_ports {I2C_SDA_FPGA}]

# I2C_MIPI_SEL
# Bank 44 VCC_IO_BO VCC_IO_A ZU2/3
set_property -dict {PACKAGE_PIN AF10  IOSTANDARD LVCMOS18  } [get_ports {I2C_MIPI_SEL}]

# I2C PL
# Bank 66 VCC_IO_B66 VCC_IO_B
set_property -dict {PACKAGE_PIN C7    IOSTANDARD LVCMOS18  } [get_ports {I2C_SCL}]
set_property -dict {PACKAGE_PIN D2    IOSTANDARD LVCMOS18  } [get_ports {I2C_SDA}]

# IO3
# Bank 44 VCC_IO_BO VCC_IO_A ZU2/3
set_property -dict {PACKAGE_PIN AE12  IOSTANDARD LVCMOS18  } [get_ports {IO3_D0_P}]
set_property -dict {PACKAGE_PIN AF12  IOSTANDARD LVCMOS18  } [get_ports {IO3_D1_N}]
set_property -dict {PACKAGE_PIN AH12  IOSTANDARD LVCMOS18  } [get_ports {IO3_D2_P}]
set_property -dict {PACKAGE_PIN AH11  IOSTANDARD LVCMOS18  } [get_ports {IO3_D3_N}]
set_property -dict {PACKAGE_PIN AF11  IOSTANDARD LVCMOS18  } [get_ports {IO3_D4_P}]
set_property -dict {PACKAGE_PIN AG11  IOSTANDARD LVCMOS18  } [get_ports {IO3_D5_N}]
set_property -dict {PACKAGE_PIN AB10  IOSTANDARD LVCMOS18  } [get_ports {IO3_D6_P}]
set_property -dict {PACKAGE_PIN AB9   IOSTANDARD LVCMOS18  } [get_ports {IO3_D7_N}]

# IO4
# Bank 44 VCC_IO_BO VCC_IO_A ZU2/3
set_property -dict {PACKAGE_PIN Y9    IOSTANDARD LVCMOS18  } [get_ports {IO4_D2_P}]
set_property -dict {PACKAGE_PIN AA8   IOSTANDARD LVCMOS18  } [get_ports {IO4_D3_N}]
set_property -dict {PACKAGE_PIN W10   IOSTANDARD LVCMOS18  } [get_ports {IO4_D4_P}]
set_property -dict {PACKAGE_PIN Y10   IOSTANDARD LVCMOS18  } [get_ports {IO4_D5_N}]
set_property -dict {PACKAGE_PIN AC12  IOSTANDARD LVCMOS18  } [get_ports {IO4_D6_P}]
set_property -dict {PACKAGE_PIN AD12  IOSTANDARD LVCMOS18  } [get_ports {IO4_D7_N}]

# XU6 LED
# Bank 66 VCC_IO_B66 VCC_IO_B
set_property -dict {PACKAGE_PIN E7    IOSTANDARD LVCMOS18  } [get_ports {LED0_PL_N}]
# Bank 65 VCC_IO_B65 VCC_IO_B
set_property -dict {PACKAGE_PIN H2    IOSTANDARD LVCMOS18  } [get_ports {LED1_PL_N}]
set_property -dict {PACKAGE_PIN P9    IOSTANDARD LVCMOS18  } [get_ports {LED2_PL_N}]
set_property -dict {PACKAGE_PIN K5    IOSTANDARD LVCMOS18  } [get_ports {LED3_PL_N}]

# MIPI0
# Bank 64 VCC_IO_B64 VCC_IO_C
set_property -dict {PACKAGE_PIN AE8   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI0_D0_N}]
set_property -dict {PACKAGE_PIN AE9   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI0_D0_P}]
set_property -dict {PACKAGE_PIN AC8   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI0_D1_N}]
set_property -dict {PACKAGE_PIN AB8   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI0_D1_P}]
set_property -dict {PACKAGE_PIN AD9   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI0_CLK_D0LP_N}]
set_property -dict {PACKAGE_PIN AC9   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI0_CLK_D0LP_P}]
set_property -dict {PACKAGE_PIN AF6   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI0_CLK_N}]
set_property -dict {PACKAGE_PIN AF7   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI0_CLK_P}]

# MIPI1
# Bank 64 VCC_IO_B64 VCC_IO_C
set_property -dict {PACKAGE_PIN AC7   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI1_D0_N}]
set_property -dict {PACKAGE_PIN AB7   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI1_D0_P}]
set_property -dict {PACKAGE_PIN AC6   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI1_D1_N}]
set_property -dict {PACKAGE_PIN AB6   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI1_D1_P}]
set_property -dict {PACKAGE_PIN AE7   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI1_CLK_D0LP_N}]
set_property -dict {PACKAGE_PIN AD7   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI1_CLK_D0LP_P}]
set_property -dict {PACKAGE_PIN AF5   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI1_CLK_N}]
set_property -dict {PACKAGE_PIN AE5   IOSTANDARD MIPI_DPHY_DCI  } [get_ports {MIPI1_CLK_P}]

# Oscillator 100 MHz
# Bank 44 VCC_IO_BO VCC_IO_A ZU2/3
set_property -dict {PACKAGE_PIN AA10  IOSTANDARD LVCMOS18  } [get_ports {CLK_100_CAL}]

# SFP
# Bank 25 VCC_IO_BE_BF VCC_IO_C ZU2/3
set_property -dict {PACKAGE_PIN B10   IOSTANDARD LVCMOS12  } [get_ports {SFP_RX_N}]
set_property -dict {PACKAGE_PIN C11   IOSTANDARD LVCMOS12  } [get_ports {SFP_RX_P}]
set_property -dict {PACKAGE_PIN H12   IOSTANDARD LVCMOS12  } [get_ports {SFP_TX_N}]
set_property -dict {PACKAGE_PIN J12   IOSTANDARD LVCMOS12  } [get_ports {SFP_TX_P}]

# ST1 LED
# Bank 64 VCC_IO_B64 VCC_IO_C
set_property -dict {PACKAGE_PIN AG9   IOSTANDARD LVCMOS12  } [get_ports {LED2}]
set_property -dict {PACKAGE_PIN AH9   IOSTANDARD LVCMOS12  } [get_ports {LED3}]
