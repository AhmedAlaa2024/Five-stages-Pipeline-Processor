module  InstrMem #(parameter WORD_LENGTH=16,parameter ADDRESS_SPACE=21) (clk, MAR, MDR, reset);
input  [ADDRESS_SPACE-1:0] MAR;
input clk, reset;
output reg[WORD_LENGTH-1:0]   MDR;

reg [WORD_LENGTH-1:0] cache [((2 ** ADDRESS_SPACE)-1):0];

/* Note: reset is an active low signal */
/* Note: reset with posedge clock ?!l */
integer i;
always @ (posedge clk)
    if (!reset)
        begin
            MDR = 'bz;
        end
    else
        begin
            MDR = cache[MAR];

        end

endmodule
