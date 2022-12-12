
module Processor (clk,reset);

//Inputs
input clk,reset;


// wires
wire write_enable,mem_en,rw,M2R,data_read,data_write;
wire [31:0] PC_in,PC_out;
wire [15:0] IR_in,IR_out,MDR_out,write_data,operand1,operand2,result;
wire [8:0] opcode;
wire [3:0] Rsrc,Rdst;
wire [4:0] outFlags;
//------------------------------------- Control Unit Signals
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
wire [15:0] control_signals_IN,control_signals_OUT;

//------------------------------------- DE Pipeline Signals
wire [3:0] reg_dst_num_IN;
wire [3:0] reg_dst_num_OUT;
wire [15:0] reg_dst_value_IN;
wire [15:0] reg_dst_value_OUT;
wire [2:0] reg_src_1_num_IN;
wire [2:0] reg_src_1_num_OUT;
wire [15:0] reg_src_1_value_IN;
wire [15:0] reg_src_1_value_OUT;
wire [3:0] reg_src_2_num_IN;
wire [3:0] reg_src_2_num_OUT;
wire [15:0] reg_src_2_value_IN;
wire [15:0] reg_src_2_value_OUT;
wire [15:0] address_IN;
wire [15:0] address_OUT;


//------------------------------------- EM Pipeline Signals
wire [6:0] control_signals_IN_Data;
wire [6:0] control_signals_OUT_Data;
wire [15:0] result_IN_Data;
wire [15:0] result_OUT_Data;
wire [15:0] address_IN_Data;
wire [15:0] address_OUT_Data;
wire [2:0] reg_dst_num_IN_Data;
wire [2:0] reg_dst_num_OUT_Data;
wire [3:0] reg_dst_value_IN_Data;
wire [3:0] reg_dst_value_OUT_Data;
wire [31:0] sp_Reg_IN_Data;
wire [31:0] sp_Reg_OUT_Data;

//---------------------------------- MW Pipeline signals
wire [4:0] control_sinals_IN_WB;
wire [4:0] control_sinals_OUT_WB;
wire [15:0] result_IN_WB;
wire [15:0] result_OUT_WB;
wire [2:0] reg_dst_num_IN_WB;
wire [2:0] reg_dst_num_OUT_WB;
wire [3:0] reg_dst_value_IN_WB;
wire [3:0] reg_dst_value_OUT_WB;
wire [31:0] sp_Reg_IN_WB;
wire [31:0] sp_Reg_OUT_WB;


//----------------------------------------  Fetch Stage --------------------------------------------------
// PC PC_reg (write_enable, clk, reset, PC_in, PC_out);

InstrMem #(16, 21) InstrCache (clk, PC_in[20:0], IR_in, reset);

FD_pipeline_register FD_pipe (IR_in, IR_out, clk, reset);

//---------------------------------------- Decode Stage  -------------------------------------------------

/*
                    Integrate Control Unit with Pipeline Register Conflict
                    Integrate IR with Register file Conflict
*/
assign opcode[8:0] = IR_out[15:7];
CU  ControlUnit (opcode,branch,data_read,data_write,DMR,DMW,IOE,IOR,IOW,stack_operation,push_pop,pass_immediate,write_sp,alu_function);

//CU ControlUnit (opcode, mem_en, rw, data_read, data_write, alu_function);

// regFile registers (data_read, data_write, operand1, operand2, write_data, 1'b0, clk, reset, Rsrc, Rdst, Rdst);

assign control_signals_IN = {branch,data_read,data_write,DMR,DMW,IOE,IOR,IOW,stack_operation,push_pop,pass_immediate,write_sp,alu_function};

DE_pipeline_register #(16) DE_pipe (control_signals_IN, control_signals_OUT, 
                             reg_dst_num_IN, reg_dst_num_OUT,
                             reg_dst_value_IN, reg_dst_value_OUT,
                             reg_src_1_num_IN, reg_src_1_num_OUT,
                             reg_src_1_value_IN, reg_src_1_value_OUT,
                             reg_src_2_num_IN, reg_src_2_num_OUT,
                             reg_src_2_value_IN, reg_src_2_value_OUT,
                             address_IN, address_OUT,
                             clk, reset);

//----------------------------------------  Execution Stage --------------------------------------------
ALU alu( .operand1(reg_src_1_value_OUT), .operand2(reg_src_2_value_OUT), .alu_function(control_signals_OUT[3:0]), .result(result), .outFlags(outFlags) );


assign control_signals_IN_Data = {branch,data_read,data_write,DMR,DMW,IOE,IOR,IOW,stack_operation,push_pop,pass_immediate,write_sp,alu_function};

EM_pipeline_register #(16) EM_pipe (control_signals_IN_Data, control_signals_OUT_Data,
                             result, result_OUT_Data,
                             address_IN_Data, address_OUT_Data,
                             reg_dst_num_IN_Data, reg_dst_num_OUT_Data,
                             reg_dst_value_IN_Data, reg_dst_value_OUT_Data,
                             sp_Reg_IN_Data, sp_Reg_OUT_Data,
                             clk, reset);

//----------------------------------------  Memory Stage --------------------------------------------

DataMem  #(16, 12)  DM(clk, operand1[11:0], result,MDR_out, reset, mem_en, rw);


MW_pipeline_register #(5) MW_pipe(control_signals_IN_WB, control_sinals_OUT_WB,
                             result_IN_WB, result_OUT_WB,
                             reg_dst_num_IN_WB, reg_dst_num_OUT_WB,
                             reg_dst_value_IN_WB, reg_dst_value_OUT_WB,
                             sp_Reg_IN_WB, sp_Reg_OUT_WB,
                             clk, reset);
//----------------------------------------  Write Back Stage --------------------------------------------
Incrementor  #(32) PC_INC(PC_out,PC_in);

// Mux for MDR_out || result
mux #(16) MUX1 (result,MDR_out, write_data, M2R);


//assign reset = 1'b1;
//assign M2R  = mem_en & rw;

endmodule
