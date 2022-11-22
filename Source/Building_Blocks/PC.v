module PC(write_enable, clk, rst, in, out);

	input write_enable, clk, rst;
	input [31:0] in;
	output reg [31:0] out;

	always @(posedge clk) begin
		if (rst == 0) out = 2**5;
		else begin
			if(write_enable)
				out = in;
		end
	end

endmodule

