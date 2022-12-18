module FU_ALU_ALU(Current_Src_1_NUM,
                  Current_Src_2_NUM,
                  Old_Dst_1_NUM, Old_Dst_1_VALUE,
                  Old_Dst_2_NUM, Old_Dst_2_VALUE,
                  Actual_Src_1_VALUE,
                  Actual_Src_2_VALUE,
                  M2R1, M2R2,
                  enable, clk);

input [3:0] Current_Src_1_NUM, Current_Src_2_NUM, Old_Dst_1_NUM, Old_Dst_2_NUM;
input [15:0] Old_Dst_1_VALUE, Old_Dst_2_VALUE;
output reg [15:0] Actual_Src_1_VALUE, Actual_Src_2_VALUE;
input M2R1, M2R2;
input enable, clk;

always @ (posedge clk)
    begin
        if (enable == 1)
            begin
                if ((M2R1 == 0) && (M2R2 == 0))
                    begin
                        Actual_Src_1_VALUE = 16'bz;
                        Actual_Src_2_VALUE = 16'bz;
                    end
                else if ((M2R1 == 1) && (M2R2 == 0))
                    begin
                        if (Old_Dst_1_NUM == Current_Src_1_NUM)
                            begin
                                Actual_Src_1_VALUE <= Old_Dst_1_VALUE;
                            end
                        else if (Old_Dst_1_NUM == Current_Src_2_NUM)
                            begin
                                Actual_Src_2_VALUE <= Old_Dst_1_VALUE;
                            end
                    end
                else if ((M2R1 == 0) && (M2R2 == 1))
                    begin
                        if (Old_Dst_2_NUM == Current_Src_1_NUM)
                            begin
                                Actual_Src_1_VALUE <= Old_Dst_2_VALUE;
                            end
                        else if (Old_Dst_2_NUM == Current_Src_2_NUM)
                            begin
                                Actual_Src_2_VALUE <= Old_Dst_2_VALUE;
                            end
                    end
                else /* if ((M2R1 == 1) && (M2R2 == 1)) */
                    begin
                        /* Check the result out from the ALU first */
                        if (Old_Dst_1_NUM == Current_Src_1_NUM)
                            begin
                                Actual_Src_1_VALUE <= Old_Dst_1_VALUE;
                            end
                        else if (Old_Dst_1_NUM == Current_Src_2_NUM)
                            begin
                                Actual_Src_2_VALUE <= Old_Dst_1_VALUE;
                            end
                            /* Then check the data out from the memory */
                        else if (Old_Dst_2_NUM == Current_Src_1_NUM)
                            begin
                                Actual_Src_1_VALUE <= Old_Dst_2_VALUE;
                            end
                        else if (Old_Dst_2_NUM == Current_Src_2_NUM)
                            begin
                                Actual_Src_2_VALUE <= Old_Dst_2_VALUE;
                            end
                        else
                            begin
                                Actual_Src_1_VALUE = 16'bz;
                                Actual_Src_2_VALUE = 16'bz;
                            end
                    end
            end
        else
            begin
                Actual_Src_1_VALUE <= 16'bz;
                Actual_Src_2_VALUE <= 16'bz;
            end
    end

endmodule