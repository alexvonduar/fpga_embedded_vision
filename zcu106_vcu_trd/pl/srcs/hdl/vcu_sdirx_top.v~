// (c) Copyright 2017-18 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//------------------------------------------------------------------------------
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     
//  \   \         
//  /   /         
// /___/   /\     
// \   \  /  \
//  \___\/\___\
//
//------------------------------------------------------------------------------
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.

`timescale 1ns / 1ps

module vcu_sdirx_top (
//// System Clock 300MHz 
 //   input   wire        SYSCLK_300_P,
 //   input   wire        SYSCLK_300_N,
    
    input   wire        USER_MGT_SI570_CLOCK1_C_P,
    input   wire        USER_MGT_SI570_CLOCK1_C_N,
    
// Reset
 //   input   wire        CPU_RESET,
 
// MGTs
    output  wire        gttxp,
    output  wire        gttxn,
    input   wire        gtrxp,
    input   wire        gtrxn,
   


//// GPIO LED
    output  wire        GPIO_LED_0_LS,
    output  wire        GPIO_LED_1_LS,
    output  wire        GPIO_LED_2_LS,
    output  wire        GPIO_LED_3_LS,
    output  wire        GPIO_LED_4_LS,
    output  wire        GPIO_LED_5_LS,
    output  wire        GPIO_LED_6_LS,
    output  wire        GPIO_LED_7_LS
);

//------------------------------------------------------------------------------
// Internal signals definitions

// Global signals
wire        clk_27M_in;
wire        clk_27M;

wire [31:0]	fzetton_fmc_gpio;
wire [2:0]  fzetton_fmc_spi_ss;
wire        fmc_init_done;

//------------------------------------------------------------------------------
zugth_uhdsdi_demo uhdsdi_demo (

    .txp_o                (gttxp),
    .txn_o                (gttxn),
    .rxp_i                (gtrxp),
    .rxn_i                (gtrxn),
    
    //system basic
//	.SYS_CLK_clk_n            (SYSCLK_300_N),
//   .SYS_CLK_clk_p            (SYSCLK_300_P),
    .USER_MGT_SI570_CLOCK1_C_P(USER_MGT_SI570_CLOCK1_C_P),
    .USER_MGT_SI570_CLOCK1_C_N(USER_MGT_SI570_CLOCK1_C_N),
//   .ext_rst                  (CPU_RESET),
    
    
    .dcm_locked (GPIO_LED_0_LS),
    .gt_cmn_qpll0lock_o (GPIO_LED_1_LS),
    .gt_cmn_qpll1lock_o (GPIO_LED_2_LS),
    .gt_ch_cplllock0_o ( GPIO_LED_3_LS),
    .gt_rx_resetdone0_o (GPIO_LED_4_LS),
    .gt_tx_resetdone0_o (GPIO_LED_5_LS)
);

assign GPIO_LED_6_LS      = 1'b0;//fmc_init_done;
assign GPIO_LED_7_LS      = 1'b0;//~HDMI_SI5324_LOL;


endmodule
