module regFile #(parameter REG_SIZE=16,parameter REG_NUMBER=8) (write_enable, read_data1,read_data2,write_data, clk,rst,read_addr1,read_addr2,write_addr);
input write_enable,clk,rst;
input [3:0] read_addr1;
input [2:0] read_addr2,write_addr;
input [REG_SIZE-1:0] write_data;
output   [REG_SIZE-1:0] read_data1,read_data2;
//assuem rst , read_enable and write_enable is active heigh
reg [REG_SIZE-1:0] general_regester[0:REG_NUMBER-1];

assign read_data1 = general_regester[read_addr1];
assign read_data2 = general_regester[read_addr2];

integer i;
always @ (negedge clk)begin
	//write in the posedge
	if (rst == 0) begin
		for(i=0;i<REG_NUMBER;i=i+1)
			general_regester[i]=0;
	end 
	else if(write_enable == 1'b1 )begin 
		general_regester[write_addr]<= write_data;
	end
end

endmodule