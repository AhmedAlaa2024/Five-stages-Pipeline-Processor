module SP_FU_tb();

localparam PERIOD = 100;

reg [31:0] SP1_VALUE;
reg [31:0] SP2_VALUE;
wire [31:0] SPact_VALUE;

reg Stack_OP_1;
reg Stack_OP_2;
reg Stack_OP_src;

reg enable, clk;

SP_FU FU(
    SP1_VALUE, Stack_OP_1,
    SP2_VALUE, Stack_OP_2,
    SPact_VALUE, Stack_OP_src,
    enable, clk
);

initial 
    begin
        /* Initialize the clk and enable */
        clk = 0;
        enable = 1;

        /* ================= Test Case 1 ================= */
        SP1_VALUE = 32'hAAAAAAAA;
        SP2_VALUE = 32'h55555555;

        Stack_OP_1 = 1;
        Stack_OP_2 = 0;
        Stack_OP_src = 0;

        #(PERIOD);

        if (SPact_VALUE === 32'bz)
            $display("Test case #1 : Succeeded!");
        else
            $display("Test case #1 : Failed!");

        /* ================= Test Case 2 ================= */
        SP1_VALUE = 32'hAAAAAAAA;
        SP2_VALUE = 32'h55555555;

        Stack_OP_1 = 1;
        Stack_OP_2 = 0;
        Stack_OP_src = 1;

        #(PERIOD);

        if (SPact_VALUE === 32'hAAAAAAAA)
            $display("Test case #2 : Succeeded!");
        else
            $display("Test case #2 : Failed!");

        /* ================= Test Case 3 ================= */
        SP1_VALUE = 32'hAAAAAAAA;
        SP2_VALUE = 32'h55555555;

        Stack_OP_1 = 0;
        Stack_OP_2 = 1;
        Stack_OP_src = 1;

        #(PERIOD);

        if (SPact_VALUE === 32'h55555555)
            $display("Test case #3 : Succeeded!");
        else
            $display("Test case #3 : Failed!");

        /* ================= Test Case 4 ================= */
        SP1_VALUE = 32'hAAAAAAAA;
        SP2_VALUE = 32'h55555555;

        Stack_OP_1 = 1;
        Stack_OP_2 = 1;
        Stack_OP_src = 1;

        #(PERIOD);

        if (SPact_VALUE === 32'hAAAAAAAA)
            $display("Test case #4 : Succeeded!");
        else
            $display("Test case #4 : Failed!");

        /* ================= Test Case 5 ================= */
        SP1_VALUE = 32'hAAAAAAAA;
        SP2_VALUE = 32'h55555555;

        Stack_OP_1 = 0;
        Stack_OP_2 = 0;
        Stack_OP_src = 1;

        #(PERIOD);

        if (SPact_VALUE === 32'bz)
            $display("Test case #5 : Succeeded!");
        else
            $display("Test case #5 : Failed!");

        /* ================= Test Case 6 ================= */
        enable = 0;

        SP1_VALUE = 32'hAAAAAAAA;
        SP2_VALUE = 32'h55555555;

        Stack_OP_1 = 1;
        Stack_OP_2 = 0;
        Stack_OP_src = 1;

        #(PERIOD);

        if (SPact_VALUE === 32'bz)
            $display("Test case #6 : Succeeded!");
        else
            $display("Test case #6 : Failed!");
    end

always
    begin
        #(PERIOD/2);
        clk = ~clk;
    end

endmodule