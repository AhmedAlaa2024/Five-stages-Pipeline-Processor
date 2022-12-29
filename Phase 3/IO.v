module IO(Result, PORTIN, PORTOUT, IN, IOR, IOW, IOE, reset, clk);

input [15:0] Result;
input [15:0] PORTIN;
input IOE, IOR, IOW;
input reset, clk;

output [15:0] PORTOUT;
output [15:0] IN;

reg [15:0] PORTIN_DATA;
reg [15:0] PORTOUT_DATA;

assign IN = PORTIN_DATA;
assign PORTOUT = PORTOUT_DATA;

always @(posedge clk) 
    begin
        if (!reset)
            begin
                PORTIN_DATA = 16'b0;
                PORTOUT_DATA = 16'b0;
            end
        else
            begin
                /* Take a snapshot of the data at the input pins */
                if (IOE & IOR)
                    begin
                        PORTIN_DATA = PORTIN;
                    end
                
                /* Propagate the data out from the memory stage to the output pins */
                if (IOE & IOW)
                    begin
                        PORTOUT_DATA = Result;
                    end
            end
    end

endmodule