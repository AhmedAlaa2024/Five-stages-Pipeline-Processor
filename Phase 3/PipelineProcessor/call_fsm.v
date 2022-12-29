module call_fsm(reset,call,clk,rdst_value,out,pc,stall);

parameter PUSH_PC_LOW = 2'b00;
parameter PUSH_PC_HIGH = 2'b01;

parameter PUSH_PC_LOW_OP = 16'b0110000000001000;
parameter PUSH_PC_HIGH_OP = 16'b0110000000001001;

input call,clk,reset;
input [15:0]rdst_value;
output reg [15:0]out;
output reg stall;
output [31:0]pc;

reg current_state;
reg next_state;
reg [15:0]rdst_reg;

assign pc = {16'b0,rdst_reg};

always @(posedge clk) begin
	if(!reset)begin 
		current_state = PUSH_PC_LOW;
		next_state = PUSH_PC_LOW;
		stall = 0;
		rdst_reg = 0;
	end
	current_state = next_state;
	if(call) begin
		rdst_reg = rdst_value;
		next_state = PUSH_PC_HIGH;
		stall = 1;
	end

	case (current_state)
		PUSH_PC_LOW: 
			out = PUSH_PC_LOW_OP;
		PUSH_PC_HIGH:
			out = PUSH_PC_HIGH_OP;
	endcase

end

always @(current_state)begin
	case (current_state)
		PUSH_PC_LOW: begin
			next_state = PUSH_PC_LOW;
			stall = 0;
			rdst_reg = 0;
		end
		PUSH_PC_HIGH:
			next_state = PUSH_PC_LOW;
	endcase
end


endmodule
