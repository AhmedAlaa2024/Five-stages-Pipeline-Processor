module PC(write_enable, clk, rst, in, out);

	input write_enable, clk, rst;
	input [31:0] in;
	output reg [31:0] out;

	always @(posedge clk or posedge rst) begin
		if (rst == 1) out = 0;
		else begin
			if(write_enable)
				out = in;
		end
	end

endmodule

