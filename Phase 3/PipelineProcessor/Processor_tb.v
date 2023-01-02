

module Processor_tb;
	parameter PERIOD = 100;
	reg [15:0]portIn;
	wire [15:0]portOut;
	reg clk,reset,int;
	wire ack;
	reg [15:0] cycles_counter;
	integer i;
	always begin 
		//#(PERIOD/2);
		#(PERIOD);
		clk=~clk;
	end
	always @(posedge clk)begin
		 cycles_counter = cycles_counter + 1;
	end
	Processor processor(clk,reset,portIn,portOut,int,ack);
	initial begin

		//Reset processor
		clk=0;
		int = 0;
		cycles_counter = 0;
		portIn = 16'h25;
		//Reset processor
		reset = 1'b1;
		#PERIOD;
		#PERIOD;
		reset = 1'b0;
		#PERIOD;
		#PERIOD;
		reset = 1'b1;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		portIn = 16'h19;
		#PERIOD;
		#PERIOD;
		portIn = 16'hffffff;
		#PERIOD;
		#PERIOD;
		portIn = 16'hffff320;
		#PERIOD;
		#PERIOD;
		//int = 1;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		//int =0;
		#(PERIOD*100);
		/**** Start ****/
		// First initialize your variables

		// Then clear reset

		#10000;
		$finish;
	end
	
endmodule