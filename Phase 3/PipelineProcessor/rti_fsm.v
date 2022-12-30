module rti_fsm(reset,rti,clk,out,stall);


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

input rti,clk,reset;

output reg [15:0]out;
output reg stall;


reg [2:0]current_state;
reg [2:0]next_state;


always @(posedge clk) begin
	if(!reset)begin 
		current_state = POP_PC_HIGH;
		next_state = POP_PC_HIGH;
		stall = 0;
	end
	current_state = next_state;
	if(rti) begin
		next_state = POP_PC_LOW;
		stall = 1;
	end
	case (current_state)
		POP_PC_LOW: 
			out = POP_PC_LOW_OP;
		POP_PC_HIGH:
			out = POP_PC_HIGH_OP;
		POP_CCR:
			out = POP_CCR_OP;
		NOP_STATE_1:
			out = 16'b0;
		NOP_STATE_2:
			out = 16'b0;
		NOP_STATE_3:
			out = 16'b0;
		NOP_STATE_4:
			out = 16'b0;
	endcase

end

always @(current_state)begin
	case (current_state)
		POP_PC_HIGH: begin
			next_state = POP_PC_HIGH;
			stall = 0;
		end
		POP_PC_LOW:
			next_state = POP_CCR;
		POP_CCR:
			next_state = NOP_STATE_1;
		NOP_STATE_1:
			next_state = NOP_STATE_2;
		NOP_STATE_2:
			next_state = NOP_STATE_3;
		NOP_STATE_3:
			next_state = NOP_STATE_4;
		NOP_STATE_4:
			next_state = POP_PC_HIGH;
	endcase
end

endmodule