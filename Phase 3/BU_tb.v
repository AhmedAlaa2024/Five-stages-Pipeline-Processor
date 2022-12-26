module BU_tb();

localparam PERIOD = 100;

reg ZF, B;
wire FD_reset, DE_reset;

reg enable, clk;

BU U(ZF, B, FD_reset, DE_reset, enable, clk);

initial 
begin
    /* Initialize the clk */
    clk = 0;

    /* ================= Test Case 1 ================= */
    ZF = 1'b1;
    B = 1'b1;
    enable = 1'b1;

    #(PERIOD);

    if (FD_reset & DE_reset)
        $display("Test case #1 : Succeeded!");
    else
        $display("Test case #1 : Failed!");

    /* ================= Test Case 2 ================= */
    ZF = 1'b1;
    B = 1'b1;
    enable = 1'b0;

    #(PERIOD);

    if (!(FD_reset & DE_reset))
        $display("Test case #2 : Succeeded!");
    else
        $display("Test case #2 : Failed!");

    /* ================= Test Case 3 ================= */
    ZF = 1'b1;
    B = 1'b0;
    enable = 1'b1;

    #(PERIOD);

    if (!(FD_reset & DE_reset))
        $display("Test case #3 : Succeeded!");
    else
        $display("Test case #3 : Failed!");

    /* ================= Test Case 4 ================= */
    ZF = 1'b1;
    B = 1'b0;
    enable = 1'b0;

    #(PERIOD);

    if (!(FD_reset & DE_reset))
        $display("Test case #4 : Succeeded!");
    else
        $display("Test case #4 : Failed!");

    /* ================= Test Case 5 ================= */
    ZF = 1'b0;
    B = 1'b1;
    enable = 1'b1;

    #(PERIOD);

    if (!(FD_reset & DE_reset))
        $display("Test case #5 : Succeeded!");
    else
        $display("Test case #5 : Failed!");

    /* ================= Test Case 6 ================= */
    ZF = 1'b0;
    B = 1'b1;
    enable = 1'b0;

    #(PERIOD);

    if (!(FD_reset & DE_reset))
        $display("Test case #6 : Succeeded!");
    else
        $display("Test case #6 : Failed!");

    /* ================= Test Case 7 ================= */
    ZF = 1'b0;
    B = 1'b0;
    enable = 1'b1;

    #(PERIOD);

    if (!(FD_reset & DE_reset))
        $display("Test case #7 : Succeeded!");
    else
        $display("Test case #7 : Failed!");

    /* ================= Test Case 8 ================= */
    ZF = 1'b0;
    B = 1'b0;
    enable = 1'b0;

    #(PERIOD);

    if (!(FD_reset & DE_reset))
        $display("Test case #8 : Succeeded!");
    else
        $display("Test case #8 : Failed!");
end

always
    begin
        #(PERIOD/2);
        clk = ~clk;
    end
endmodule