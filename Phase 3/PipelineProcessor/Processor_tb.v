

module Processor_tb;
	parameter PERIOD = 100;
	reg [15:0]portIn;
	wire [15:0]portOut;
	reg clk,reset;
	integer i;
	always #PERIOD clk=~clk;
	Processor processor(clk,reset,portIn,portOut);
	initial begin
		portIn = 16'b0000_0000_0000_0101;
		//Reset processor
		clk=0;
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

		#(PERIOD*100);
		/**** Start ****/
		// First initialize your variables

		// Then clear reset

		#10000;
		$finish;
	end
	
endmodule