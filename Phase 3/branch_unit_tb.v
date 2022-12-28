module branch_unit_tb();

localparam PERIOD = 100;

reg [3:0] CCR;
reg branch,clk;
reg [1:0] jmp_type;
wire  is_taken;


BranchUnit BU(.CCR(CCR),.branch(branch),.jmp_type(jmp_type),.is_taken(is_taken));

always begin
        #(PERIOD/2);
        clk = ~clk;
end

initial begin
clk =0;
CCR = 4'b0000;
branch = 1'b1;
jmp_type = 2'b00;
# PERIOD;

if (!(is_taken))
    $display("#1, success not taken branch");
else
    $display("#1, fail  taken branch");
# PERIOD;

CCR = 4'b0001;
branch = 1'b1;
jmp_type = 2'b00;
# PERIOD;

if (is_taken == 1'b1)
    $display("#2, success taken branch");
else
    $display("#2, fail not taken branch");
# PERIOD;


CCR = 4'b0001;
branch = 1'b0;
jmp_type = 2'b00;
# PERIOD;

if (!(is_taken))
    $display("#3, success not taken branch");
else
    $display("#3, fail  taken branch");
# PERIOD;
/////////////////////////////

CCR = 4'b0000;
branch = 1'b1;
jmp_type = 2'b01;
# PERIOD;

if (!(is_taken))
    $display("#4, success not taken branch");
else
    $display("#4, fail  taken branch");
# PERIOD;

CCR = 4'b0011;
branch = 1'b1;
jmp_type = 2'b01;
# PERIOD;

if (is_taken == 1'b1)
    $display("#5, success taken branch");
else
    $display("#5, fail not taken branch");
# PERIOD;


CCR = 4'b0011;
branch = 1'b0;
jmp_type = 2'b01;
# PERIOD;

if (!(is_taken))
    $display("#6, success not taken branch");
else
    $display("#6, fail  taken branch");
# PERIOD;
//////////////////////////////
CCR = 4'b0000;
branch = 1'b1;
jmp_type = 2'b10;
# PERIOD;

if (!(is_taken))
    $display("#7, success not taken branch");
else
    $display("#7, fail  taken branch");
# PERIOD;

CCR = 4'b0111;
branch = 1'b1;
jmp_type = 2'b10;
# PERIOD;

if (is_taken == 1'b1)
    $display("#8, success taken branch");
else
    $display("#8, fail not taken branch");
# PERIOD;


CCR = 4'b0101;
branch = 1'b0;
jmp_type = 2'b10;
# PERIOD;

if (!(is_taken))
    $display("#9, success not taken branch");
else
    $display("#9, fail  taken branch");
# PERIOD;
/////////////////////////////////
CCR = 4'b0000;
branch = 1'b1;
jmp_type = 2'b11;
# PERIOD;

if (is_taken == 1'b1)
    $display("#10, success  taken branch");
else
    $display("#10, fail not taken branch");
# PERIOD;

CCR = 4'b1111;
branch = 1'b1;
jmp_type = 2'b11;
# PERIOD;

if (is_taken == 1'b1)
    $display("#11, success taken branch");
else
    $display("#11, fail not taken branch");
# PERIOD;


CCR = 4'b1111;
branch = 1'b0;
jmp_type = 2'b11;
# PERIOD;

if (!(is_taken))
    $display("#12, success not taken branch");
else
    $display("#12, fail  taken branch");
# PERIOD;

$finish;

end

endmodule
