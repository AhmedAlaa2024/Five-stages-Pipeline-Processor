
module Processor (clk,reset,portIn,portOut,int_flag,ack);

//Inputs
input clk,reset,int_flag;
output ack;
input [15:0]portIn;
output [15:0]portOut;

//wire clk;

// wires



//------------------------------------  Fetch Stage Wires ------------------------------------ 
wire [31:0] PC_in,PC_out,PC_branch;
wire [15:0] IR_in;

//------------------------------------- Decode Stage  ------------------------------------ 
wire [15:0] IR_out;
wire [8:0] opcode;
wire [15:0] address_IN;
wire [31:0] SP_value_in;

wire [2:0] Opd2_Add;
wire [3:0] Opd1_Add,write_addr1;
wire [15:0] write_data1;
wire [31:0] write_pc_data;
wire [4:0]  write_ccr,write_back_ccr;

wire [15:0] Src1,Src2,final_Src;
wire [31:0] read_pc;
wire [4:0] read_ccr;
// Control Unit Signals
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
wire [20:0] control_signals_IN,control_signals_OUT;


// Call signals
wire [15:0]call_fsm_instruction,IR_in_call;
wire [31:0]call_pc,PC_call;
wire call_stall,change_pc_call;

// Ret signals
wire [15:0]ret_fsm_instruction;
wire ret_stall;
wire [15:0]IR_in_ret;

// Interrupt signals
wire int_flag,int_pc_stop,int_change_pc;
wire [15:0]int_instruction,IR_in_int;
wire [31:0]int_pc,PC_int;

// Rti signals
wire rti_stall;
wire [15:0]rti_instruction;
wire [15:0] IR_in_rti;

//------------------------------------- Execution Stage  ------------------------------------- 

// Hazards Detection Unit
wire loadUseStall;

wire [3:0] reg_dst_num_OUT;
wire [15:0] reg_dst_value_OUT;
wire [2:0] reg_src_1_num_OUT;
wire [15:0] reg_src_1_value_OUT;
wire [3:0] reg_src_2_num_OUT;
wire [15:0] reg_src_2_value_OUT;
wire [15:0] address_OUT;
wire [15:0] alu_address;
wire [15:0] decode_address;
wire [15:0] memory_address;
wire [15:0] final_memory_address;
wire [15:0] immediate_shift;
wire [31:0] SP_value_OUT;
wire [31:0] SP_address;
wire [31:0] SP_corrected_address;


wire forwardSrc1,forwardSrc2;
wire [15:0] Actual_Src_1_VALUE,Actual_Src_2_VALUE;
wire [15:0] forwardSrc1_VALUE,forwardSrc2_VALUE;
wire [15:0] result;

wire branch_taken;
//------------------------------------- Memory Stage ------------------------------------- 
wire [20:0] control_signals_OUT_Data;
wire [15:0] result_OUT_Data;
wire [15:0] address_OUT_Data;
wire [3:0] reg_dst_num_OUT_Data;
wire [15:0] reg_dst_value_OUT_Data;
wire [31:0] sp_Reg_OUT_Data;
wire memory_enable;
wire [15:0] MDR_out;
wire [15:0] write_back_output;
wire write_back_enable;


//---------------------------------- Write Back signals
wire [20:0] control_signals_OUT_WB;
wire [15:0] result_OUT_WB;
wire [3:0] reg_dst_num_OUT_WB;
wire [15:0] reg_dst_value_OUT_WB;
wire [31:0] sp_Reg_OUT_WB;





// Input wire IO
wire [15:0] in;
wire [15:0] write_back_output_IO;





//----------------------------------------  Fetch Stage --------------------------------------------------
// PC PC_reg (write_enable, clk, reset, PC_in, PC_out);

InstrMem #(16, 21) InstrCache (clk, PC_in[20:0], IR_in, reset);

// increment pcin , pcout = pcin + 1
Incrementor  #(32) PC_INC(.in(PC_in),.en(!loadUseStall & !call_stall & !call & !ret_stall & !ret & !int_pc_stop & !rti & !rti_stall),.out(PC_out));

