//////////////////////////////////////////////////////////////////////////////////
// Exercise #9 
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a module that lights leds
//  at different frequencies
//
//  inputs:
//           rst_n, clk_n, clk_p, button
//
//  outputs:
//           led_0, led_1, led_2
//////////////////////////////////////////////////////////////////////////////////
module top(
	input clk_p,
	input clk_n,
	//Todo: add all other ports besides clk_n and clk_p
	input rst_n,
	input button,
	output led_2,
	output led_1,
	output led_0
	);
	
	// Count for 2,000,000 - 50Hz blink cycle vs 100MHz clock cycle
	reg [23:0] counter = 24'h0;
	reg [2:0] led;
	
	assign led_2 = led[2];
	assign led_1 = led[1];
	assign led_0 = led[0];
	
	/* clock infrastructure, do not modify */
        wire clk_ibufds;

    IBUFDS IBUFDS_sysclk (
	.I(clk_p),
	.IB(clk_n),
	.O(clk_ibufds)
);

     wire clk; //use this signal as a clock for your design
        
     BUFG bufg_clk (
	.I  (clk_ibufds),
	.O  (clk)
      );

	//Add logic here
	always@(posedge clk or posedge rst_n)
	begin
		// Reset is Active Low, Button pressed, LED to be off
		if(!rst_n||button==1) 
			begin
			led = 3'b000;
			counter = 24'h0;
			end
		// LED on once no reset or button
		else if (counter==24'h1)
			led = 3'b111;
		// off half a cycle later for "blinking"
		else if(counter==24'd1000001)
			led = 3'b000;
		else
			;
		counter=counter+1;
	end
	
endmodule
