//////////////////////////////////////////////////////////////////////////////////
// Exercise #6 
// Student Name:
// Date: 
//
//
//  Description: In this exercise, you need to design a multiplexer between a dice and traffic 
//  lights, where the output acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | dice
//   1  | traffic lights
//
//  inputs:
//           rst, clk, button,sel
//
//  outputs:
//           result[2:0]
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module muxtd(
	input rst,
	input clk,
	input button,
	input sel,
	output [2:0] result
	);
	
	reg [2:0] RAG;
	wire red;
	wire amber;
	wire green;

	assign RAG[2] = red;
	assign RAG[1] = amber;
	assign RAG[0] = green;

	reg [2:0] throw;

	// Instantiate traffic module

	traffic toptraffic (
	.clk (clk),
	.red (red),
	.amber (amber),
	.green (green)
	);
	
	// Instantiate dice module
 	dice topdice (
	.clk (clk),		
	.rst (rst),
	.button (button),
	.throw (throw)
	);
	
	// Instantiate multiplex module
	// when select = 1, b chosen.. If select is 1, out = traffic /RAG
	mux topmux (
	.a (throw),
	.b (RAG),
	.sel (sel),
 	.out (result)
	);

endmodule
	
	


	



