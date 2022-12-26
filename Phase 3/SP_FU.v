module SP_FU(
    SP1_VALUE, Stack_OP_1,
    SP2_VALUE, Stack_OP_2,
    SPact_VALUE, Stack_OP_src,
    enable, clk
);

input [31:0] SP1_VALUE;
input [31:0] SP2_VALUE;
output reg [31:0] SPact_VALUE;

input Stack_OP_1;
input Stack_OP_2;
input Stack_OP_src;

input enable, clk;

always @(posedge clk) begin
    if (enable == 1)
        begin
            if (Stack_OP_src == 1)
                begin
                    if (Stack_OP_1 == 1)
                        begin
                            SPact_VALUE <= SP1_VALUE;
                        end
                    else if (Stack_OP_2 == 1)
                        begin
                            SPact_VALUE <= SP2_VALUE;
                        end
                    else
                        SPact_VALUE <= 32'bz;
                end
            else
                begin
                    SPact_VALUE <= 32'bz;
                end
        end
    else
        begin
            SPact_VALUE <= 32'bz;
        end
end

endmodule