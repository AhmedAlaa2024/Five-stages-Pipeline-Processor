module HDU(
    Old_Dst_NUM,
    Current_Src_NUM,
    DMR,
    enable,
    clk,
    Stall
);

input [3:0] Old_Dst_NUM;
input [3:0] Current_Src_NUM;
input DMR, enable, clk;

output reg Stall;

always @(posedge clk) 
    begin
        if (enable == 1)
            begin
                if (DMR == 1)
                    begin
                        if (Current_Src_NUM == Old_Dst_NUM)
                            begin
                                Stall = 1;
                            end
                        else
                            begin
                                Stall = 0;
                            end
                    end
                else
                    begin
                        Stall = 0;
                    end
            end
        else
            begin
                Stall = 0;
            end
    end

endmodule;