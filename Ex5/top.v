//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to implement a UK traffic lights 
//  sequencing system. 
//
//  inputs:
//           clk
//
//  outputs:
//           red, amber, green
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module traffic(
	input clk,
    output red,
	output amber,
	output green,
    );
	
	reg [3:0] RAG;
	
	assign red = RAG[2]
	assign amber = RAG[1]
	assign green = RAG[0]
	
	always@(posedge clk or posedge rst)
		if(RAG==3'b000|RAG==3'b101|RAG==3'b111|RAG==3'b011) 
			RAG <= 3'b100;
		else if (RAG==3'b100)
			RAG <= 3'b110;
		else if (RAG==3'b110)
			RAG <= 3'b001;
		else if (RAG==3'b001)
			RAG <= 3'b010;
		else if (RAG==3'b001)
			RAG <= 3'b010;
		
endmodule
	
