module  InstrMem #(parameter WORD_LENGTH=16,parameter ADDRESS_SPACE=21) (clk, MAR, MDR, reset, en);
input  [ADDRESS_SPACE-1:0] MAR;
input clk, reset, en;
output reg[WORD_LENGTH-1:0]   MDR;

reg [WORD_LENGTH-1:0] cache [((2 ** ADDRESS_SPACE)-1):0];

/* Note: reset is an active low signal */
integer i;
always @ (posedge clk)
    if (!reset)
        begin
            for (i=0; i<(2 ** ADDRESS_SPACE) ; i=i+1)
                cache[i] = 0;
            MDR = 'bz;
        end
    else
        begin
            if (en)
                begin
                    MDR = cache[MAR];
                end
            else
                begin
                    MDR = 'bz;
                end
        end

endmodule
