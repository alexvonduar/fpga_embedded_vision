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

module zugth_uhdsdi_demo  
(     

    output  wire   txp_o,                // GTH TXP output
    output  wire   txn_o,                // GTH TXN output
    input   wire   rxp_i,                // GTH RXP input
    input   wire   rxn_i,                // GTH RXN input
	//system basic
    input SYS_CLK_clk_n,
    input SYS_CLK_clk_p,
    input ext_rst,
    input USER_MGT_SI570_CLOCK1_C_P,
    input USER_MGT_SI570_CLOCK1_C_N,

    output wire dcm_locked,    
    output wire gt_cmn_qpll0lock_o,
    output wire gt_cmn_qpll1lock_o,
    output wire gt_ch_cplllock0_o,
    output wire gt_tx_resetdone0_o,
    output wire gt_rx_resetdone0_o

);

//cmp_gt signals
wire [0:0] tx_usrclk;
wire [0:0] rx_usrclk;
wire [0:0] rxp;
wire [0:0] rxn;
wire [0:0] txp;
wire [0:0] txn;

wire [63:0] cmp_gt_sts;

wire qpll0lock;
wire qpll1lock;
wire cplllock  ;
wire tx_resetdone ;
wire tx_change_done ;
wire tx_fabric_rst ;

wire rx_resetdone ;
wire rx_mode_locked;
wire [2:0] rx_mode;
wire  rx_level_b;
wire rx_bit_rate ;
wire rx_change_done ;
wire rx_fabric_rst ;
wire rx_ce;


system_basic_wrapper i_system_basic (
	.SYS_CLK_clk_n(SYS_CLK_clk_n),
    .SYS_CLK_clk_p(SYS_CLK_clk_p),	
    .ext_rst(ext_rst),
	.txoutclk(tx_usrclk),
    .rxoutclk(rx_usrclk),
    //.GTREFCLK0_D_clk_p(FMC_HPC_GBTCLK0_M2C_C_P),
    //.GTREFCLK0_D_clk_n(FMC_HPC_GBTCLK0_M2C_C_N),
    //.GTREFCLK1_D_clk_p(FMC_HPC_GBTCLK1_M2C_C_P),
    //.GTREFCLK1_D_clk_n(FMC_HPC_GBTCLK1_M2C_C_N),
    .GTSOUTHREFCLK1_D_clk_p(USER_MGT_SI570_CLOCK1_C_P),
    .GTSOUTHREFCLK1_D_clk_n(USER_MGT_SI570_CLOCK1_C_N),
//	.si5324_lol(SI5324_LOL),
//	.fmc_init_done(1'b1/*fmc_init_done*/),  
	.rxp(rxp),
	.rxn(rxn),
	.txp(txp),
	.txn(txn),
    .dcm_locked (dcm_locked),
    .cmp_gt_sts (cmp_gt_sts)	
);

assign tx_usrclk_out = tx_usrclk;
assign rx_usrclk_out = rx_usrclk;

//cmp_gt output
assign txp_o = txp[0];
assign txn_o = txn[0];
assign rxp[0] = rxp_i;
assign rxn[0] = rxn_i;

//cmp_gt_sts
assign qpll0lock = cmp_gt_sts[0];
assign qpll1lock = cmp_gt_sts[1];
assign cplllock  = cmp_gt_sts[4];
assign tx_resetdone = cmp_gt_sts[5];
assign tx_change_done = cmp_gt_sts[6];
assign tx_fabric_rst = cmp_gt_sts[7];
assign rx_resetdone = cmp_gt_sts[8];
assign rx_change_done = cmp_gt_sts[9];
assign rx_fabric_rst = cmp_gt_sts[10];
assign rx_mode_locked = cmp_gt_sts[12];
assign rx_level_b = cmp_gt_sts[13];
assign rx_bit_rate = cmp_gt_sts[14];
assign rx_ce = cmp_gt_sts[15];
assign rx_mode = cmp_gt_sts[18:16];


assign gt_cmn_qpll0lock_o = qpll0lock;
assign gt_cmn_qpll1lock_o = qpll1lock;
assign gt_ch_cplllock0_o = cplllock;
assign gt_tx_resetdone0_o = tx_resetdone;
assign gt_rx_resetdone0_o = rx_resetdone;


endmodule

    
