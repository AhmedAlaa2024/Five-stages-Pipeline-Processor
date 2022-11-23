

module Processor_tb;
	parameter PERIOD = 100;
	
	reg clk,reset;
	
	always #PERIOD clk=~clk;
	Processor processor(clk,reset);
	initial begin
		//Reset processor
		clk=0;
		reset = 1'b1;
		#PERIOD;
		reset = 1'b0;
		#PERIOD;
		#PERIOD;
		#PERIOD;
		#PERIOD;
#PERIOD;
#PERIOD;
#PERIOD;
		/**** Start ****/
		// First initialize your variables

		// Then clear reset
		reset = 1;

		#10000;
		$finish;
	end
	
endmodule