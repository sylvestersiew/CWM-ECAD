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
	reg [3:0] RAG_before;
	wire [3:0] RAG;

	//Todo: Clock generation
	initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end

	//Todo: User logic
	initial begin
		button=1'b0;
    	err=0;
    	RAG_before=3'b000;
    	RAG=3'b000; // Initialise value for CODE below to work with = IMMEDIATELY gives a new value
    	
		forever begin
			// at start, RAG = new value, RAG b4 = old value
			#CLK_PERIOD
			
        	if(RAG_before==3'b000|RAG_before==3'b101|RAG_before==3'b111|RAG_before==3'b011)
	    	begin
				if (RAG_before!=3'b000|RAG==3'b101|RAG==3'b111|RAG==3'b011)
				begin
					$display("***TEST FAILED!,001 to 110 button 0 issue***");
					err=1;
				end
			end
			
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
         	// at end, RAG b4 = new value becomes old value
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
	mux traffic (
    .clk (clk),
    .red (RAG[2]),
    .amber (RAG[1]),
    .green (RAG[0])
    );

endmodule 
