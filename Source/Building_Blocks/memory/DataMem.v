module  InstrMem #(parameter WORD_LENGTH=16, parameter ADDRESS_SPACE=12) (clk, MAR, MDR, reset, mem, rw, en);
input [ADDRESS_SPACE-1:0] MAR;
input reset, clk, mem, rw, en;
inout [WORD_LENGTH-1:0]   MDR;

reg [WORD_LENGTH-1:0] cache [((2 ** ADDRESS_SPACE)-1):0];

/* Note: reset is an active low signal */
always @ (posedge clk)
    if (!reset)
        begin
            cache = 0;
            MDR = 'bz;
        end
    else
        begin
            if (mem && en)
                begin
                    if (rw)
                        begin
                            MDR = cache[MAR];
                        end
                    else
                        begin
                            cache[MAR] = MDR;
                        end
                end
            else
                MDR = 'bz;
        end

endmodule