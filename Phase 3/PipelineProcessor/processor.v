
module Processor (clk,reset);

//Inputs
input clk,reset;
//wire clk;

// wires
wire [31:0] PC_in,PC_out;
wire [15:0] IR_in,IR_out,write_data,result;
wire [8:0] opcode;
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
wire [3:0] reg_dst_num_OUT;
wire [15:0] reg_dst_value_OUT;
wire [2:0] reg_src_1_num_OUT;
wire [15:0] reg_src_1_value_OUT;
wire [3:0] reg_src_2_num_OUT;
wire [15:0] reg_src_2_value_OUT;
wire [15:0] address_IN;
wire [15:0] address_OUT;
wire [15:0] alu_address;
wire [15:0] decode_address;
wire [15:0] memory_address;


wire [2:0] Opd2_Add;
wire [3:0] Opd1_Add,write_addr1;
wire [15:0] write_data1;
wire [31:0] write_sp_data,write_pc_data;
wire [4:0]  write_ccr;

wire [15:0] Src1,Src2;
wire [31:0] read_sp,read_pc;
wire [4:0] read_ccr;

wire forwardSrc1,forwardSrc2;
wire [15:0] Actual_Src_1_VALUE,Actual_Src_2_VALUE;
wire [15:0] forwardSrc1_VALUE,forwardSrc2_VALUE;

//------------------------------------- EM Pipeline Signals
wire [15:0] control_signals_OUT_Data;
wire [15:0] result_OUT_Data;
wire [15:0] address_OUT_Data;
wire [3:0] reg_dst_num_OUT_Data;
wire [15:0] reg_dst_value_OUT_Data;
wire [31:0] sp_Reg_IN_Data;
wire [31:0] sp_Reg_OUT_Data;




//---------------------------------- MW Pipeline signals
wire [15:0] control_signals_OUT_WB;
wire [15:0] result_OUT_WB;
wire [3:0] reg_dst_num_OUT_WB;
wire [15:0] reg_dst_value_OUT_WB;
wire [31:0] sp_Reg_OUT_WB;


wire memory_enable;
wire [15:0] MDR_out;

//---------------------------------- WF Pipeline signals

wire [15:0] write_back_output;
wire write_back_enable;


// Hazards Detection Unit

wire loadUseStall;



//----------------------------------------  Fetch Stage --------------------------------------------------
// PC PC_reg (write_enable, clk, reset, PC_in, PC_out);

InstrMem #(16, 21) InstrCache (clk, PC_in[20:0], IR_in, reset);

// increment pcin , pcout = pcin + 1
Incrementor  #(32) PC_INC(.in(PC_in),.en(!loadUseStall),.out(PC_out));
FD_pipeline_register FD_pipe (IR_in, IR_out, clk, reset,!loadUseStall);

//---------------------------------------- Decode Stage  -------------------------------------------------

/*
                    Integrate Control Unit with Pipeline Register Conflict
                    Integrate IR with Register file Conflict
*/

assign opcode[8:0] = IR_out[15:7];
CU  ControlUnit (opcode,branch,data_read,data_write,DMR,DMW,IOE,IOR,IOW,stack_operation,push_pop,pass_immediate,write_sp,alu_function);

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


regFile #(16,5,8) registers (.Data_write1(control_signals_OUT_WB[13]),.sp_write(write_sp),
     .Src1(Src1),.Src2(Src2),.read_sp(read_sp),.read_pc(PC_in),.read_ccr(read_ccr),
     .write_sp_data(write_sp_data) , .write_pc_data(PC_out) , .write_ccr(write_ccr),.write_data1(result_OUT_WB),
      .clk(clk),.rst(reset),.Opd1_Add(Opd1_Add),.Opd2_Add(Opd2_Add),.write_addr1(reg_dst_num_OUT_WB),.en(loadUseStall));

assign control_signals_IN = {branch,data_read,data_write,DMR,DMW,IOE,IOR,IOW,stack_operation,push_pop,pass_immediate,write_sp,alu_function};

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
                             .address_IN(address_IN), .address_OUT(address_OUT),
                             .clk(clk), .reset(reset),.en(!loadUseStall));

