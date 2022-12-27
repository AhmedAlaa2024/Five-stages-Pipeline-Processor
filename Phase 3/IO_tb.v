module IO_tb();

localparam PERIOD = 100;

reg [15:0] Result;
reg [15:0] PORTIN;
reg IOE, IOR, IOW;
reg reset, clk;

wire [15:0] PORTOUT;
wire [15:0] IN;

IO IO_inst(Result, PORTIN, PORTOUT, IN, IOR, IOW, IOE, reset, clk);

initial 
    begin
        /* Initialize the clk, reset */
        clk = 0;
        reset = 1'b1;

        /* Start with reset */
        #(PERIOD);
        reset = 1'b0;
        #(PERIOD);
        reset = 1'b1;

        /* ================= Test Case 1 ================= */
        Result = 16'h5555;
        PORTIN = 16'hAAAA;

        IOE = 1'b1;
        IOR = 1'b1;
        IOW = 1'b0;

        #(PERIOD);

        if ((IN == 16'hAAAA) && (PORTOUT === 16'b0))
            $display("Test case #1 : Succeeded!");
        else
            $display("Test case #1 : Failed!");

        /* ================= Test Case 2 ================= */
        Result = 16'h5555;
        PORTIN = 16'hBBBB;

        IOE = 1'b1;
        IOR = 1'b0;
        IOW = 1'b0;

        #(PERIOD);

        if ((IN == 16'hAAAA) && (PORTOUT === 16'b0))
            $display("Test case #2 : Succeeded!");
        else
            $display("Test case #2 : Failed!");

        /* ================= Test Case 3 ================= */
        Result = 16'h5555;
        PORTIN = 16'hBBBB;

        IOE = 1'b1;
        IOR = 1'b1;
        IOW = 1'b0;

        #(PERIOD);

        if ((IN == 16'hBBBB) && (PORTOUT === 16'b0))
            $display("Test case #3 : Succeeded!");
        else
            $display("Test case #3 : Failed!");

        /* ================= Test Case 4 ================= */
        Result = 16'h5555;
        PORTIN = 16'hCCCC;

        IOE = 1'b0;
        IOR = 1'b1;
        IOW = 1'b0;

        #(PERIOD);

        if ((IN == 16'hBBBB) && (PORTOUT === 16'b0))
            $display("Test case #4 : Succeeded!");
        else
            $display("Test case #4 : Failed!");

        /* ================= Test Case 5 ================= */
        Result = 16'h5555;
        PORTIN = 16'hCCCC;

        IOE = 1'b1;
        IOR = 1'b0;
        IOW = 1'b1;

        #(PERIOD);

        if ((IN == 16'hBBBB) && (PORTOUT === 16'h5555))
            $display("Test case #5 : Succeeded!");
        else
            $display("Test case #5 : Failed!");

        /* ================= Test Case 6 ================= */
        Result = 16'h6666;
        PORTIN = 16'hCCCC;

        IOE = 1'b1;
        IOR = 1'b0;
        IOW = 1'b0;

        #(PERIOD);

        if ((IN == 16'hBBBB) && (PORTOUT === 16'h5555))
            $display("Test case #6 : Succeeded!");
        else
            $display("Test case #6 : Failed!");

        /* ================= Test Case 7 ================= */
        Result = 16'h6666;
        PORTIN = 16'hCCCC;

        IOE = 1'b1;
        IOR = 1'b0;
        IOW = 1'b1;

        #(PERIOD);

        if ((IN == 16'hBBBB) && (PORTOUT === 16'h6666))
            $display("Test case #7 : Succeeded!");
        else
            $display("Test case #7 : Failed!");

        /* ================= Test Case 8 ================= */
        Result = 16'h7777;
        PORTIN = 16'hCCCC;

        IOE = 1'b0;
        IOR = 1'b0;
        IOW = 1'b1;

        #(PERIOD);

        if ((IN == 16'hBBBB) && (PORTOUT === 16'h6666))
            $display("Test case #8 : Succeeded!");
        else
            $display("Test case #8 : Failed!");

        /* ================= Test Case 9 ================= */
        Result = 16'h7777;
        PORTIN = 16'hCCCC;

        IOE = 1'b1;
        IOR = 1'b1;
        IOW = 1'b1;

        #(PERIOD);

        if ((IN == 16'hCCCC) && (PORTOUT === 16'h7777))
            $display("Test case #9 : Succeeded!");
        else
            $display("Test case #9 : Failed!");

        /* ================= Test Case 10 ================= */
        Result = 16'h8888;
        PORTIN = 16'hDDDD;

        IOE = 1'b0;
        IOR = 1'b1;
        IOW = 1'b1;

        #(PERIOD);

        if ((IN == 16'hCCCC) && (PORTOUT === 16'h7777))
            $display("Test case #10 : Succeeded!");
        else
            $display("Test case #10 : Failed!");

        /* ================= Test Case 11 ================= */
        Result = 16'h9999;
        PORTIN = 16'hDDDD;

        IOE = 1'b1;
        IOR = 1'b1;
        IOW = 1'b0;

        #(PERIOD);

        if ((IN == 16'hDDDD) && (PORTOUT === 16'h7777))
            $display("Test case #11 : Succeeded!");
        else
            $display("Test case #11 : Failed!");

        /* ================= Test Case 12 ================= */
        Result = 16'h9999;
        PORTIN = 16'hDDDD;

        IOE = 1'b1;
        IOR = 1'b0;
        IOW = 1'b1;

        #(PERIOD);

        if ((IN == 16'hDDDD) && (PORTOUT === 16'h9999))
            $display("Test case #12 : Succeeded!");
        else
            $display("Test case #12 : Failed!");
    end

always
    begin
        #(PERIOD/2);
        clk = ~clk;
    end
endmodule