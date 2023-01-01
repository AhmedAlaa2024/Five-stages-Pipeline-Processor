module Fabonacci_Processor_tb();

localparam PERIOD = 100;
localparam N = 15;

reg [15:0]portIn;
wire [15:0]portOut;
reg clk, reset, int;
wire ack;

reg [15:0] cycles_counter;

Processor processor(clk, reset, portIn, portOut, int, ack);

initial 
    begin
        portIn = 16'h00;
		/* Initialize the processor */
		clk = 0;
		int = 0;
		cycles_counter = 0;

		reset = 1'b1;
		#(PERIOD);
		reset = 1'b0;
		#(PERIOD);
		reset = 1'b1;
        
        #(PERIOD*3);
        portIn = 16'hF0;
        #(PERIOD*8);
        portIn = 16'h2D;
        #(PERIOD);
        #(PERIOD*9*N);
        portIn = 16'h3A;
        #(PERIOD*20);

        int = 1'b1;
        #(PERIOD*6);
        int = 1'b0;
        #(PERIOD);
        portIn = 16'h04;
        #(PERIOD*5);

		#(PERIOD*1000);
    end

always
    begin
        #(PERIOD/2);
        clk = ~clk;
    end

always @(posedge clk)
    begin
        cycles_counter = cycles_counter + 1;
    end
	
endmodule