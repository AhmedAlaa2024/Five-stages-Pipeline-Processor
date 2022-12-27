
module stackAdder(clk,stack_op,push_pop,in,out);

input push_pop,stack_op,clk;
input [31:0]in;
output reg [31:0]out;

always@(posedge clk) begin
	if(stack_op && push_pop) // push
		out = in - 1;
	else if(stack_op && !push_pop) // pop
		out = in + 1;
	else
		out = in;	
end
endmodule