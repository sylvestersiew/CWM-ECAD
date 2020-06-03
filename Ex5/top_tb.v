//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Traffic Lights
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex5 - Traffic Lights
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
	reg [2:0] RAG_before;	
	wire [2:0] RAG;
	wire red;
	wire amber;
	wire green;

	assign RAG[2] = red;
	assign RAG[1] = amber;
	assign RAG[0] = green;

	//Todo: Clock generation
	initial	begin
  		clk = 1'b0;
  		forever
  			#(CLK_PERIOD/2) clk=~clk;
  	end

	//Todo: User logic
	initial begin
		
		err=0;
		RAG_before=3'b000;
    	
		forever begin
			
			#CLK_PERIOD
			
			if ((RAG_before==3'b000||RAG_before==3'b101||RAG_before==3'b111||RAG_before==3'b011) && (RAG==3'b000||RAG==3'b101||RAG==3'b111|RAG==3'b011))
				begin
					$display("***TEST FAILED!,unable to self start***");
					err=1;
				end
			
			else if ((RAG_before==3'b100) && (RAG!=3'b110))
				begin
					$display("***TEST FAILED!,100->110 issue***");
					err=1;
				end

			else if ((RAG_before==3'b110) && (RAG!=3'b001))
				begin
					$display("***TEST FAILED!,110->001 issue***");
					err=1;
				end	

			else if ((RAG_before==3'b001) && (RAG!=3'b010))
				begin
					$display("***TEST FAILED!,001->010 issue***");
					err=1;
				end	
			
         		else if ((RAG_before==3'b010) && (RAG!=3'b001))
				begin
					$display("***TEST FAILED!,001->010 issue***");
					err=1;
				end

			// at end, RAG b4 = new value becomes old value
			RAG_before = RAG;

		end
	end
	
	//Todo: Finish test, check for success
	initial begin
	// 40s, time to complete one loop of testing
        	#50
        	if (err==0)
          		$display("***TEST PASSED! :) ***");
		$finish;
	end

	//Todo: Instantiate traffic module
	traffic top (
	.clk (clk),
	.red (red),
	.amber (amber),
	.green (green)
	);

endmodule 