mux #(16) callMux (.in1(call_fsm_instruction),.in2(IR_in), .out(IR_in_call), .sel(call_stall) );

mux #(16) retMux (.in1(ret_fsm_instruction),.in2(IR_in_call), .out(IR_in_ret), .sel(ret_stall) );

mux #(16) intMux (.in1(int_instruction),.in2(IR_in_ret), .out(IR_in_int), .sel(int_pc_stop) );

mux #(16) rtiMux (.in1(rti_instruction),.in2(IR_in_int), .out(IR_in_rti), .sel(rti_stall) );

FD_pipeline_register FD_pipe (IR_in_rti, IR_out, clk, reset & !branch_taken & !call & !ret & !rti & !pass_immediate,!loadUseStall);

//---------------------------------------- Decode Stage  -------------------------------------------------

/*
                    Integrate Control Unit with Pipeline Register Conflict
                    Integrate IR with Register file Conflict
*/

assign opcode[8:0] = IR_out[15:7];
CU  ControlUnit (opcode,1'b0,branch,data_read,data_write,DMR,DMW,IOE,IOR,IOW,stack_operation,push_pop,pass_immediate,write_sp,alu_function,rti,ret,call,branch_type);

//CU ControlUnit (opcode, mem_en, rw, data_read, data_write, alu_function);
/*
        write_sp_data -> write data of SP
        read_ccr -> input flags of ALU
        read_pc -> output PC
        read_sp -> output SP
        write_pc_data -> write back of pc value of adder "PC_out"or branch
        write_data1 -> write back of register
        write_addr1 -> write back address
*/

assign Opd1_Add =  IR_out[3:0];    // destination
assign Opd2_Add =  IR_out[6:4];    // source
//assign address_IN = IR_out;


regFile #(16,5,8) registers (.Data_write1(control_signals_OUT_WB[13]),.sp_write(control_signals_OUT[4]),
     .Src1(Src1),.Src2(Src2),.read_sp(SP_value_in),.read_pc(PC_in),.read_ccr(read_ccr),
     .write_sp_data(SP_address) , .write_pc_data(PC_int) , .write_ccr(write_ccr),.write_data1(result_OUT_WB),
      .clk(clk),.rst(reset),.Opd1_Add(Opd1_Add),.Opd2_Add(Opd2_Add),.write_addr1(reg_dst_num_OUT_WB),.en(loadUseStall));

assign control_signals_IN = {rti,ret,call,branch_type,branch,data_read,data_write,DMR,DMW,IOE,IOR,IOW,stack_operation,push_pop,pass_immediate,write_sp,alu_function};

/*
                Src1 -> is Destination which is operand2 in alu
                Src2 -> is Source which is operand1 in alu
*/
//mux #(16) imediate_mux (.in1(IR_in),.in2(Src2), .out(decode_address), .sel(control_signals_OUT[5]) );

DE_pipeline_register #(16) DE_pipe ( .control_sinals_IN(control_signals_IN), .control_sinals_OUT(control_signals_OUT), 
                             .reg_dst_num_IN(Opd1_Add), .reg_dst_num_OUT(reg_dst_num_OUT),
                             .reg_dst_value_IN(Src1), .reg_dst_value_OUT(reg_dst_value_OUT),
                             .reg_src_1_num_IN(Opd2_Add), .reg_src_1_num_OUT(reg_src_1_num_OUT),
                             .reg_src_1_value_IN(Src2), .reg_src_1_value_OUT(reg_src_1_value_OUT),
                             .reg_src_2_num_IN(Opd1_Add), .reg_src_2_num_OUT(reg_src_2_num_OUT),
                             .reg_src_2_value_IN(Src1), .reg_src_2_value_OUT(reg_src_2_value_OUT),
                             .address_IN(IR_in), .address_OUT(address_OUT),
                             .SP_value_IN(SP_value_in),.SP_value_OUT(SP_value_OUT),
                             .immediate_IN(IR_in),.immediate_OUT(immediate_shift) ,
                             .clk(clk), .reset(reset & !branch_taken),.en(!loadUseStall));

