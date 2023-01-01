
module CU_tb;

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
	parameter SHL_IMM_OP = 9'b010_000111;
	parameter SHR_IMM_OP = 9'b010_001000;

	parameter PUSH_OP = 9'b011_000000;
	parameter POP_OP = 9'b011_000001;
	parameter LDM_OP = 9'b011_000010;
	parameter LDD_OP = 9'b011_000011;
	parameter STD_OP = 9'b011_000100;

	parameter JZ_OP = 9'b100_000000;
	parameter JN_OP = 9'b100_000001;
	parameter JC_OP = 9'b100_000010;
	parameter JMP_OP = 9'b100_000100;
	parameter JMPI_OP = 9'b100_000101;
	parameter CALL_OP = 9'b100_000110;
	parameter RET_OP = 9'b100_001000;
	parameter RTI_OP = 9'b100_001010;
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
	parameter SHL_IMM_ALU = 4'b1100;
	parameter SHR_IMM_ALU = 4'b1101;

	parameter PUSH_ALU = 4'b0100;
	parameter POP_ALU = 4'b0000;
	parameter LDM_ALU = 4'b0011;
	parameter LDD_ALU = 4'b0011;
	parameter STD_ALU = 4'b0011;

	parameter JZ_ALU = 4'b0011; // Edited move operand 1
	parameter JN_ALU = 4'b0011; // Edited move operand 1
	parameter JC_ALU = 4'b0011; // Edited move operand 1
	parameter JMP_ALU = 4'b0011; // Edited move operand 1
	parameter JMPI_ALU = 9'b0011;
	parameter CALL_ALU = 4'b0100;
	parameter RET_ALU = 4'b0000;
	parameter RTI_ALU = 4'b0000;
	//********* End ALU functions of instructions ***********//
	
	reg int_flag;
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
	wire write_sp;	
	wire [3:0] alu_function;
	wire rti;
	wire ret;
	wire call;
	wire [1:0]branch_type;
	
	CU cu(opcode,
		int_flag,
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
		write_sp,
		alu_function,
		rti,
		ret,
		call,
		branch_type);

	initial begin
		int_flag = 0;
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
		write_sp == 0&&
		alu_function == NOP_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == SETC_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0)
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
		write_sp == 0&&
		alu_function == CLRC_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == NOT_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == INC_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == DEC_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0)
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
		write_sp == 0&&
		alu_function == OUT_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0)
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
		write_sp == 0&&
		alu_function == IN_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == MOV_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == ADD_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == SUB_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == AND_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == OR_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0)
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
		write_sp == 0&&
		alu_function == SHL_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == SHR_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0)
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
		write_sp == 1&&
		alu_function == PUSH_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 1&&
		alu_function == POP_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == LDM_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == LDD_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == STD_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		write_sp == 0&&
		alu_function == JZ_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 2'b00) 
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
		write_sp == 0&&
		alu_function == JN_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 2'b01)
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
		write_sp == 0&&
		alu_function == JC_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 2'b10)
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
		write_sp == 0&&
		alu_function == JMP_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 2'b11)  
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
		branch == 0 &&
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
		write_sp == 0&&
		alu_function == CALL_ALU&&
		call == 1&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
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
		branch == 0 &&
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
		alu_function == RET_ALU&&
		call == 0&&
		ret == 1&&
		rti == 0&&
		branch_type == 0)  
		begin
			$display("PASS RET");	
		end else 
		begin
			$display("FAILED RET");	
		end
		// Test RTI_OP
		opcode = RTI_OP;
		#10;
		if(
		branch == 0 &&
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
		alu_function == RTI_ALU&&
		call == 0&&
		ret == 0&&
		rti == 1&&
		branch_type == 0)  
		begin
			$display("PASS RTI");	
		end else 
		begin
			$display("FAILED RTI");	
		end
		// Test SHL_IMM_OP
		opcode = SHL_IMM_OP;
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
		pass_immediate == 1&&
		write_sp == 0&&
		alu_function == SHL_IMM_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0)  
		begin
			$display("PASS SHL IM");	
		end else 
		begin
			$display("FAILED SHL IM");	
		end
		// Test SHR_IMM_OP
		opcode = SHR_IMM_OP;
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
		pass_immediate == 1&&
		write_sp == 0&&
		alu_function == SHR_IMM_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 0) 
		begin
			$display("PASS SHR IM");	
		end else 
		begin
			$display("FAILED SHR IM");	
		end
		// Test JMPI_OP
		opcode = JMPI_OP;
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
		write_sp == 0&&
		alu_function == JMPI_ALU&&
		call == 0&&
		ret == 0&&
		rti == 0&&
		branch_type == 2'b11)
		begin
			$display("PASS JMPI IM");	
		end else 
		begin
			$display("FAILED JMPI IM");	
		end
		$finish;	
	end	
	
endmodule;