//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Electronic Dice
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex4 - Electronic Dice
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
	reg button;
	reg err;
	reg [2:0] throw_before;
	wire [2:0] throw;

	//Todo: Clock generation
	initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

	//Todo: User logic
	initial begin
		rst=0; // start with no reset so can check 111
		button=1'b0;
    	err=0;
    	throw_before=3'b111;
    	assign throw = 3'b111; // IMMEDIATELY GIVES NEW THROW OUTPUT from bottom
		forever begin
			#CLK_PERIOD
			
        	if (rst)
        	begin
				if (throw!=3'b000)
				begin
					$display("***TEST FAILED!,Reset issue***");
					err=1;
				end
			end
				
			else if (throw_before==3'b000|throw_before==3'b111)
			begin
					if (throw != 3'b001)
					begin
						$display("***TEST FAILED!,000 and 111 issue***");
						err=1;
					end
			end
					
			else if (!button)
			begin
				if (throw!=throw_before)
				begin
					$display("***TEST FAILED!,001 to 110 button 0 issue***");
					err=1;
				end
			end
			
			else if (throw_before==3'b110)
			begin
				if (throw!=throw_before)
				begin
					$display("***TEST FAILED!,110 button 1 issue***");
					err=1;
				end
			// from 001 to 101, wrt button 1
			end
			
			else 
			begin
				if (throw!=(throw_before+1))
				begin
					$display("***TEST FAILED!,001 to 101 button 1 issue***");
					err=1;
				end
         	end
         	
         	begin
         	// Place NEW THROW OUTPUT as old (before) for next iteration
         	throw_before <= throw;
		    button=button+1;  //2-000 4-010 6-001 8-011
			// test reset
			#50
			rst <= 1;
			#70
			rst <= 0;
			end
		end
	end
	
	//Todo: Finish test, check for success
	initial begin
		// From 70s, time to complete one loop of testing
        #220
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end

	//Todo: Instantiate counter module
 	dice top (
	.clk (clk),		
	.rst (rst),
	.button (button),
	.throw (throw)
	);

endmodule 
