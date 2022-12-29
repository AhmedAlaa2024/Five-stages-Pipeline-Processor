module call_fsm_tb;

parameter PUSH_PC_LOW = 16'b01;
parameter PUSH_PC_HIGH = 16'b10;

parameter PUSH_PC_LOW_OP = 16'b0110000000001000;
parameter PUSH_PC_HIGH_OP = 16'b0110000000001001;

reg call,clk,reset;
reg [15:0]rdst_value;
wire [15:0]out;
wire stall;
wire [31:0] pc;

call_fsm callfsm(reset,call,clk,rdst_value,out,pc,stall);
always #10 clk = ~clk;

initial begin
	clk = 0;
	reset = 1;
	call = 0;
	#40;
	reset = 0;
	#20;
	reset = 1;
	call = 1;
	rdst_value = 16'b0000_1111_0000_1111;
	#20;
	if(out == PUSH_PC_LOW_OP && stall == 1 && pc == 16'b0000_1111_0000_1111)
		$display("PASS 1");
	else 
		$display("FALID %d",out);
	call = 0;
	rdst_value = 0;
	#20;
	if(out == PUSH_PC_HIGH_OP && stall == 1 && pc == 16'b0000_1111_0000_1111)
		$display("PASS 2");
	else 
		$display("FALID %d",out);
	#20;
	if(out == PUSH_PC_LOW_OP && stall == 0 && pc == 16'b0)
		$display("PASS no call");
	else 
		$display("FALID %d",out);
	#20;
	if(out == PUSH_PC_LOW_OP && stall == 0 && pc == 16'b0)
		$display("PASS no call");
	else 
		$display("FALID %d",out);
	#20;
	if(out == PUSH_PC_LOW_OP && stall == 0 && pc == 16'b0)
		$display("PASS no call");
	else 
		$display("FALID %d",out);
	#20;
	if(out == PUSH_PC_LOW_OP && stall == 0 && pc == 16'b0)
		$display("PASS no call");
	else 
		$display("FALID %d",out);
	call = 1;
	rdst_value = 16'b1111_1111_0000_1111;
	#20;
	if(out == PUSH_PC_LOW_OP && stall == 1 && pc == 16'b1111_1111_0000_1111)
		$display("PASS 1");
	else 
		$display("FALID %d",out);
	#20;
	call =0;
	if(out == PUSH_PC_HIGH_OP && stall == 1 && pc == 16'b1111_1111_0000_1111)
		$display("PASS 2");
	else 
		$display("FALID %d",out);
	#20;
	$finish;
end
endmodule