// or with reset signal pass_immediate signal to flush pipeline of immediate instruction
//----------------------------------------  Execution Stage --------------------------------------------

/*
                MUX for output of pipeline register and imediate value  in operand2 which is destination
                address_OUT or reg_src_2_value_OUT -> MUX
*/
mux #(16) forwardSrc1Mux (.in1(Actual_Src_1_VALUE),.in2(reg_src_1_value_OUT), .out(forwardSrc1_VALUE), .sel(forwardSrc1) );
mux #(16) forwardSrc2Mux (.in1(Actual_Src_2_VALUE),.in2(reg_src_2_value_OUT), .out(forwardSrc2_VALUE), .sel(forwardSrc2) );
mux #(16) imediate_shift(.in1(immediate_shift),.in2(forwardSrc1_VALUE), .out(final_Src), .sel(control_signals_OUT[5]) );

stackAdder SP_Value(.stack_op(control_signals_OUT[7]),.push_pop(control_signals_OUT[6]),.in(SP_value_OUT),.out(SP_address));

mux #(32) SP_mux (.in1(SP_value_OUT),.in2(SP_address), .out(SP_corrected_address), .sel(control_signals_OUT[6]) );


ALU alu( .op1(final_Src), .op2(forwardSrc2_VALUE), .func(control_signals_OUT[3:0]), .result(result),.inFlags(read_ccr) ,.outFlags(write_ccr) );

BranchUnit BU (.CCR(read_ccr[3:0]) ,.branch(control_signals_OUT[15]) ,.jmp_type(control_signals_OUT[17:16]) ,.is_taken(branch_taken) );

mux #(32) branch_mux (.in1({16'b0,result}),.in2(PC_out), .out(PC_branch), .sel(branch_taken) );

mux #(32) call_mux (.in1(call_pc),.in2(PC_branch), .out(PC_call), .sel(change_pc_call) );

mux #(32) int_mux (.in1(int_pc),.in2(PC_call), .out(PC_int), .sel(int_change_pc) );




// mux between address_OUT(immd) and Rsrc value not IR_in instead address_OUT
mux #(16) address_load (.in1(immediate_shift),.in2(reg_src_1_value_OUT), .out(alu_address), .sel(control_signals_OUT[5]) );

EM_pipeline_register #(16) EM_pipe (.control_sinals_IN(control_signals_OUT), .control_sinals_OUT(control_signals_OUT_Data),
                             .result_IN(result), .result_OUT(result_OUT_Data),
                             .address_IN(alu_address), .address_OUT(address_OUT_Data),
                             .reg_dst_num_IN(reg_dst_num_OUT), .reg_dst_num_OUT(reg_dst_num_OUT_Data),
                             .reg_dst_value_IN(forwardSrc2_VALUE), .reg_dst_value_OUT(reg_dst_value_OUT_Data), // reg_dst_value_OUT changed to forwardSrc2_VALUE
                             .sp_Reg_IN(SP_corrected_address), .sp_Reg_OUT(sp_Reg_OUT_Data),
                             .CCR_Reg_IN(write_ccr),.CCR_Reg_OUT(write_back_ccr),
                             .clk(clk), .reset(reset));


//----------------------------------------  Memory Stage --------------------------------------------

/*
                MDR out result -> should be send to write back and be write back of register
                need mux for MDR out and ALU output result in  Write Back stage
                memory enable is oring push_pop signale and DMR and DMW
*/

assign memory_enable = control_signals_OUT_Data[11] | control_signals_OUT_Data[12] ;
// mux between address_OUT_Data and Rdst value with memory write as selector
mux #(16) address_mem (.in1(reg_dst_value_OUT_Data),.in2(address_OUT_Data), .out(memory_address), .sel(control_signals_OUT_Data[11]) );

mux #(16) stack_address_mux (.in1(sp_Reg_OUT_Data[15:0]),.in2(memory_address), .out(final_memory_address), .sel(control_signals_OUT_Data[7]) );

