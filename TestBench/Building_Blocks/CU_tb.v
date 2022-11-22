
module CU_tb;

	// Opcodes of instructions	
	parameter LOAD_OP = 9'b1;
	parameter STORE_OP = 9'b10;
	parameter ADD_OP = 9'b011;
	parameter NOT_OP = 9'b100;
	parameter NOP_OP = 9'b101;


	// Alu functions of instructions
	parameter LOAD = 2'b00; // NOP
	parameter STORE = 2'b10; // MOV
	parameter ADD = 2'b11;
	parameter NOT = 2'b01;
	parameter NOP = 2'b00;

	reg [8:0] opcode;
	wire dmr;
	wire dmw;
	wire data_read;
	wire data_write;
	wire [2:0] alu_function;
	
	CU cu(opcode,dmr,dmw,data_read,data_write,alu_function);
	initial begin
		// Test load
		opcode = LOAD_OP;
		#10;
		if(dmr == 1 && dmw==0 && data_read ==0 && data_write == 1 && alu_function == LOAD) begin
			$display("PASS LOAD");	
		end else begin
			$display("FAILED LOAD");	
		end

		// Test store
		opcode = STORE_OP;
		#10;
		if(dmr == 0 && dmw == 1 && data_read == 1 && data_write == 0 && alu_function == STORE) begin
			$display("PASS STORE");	
		end else begin
			$display("FAILED STORE");	
		end

		// Test add
		opcode = ADD_OP;
		#10;
		if(dmr == 0 && dmw== 0 && data_read == 1 && data_write == 1 && alu_function == ADD) begin
			$display("PASS ADD");	
		end else begin
			$display("FAILED ADD");	
		end

		// Test not
		opcode = NOT_OP;
		#10;
		if(dmr == 0 && dmw== 0 && data_read == 1 && data_write == 1 && alu_function == NOT) begin
			$display("PASS NOT");	
		end else begin
			$display("FAILED NOT");	
		end

		// Test nop
		opcode = NOP_OP;
		#10;
		if(dmr == 0 && dmw== 0 && data_read == 0 && data_write == 0 && alu_function == NOP) begin
			$display("PASS NOP");	
		end else begin
			$display("FAILED NOP");	
		end

		$finish;	
	end	
	
endmodule;