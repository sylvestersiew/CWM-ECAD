//////////////////////////////////////////////////////////////////////////////////
// Exercise #7
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to implement a times table of 0..7x0..7
//  using a memory.
//
//  inputs:
//           clk, a[2:0], b[2:0], read
//
//  outputs:
//           result[4:0]
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module timestable(
	input clk,
	input [2:0] a,
	input [2:0] b,	
	input read,
	output [5:0] result
	);

	wire [5:0] ab;
	assign ab = {a[2:0],b[2:0]};

	mybram_timestable your_instance_name (
	.clka(clk),
	.ena(read),      
	.addra(ab),  // input wire [5 : 0] addra
	.douta(result)  // output wire [5 : 0] douta
	);

endmodule

