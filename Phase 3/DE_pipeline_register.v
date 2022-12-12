module DE_pipeline_register #(parameter NUMBER_CONTROL_SIGNALS = 14) (control_sinals_IN, control_sinals_OUT, 
                             reg_dst_num_IN, reg_dst_num_OUT,
                             reg_dst_value_IN, reg_dst_value_OUT,
                             reg_src_1_num_IN, reg_src_1_num_OUT,
                             reg_src_1_value_IN, reg_src_1_value_OUT,
                             reg_src_2_num_IN, reg_src_2_num_OUT,
                             reg_src_2_value_IN, reg_src_2_value_OUT,
                             address_IN, address_OUT,
                             clk, reset);

input [NUMBER_CONTROL_SIGNALS-1:0] control_sinals_IN;
output [NUMBER_CONTROL_SIGNALS-1:0] control_sinals_OUT;
reg [NUMBER_CONTROL_SIGNALS-1:0] control_sinals_REG;

input [2:0] reg_dst_num_IN;
output [2:0] reg_dst_num_OUT;
reg [2:0] reg_dst_num_REG;

input [2:0] reg_dst_value_IN;
output [2:0] reg_dst_value_OUT;
reg [2:0] reg_dst_value_REG;

input [3:0] reg_src_1_num_IN;
output [3:0] reg_src_1_num_OUT;
reg [3:0] reg_src_1_num_REG;

input [3:0] reg_src_1_value_IN;
output [3:0] reg_src_1_value_OUT;
reg [3:0] reg_src_1_value_REG;

input [3:0] reg_src_2_num_IN;
output [3:0] reg_src_2_num_OUT;
reg [3:0] reg_src_2_num_REG;

input [3:0] reg_src_2_value_IN;
output [3:0] reg_src_2_value_OUT;
reg [3:0] reg_src_2_value_REG;

input [15:0] address_IN;
output [15:0] address_OUT;
reg [15:0] address_REG;

input clk;
input reset;

// Asynchronous read
assign control_sinals_OUT = control_sinals_REG;
assign reg_dst_num_OUT = reg_dst_num_REG;
assign reg_dst_value_OUT = reg_dst_value_REG;
assign reg_src_1_num_OUT = reg_src_1_num_REG;
assign reg_src_1_value_OUT = reg_src_1_value_REG;
assign reg_src_2_num_OUT = reg_src_2_num_REG;
assign reg_src_2_value_OUT = reg_src_2_value_REG;
assign address_OUT = address_REG;

always @(posedge clk)
    begin
        // Active low reset
        if (!reset)
            begin
                control_sinals_REG = 0;
                reg_dst_num_REG = 0;
                reg_dst_value_REG = 0;
                reg_src_1_num_REG = 0;
                reg_src_1_value_REG = 0;
                reg_src_2_num_REG = 0;
                reg_src_2_value_REG = 0;
                address_REG = 0;
            end
        // Synchronous write @ +ve edge
        else
            begin
                control_sinals_REG = control_sinals_IN;
                reg_dst_num_REG = reg_dst_num_IN;
                reg_dst_value_REG = reg_dst_value_IN;
                reg_src_1_num_REG = reg_src_1_num_IN;
                reg_src_1_value_REG = reg_src_1_value_IN;
                reg_src_2_num_REG = reg_src_2_num_IN;
                reg_src_2_value_REG = reg_src_2_value_IN;
                address_REG = address_IN;
            end
    end
endmodule