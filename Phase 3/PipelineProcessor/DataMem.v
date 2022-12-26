module  DataMem #(parameter WORD_LENGTH=16, parameter ADDRESS_SPACE=12) (clk, MAR, MDR_in,MDR_out, reset, mem, rw);
input [ADDRESS_SPACE-1:0] MAR;
input reset, clk, mem, rw;

input [WORD_LENGTH-1:0]   MDR_in;
output [WORD_LENGTH-1:0]   MDR_out;

reg [WORD_LENGTH-1:0]   MDR_reg;
reg [WORD_LENGTH-1:0] cache [((2 ** ADDRESS_SPACE)-1):0];

/* Note: reset is an active low signal */
assign MDR_out=MDR_reg;
integer i;
always @ (negedge clk)
    if (!reset)
        begin
            for (i=0; i<(2 ** ADDRESS_SPACE) ; i=i+1)
                cache[i] = 0;
            MDR_reg = 'bz;
        end
    else
        begin
            if (mem)
            // neable the memory
                begin
                    if (rw)
                     // enable reade in the memory
                        begin
                            MDR_reg = cache[MAR];
                        end
                    else
                        begin
                            cache[MAR] = MDR_in;
                        end
                end
            else
                MDR_reg = 'bz;
        end

endmodule