//----------------------------------------  Execution Stage --------------------------------------------

/*
                MUX for output of pipeline register and imediate value  in operand2 which is destination
                address_OUT or reg_src_2_value_OUT -> MUX
*/
mux #(16) forwardSrc1Mux (.in1(Actual_Src_1_VALUE),.in2(reg_src_1_value_OUT), .out(forwardSrc1_VALUE), .sel(forwardSrc1) );
mux #(16) forwardSrc2Mux (.in1(Actual_Src_2_VALUE),.in2(reg_src_2_value_OUT), .out(forwardSrc2_VALUE), .sel(forwardSrc2) );

ALU alu( .op1(forwardSrc1_VALUE), .op2(forwardSrc2_VALUE), .func(control_signals_OUT[3:0]), .result(result),.inFlags(read_ccr) ,.outFlags(write_ccr) );

/*
                Missing SP data value in DE stage so that can be propagated to EM stage //sp_Reg_IN_Data
*/

/*
                SP Adder circuit in Execution stage according to push_pop signal
                MUX for ALU Result and SP for MAR
*/

// mux between address_OUT(immd) and Rsrc value
mux #(16) address_load (.in1(IR_in),.in2(reg_src_1_value_OUT), .out(alu_address), .sel(control_signals_OUT[5]) );

EM_pipeline_register #(16) EM_pipe (.control_sinals_IN(control_signals_OUT), .control_sinals_OUT(control_signals_OUT_Data),
                             .result_IN(result), .result_OUT(result_OUT_Data),
                             .address_IN(alu_address), .address_OUT(address_OUT_Data),
                             .reg_dst_num_IN(reg_dst_num_OUT), .reg_dst_num_OUT(reg_dst_num_OUT_Data),
                             .reg_dst_value_IN(reg_dst_value_OUT), .reg_dst_value_OUT(reg_dst_value_OUT_Data),
                             .sp_Reg_IN(sp_Reg_IN_Data), .sp_Reg_OUT(sp_Reg_OUT_Data),
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

DataMem #(16,12) DM ( .clk(clk), .MAR(memory_address[11:0]), .MDR_in(result_OUT_Data) , .MDR_out(MDR_out) , .reset(reset) , .mem(memory_enable), .rw(control_signals_OUT_Data[12]));


//  Write Back Stage 
//assign write_back_enable = control_signals_OUT_WB[12] | control_signals_OUT_WB[11] | control_signals_OUT_WB[10] ;
assign write_back_enable = control_signals_OUT_Data[12];
mux #(16) MUX1 (.in1(MDR_out),.in2(result_OUT_Data), .out(write_back_output), .sel(write_back_enable) );

MW_pipeline_register #(16) MW_pipe(.control_sinals_IN(control_signals_OUT_Data), .control_sinals_OUT(control_signals_OUT_WB),
                             .result_IN(write_back_output), .result_OUT(result_OUT_WB),
                             .reg_dst_num_IN(reg_dst_num_OUT_Data), .reg_dst_num_OUT(reg_dst_num_OUT_WB),
                             .reg_dst_value_IN(reg_dst_value_OUT_Data), .reg_dst_value_OUT(reg_dst_value_OUT_WB),
                             .sp_Reg_IN(sp_Reg_OUT_Data), .sp_Reg_OUT(sp_Reg_OUT_WB),
                             .clk(clk), .reset(reset));
                          
//----------------------------------------  Write Back Stage --------------------------------------------


// Forward Unit Block
// need two muxs for source and destination in Executation stage
// need two muxs for source and destination in Memory stage

Full_FU FU (.Current_Src_1_NUM(reg_src_1_num_OUT),.Current_Src_2_NUM(reg_src_2_num_OUT),
            .Old_Dst_1_NUM(reg_dst_num_OUT_Data), .Old_Dst_1_VALUE(result_OUT_Data),
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
    .DMR(control_signals_OUT[12]),
    .enable(1'b1),
    .clk(clk),
    .Stall(loadUseStall)
);

endmodule
