

module Processor_tb;
	parameter PERIOD = 100;
	
	reg clk,reset;
	integer i;
	always #PERIOD clk=~clk;
	Processor processor(clk,reset);
	initial begin
		//Reset processor
		clk=0;
		reset = 1'b1;
		#PERIOD;
		#PERIOD;
		reset = 1'b0;
		#PERIOD;
		#PERIOD;
		reset = 1'b1;
		#(PERIOD*100);
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;

		/**** Start ****/
		// First initialize your variables

		// Then clear reset

		#10000;
		$finish;
	end
	
endmodule