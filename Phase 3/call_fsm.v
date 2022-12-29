module call_fsm(reset,call,clk,out,stall);

parameter PUSH_PC_LOW = 16'b01;
parameter PUSH_PC_HIGH = 16'b10;
parameter MOV_PC_LOW = 16'b11;
parameter MOV_PC_HIGH = 16'b100;

input call,clk,reset;
output [15:0]out;
output reg stall;

reg [15:0]current_state;
reg [15:0]next_state;


assign out = current_state;
always @(posedge clk) begin
	if(!reset)begin 
		current_state = PUSH_PC_LOW;
		next_state = PUSH_PC_LOW;
		stall = 0;
	end
	current_state = next_state;
	if(call) begin
		next_state = PUSH_PC_HIGH;
		stall = 1;
	end else begin
	end

end

always @(current_state)begin
	case (current_state)
		PUSH_PC_LOW: begin
			next_state = PUSH_PC_LOW;
			stall = 0;
		end
		PUSH_PC_HIGH:
			next_state = MOV_PC_LOW;
		MOV_PC_LOW:
			next_state = MOV_PC_HIGH;
		MOV_PC_HIGH: begin 
			next_state = PUSH_PC_LOW;
		end
	endcase
end


endmodule
