module rti_fsm_tb;

parameter POP_PC_HIGH = 3'b0;
parameter POP_PC_LOW = 3'b1;
parameter POP_CCR = 3'b10;
parameter NOP_STATE_1 = 3'b11; 
parameter NOP_STATE_2 = 3'b100; 
parameter NOP_STATE_3 = 3'b101; 
parameter NOP_STATE_4 = 3'b110; 


parameter POP_PC_HIGH_OP = 16'b0110000010001001;
parameter POP_PC_LOW_OP = 16'b0110000010001000;
parameter POP_CCR_OP = 16'b0110000010001010;


reg rti,clk,reset;

wire [15:0]out;
wire stall;


reg current_state;
reg next_state;
rti_fsm rtiFsm(reset,rti,clk,out,stall);
always #10 clk = ~clk;

initial begin
	clk = 0;
	reset = 1;
	rti = 0;
	#40;
	reset = 0;
	#20;
	reset = 1;
	rti = 1;
	#20;
	if(out == POP_PC_HIGH_OP && stall == 1)
		$display("PASS 1");
	else 
		$display("FALID %d",out);
	rti = 0;
	#20;
	if(out == POP_PC_LOW_OP && stall == 1)
		$display("PASS 2");
	else 
		$display("FALID %d",out);
	#20;
	if(out == POP_CCR_OP && stall == 1)
		$display("PASS 3");
	else 
		$display("FALID %d",out);
	#20;
	if(out == 16'b0 && stall == 1)
		$display("PASS 4");
	else 
		$display("FALID %d",out);
	#20;
	if(out == 16'b0 && stall == 1)
		$display("PASS 5");
	else 
		$display("FALID %d",out);
	#20;
	if(out == 16'b0 && stall == 1)
		$display("PASS 6");
	else 
		$display("FALID %d",out);
	#20;
	if(out == 16'b0 && stall == 1)
		$display("PASS 7");
	else 
		$display("FALID %d",out);
	#20;
	if(out == POP_PC_HIGH_OP && stall == 0)
		$display("PASS no call");
	else 
		$display("FALID %d",out);
	#20;
	if(out == POP_PC_HIGH_OP && stall == 0)
		$display("PASS no call");
	else 
		$display("FALID %d",out);
	#20;
	if(out == POP_PC_HIGH_OP && stall == 0)
		$display("PASS no call");
	else 
		$display("FALID %d",out);
	#20;
	if(out == POP_PC_HIGH_OP && stall == 0)
		$display("PASS no call");
	else 
		$display("FALID %d",out);
	rti = 1;
	#20;
	if(out == POP_PC_HIGH_OP && stall == 1)
		$display("PASS 1");
	else 
		$display("FALID %d",out);
	#20;
	rti = 0;
	if(out == POP_PC_LOW_OP && stall == 1)
		$display("PASS 2");
	else 
		$display("FALID %d",out);
	#20;
	if(out == POP_CCR_OP && stall == 1)
		$display("PASS 3");
	else 
		$display("FALID %d",out);
	#20;
	if(out == 16'b0 && stall == 1)
		$display("PASS 4");
	else 
		$display("FALID %d",out);
	#20;
	if(out == 16'b0 && stall == 1)
		$display("PASS 5");
	else 
		$display("FALID %d",out);
	#20;
	if(out == 16'b0 && stall == 1)
		$display("PASS 6");
	else 
		$display("FALID %d",out);
	#20;
	if(out == 16'b0 && stall == 1)
		$display("PASS 7");
	else 
		$display("FALID %d",out);
	#20;
	$finish;
end
endmodule
