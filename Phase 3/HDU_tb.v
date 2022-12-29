module HDU_tb();

localparam PERIOD = 100;

localparam R0_NUM = 0;
localparam R1_NUM = 1;
localparam R2_NUM = 2;
localparam R3_NUM = 3;
localparam R4_NUM = 4;
localparam R5_NUM = 5;
localparam R6_NUM = 6;
localparam R7_NUM = 7;
localparam PC_NUM = 8;
localparam SP_NUM = 9;

reg [3:0] Old_Dst_NUM;
reg [3:0] Current_Src_NUM;
reg DMR, enable, clk;

wire Stall;

reg [3:0] testcases_counter;

HDU hdu(
    Old_Dst_NUM,
    Current_Src_NUM,
    DMR,
    enable,
    clk,
    Stall
);

initial 
    begin
        /* Let the initial Edge is the +ve edge */
        clk = 0;
        enable = 1;
        testcases_counter = 0;

        /* Test Case 1 */
        DMR = 1;
        Old_Dst_NUM = R3_NUM;
        Current_Src_NUM = R7_NUM;
        testcases_counter = testcases_counter + 1;

        #(PERIOD);

        if (Stall == 0)
            $display("Test Case #1 PASSED!");
        else
            $display("Test Case #1 Failed!");

        /* Test Case 2 */
        Old_Dst_NUM = R3_NUM;
        Current_Src_NUM = R3_NUM;
        testcases_counter = testcases_counter + 1;

        #(PERIOD);

        if (Stall == 1)
            $display("Test Case #2 PASSED!");
        else
            $display("Test Case #2 Failed!");

        /* Test Case 3 */
        DMR = 0;
        Old_Dst_NUM = R5_NUM;
        Current_Src_NUM = R5_NUM;
        testcases_counter = testcases_counter + 1;

        #(PERIOD);

        if (Stall == 0)
            $display("Test Case #3 PASSED!");
        else
            $display("Test Case #3 Failed!");

        /* Test Case 4 */
        DMR = 0;
        Old_Dst_NUM = R5_NUM;
        Current_Src_NUM = R5_NUM;
        testcases_counter = testcases_counter + 1;

        #(PERIOD);

        if (Stall == 0)
            $display("Test Case #4 PASSED!");
        else
            $display("Test Case #4 Failed!");
    end

always #(PERIOD / 2)
        clk = ~clk;

endmodule