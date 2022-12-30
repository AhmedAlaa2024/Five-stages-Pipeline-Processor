

module Processor_tb;
	parameter PERIOD = 100;
	reg [15:0]portIn;
	wire [15:0]portOut;
	reg clk,reset,int;
	wire ack;
	reg [15:0] cycles_counter;
	integer i;
	always begin 
		#(PERIOD/2);
		clk=~clk;
	end
	always @(posedge clk)begin
		 cycles_counter = cycles_counter + 1;
	end
	Processor processor(clk,reset,portIn,portOut,int,ack);
	initial begin
		portIn = 16'hDA;
		//Reset processor
		clk=0;
		int = 0;
		cycles_counter = 0;
		reset = 1'b1;
		#PERIOD;
		#PERIOD;
		reset = 1'b0;
		#PERIOD;
		#PERIOD;
		reset = 1'b1;
		#(PERIOD*2);
		int = 1'b1;
		#PERIOD;
		int = 1'b0;
		#(PERIOD*50);
		/**** Start ****/
		// First initialize your variables

		// Then clear reset

		#10000;
		$finish;
	end
	
endmodule