
module fechDecodeRegTB();
localparam N=16;
localparam T=100;
reg [N-1:0]in;
wire [N-1:0]out;
reg write_en;
reg clck;
reg reset;

fech_decode_reg #(N) FDTB(.IR_in(in),.write_en(write_en),.IR_out(out),.clk(clck),.reset(reset));

initial begin
write_en=1;
reset=1;
clck=0;
in=0;

#T
in=10;
write_en=0;
reset=0;
#T
if(out == (2 ** 5))
		$display("passed output for this test case");
else 
		$display("failed output for this test case");
// ////////////////
in =10;
write_en=0;
reset=1;
#T
if(out == 10)
		$display("passed output for this test case");
else 
		$display("failed output for this test case");
// ////////////////
in =100;
write_en=1;
reset=1;
#T
if(out == 10)
		$display("passed output for this test case");
else 
		$display("failed output for this test case");
// ////////////////
in =100;
write_en=0;
reset=1;
#T
if(out == 100)
		$display("passed output for this test case");
else 
		$display("failed output for this test case");

// ////////////////
in =100;
write_en=0;
reset=0;
#T
if(out == (2 ** 5))
		$display("passed output for this test case");
else 
		$display("failed output for this test case");

#T
$finish;

end
always #(T/2) clck=~clck;
endmodule