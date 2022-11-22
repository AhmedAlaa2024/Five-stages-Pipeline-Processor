module  InstrMem #(parameter WORD_LENGTH=16, parameter ADDRESS_SPACE=12) (clk, MAR, MDR, reset, mem, rw, en);
input [ADDRESS_SPACE-1:0] MAR;
input reset, clk, mem, rw, en;
inout [WORD_LENGTH-1:0]   MDR;
reg [WORD_LENGTH-1:0]   MDR_reg;
reg [WORD_LENGTH-1:0] cache [((2 ** ADDRESS_SPACE)-1):0];

/* Note: reset is an active low signal */
assign MDR=MDR_reg;
integer i;
always @ (posedge clk)
    if (!reset)
        begin
            for (i=0; i<(2 ** ADDRESS_SPACE) ; i=i+1)
                cache[i] = 0;
            MDR_reg = 'bz;
        end
    else
        begin
            if (mem && en)
                begin
                    if (rw)
                        begin
                            MDR_reg = cache[MAR];
                        end
                    else
                        begin
                            cache[MAR] = MDR;
                        end
                end
            else
                MDR_reg = 'bz;
        end

endmodule