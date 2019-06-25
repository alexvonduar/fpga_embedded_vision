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

module compact_gt_ctrl 
(     
    input  wire  s_axi_aclk, 
    input  wire  s_axi_aresetn, 
    input  wire  fmc_init_done,  
    input  wire  SI5324_LOL,
	//to compact_gt
	input  wire [63:0] cmp_gt_sts,
	output wire [63:0] cmp_gt_ctrl,
	//to others
	output wire si5324_stable,
	output reg si5324_lol_db //after debounce
);

localparam SI5324_STABLE_DLY_MSB = 8;

reg qpll0reset;
reg qpll1reset;

reg  [11:0]	qpll0reset_cnt;
wire qpll0reset_cnt_tc;
reg  [11:0]	qpll1reset_cnt;
wire qpll1reset_cnt_tc;
reg qpll0reset_req;
reg qpll1reset_req;

reg si5324_stable_d1;
reg si5324_stable_d2;
reg si5324_stable_d3;
reg si5324_stable_d4;

reg fmc_init_done_d1;
reg fmc_init_done_d2;

reg [SI5324_STABLE_DLY_MSB:0] si5324_stable_dly = 0;  
reg  si5324_stable_int;

assign qpll0reset_cnt_tc = &qpll0reset_cnt;
assign qpll1reset_cnt_tc = &qpll1reset_cnt;

assign si5324_stable = si5324_stable_d2;

always @ (posedge s_axi_aclk) begin 
   qpll0reset <= 1'b0; 
   qpll1reset <= 1'b0;  
 
   if(qpll0reset_req == 1'b0) begin
      qpll0reset_cnt <= 0;
   end else begin
      qpll0reset_cnt <= qpll0reset_cnt + 1;  
   end
    if(qpll1reset_req == 1'b0) begin
        qpll1reset_cnt <= 0;
     end else begin
        qpll1reset_cnt <= qpll1reset_cnt + 1;  
     end
     
    if(qpll0reset_req & qpll0reset_cnt_tc) begin
       qpll0reset_req <= 1'b0;
       qpll0reset <= 1'b1; 
    end
    if(qpll1reset_req & qpll1reset_cnt_tc) begin
           qpll1reset_req <= 1'b0;
           qpll1reset <= 1'b1; 
    end
    /////////////////////////////////////qpll0 reset gen///////////////////////// 
    fmc_init_done_d1 <= fmc_init_done;
    fmc_init_done_d2 <= fmc_init_done_d1;
    //rising edge of fmc_init_done
    if(fmc_init_done_d1 == 1'b1 && fmc_init_done_d2 == 1'b0) begin
        qpll0reset_req <= 1'b1;                   
    end
    ///////////////////////////////qpll1reset gen///////////////////////////////
    //sync from 27mhz to 100mhz domain
     si5324_stable_d1 <= si5324_stable_int;
     si5324_stable_d2 <= si5324_stable_d1;
     si5324_stable_d3 <= si5324_stable_d2;
     si5324_stable_d4 <= si5324_stable_d3;   

	 si5324_lol_db <= ~si5324_stable_d2;
     
     //risign edge of stable trigger qpll1 reset,note qpll reset only one cycle pulse
     if(si5324_stable_d3 == 1'b1 && si5324_stable_d4 == 1'b0) begin
         qpll1reset_req <= 1'b1; 
     end

end

always @ (posedge s_axi_aclk) begin 
    if (SI5324_LOL == 1'b1) begin
        si5324_stable_dly <= 0;
        si5324_stable_int <= 0;
    end else begin
        if (~si5324_stable_int) begin
            si5324_stable_dly <= si5324_stable_dly + 1;
        end
        si5324_stable_int = si5324_stable_dly[SI5324_STABLE_DLY_MSB];
    end
end


assign cmp_gt_ctrl[0] = qpll0reset; //qpll0reset
assign cmp_gt_ctrl[1] = 1'b0; //qpll0pd 
assign cmp_gt_ctrl[2] = qpll1reset; //qpll1reset
assign cmp_gt_ctrl[3] = 1'b0; //qpll1pd 
assign cmp_gt_ctrl[6:4] = 3'b000; //qpll0refclksel; 
assign cmp_gt_ctrl[7] = 1'b0; //qpll0refclksel_valid; 
assign cmp_gt_ctrl[10:8] = 3'b000; //qpll1refclksel
assign cmp_gt_ctrl[11] = 1'b0; //qpll1refclksel_valid
assign cmp_gt_ctrl[12] = ~fmc_init_done; //cpllreset
assign cmp_gt_ctrl[13] = 1'b0; //cpllpd
assign cmp_gt_ctrl[14] = si5324_stable_d2; //txclk_ready
assign cmp_gt_ctrl[15] = fmc_init_done_d2; //rxclk_ready
assign cmp_gt_ctrl[18:16] = 3'b000; //cpll0 ref clk sel
assign cmp_gt_ctrl[19] = 1'b0; //cpllrefclksel0_valid
assign cmp_gt_ctrl[22:20] = 3'b000; //gt_loopback

endmodule

    
