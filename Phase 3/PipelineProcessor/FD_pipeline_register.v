module FD_pipeline_register (IR_Reg_IN, IR_Reg_OUT, clk, reset,en);
input [15:0] IR_Reg_IN;
output [15:0] IR_Reg_OUT;
input clk;
input reset;
input en;

reg [15:0] FD_PIPELINE_REG;

// Asynchronous read
assign IR_Reg_OUT = (en)? FD_PIPELINE_REG:0;

always @(posedge clk)
    begin
        // Active low reset
        if (!reset)
            begin
                FD_PIPELINE_REG = 0;
            end
        // Synchronous write @ +ve edge
        else
            begin
                FD_PIPELINE_REG = IR_Reg_IN;
            end
    end
endmodule