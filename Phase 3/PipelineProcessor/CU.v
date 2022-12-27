
module CU(opcode,branch,data_read,data_write,DMR,DMW,IOE,IOR,IOW,stack_operation,push_pop,pass_immediate,write_sp,alu_function);
	//********* Start Opcodes of instructions ***********//
	parameter NOP_OP = 9'b0;
	parameter SETC_OP = 9'b1;
	parameter CLRC_OP = 9'b10;

	parameter NOT_OP = 9'b001_000000;
	parameter INC_OP = 9'b001_000001;
	parameter DEC_OP = 9'b001_000010;
	parameter OUT_OP = 9'b001_000011;
	parameter IN_OP = 9'b001_000100;
	
	parameter MOV_OP = 9'b010_000000;
	parameter ADD_OP = 9'b010_000001;
	parameter SUB_OP = 9'b010_000010;
	parameter AND_OP = 9'b010_000011;
	parameter OR_OP = 9'b010_000100;
	parameter SHL_OP = 9'b010_000101;
	parameter SHR_OP = 9'b010_000110;

	parameter PUSH_OP = 9'b011_000000;
	parameter POP_OP = 9'b011_000001;
	parameter LDM_OP = 9'b011_000010;
	parameter LDD_OP = 9'b011_000011;
	parameter STD_OP = 9'b011_000100;

	parameter JZ_OP = 9'b100_000000;
	parameter JN_OP = 9'b100_000001;
	parameter JC_OP = 9'b100_000010;
	parameter JMP_OP = 9'b100_000100;
	parameter CALL_OP = 9'b100_000110;
	parameter RET_OP = 9'b100_001000;
	//********* End Opcodes of instructions ***********//

	//********* Start ALU functions of instructions ***********//
	parameter NOP_ALU = 4'b0;
	parameter SETC_ALU = 4'b1;
	parameter CLRC_ALU = 4'b10;

	parameter NOT_ALU = 4'b0101;
	parameter INC_ALU = 4'b0110;
	parameter DEC_ALU = 4'b0111;
	parameter OUT_ALU = 4'b0011; // Edited move operand 1
	parameter IN_ALU = 4'b0000;
	
	parameter MOV_ALU = 4'b0011;
	parameter ADD_ALU = 4'b1000;
	parameter SUB_ALU = 4'b1001;
	parameter AND_ALU = 4'b1010;
	parameter OR_ALU = 4'b1011;
	parameter SHL_ALU = 4'b1100;
	parameter SHR_ALU = 4'b1101;

	parameter PUSH_ALU = 4'b0100; // Edited ,should be operand2 0100
	parameter POP_ALU = 4'b0000;
	parameter LDM_ALU = 4'b0011;
	parameter LDD_ALU = 4'b0011;
	parameter STD_ALU = 4'b0011;

	parameter JZ_ALU = 4'b0100;
	parameter JN_ALU = 4'b0100;
	parameter JC_ALU = 4'b0100;
	parameter JMP_ALU = 4'b0100;
	parameter CALL_ALU = 4'b0100;
	parameter RET_ALU = 4'b0000;
	//********* End ALU functions of instructions ***********//
	//,,,,,,,,,alu_function
	input [8:0] opcode;
	output reg branch;
	output reg data_read;
	output reg data_write;
	output reg DMR;
	output reg DMW;
	output reg IOE;
	output reg IOR;
	output reg IOW;
	output reg stack_operation;
	output reg push_pop;
	output reg pass_immediate;
	output reg write_sp;
	output reg [3:0] alu_function;
	
	always @(*) begin
		// Avoid unwanted latches	
		branch = 0;
		data_read = 0;
	 	data_write = 0;
		DMR = 0;
		DMW = 0;
		IOE = 0;
		IOR = 0;
		IOW = 0;
	 	stack_operation = 0;
	 	push_pop = 0;
		pass_immediate = 0;
		write_sp = 0;
	 	alu_function = 0;
		case(opcode)
			NOP_OP: begin
				alu_function = NOP_ALU;
			end
			SETC_OP: begin
				alu_function = SETC_ALU;
			end 
			CLRC_OP: begin
				alu_function = CLRC_ALU;
			end
			NOT_OP: begin
				alu_function = NOT_ALU;
				data_read = 1;
				data_write = 1;
			end 
 			INC_OP: begin
				alu_function = INC_ALU;
				data_read = 1;
				data_write = 1;
			end
			DEC_OP: begin
				alu_function = DEC_ALU;
				data_read = 1;
				data_write = 1;
			end 
			OUT_OP: begin
				alu_function = OUT_ALU;
				data_read = 1;
				IOE = 1;
				IOW = 1;
			end
			IN_OP: begin
				alu_function = IN_ALU;
				data_write = 1;
				IOE = 1;
				IOR = 1;
			end 
			MOV_OP: begin
				alu_function = MOV_ALU;
				data_read = 1;
				data_write = 1;
			end
			ADD_OP: begin
				alu_function = ADD_ALU;
				data_read = 1;
				data_write = 1;
			end 
			SUB_OP: begin
				alu_function = SUB_ALU;
				data_read = 1;
				data_write = 1;
			end
			AND_OP: begin
				alu_function = AND_ALU;
				data_read = 1;
				data_write = 1;
			end 
 			OR_OP: begin
				alu_function = OR_ALU;
				data_read = 1;
				data_write = 1;
			end
			SHL_OP: begin
				alu_function = SHL_ALU;
				data_read = 1;
				data_write = 1;
			end 
			SHR_OP: begin
				alu_function = SHR_ALU;
				data_read = 1;
				data_write = 1;
			end
			PUSH_OP: begin
				alu_function = PUSH_ALU;
				data_read = 1;
				DMW = 1;
				stack_operation = 1;
				push_pop = 1;
				write_sp = 1;
			end
			POP_OP: begin
				alu_function = POP_ALU;
				data_write = 1;
				DMR = 1;
				stack_operation = 1;
				write_sp = 1;
			end 
 			LDM_OP: begin
				alu_function = LDM_ALU;
				data_write = 1;
				DMR = 1;
				pass_immediate = 1;
			end
			LDD_OP: begin
				alu_function = LDD_ALU;
				data_read = 1;
				data_write = 1;
				DMR = 1;
			end 
			STD_OP: begin
				alu_function = STD_ALU;
				data_read = 1;
				DMW = 1;
			end
			JZ_OP: begin
				alu_function = JZ_ALU;
				branch = 1;
				data_read = 1;
			end 
 			JN_OP: begin
				alu_function = JN_ALU;
				branch = 1;
				data_read = 1;
			end
			JC_OP: begin
				alu_function = JC_ALU;
				branch = 1;
				data_read = 1;
			end 
			JMP_OP: begin
				alu_function = JMP_ALU;
				branch = 1;
			end
 			CALL_OP: begin
				alu_function = CALL_ALU;
				branch = 1;
			end 
			RET_OP: begin
				alu_function = RET_ALU;
				branch = 1;
			end
		endcase
	end		

endmodule