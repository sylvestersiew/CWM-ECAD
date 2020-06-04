//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8 - Times Table using AXI interface
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex8 - Times Table using AXI4-Lite
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
	);
    
	//Todo: Parameters
	parameter CLK_PERIOD = 10;

	//Todo: Regitsers and wires
	reg clk;
	reg rst;
	reg err;
	reg [2:0] a;	
	reg [2:0] b;
	reg read;
	reg result_prev;
	wire [5:0] result;
	
	//Decide how enable will be tested	
	initial begin
		read=1;
		#391 // If put at 140, test will be for read=0 instead of the results on read=1 at clock #135 instance
		read=0;
	end
	
	//Todo: Clock generation
	initial	begin
  		clk = 1'b0;
  		forever
  			#(CLK_PERIOD/2) clk=~clk;
  	end

	//Todo: User logic
	initial begin
		a=0;
		b=0;
		rst = 0;
		err=0;
		result_prev=0;
		forever begin
			
			#CLK_PERIOD
			if (read && a*b!=result)
				begin
					$display("***TEST FAILED!,wrong calculation***");
					err=1;
				end

			else if (!read && result_prev!=result)
				begin
					$display("***TEST FAILED!,read issue***");
					err=1;
				end
			result_prev = result;	
			a = a+1;
			if (a==0)
				b = b+1;
		end
	end
	
	//Todo: Finish test, check for success
	initial begin
	// 7 ticks, time to complete one of seven of testing
        	#400
        	if (err==0)
          		$display("***TEST PASSED! :) ***");
		$finish;
	end

	//Todo: Instantiate traffic module
	timestable top (
	.clk (clk),
	.rst (rst),
	.a (a),
	.b (b),
	.read (read),
	.result (result)
	);
	
endmodule 
