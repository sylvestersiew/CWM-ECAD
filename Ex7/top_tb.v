//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Times Table
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex7 - Times Table
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
	);
    
	//Todo: Parameters
	parameter CLK_PERIOD = 10;

	//Todo: Regitsers and wires
	reg clk;
	reg err;
	reg [2:0] a;	
	reg [2:0] b;
	reg read;
	wire [5:0] result;
	reg [2:0] a_prev;	
	reg [2:0] b_prev;
	reg [5:0] result_prev;
	
	//Decide how enable will be tested	
	initial begin
		read=1;
		#381 // If put at 140, test will be for read=0 instead of the results on read=1 at clock #135 instance
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
		err=0;
		#10 //TO ALLOW CURRENT RESULT FROM A_PREV AND B_PREV TO BE REGISTERED
		forever begin
			
			#CLK_PERIOD
			// RAM HAS A LATENCY OF 2 CLOCK CYCLE // ONE CLOCK PERIOD. THUS, COMPARE PREVIOUS A AND B TO CURRENT RESULT
			if ((read) && a_prev*b_prev!=result)
				begin
					$display("***TEST FAILED!,wrong calculation***");
					err=1;
				end
			
			// WHEN READ IS LOW, AT 381, RESULT TO BE CLOCKED AT 375, DELAYED TO 385 WILL NOT BE CLOCKED TOO
			else if (!read && result_prev!=result)
				begin
					$display("***TEST FAILED!,read issue***");
					err=1;
				end

			result_prev = result;	
			a_prev=a;
			b_prev=b;
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
	.a (a),
	.b (b),
	.read (read),
	.result (result)
	);
	
endmodule 
