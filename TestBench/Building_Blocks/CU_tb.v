
module CU_tb;

	//********* Start Opcodes of instructions ***********//
	parameter NOP_OP = 9'b0;
	parameter SETC_OP = 9'b1;
	parameter CLRC_OP = 9'b10;

	parameter NOT_OP = 9'b001_00000;
	parameter INC_OP = 9'b001_00001;
	parameter DEC_OP = 9'b001_00010;
	parameter OUT_OP = 9'b001_00011;
	parameter IN_OP = 9'b001_00100;
	
	parameter MOV_OP = 9'b010_00000;
	parameter ADD_OP = 9'b010_00001;
	parameter SUB_OP = 9'b010_00010;
	parameter AND_OP = 9'b010_00011;
	parameter OR_OP = 9'b010_00100;
	parameter SHL_OP = 9'b010_00101;
	parameter SHR_OP = 9'b010_00110;

	parameter PUSH_OP = 9'b011_00000;
	parameter POP_OP = 9'b011_00001;
	parameter LDM_OP = 9'b011_00010;
	parameter LDD_OP = 9'b011_00011;
	parameter STD_OP = 9'b011_00100;

	parameter JZ_OP = 9'b100_00000;
	parameter JN_OP = 9'b100_00001;
	parameter JC_OP = 9'b100_00010;
	parameter JMP_OP = 9'b100_00100;
	parameter CALL_OP = 9'b100_00110;
	parameter RET_OP = 9'b100_01000;
	//********* End Opcodes of instructions ***********//

	//********* Start ALU functions of instructions ***********//
	parameter NOP_ALU = 4'b0;
	parameter SETC_ALU = 4'b1;
	parameter CLRC_ALU = 4'b10;

	parameter NOT_ALU = 4'b0101;
	parameter INC_ALU = 4'b0110;
	parameter DEC_ALU = 4'b0111;
	parameter OUT_ALU = 4'b0100;
	parameter IN_ALU = 4'b0000;
	
	parameter MOV_ALU = 4'b0011;
	parameter ADD_ALU = 4'b1000;
	parameter SUB_ALU = 4'b1001;
	parameter AND_ALU = 4'b1010;
	parameter OR_ALU = 4'b1011;
	parameter SHL_ALU = 4'b1100;
	parameter SHR_ALU = 4'b1101;

	parameter PUSH_ALU = 4'b0100;
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

	reg [8:0] opcode;
	wire branch;
	wire data_read;
	wire data_write;
	wire DMR;
	wire DMW;
	wire IOE;
	wire IOR;
	wire IOW;
	wire stack_operation;
	wire push_pop;
	wire pass_immediate;
	wire [3:0] alu_function;
	
	CU cu(opcode,
		branch,
		data_read,
		data_write,
		DMR,
		DMW,
		IOE,
		IOR,
		IOW,
		stack_operation,
		push_pop,
		pass_immediate,
		alu_function);

	initial begin
		// Test NOP_OP
		opcode = NOP_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 0 &&
		data_write == 0&&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == NOP_ALU) 
		begin
			$display("PASS NOP");	
		end else 
		begin
			$display("FAILED NOP");	
		end


		// Test SETC_OP
		opcode = SETC_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 0 &&
		data_write == 0&&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == SETC_ALU) 
		begin
			$display("PASS SETC");	
		end else 
		begin
			$display("FAILED SETC");	
		end

		// Test CLRC_OP
		opcode = CLRC_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 0 &&
		data_write == 0&&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == CLRC_ALU) 
		begin
			$display("PASS CLRC");	
		end else 
		begin
			$display("FAILED CLRC");	
		end



		// Test NOT_OP
		opcode = NOT_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 1&&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == NOT_ALU) 
		begin
			$display("PASS NOT");	
		end else 
		begin
			$display("FAILED NOT");	
		end


		// Test INC_OP
		opcode = INC_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 1&&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == INC_ALU) 
		begin
			$display("PASS INC");	
		end else 
		begin
			$display("FAILED INC");	
		end


		// Test DEC_OP
		opcode = DEC_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 1&&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == DEC_ALU) 
		begin
			$display("PASS DEC");	
		end else 
		begin
			$display("FAILED DEC");	
		end



		// Test OUT_OP
		opcode = OUT_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 0&&
		DMR == 0&&
		DMW == 0&&
		IOE == 1&&
		IOR == 0&&
		IOW == 1&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == OUT_ALU) 
		begin
			$display("PASS OUT");	
		end else 
		begin
			$display("FAILED OUT");	
		end


		// Test IN_OP
		opcode = IN_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 0 &&
		data_write == 1 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 1&&
		IOR == 1&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == IN_ALU) 
		begin
			$display("PASS IN");	
		end else 
		begin
			$display("FAILED IN");	
		end

		// Test MOV_OP
		opcode = MOV_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 1 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == MOV_ALU) 
		begin
			$display("PASS MOV");	
		end else 
		begin
			$display("FAILED MOV");	
		end

		// Test ADD_OP
		opcode = ADD_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 1 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == ADD_ALU) 
		begin
			$display("PASS ADD");	
		end else 
		begin
			$display("FAILED ADD");	
		end


		// Test SUB_OP
		opcode = SUB_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 1 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == SUB_ALU) 
		begin
			$display("PASS SUB");	
		end else 
		begin
			$display("FAILED SUB");	
		end

		// Test AND_OP
		opcode = AND_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 1 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == AND_ALU) 
		begin
			$display("PASS AND");	
		end else 
		begin
			$display("FAILED AND");	
		end

		// Test OR_OP
		opcode = OR_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 1 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == OR_ALU) 
		begin
			$display("PASS OR");	
		end else 
		begin
			$display("FAILED OR");	
		end

		// Test SHL_OP
		opcode = SHL_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 1 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == SHL_ALU) 
		begin
			$display("PASS SHL");	
		end else 
		begin
			$display("FAILED SHL");	
		end

		// Test SHR_OP
		opcode = SHR_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 1 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == SHR_ALU) 
		begin
			$display("PASS SHR");	
		end else 
		begin
			$display("FAILED SHR");	
		end

		// Test PUSH_OP
		opcode = PUSH_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 0 &&
		DMR == 0&&
		DMW == 1&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 1&&
		push_pop == 1&&
		pass_immediate == 0&&
		alu_function == PUSH_ALU) 
		begin
			$display("PASS PUSH");	
		end else 
		begin
			$display("FAILED PUSH");	
		end

		// Test POP_OP
		opcode = POP_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 0 &&
		data_write == 1 &&
		DMR == 1&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 1&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == POP_ALU) 
		begin
			$display("PASS POP");	
		end else 
		begin
			$display("FAILED POP");	
		end
		// Test LDM_OP
		opcode = LDM_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 0 &&
		data_write == 1 &&
		DMR == 1&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 1&&
		alu_function == LDM_ALU) 
		begin
			$display("PASS LDM");	
		end else 
		begin
			$display("FAILED LDM");	
		end

		// Test LDD_OP
		opcode = LDD_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 1 &&
		DMR == 1&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == LDD_ALU) 
		begin
			$display("PASS LDD");	
		end else 
		begin
			$display("FAILED LDD");	
		end
		// Test STD_OP
		opcode = STD_OP;
		#10;
		if(
		branch == 0 &&
		data_read == 1 &&
		data_write == 0 &&
		DMR == 0&&
		DMW == 1&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == STD_ALU) 
		begin
			$display("PASS STD");	
		end else 
		begin
			$display("FAILED STD");	
		end
		// Test JZ_OP
		opcode = JZ_OP;
		#10;
		if(
		branch == 1 &&
		data_read == 1 &&
		data_write == 0 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == JZ_ALU) 
		begin
			$display("PASS JZ");	
		end else 
		begin
			$display("FAILED JZ");	
		end
		// Test JN_OP
		opcode = JN_OP;
		#10;
		if(
		branch == 1 &&
		data_read == 1 &&
		data_write == 0 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == JN_ALU) 
		begin
			$display("PASS JN");	
		end else 
		begin
			$display("FAILED JN");	
		end
		// Test JC_OP
		opcode = JC_OP;
		#10;
		if(
		branch == 1 &&
		data_read == 1 &&
		data_write == 0 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == JC_ALU) 
		begin
			$display("PASS JC");	
		end else 
		begin
			$display("FAILED JC");	
		end
		// Test JMP_OP
		opcode = JMP_OP;
		#10;
		if(
		branch == 1 &&
		data_read == 0 &&
		data_write == 0 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == JMP_ALU) 
		begin
			$display("PASS JMP");	
		end else 
		begin
			$display("FAILED JMP");	
		end
		// Test CALL_OP
		opcode = CALL_OP;
		#10;
		if(
		branch == 1 &&
		data_read == 0 &&
		data_write == 0 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == CALL_ALU) 
		begin
			$display("PASS CALL");	
		end else 
		begin
			$display("FAILED CALL");	
		end
		// Test RET_OP
		opcode = RET_OP;
		#10;
		if(
		branch == 1 &&
		data_read == 0 &&
		data_write == 0 &&
		DMR == 0&&
		DMW == 0&&
		IOE == 0&&
		IOR == 0&&
		IOW == 0&&
		stack_operation == 0&&
		push_pop == 0&&
		pass_immediate == 0&&
		alu_function == RET_ALU) 
		begin
			$display("PASS RET");	
		end else 
		begin
			$display("FAILED RET");	
		end
		$finish;	
	end	
	
endmodule;