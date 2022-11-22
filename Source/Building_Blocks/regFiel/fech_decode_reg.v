module  fech_decode_reg #(parameter IR_SIZE=16) (IR_in,write_en,IR_out,clk,reset);
parameter START_ADDRESS=(2 ** 5);
input [IR_SIZE-1:0]IR_in;
input clk,reset,write_en;
output  [IR_SIZE-1:0] IR_out;
reg [IR_SIZE-1:0] IR;

assign IR_out=IR;
always @ (posedge clk)
    if (!reset)
        begin
            IR = START_ADDRESS;
        end
    else if(!write_en)
        begin
            IR <= IR_in;
        end

endmodule
