module Full_FU(Current_Src_1_NUM,
                  Current_Src_2_NUM,
                  Old_Dst_1_NUM, Old_Dst_1_VALUE,
                  Old_Dst_2_NUM, Old_Dst_2_VALUE,
                  Actual_Src_1_VALUE,
                  Actual_Src_2_VALUE,
                  M2R1, M2R2,
                  enable, clk,
                  forwardSrc1,forwardSrc2);

input [2:0] Current_Src_1_NUM;
input [3:0] Current_Src_2_NUM, Old_Dst_1_NUM, Old_Dst_2_NUM;
input [15:0] Old_Dst_1_VALUE, Old_Dst_2_VALUE;
output reg [15:0] Actual_Src_1_VALUE, Actual_Src_2_VALUE;
output reg forwardSrc1,forwardSrc2;
input M2R1, M2R2;
input enable, clk;

always @ (*)
    begin
        forwardSrc1 = 1'b0;
        forwardSrc2 = 1'b0;
        if (enable == 1)
            begin
                Actual_Src_1_VALUE = 16'bz;
                Actual_Src_2_VALUE = 16'bz;
                if (Old_Dst_2_NUM == Current_Src_1_NUM)
                    begin
                        Actual_Src_1_VALUE = Old_Dst_2_VALUE;
                        forwardSrc1  =1'b1;
                    end
                else if (Old_Dst_2_NUM == Current_Src_2_NUM) // removed else
                    begin
                        Actual_Src_2_VALUE = Old_Dst_2_VALUE;
                        forwardSrc2  =1'b1;
                    end

                if (Old_Dst_1_NUM == Current_Src_1_NUM)
                    begin
                        Actual_Src_1_VALUE = Old_Dst_1_VALUE;
                        forwardSrc1  =1'b1;
                    end
                else if (Old_Dst_1_NUM == Current_Src_2_NUM) // removed else
                    begin
                        Actual_Src_2_VALUE = Old_Dst_1_VALUE;
                        forwardSrc2  =1'b1;
                    end
            end
        else
            begin
                Actual_Src_1_VALUE <= 16'bz;
                Actual_Src_2_VALUE <= 16'bz;
            end
    end

endmodule