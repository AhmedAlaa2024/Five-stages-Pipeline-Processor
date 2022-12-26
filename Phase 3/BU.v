module BU(ZF, B, FD_reset, DE_reset, enable, clk);

input ZF, B;
output reg FD_reset, DE_reset;

input enable, clk;

assign FD_reset = (ZF & B)? 1'b1 : 1'b0;
assign DE_reset = (ZF & B)? 1'b1 : 1'b0;

always @(posedge clk) 
    begin
        FD_reset <= (enable & ZF & B);
        DE_reset <= (enable & ZF & B);
    end
endmodule