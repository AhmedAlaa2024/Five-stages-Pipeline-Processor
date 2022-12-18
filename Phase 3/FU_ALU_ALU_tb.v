module FU_ALU_ALU_tb();

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

reg [3:0] Current_Src_1_NUM, Current_Src_2_NUM, Old_Dst_1_NUM, Old_Dst_2_NUM;
reg [15:0] Old_Dst_1_VALUE, Old_Dst_2_VALUE;
wire [15:0] Actual_Src_1_VALUE, Actual_Src_2_VALUE;
reg M2R1, M2R2;
reg enable, clk;

FU_ALU_ALU FU(
    Current_Src_1_NUM,
    Current_Src_2_NUM,
    Old_Dst_1_NUM, Old_Dst_1_VALUE,
    Old_Dst_2_NUM, Old_Dst_2_VALUE,
    Actual_Src_1_VALUE,
    Actual_Src_2_VALUE,
    M2R1, M2R2,
    enable, clk
);

initial 
    begin
        /* Let the initial Edge is the +ve edge */
        clk = 0;

        /* Test Case 1 */
        enable = 1;
        M2R1 = 1;
        M2R2 = 1;

        Old_Dst_1_VALUE = 16'hABCD;
        Old_Dst_2_VALUE = 16'h1234;

        Current_Src_1_NUM = R3_NUM;
        Current_Src_2_NUM = R7_NUM;

        Old_Dst_1_NUM = R3_NUM;
        Old_Dst_2_NUM = R5_NUM;

        #(PERIOD);

        if ((Actual_Src_1_VALUE == 16'hABCD) && (Actual_Src_2_VALUE === 16'bz))
            $display("Test Case #1 PASSED!");
        else
            $display("Test Case #1 Failed!");

        /* Test Case 2 */
        Old_Dst_1_VALUE = 16'hABCD;
        Old_Dst_2_VALUE = 16'h1234;

        Current_Src_1_NUM = R3_NUM;
        Current_Src_2_NUM = R5_NUM;

        Old_Dst_1_NUM = R1_NUM;
        Old_Dst_2_NUM = R5_NUM;

        #(PERIOD);

        if ((Actual_Src_1_VALUE === 16'bz) && (Actual_Src_2_VALUE == 16'h1234))
            $display("Test Case #2 PASSED!");
        else
            $display("Test Case #2 Failed!");

        /* Test Case 3 */
        Old_Dst_1_VALUE = 16'hABCD;
        Old_Dst_2_VALUE = 16'h1234;

        Current_Src_1_NUM = PC_NUM;
        Current_Src_2_NUM = SP_NUM;

        Old_Dst_1_NUM = SP_NUM;
        Old_Dst_2_NUM = PC_NUM;

        #(PERIOD);

        if ((Actual_Src_1_VALUE == 16'h1234) && (Actual_Src_2_VALUE == 16'hABCD))
            $display("Test Case #3 PASSED!");
        else
            $display("Test Case #3 Failed!");

        
        /* [TODO] I think this corner case is not possible */
        /* Test Case 4 */
        Old_Dst_1_VALUE = 16'h2486;
        Old_Dst_2_VALUE = 16'h1234;

        Current_Src_1_NUM = R6_NUM;
        Current_Src_2_NUM = R7_NUM;

        Old_Dst_1_NUM = R6_NUM;
        Old_Dst_2_NUM = R6_NUM;

        #(PERIOD);

        if ((Actual_Src_1_VALUE == 16'h2486) && (Actual_Src_2_VALUE == 16'h2486))
            $display("Test Case #4 PASSED!");
        else
            $display("Test Case #4 Failed!");

        /* [TODO] I think this corner case is not possible */
        /* Test Case 5 */
        M2R1 = 0;
        M2R1 = 1;
        Old_Dst_1_VALUE = 16'h2486;
        Old_Dst_2_VALUE = 16'h1234;

        Current_Src_1_NUM = R6_NUM;
        Current_Src_2_NUM = R7_NUM;

        Old_Dst_1_NUM = R6_NUM;
        Old_Dst_2_NUM = R6_NUM;

        #(PERIOD);

        if ((Actual_Src_1_VALUE === 16'bz) && (Actual_Src_2_VALUE === 16'bz))
            $display("Test Case #5 PASSED!");
        else
            $display("Test Case #5 Failed!");

        /* Test Case 6 */
        M2R1 = 0;
        M2R2 = 1;
        Old_Dst_1_VALUE = 16'h2486;
        Old_Dst_2_VALUE = 16'h1234;

        Current_Src_1_NUM = R6_NUM;
        Current_Src_2_NUM = R4_NUM;

        Old_Dst_1_NUM = R6_NUM;
        Old_Dst_2_NUM = R4_NUM;

        #(PERIOD);

        if ((Actual_Src_1_VALUE === 16'bz) && (Actual_Src_2_VALUE == 16'h1234))
            $display("Test Case #6 PASSED!");
        else
            $display("Test Case #6 Failed!");

        /* Test Case 7 */
        M2R1 = 0;
        M2R2 = 0;
        Old_Dst_1_VALUE = 16'h2486;
        Old_Dst_2_VALUE = 16'h1234;

        Current_Src_1_NUM = R6_NUM;
        Current_Src_2_NUM = R4_NUM;

        Old_Dst_1_NUM = R6_NUM;
        Old_Dst_2_NUM = R4_NUM;

        #(PERIOD);

        if ((Actual_Src_1_VALUE === 16'bz) && (Actual_Src_2_VALUE === 16'bz))
            $display("Test Case #7 PASSED!");
        else
            $display("Test Case #7 Failed!");

        /* Test Case 8 */
        enable = 0;
        M2R1 = 1;
        M2R2 = 1;

        Old_Dst_1_VALUE = 16'hABCD;
        Old_Dst_2_VALUE = 16'h1234;

        Current_Src_1_NUM = R3_NUM;
        Current_Src_2_NUM = R5_NUM;

        Old_Dst_1_NUM = R3_NUM;
        Old_Dst_2_NUM = R5_NUM;

        #(PERIOD);

        if ((Actual_Src_1_VALUE === 16'bz) && (Actual_Src_2_VALUE === 16'bz))
            $display("Test Case #8 PASSED!");
        else
            $display("Test Case #8 Failed!");
    end

always #(PERIOD / 2)
        clk = ~clk;

endmodule