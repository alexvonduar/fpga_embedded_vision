
`timescale 1 ns / 1 ps

	module reg_space_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 7,

		// Parameters of Axi Slave Bus Interface S01_AXI
		parameter integer C_S01_AXI_DATA_WIDTH	= 32,
		parameter integer C_S01_AXI_ADDR_WIDTH	= 7
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready,

		// Ports of Axi Slave Bus Interface S01_AXI
		input wire  s01_axi_aclk,
		input wire  s01_axi_aresetn,
		input wire [C_S01_AXI_ADDR_WIDTH-1 : 0] s01_axi_awaddr,
		input wire [2 : 0] s01_axi_awprot,
		input wire  s01_axi_awvalid,
		output wire  s01_axi_awready,
		input wire [C_S01_AXI_DATA_WIDTH-1 : 0] s01_axi_wdata,
		input wire [(C_S01_AXI_DATA_WIDTH/8)-1 : 0] s01_axi_wstrb,
		input wire  s01_axi_wvalid,
		output wire  s01_axi_wready,
		output wire [1 : 0] s01_axi_bresp,
		output wire  s01_axi_bvalid,
		input wire  s01_axi_bready,
		input wire [C_S01_AXI_ADDR_WIDTH-1 : 0] s01_axi_araddr,
		input wire [2 : 0] s01_axi_arprot,
		input wire  s01_axi_arvalid,
		output wire  s01_axi_arready,
		output wire [C_S01_AXI_DATA_WIDTH-1 : 0] s01_axi_rdata,
		output wire [1 : 0] s01_axi_rresp,
		output wire  s01_axi_rvalid,
		input wire  s01_axi_rready,
		input wire [15:0] Interrupt_ack_input,
	output wire [15:0] IRQ
	//output wire perst

	);
	
	wire [31:0] w[30:0];
	//wire [31:0] perst_int;
// Instantiation of Axi Bus Interface S00_AXI
	reg_space_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) reg_space_v1_0_S00_AXI_inst (
	
		.slv_reg0_output (w[0] ),
	    .slv_reg1_output (w[1] ),
	    .slv_reg2_output (w[2] ),
	    .slv_reg3_output (w[3] ),
	    .slv_reg4_output (w[4] ),
		.slv_reg5_output (w[5] ),
	    .slv_reg6_output (w[6] ),
	    .slv_reg7_output (w[7] ),
	    .slv_reg8_output (w[8] ),
	    .slv_reg9_output (w[9] ),
		.slv_reg10_output (w[10] ),
	    .slv_reg11_output (w[11] ),
	    .slv_reg12_output (w[12] ),
	    .slv_reg13_output (w[13] ),
	    .slv_reg14_output (w[14] ),
	    .slv_reg15_input (w[15] ),
	    .slv_reg16_input (w[16] ),
	    .slv_reg17_input (w[17] ),
	    .slv_reg18_input (w[18] ),
	    .slv_reg19_input (w[19] ),
	    .slv_reg20_input (w[20] ),
	    .slv_reg21_input (w[21] ),
	    .slv_reg22_input (w[22] ),
	    .slv_reg23_input (w[23] ),
	    .slv_reg24_input (w[24] ),
	    .slv_reg25_input (w[25] ),
	    .slv_reg26_input (w[26]),
	    .slv_reg27_input (w[27] ),
	    .slv_reg28_input (w[28] ),
	    .slv_reg29_input (32'b0 ),

		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

// Instantiation of Axi Bus Interface S01_AXI
	reg_space_v1_0_S01_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S01_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S01_AXI_ADDR_WIDTH)
	) reg_space_v1_0_S01_AXI_inst (
	
			.slv_reg0_output (w[15] ),
	    .slv_reg1_output (w[16] ),
	    .slv_reg2_output (w[17] ),
	    .slv_reg3_output (w[18] ),
	    .slv_reg4_output (w[19] ),
		.slv_reg5_output (w[20] ),
	    .slv_reg6_output (w[21] ),
	    .slv_reg7_output (w[22] ),
	    .slv_reg8_output (w[23] ),
	    .slv_reg9_output (w[24] ),
		.slv_reg10_output (w[25] ),
	    .slv_reg11_output (w[26] ),
	    .slv_reg12_output (w[27] ),
	    .slv_reg13_output (w[28] ),
	   // .slv_reg14_output (w[14] ),
	    .slv_reg15_input (w[0] ),
	    .slv_reg16_input (w[1] ),
	    .slv_reg17_input (w[2] ),
	    .slv_reg18_input (w[3] ),
	    .slv_reg19_input (w[4] ),
	    .slv_reg20_input (w[5] ),
	    .slv_reg21_input (w[6] ),
	    .slv_reg22_input (w[7] ),
	    .slv_reg23_input (w[8] ),
	    .slv_reg24_input (w[9] ),
	    .slv_reg25_input (w[10] ),
	    .slv_reg26_input (w[11]),
	    .slv_reg27_input (w[12] ),
	    .slv_reg28_input (w[13] ),
	    .slv_reg29_input (w[14] ),
		
		.Interrupt_ack_input(Interrupt_ack_input),
		.IRQ(IRQ),
		.S_AXI_ACLK(s01_axi_aclk),
		.S_AXI_ARESETN(s01_axi_aresetn),
		.S_AXI_AWADDR(s01_axi_awaddr),
		.S_AXI_AWPROT(s01_axi_awprot),
		.S_AXI_AWVALID(s01_axi_awvalid),
		.S_AXI_AWREADY(s01_axi_awready),
		.S_AXI_WDATA(s01_axi_wdata),
		.S_AXI_WSTRB(s01_axi_wstrb),
		.S_AXI_WVALID(s01_axi_wvalid),
		.S_AXI_WREADY(s01_axi_wready),
		.S_AXI_BRESP(s01_axi_bresp),
		.S_AXI_BVALID(s01_axi_bvalid),
		.S_AXI_BREADY(s01_axi_bready),
		.S_AXI_ARADDR(s01_axi_araddr),
		.S_AXI_ARPROT(s01_axi_arprot),
		.S_AXI_ARVALID(s01_axi_arvalid),
		.S_AXI_ARREADY(s01_axi_arready),
		.S_AXI_RDATA(s01_axi_rdata),
		.S_AXI_RRESP(s01_axi_rresp),
		.S_AXI_RVALID(s01_axi_rvalid),
		.S_AXI_RREADY(s01_axi_rready)
	);

	// Add user logic here
	//assign perst=perst_int[0];
	// User logic ends

	endmodule
