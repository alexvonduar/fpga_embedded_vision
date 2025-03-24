`timescale 1ps/1ps

module iserdes_interface_zynq
(
    input                                 CLOCK,      // Reference clock for input delay control
    input                                 RESET,      // reset (active high)
    input                                 CLK200,     // optional 200MHz refclk
    input                                 HS_IN_CLK,
    input                                 HS_IN_CLKb, // LVDS clock input
    input       [NROF_CONN-1:0]           SDATAP,
    input       [NROF_CONN-1:0]           SDATAN,     // lvds data inputs
    output                                CLK_RDY,    // Dummy output for test
    output      [15:0]                    CLK_STATUS, // Dummy output for test
    output      [NROF_CONN-1:0]           EDGE_DETECT,
    output      [NROF_CONN-1:0]           TRAINING_DETECT,
    output      [NROF_CONN-1:0]           STABLE_DETECT,
    output      [NROF_CONN-1:0]           FIRST_EDGE_FOUND,
    output      [NROF_CONN-1:0]           SECOND_EDGE_FOUND,
    output      [NROF_CONN*16-1:0]        NROF_RETRIES,
    output      [NROF_CONN*10-1:0]        TAP_SETTING,
    output      [NROF_CONN*10-1:0]        WINDOW_WIDTH,
    output      [NROF_CONN-1:0]           WORD_ALIGN,
    output      [NROF_CONN-1:0]           TIMEOUTONACK, // Dummy output for test
    input                                 ALIGN_START,  // reset (active high)
    output                                ALIGN_BUSY,   // Dummy output for test
    output                                ALIGNED,      // Dummy output for test
    input                                 FIFO_EN,      // reset (active high)
    input                                 AUTOALIGN,    // reset (active high)
    input       [DATAWIDTH-1:0]           TRAINING,     // Dummy output for test
    input       [DATAWIDTH-1:0]           MANUAL_TAP,   // Dummy output for test
    input                                 FIFO_RDEN,    // reset (active high)
    output                                FIFO_EMPTY,   // Dummy output for test
    output      [NROF_CONN*DATAWIDTH-1:0] FIFO_DATAOUT  // Dummy output for test
);

    // Parameters

    parameter integer         SIMULATION = 0;           // Set the number of inputs to be 16 in this example
    parameter integer         NROF_CONN = 16;           // Set the number of inputs to be 16 in this example
    parameter integer         DATAWIDTH = 10;           // Set the serdes factor to be 6 in this example
    parameter integer         RETRY_MAX = 32767;        // Set the serdes factor to be 6 in this example
    parameter integer         STABLE_COUNT = 16;        // Set the serdes factor to be 6 in this example
    parameter integer         TAP_COUNT_MAX = 64;       // Set the serdes factor to be 6 in this example
    parameter                 DATA_RATE = "DDR";        // Set the ser
    parameter                 DIFF_TERM = "TRUE";         // Set the serdes factor to be 6 in this example
    parameter                 USE_FIFO = "TRUE";         // Set the serdes factor to be 6 in this example
    parameter                 USE_BLOCKRAMFIFO = "TRUE";  // Set the serdes factor to be 6 in this example
    parameter                 INVERT_OUTPUT = "FALSE";    // Set the serdes factor to be 6 in this example
    parameter                 INVERSE_BITORDER = "FALSE"; // Set the serdes factor to be 6 in this example
    parameter integer         CLKSPEED = 50;            // Set the serdes factor to be 6 in this example
    parameter                 C_FAMILY = "zynq";        // Set the serdes factor to be 6 in this example
    parameter                 USE_OUTPLL = "TRUE";        // Set the serdes factor to be 6 in this example
    parameter                 USE_INPLL = "TRUE";         // Set the serdes factor to be 6 in this example

wire refclkint;
wire refclkintbufg;
wire delay_ready;
//wire rx_lckd;
wire rx_system_clk;
wire [NROF_CONN-1:0] bitslip;
reg  [3:0] bcount;
wire [DATAWIDTH*NROF_CONN-1:0] rxd;
wire [NROF_CONN-1:0] ALIGN_BUSY_d;
wire [NROF_CONN-1:0] ALIGNED_d;
wire [NROF_CONN * 16 - 1 : 0] DI, DO;
wire [NROF_CONN-1:0] FIFO_EMPTY_d;
wire [NROF_CONN-1:0] FIFO_FULL_d;
wire  [NROF_CONN-1:0] FIFO_RST;

// 200 or 300 Mhz Reference Clock Input, 300 MHz receomended for bit rates > 1 Gbps

IBUF iob_200m_in(
    .I (CLK200),
    .O (refclkint));

BUFG bufg_200_ref (
    .I (refclkint),
    .O (refclkintbufg));

IDELAYCTRL icontrol (                              // Instantiate input delay control block
    .REFCLK (refclkintbufg),
    .RST    (RESET),
    .RDY    (delay_ready));

generate
// generate the serdes_1_to_468_idelay_ddr module according to DATAWIDTH
if (DATAWIDTH <= 8) begin
    /*
    serdes_1_to_468_idelay_ddr #(
        .S            (DATAWIDTH),                // Set the serdes factor (4, 6 or 8)
        .HIGH_PERFORMANCE_MODE     ("TRUE"),
        .D            (NROF_CONN),                // Number of data lines
        .REF_FREQ        (200.0),            // Set idelay control reference frequency, 300 MHz shown
        .CLKIN_PERIOD        (1.666),            // Set input clock period, 600 MHz shown
        .DATA_FORMAT         ("PER_CHANL"))          // PER_CLOCK or PER_CHANL data formatting
    rx0 (
        .clkin_p           (HS_IN_CLK),
        .clkin_n           (HS_IN_CLKb),
        .datain_p             (SDATAP),
        .datain_n             (SDATAN),
        .enable_phase_detector    (1'b1),                // enable phase detector (active alignment) operation
        .enable_monitor        (1'b0),                // enables data eye monitoring
        .dcd_correct        (1'b0),                // enables clock duty cycle correction
        .rxclk            (),
        .idelay_rdy        (delay_ready),
        .system_clk        (rx_system_clk),
        .reset             (RESET),
        .rx_lckd        (CLK_RDY),
        .bitslip          (bitslip),
        .rx_data        (rxd),
        .bit_rate_value        (16'h0720),            // required bit rate value in BCD (1200 Mbps shown)
        .bit_time_value        (),                // bit time value
        .eye_info        (),                // data eye monitor per line
        .m_delay_1hot        (),                // sample point monitor per line
        .debug            ()
    );
    */
end
if (DATAWIDTH == 10) begin
    serdes_1_to_10_idelay_ddr #(
        .HIGH_PERFORMANCE_MODE     ("TRUE"),
        .D            (NROF_CONN),                // Number of data lines
        .REF_FREQ        (200.0),            // Set idelay control reference frequency, 300 MHz shown
        .CLKIN_PERIOD        (1.666),            // Set input clock period, 600 MHz shown
        .DATA_FORMAT         ("PER_CHANL"))          // PER_CLOCK or PER_CHANL data formatting
    rx0 (
        .clkin_p           (HS_IN_CLK),
        .clkin_n           (HS_IN_CLKb),
        .datain_p             (SDATAP),
        .datain_n             (SDATAN),
        .enable_phase_detector    (1'b1),                // enable phase detector (active alignment) operation
        .enable_monitor        (1'b0),                // enables data eye monitoring
        .dcd_correct        (1'b0),                // enables clock duty cycle correction
        .rxclk            (),
        .idelay_rdy        (delay_ready),
        .system_clk        (rx_system_clk),
        .reset             (RESET),
        .rx_lckd        (CLK_RDY),
        .bitslip          (bitslip),
        .rx_data        (rxd),
        .bit_rate_value        (16'h0720),            // required bit rate value in BCD (1200 Mbps shown)
        .bit_time_value        (),                // bit time value
        .eye_info        (),                // data eye monitor per line
        .m_delay_1hot        (),                // sample point monitor per line
        .debug            ()
    );
end
endgenerate

genvar i;
generate
for (i = 0; i < NROF_CONN; i = i + 1) begin
    bit_align #(
        .DATAWIDTH (DATAWIDTH)
    ) bit_align_inst (
        .CLOCK (rx_system_clk),
        .RESET (RESET),
        .ALIGN_START (ALIGN_START),
        .DATA (rxd[i*DATAWIDTH + DATAWIDTH - 1: DATAWIDTH * i]),
        .ALIGN_BUSY (ALIGN_BUSY_d[i]),
        .ALIGNED (ALIGNED_d[i]),
        .FIFO_RST (FIFO_RST[i]),
        .TRAINING (TRAINING),
        .BITSLIP (bitslip[i])
    );
end
assign CLK_STATUS[NROF_CONN:1] = bitslip;
endgenerate
assign CLK_STATUS[0] = rx_system_clk;

assign ALIGN_BUSY = &ALIGN_BUSY_d;
assign ALIGNED = &ALIGNED_d;
assign EDGE_DETECT = FIFO_EMPTY_d;
assign TRAINING_DETECT = FIFO_FULL_d;
assign STABLE_DETECT[0] = FIFO_RDEN;

generate
    for (i = 0; i < NROF_CONN; i = i + 1) begin
        //DI[16 * i + 15 : 16 * i + DATAWIDTH] <= (others => '0');
        //DI(15 downto DATAWIDTH) <= (others => '0');
        //assign DI[16 * i + DATAWIDTH - 1 : 16 * i] = rxd[DATAWIDTH * i + DATAWIDTH - 1 : DATAWIDTH * i];
        //assign FIFO_DATAOUT[DATAWIDTH * i + DATAWIDTH - 1 : DATAWIDTH * i] = DO[16 * i + DATAWIDTH - 1 : 16 * i];
        assign NROF_RETRIES[16 * i + DATAWIDTH - 1 : 16 * i] = rxd[DATAWIDTH * i + DATAWIDTH - 1 : DATAWIDTH * i];

        FIFO_DUALCLOCK_MACRO 
        #(
            .ALMOST_EMPTY_OFFSET(9'h080), // Sets the almost empty threshold
            .ALMOST_FULL_OFFSET(9'h080),  // Sets almost full threshold   
            .DATA_WIDTH(DATAWIDTH),   // Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")   
            .DEVICE("7SERIES"),  // Target device: "7SERIES"   
            .FIFO_SIZE ("18Kb"), // Target BRAM: "18Kb" or "36Kb"   
            .FIRST_WORD_FALL_THROUGH ("FALSE") // Sets the FIFO FWFT to "TRUE" or "FALSE"
        ) FIFO_DUALCLOCK_MACRO_inst
        (
            .ALMOSTEMPTY(), // 1-bit output almost empty
            .ALMOSTFULL(),   // 1-bit output almost full   
            .DO(FIFO_DATAOUT[DATAWIDTH * i + DATAWIDTH - 1 : DATAWIDTH * i]),                   // Output data, width defined by DATA_WIDTH parameter   
            .EMPTY(FIFO_EMPTY_d[i]),             // 1-bit output empty   
            .FULL(FIFO_FULL_d[i]),               // 1-bit output full   
            .RDCOUNT(),         // Output read count, width determined by FIFO depth   
            .RDERR(),             // 1-bit output read error   
            .WRCOUNT(),         // Output write count, width determined by FIFO depth   
            .WRERR(),             // 1-bit output write error   
            .DI(rxd[DATAWIDTH * i + DATAWIDTH - 1 : DATAWIDTH * i]),                   // Input data, width defined by DATA_WIDTH parameter   
            .RDCLK(CLOCK),             // 1-bit input read clock   
            .RDEN(FIFO_RDEN),               // 1-bit input read enable   
            .RST(FIFO_RST[i]),                 // 1-bit input reset   
            .WRCLK(rx_system_clk),             // 1-bit input write clock   
            .WREN(FIFO_EN)                // 1-bit input write enable
        );
    end
endgenerate

assign FIFO_EMPTY = &FIFO_EMPTY_d;

endmodule


module bit_align
(
    input                                 CLOCK,      // Reference clock for input delay control
    input                                 RESET,      // reset (active high)
    input                                 ALIGN_START,  // reset (active high)
    input [DATAWIDTH-1:0]                 DATA,         // Dummy output for test
    output reg                            ALIGN_BUSY,   // Dummy output for test
    output reg                            ALIGNED,      // Dummy output for test
    //input                                 AUTOALIGN,    // reset (active high)
    output reg                            FIFO_RST,
    input       [DATAWIDTH-1:0]           TRAINING,     // Dummy output for test
    output  reg                           BITSLIP
);

    // Parameters
    parameter DATAWIDTH = 10;

// a state machine triggered by ALIGN_START
// Idle: wait for ALIGN_START
// Aligning: compare DATA with TRAINING

reg [1:0] state;
reg [3:0] bcount;

always @(posedge CLOCK or posedge RESET)
begin
    if (RESET) begin
        state <= 2'b00;
        BITSLIP <= 1'b0;
        ALIGN_BUSY <= 1'b0;
        ALIGNED <= 1'b0;
        bcount <= 4'h0;
        FIFO_RST <= 1'b1;
    end
    else begin
        case (state)
            2'b00: begin
                if (ALIGN_START) begin
                    state <= 2'b01;
                    ALIGN_BUSY <= 1'b1;
                    ALIGNED <= 1'b0;
                    BITSLIP <= 1'b0;
                    bcount <= 4'h0;
                    FIFO_RST <= 1'b1;
                end
            end
            2'b01: begin
                bcount <= bcount + 4'h1;
                if ((DATA != TRAINING) && (bcount == 4'hF)) begin
                    BITSLIP <= 1'b1;
                end
                else begin
                    BITSLIP <= 1'b0;
                end
                if (DATA == TRAINING) begin
                    state <= 2'b10;
                end
                else begin
                    state <= 2'b01;
                end
                ALIGN_BUSY <= 1'b1;
                ALIGNED <= 1'b0;
                FIFO_RST <= 1'b1;
            end
            2'b10: begin
                if (ALIGN_START) begin
                    state <= 2'b01;
                    ALIGN_BUSY <= 1'b1;
                    ALIGNED <= 1'b0;
                    BITSLIP <= 1'b0;
                    bcount <= 4'h0;
                    FIFO_RST <= 1'b1;
                end
                else begin
                    state <= 2'b10;
                    ALIGN_BUSY <= 1'b0;
                    ALIGNED <= 1'b1;
                    BITSLIP <= 1'b0;
                    bcount <= 4'h0;
                    FIFO_RST <= 1'b0;
                end
            end
            default: begin
                state <= 2'b00;
                ALIGN_BUSY <= 1'b0;
                ALIGNED <= 1'b0;
                BITSLIP <= 1'b0;
                bcount <= 4'h0;
                FIFO_RST <= 1'b1;
            end
        endcase
    end
end


endmodule