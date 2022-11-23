module DataMemoryTB();
localparam WORD_LENGTH=16;
localparam ADDRESS_SPACE=12;
localparam T=100;

reg  [ADDRESS_SPACE-1:0] MAR;
reg [WORD_LENGTH-1:0]MDR_in;
reg clk, reset,en,re;
wire [WORD_LENGTH-1:0]   MDR_out;

DataMem #(WORD_LENGTH,ADDRESS_SPACE) memory (.clk(clk),.MAR(MAR),.MDR_in(MDR_in), .MDR_out(MDR_out), .reset(reset),.mem(en),.rw(re));

initial begin
clk=0;
reset=1;
MAR=0;
en=0;
re=0;
MDR_in=0;
#T

reset=0;
MAR=0;
en=0;
re=0;
MDR_in=0;
MDR_in=0;
#T
if(MDR_out === 16'bz)
		$display("passed output for this test case");
else 
		$display("failed output for this test case");
// ////////////////
reset=1;
MAR=10;
en=1;
re=0;
MDR_in=100;
#T
if(MDR_out === 16'bz)
		$display("passed output for this test case");
else 
		$display("failed output for this test case");
// ////////////////
#T
reset=1;
MAR=10;
en=1;
re=1;
MDR_in=0;
#T
if(MDR_out == 100)
		$display("passed output for this test case");
else 
		$display("failed output for this test case");
// ////////////////
#T
reset=1;
MAR=200;
en=1;
re=0;
MDR_in=200;
#T
if(MDR_out == 100)
		$display("passed output for this test case");
else 
		$display("failed output for this test case");
// ////////////////
#T
reset=1;
MAR=200;
en=1;
re=1;
MDR_in=0;
#T
if(MDR_out == 200)
		$display("passed output for this test case");
else 
		$display("failed output for this test case");
// ////////////////
#T
reset=1;
MAR=200;
en=1;
re=0;
MDR_in=300;
#T
// ////////////////
reset=1;
MAR=200;
en=1;
re=1;
MDR_in=0;
#T
if(MDR_out == 300)
		$display("passed output for this test case");
else 
		$display("failed output for this test case");
// ////////////////
reset=1;
MAR=20;
en=1;
re=0;
MDR_in=20;
#T
// ////////////////
reset=1;
MAR=30;
en=1;
re=0;
MDR_in=30;
#T
// ////////////////
reset=1;
MAR=30;
en=1;
re=1;
MDR_in=0;
#T
if(MDR_out == 30)
		$display("passed output for this test case");
else 
		$display("failed output for this test case");
// ////////////////
reset=1;
MAR=20;
en=1;
re=1;
MDR_in=0;
#T
if(MDR_out == 20)
		$display("passed output for this test case");
else 
		$display("failed output for this test case");
// ////////////////
#T
reset=0;
MAR=200;
en=1;
re=1;
MDR_in=0;
#T
if(MDR_out === 16'bz)
		$display("passed output for this test case");
else 
		$display("failed output for this test case");
// ////////////////
#T
$finish;

end
always #(T/2) clk=~clk;
endmodule
