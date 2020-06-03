//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - Dice or Traffic Lights?
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex6 - Dice or Traffic Lights?
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
	    
	//Parameters
	parameter CLK_PERIOD = 10;

	//Registers and wires
	reg clk;
	reg sel;
	reg rst;
	reg button;
	reg [2:0] result_prev;
	wire [2:0] result;
	reg err;
    
	//Clock generation
	initial begin
		clk = 1'b0;
			forever
	 			#(CLK_PERIOD/2) clk=~clk;
	end
	
	//Decide how select will be tested (split testing into traffic(1) and dice)	
	initial begin
		sel=1;	
		rst=1;
		// traffic requires 5 clk period to complete
		#50
		sel = 0;
		#10
		rst = 0;
		#50
		rst = 1;
		#10
		rst = 0;
	end
		
	//Stimulus logic
	initial begin
		
		result=0;
		result_prev=ab;
		err=0;
		

		forever begin
			#CLK_PERIOD

			// testbench for traffic/RAG
			if (sel)
			begin
			
			
			
				if ((result_prev==3'b000||result_prev==3'b101||result_prev==3'b111||result_prev==3'b011) && (result==3'b000||result==3'b101||result==3'b111|result==3'b011))
					begin
						$display("***Traffic TEST FAILED!,unable to self start***");
						err=1;
					end
				else if ((result_prev==3'b100) && (result!=3'b110))
					begin
						$display("***TrafficTEST FAILED!,100->110 issue***");
						err=1;
					end
				else if ((result_prev==3'b110) && (result!=3'b001))
					begin
						$display("***Traffic TEST FAILED!,110->001 issue***");
						err=1;
					end	
				else if ((result_prev==3'b001) && (result!=3'b010))
					begin
						$display("***TEST FAILED!,001->010 issue***");
						err=1;
					end	
		 		else if ((result_prev==3'b010) && (result!=3'b001))
					begin
						$display("***Traffic TEST FAILED!,001->010 issue***");
						err=1;
					end
			
			
			
			end
			

				// testbench for dice
				if (sel)
				begin
					
					
				if (rst)
				begin
					if (result!=3'b000)
					begin
						$display("***Dice TEST FAILED!,Reset issue***");
						err=1;
					end
				end
				else if (result_prev==3'b000||result_prev==3'b111)
				begin
					if (result!= 3'b001)
					begin
						$display("***Dice TEST FAILED!,000 and 111 issue***");
						err=1;
					end
				end
				    
				else if (!button)
					begin
					if (result!=result_prev)
					begin
						$display("***Dice TEST FAILED!,001 to 110 button 0 issue***");
						err=1;
					end
				end

				else if (result_prev==3'b110)
				begin
					if (result!=3'b001)
					begin
						$display("***Dice TEST FAILED!,110 button 1 issue***");
						err=1;
					end
				end
				else if (result!=(result_prev+1))
				begin
					$display("***Dice TEST FAILED!,001 to 101 button 1 issue***");
					err=1;
				end
				


			end
			result_prev = result;
		    	button = button+1;
		end
	end

	//Finish simulation and check for success
	initial begin
		// 5 periods for traffic, 22 for dice
		#270
		if (err==0)
			$display("***TEST PASSED! :) ***");
		$finish;
	end

	//Todo: Instantiate Multiplex of Traffic or Dice module
 	muxtd top (
	.rst (rst),
	.clk (clk),		
	.button (button),
	.sel (sel),
	.result (result)
	);

endmodule