DataMem #(16,12) DM ( .clk(clk), .MAR(final_memory_address[11:0]), .MDR_in(result_OUT_Data) , .MDR_out(MDR_out) , .reset(reset) , .mem(memory_enable), .rw(control_signals_OUT_Data[12]));


//  Write Back Stage 
//assign write_back_enable = control_signals_OUT_WB[12] | control_signals_OUT_WB[11] | control_signals_OUT_WB[10] ;
assign write_back_enable = control_signals_OUT_Data[12];
mux #(16) MUX1 (.in1(MDR_out),.in2(result_OUT_Data), .out(write_back_output), .sel(write_back_enable) );
mux #(16) MUX2 (.in1(in),.in2(write_back_output), .out(write_back_output_IO), .sel(control_signals_OUT_Data[9] & control_signals_OUT_Data[10]) );

MW_pipeline_register #(16) MW_pipe(.control_sinals_IN(control_signals_OUT_Data), .control_sinals_OUT(control_signals_OUT_WB),
                             .result_IN(write_back_output_IO), .result_OUT(result_OUT_WB),
                             .reg_dst_num_IN(reg_dst_num_OUT_Data), .reg_dst_num_OUT(reg_dst_num_OUT_WB),
                             .reg_dst_value_IN(reg_dst_value_OUT_Data), .reg_dst_value_OUT(reg_dst_value_OUT_WB),
                             .sp_Reg_IN(sp_Reg_OUT_Data), .sp_Reg_OUT(sp_Reg_OUT_WB),
                             .clk(clk), .reset(reset));
                          
//----------------------------------------  Write Back Stage --------------------------------------------


// Forward Unit Block
// need two muxs for source and destination in Executation stage
// need two muxs for source and destination in Memory stage

Full_FU FU (.Current_Src_1_NUM(reg_src_1_num_OUT),.Current_Src_2_NUM(reg_src_2_num_OUT),
            .Old_Dst_1_NUM(reg_dst_num_OUT_Data), .Old_Dst_1_VALUE(write_back_output_IO),
            .Old_Dst_2_NUM(reg_dst_num_OUT_WB), .Old_Dst_2_VALUE(result_OUT_WB),
            .Actual_Src_1_VALUE(Actual_Src_1_VALUE),
            .Actual_Src_2_VALUE(Actual_Src_2_VALUE),
            .M2R1(control_signals_OUT_Data[12]), .M2R2(control_signals_OUT_WB[12]),
            .enable(1'b1), .clk(clk),
            .forwardSrc1(forwardSrc1),.forwardSrc2(forwardSrc2));


// Hazards Detection Unit
HDU load_use_stall(
    .Old_Dst_NUM(Opd1_Add),
    .Current_Src_NUM(reg_dst_num_OUT),
    .DMR(control_signals_OUT[12] | control_signals_OUT[9]),
    .enable(1'b1),
    .clk(clk),
    .Stall(loadUseStall)
);

// IO unit
IO io(.Result(result_OUT_Data),
    .PORTIN(portIn),
    .PORTOUT(portOut),
    .IN(in),
    .IOR(control_signals_OUT_Data[9]),
    .IOW(control_signals_OUT_Data[8]),
    .IOE(control_signals_OUT_Data[10]),
    .reset(reset),
    .clk(clk));

call_fsm callFsm(.reset(reset),
    .call(call),
    .clk(clk),
    .rdst_value(Src1),
    .out(call_fsm_instruction),
    .pc(call_pc),
    .stall(call_stall),
    .change_pc_call(change_pc_call));


ret_fsm retFsm(.reset(reset),
               .ret(ret),
               .clk(clk),
               .out(ret_fsm_instruction),
               .stall(ret_stall));

ICU icu(.int_flag(int_flag), 
    .ack(ack), 
    .pc_stop(int_pc_stop), 
    .instruction(int_instruction), 
    .PC_VALUE(int_pc), 
    .clk(clk), 
    .enable(1'b1), 
    .reset(reset),
    .pc_change(int_change_pc));

rti_fsm rtiFsm(.reset(reset),
        .rti(rti),
        .clk(clk),
        .out(rti_instruction),
        .stall(rti_stall));

endmodule
