//////////////////////////////////////////////////////////////////////////////////
// Exercise #8
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to implement a times table of 0..7x0..7
//  using a memory and AXI-4-lite interface.
//
//  inputs:
//           clk, rst, a[2:0], b[2:0], read
//
//  outputs:
//           result[5:0]
//////////////////////////////////////////////////////////////////////////////////

module timestable(
	input clk,
	input rst,
	input [2:0] a,
	input [2:0] b,	
	input read,
	output [5:0] result
	);

	wire [5:0] ab;
	
	// Unused Outputs
	wire s_axi_rresp;
	wire s_axi_rvalid;
	wire rsta_busy;
	wire rstb_busy;
	wire s_axi_awready;
	wire s_axi_wready;
	wire s_axi_bresp;
	wire s_axi_bvalid;
	wire s_axi_arready;

	assign ab = {a[2:0],b[2:0]};

	blk_mem_gen_AXI4 your_instance_name (
	  // Safety Circuit not required
	  .rsta_busy(rsta_busy),          // output wire rsta_busy
	  .rstb_busy(rstb_busy),          // output wire rstb_busy
	  // Global Clock and Reset
	  .s_aclk(clk),                // input wire s_aclk
	  .s_aresetn(rst),          // input wire s_aresetn
	  // Write I/O unused
	  .s_axi_awaddr(0),    // input wire [31 : 0] s_axi_awaddr
	  .s_axi_awvalid(0),  // input wire s_axi_awvalid
	  .s_axi_awready(s_axi_awready),  // output wire s_axi_awready
	  .s_axi_wdata(0),      // input wire [31 : 0] s_axi_wdata
	  .s_axi_wstrb(0),      // input wire [3 : 0] s_axi_wstrb
	  .s_axi_wvalid(0),    // input wire s_axi_wvalid
	  .s_axi_wready(s_axi_wready),    // output wire s_axi_wready
	  .s_axi_bresp(s_axi_bresp),      // output wire [1 : 0] s_axi_bresp
	  .s_axi_bvalid(s_axi_bvalid),    // output wire s_axi_bvalid
	  .s_axi_bready(0),    // input wire s_axi_bready
	  // Read Address
	  .s_axi_araddr(ab),    // input wire [31 : 0] s_axi_araddr
	  // When High address is valid
	  .s_axi_arvalid(read),  // input wire s_axi_arvalid
	  // Readiness of slave to receive above address is irrelevant as we will see from output
	  .s_axi_arready(s_axi_arready),  // output wire s_axi_arready
	  // Output (read) data
	  .s_axi_rdata(result),      // output wire [31 : 0] s_axi_rdata
	  // Not-needed Output as ID not used
	  .s_axi_rresp(s_axi_rresp),      // output wire [1 : 0] s_axi_rresp
	  // Readiness to send to Master is irrelevant as we will see from output
	  .s_axi_rvalid(s_axi_rvalid),    // output wire s_axi_rvalid
	  // Master ready to receive if ENABLED
  	  .s_axi_rready(read)    // input wire s_axi_rready
	);

endmodule
