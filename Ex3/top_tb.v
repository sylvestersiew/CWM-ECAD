//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Up/Down counter
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex3 - counter
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
	//Todo: Parameters
	parameter CLK_PERIOD = 10;

	//Todo: Regitsers and wires
	reg clk;
    reg rst;
	reg enable;
	reg direction;
	reg err;
	wire [7:0] counter_out;

	//Todo: Clock generation
	initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

	//Todo: User logic
	initial begin
		rst=1'b0; // start with reset so can check from there
		enable=0;
		direction=0;
    	err=0;
		forever begin
			#CLK_PERIOD
			// No reset, With enable, Still at Zero // positive direction give 11111111 and vice versa
			
        	if (rst&(counter_out!=8'b00000000))
			begin
				$display("***TEST FAILED!,Reset issue***");
				err=1;
         	end
         	
         	if (!rst & enable & counter_out==8'b00000000)
			begin
				$display("***TEST FAILED!,Enable issue***");
				err=1;
			end	
				
			if ((!rst & enable & direction & counter_out!=8'b00000001)|(!rst & enable & !direction & counter_out!=8'b11111111))
			begin
				$display("***TEST FAILED!,Direction issue***");
				err=1;
         		end // 1-100
         	
		    rst=rst+1;  //2-000 4-010 6-001 8-011
		    if (rst==1)  
		    	enable=~enable; // 3-110 7-111
		    	if (enable==0)
		    		direction=~direction; // 5 101 9-100
		end
	end
	//Todo: Finish test, check for success
	initial begin
		// 8 different permutations to test
        #100 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end

	//Todo: Instantiate counter module
 	counter top (
	.clk (clk),		
	.rst (rst),
	.enable (enable),
	.direction (direction),
	.counter_out (counter_out)
	);

endmodule 
