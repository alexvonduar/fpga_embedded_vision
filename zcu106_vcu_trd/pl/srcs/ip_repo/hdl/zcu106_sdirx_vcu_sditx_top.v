
`timescale 1ns / 1ps

module zcu106_sdirx_vcu_sditx_top (
//// System Clock 300MHz 
    input   wire        SYSCLK_300_P,
    input   wire        SYSCLK_300_N,
    
    input   wire        USER_MGT_SI570_CLOCK1_C_P,
    input   wire        USER_MGT_SI570_CLOCK1_C_N,
    
// Reset
    input   wire        CPU_RESET,
 
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
	.SYS_CLK_clk_n            (SYSCLK_300_N),
    .SYS_CLK_clk_p            (SYSCLK_300_P),
    .USER_MGT_SI570_CLOCK1_C_P(USER_MGT_SI570_CLOCK1_C_P),
    .USER_MGT_SI570_CLOCK1_C_N(USER_MGT_SI570_CLOCK1_C_N),
    .ext_rst                  (CPU_RESET),
    
    
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
