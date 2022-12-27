module stackAdder_tb();
parameter period = 10;
reg push_pop,stack_op,clk;
reg [31:0]in;
wire [31:0]out;
always #(period/2) clk = ~clk;

stackAdder add(clk,stack_op,push_pop,in,out);
initial begin
	clk = 0;
	in = 3;
	stack_op = 0;
	push_pop = 1;
	#(period*2);
	if(out == in )
		$display("no stack pass");
	
	stack_op = 1;
	push_pop = 1;
	#(period*2);
	if(out == in - 1)
		$display("push stack pass");
	stack_op = 1;
	push_pop = 0;
	#(period*2);
	if(out == in + 1)
		$display("pop stack pass");
	$finish;
end

endmodule
