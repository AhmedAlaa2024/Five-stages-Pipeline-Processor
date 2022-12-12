module FD_pipeline_register (IR_Reg_IN, IR_Reg_OUT, clk, reset);
input [15:0] IR_Reg_IN;
output [15:0] IR_Reg_OUT;
input clk;
input reset;

reg [15:0] FD_PIPELINE_REG;

// Asynchronous read
assign IR_Reg_OUT = FD_PIPELINE_REG;

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