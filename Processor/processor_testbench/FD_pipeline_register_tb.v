module FD_pipeline_register_tb;
	parameter PERIOD = 100;
	
    reg [31:0] IR_Reg_IN;
	reg clk,reset;

    wire [31:0] IR_Reg_OUT;
	
	FD_pipeline_register FD_pipeline_reg(IR_Reg_IN, IR_Reg_OUT, clk,reset);

	initial 
    begin
        reset = 1;
        clk = 0;
        IR_Reg_IN = 32'hABCD;

        #(PERIOD)

        if (IR_Reg_OUT == 32'hABCD)
            begin
                $display("Test case [1]: Success!");
            end
        else
            begin
                $display("Test case [1]: Failed!");
            end

        IR_Reg_IN = 32'h1234;

        #(PERIOD)

        if (IR_Reg_OUT == 32'h1234)
            begin
                $display("Test case [1]: Success!");
            end
        else
            begin
                $display("Test case [1]: Failed!");
            end

        reset = 0;

        #(PERIOD)

        reset = 1;

        if (IR_Reg_OUT == 0)
            begin
                $display("Test case [1]: Success!");
            end
        else
            begin
                $display("Test case [1]: Failed!");
            end

        IR_Reg_IN = 32'h1598;

        #(PERIOD)

        if (IR_Reg_OUT == 32'h1598)
            begin
                $display("Test case [1]: Success!");
            end
        else
            begin
                $display("Test case [1]: Failed!");
            end
	end
	
always
    begin
        #(PERIOD/2) clk = ~clk;
    end
endmodule