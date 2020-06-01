//////////////////////////////////////////////////////////////////////////////////
// Exercise #2 
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a multiplexer, where the  
//  output acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | a
//   1  | b
//
//  inputs:
//           a, b, sel
//
//  outputs:
//           out
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module mux(
    input a,
    input b,
    input sel,
    output out
    );
    
    wire out;
    
    assign out = sel?b:a;
    
    //t=0
	//assign out = (t==0 && sel)?b:
		//(t==0)?a:
		//(t==5)?0:
		//(t!=0)?t+1;

    //Todo: define your logic here                 
      
endmodule
