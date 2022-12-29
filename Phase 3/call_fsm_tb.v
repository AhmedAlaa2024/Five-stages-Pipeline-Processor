module call_fsm_tb;

parameter PUSH_PC_LOW = 16'b01;
parameter PUSH_PC_HIGH = 16'b10;
parameter MOV_PC_LOW = 16'b11;
parameter MOV_PC_HIGH = 16'b100;

reg call,clk,reset;
wire [15:0]out;
wire stall;

call_fsm callfsm(reset,call,clk,out,stall);
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
	#20;
	if(out === PUSH_PC_LOW && stall == 1)
		$display("PASS 1");
	else 
		$display("FALID %d",out);
	call = 0;
	#20;
	if(out === PUSH_PC_HIGH && stall == 1)
		$display("PASS 2");
	else 
		$display("FALID %d",out);
	#20;
	if(out === MOV_PC_LOW && stall == 1)
		$display("PASS 3");
	else 
		$display("FALID %d",out);
	#20;
	if(out === MOV_PC_HIGH && stall == 1)
		$display("PASS 4");
	else 
		$display("FALID %d",out);
	#20;
	if(out === PUSH_PC_LOW && stall == 0)
		$display("PASS no call");
	else 
		$display("FALID %d",out);
	#20;
	if(out === PUSH_PC_LOW && stall == 0)
		$display("PASS no call");
	else 
		$display("FALID %d",out);
	#20;
	if(out === PUSH_PC_LOW && stall == 0)
		$display("PASS no call");
	else 
		$display("FALID %d",out);
	#20;
	if(out === PUSH_PC_LOW && stall == 0)
		$display("PASS no call");
	else 
		$display("FALID %d",out);
	call = 1;
	#20;
	if(out === PUSH_PC_LOW && stall == 1)
		$display("PASS 1");
	else 
		$display("FALID %d",out);
	#20;
	call =0;
	if(out === PUSH_PC_HIGH && stall == 1)
		$display("PASS 2");
	else 
		$display("FALID %d",out);
	#20;
	if(out === MOV_PC_LOW && stall == 1)
		$display("PASS 3");
	else 
		$display("FALID %d",out);
	#20;
	if(out === MOV_PC_HIGH && stall == 1)
		$display("PASS 4");
	else 
		$display("FALID %d",out);
	$finish;
end
endmodule
