module DE_pipeline_register_tb;
	parameter PERIOD = 100;
    reg clk,reset;
	
    reg [NUMBER_CONTROL_SIGNALS-1:0] control_sinals_IN;
    wire [NUMBER_CONTROL_SIGNALS-1:0] control_sinals_OUT;

    reg [2:0] reg_dst_num_IN;
    wire [2:0] reg_dst_num_OUT;

    reg [3:0] reg_src_1_num_IN;
    wire [3:0] reg_src_1_num_OUT;

    reg [3:0] reg_src_2_num_IN;
    wire [3:0] reg_src_2_num_OUT;

    reg [15:0] address_IN;
    wire [15:0] address_OUT;
	
	DE_pipeline_register #(14) DE_pipeline_reg(control_sinals_IN, control_sinals_OUT, 
                                         reg_dst_num_IN, reg_dst_num_OUT,
                                         reg_src_1_num_IN, reg_src_1_num_OUT,
                                         reg_src_2_num_IN, reg_src_2_num_OUT,
                                         address_IN, address_OUT,
                                         clk, reset);

	initial 
    begin
        reset = 1;
        clk = 0;
        control_sinals_IN = 14'b10010110111100;
        reg_dst_num_IN = 3'b101;
        reg_src_1_num_IN = 4'b1101;
        reg_src_2_num_IN = 4'b0001;
        address_IN = 16'b1100110011110101;

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