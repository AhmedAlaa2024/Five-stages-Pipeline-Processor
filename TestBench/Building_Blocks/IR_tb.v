
module IR_tb;
	parameter PERIOD = 2;
	reg write_enable, clk, rst;
	reg [15:0] in;
	wire [15:0] out;
	IR ir(write_enable, clk, rst, in, out);

	initial begin
		clk = 0;
		rst = 1;
		write_enable = 0;
		in = 0;	
	end
	always #PERIOD clk=~clk;
	
	initial begin
		
		// test reset without write enable
		rst = 0;
		write_enable = 0;
		in = 1234;	
		#10;
		if (out == 0)begin
			$display("PASS test reset without write enable out = %d",out);	
		end else begin
			$display("Failed test reset without write enable out = %d",out);	
		end
	
		// test reset with write enable
		rst = 0;
		write_enable = 1;
		in = 1234;	
		#10;
		if (out == 0)begin
			$display("PASS test reset with write enable out = %d",out);	
		end else begin
			$display("Failed test reset with write enable out = %d",out);	
		end

		// test write
		rst = 1;
		write_enable = 1;
		in = 1234;	
		#10;
		if (out == 1234)begin
			$display("PASS test read out = %d",out);	
		end else begin
			$display("Failed test read out = %d",out);	
		end

		// test write
		rst = 1;
		write_enable = 1;
		in = 9999;	
		#10;
		if (out == 9999)begin
			$display("PASS test read out = %d",out);	
		end else begin
			$display("Failed test read out = %d",out);	
		end

		// test write
		rst = 1;
		write_enable = 1;
		in = 1234;
		#10;
		if (out == 1234)begin
			$display("PASS test write out = %d",out);	
		end else begin
			$display("Failed test write out = %d",out);	
		end
		$finish;
	end	

endmodule