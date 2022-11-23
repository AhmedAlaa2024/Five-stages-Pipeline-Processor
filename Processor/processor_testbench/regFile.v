module regFile(read_enable,write_enable, read_data1,read_data2,write_data,dirc_byte, clk,rst,read_addr1,read_addr2,write_addr);
parameter N_GENERAL=16;
parameter N_BIGGER=32;
parameter N_CONTROL=16;
input read_enable,write_enable,clk,rst;
input [3:0] read_addr1,read_addr2,write_addr;
input [N_GENERAL-1:0] write_data;
input dirc_byte;
output reg [N_GENERAL-1:0] read_data1,read_data2;
/// assumtions
/// 
/// 1-assume that the first edge is positive edge and the ideal is low
/// 2-assume the reset is heiger priority than read or write data
/// 3-when reset ,then read_data will be reset
/// 4-all segnals is active low
/// 5-PC will be 0 when reset , SP will be 2^11-1

//assuem rst , read_enable and write_enable is active heigh
reg [N_GENERAL-1:0] general_regester[0:7];
reg [N_BIGGER-1:0] purposed_regester[0:1];
reg [N_CONTROL-1:0] flag_regester[0:0];
integer i;
always @ (posedge clk)begin
	//write in the posedge
	if (rst == 0) begin
		for(i=0;i<8;i=i+1)
			general_regester[i]=0;

		purposed_regester[0]=0;
		purposed_regester[1]=4095;

		flag_regester[0]=0;

		if(read_enable==0 || rst==0)begin
		if(read_addr1 < 16'd8)
		 	read_data1 <= general_regester[read_addr1];
		else if(read_addr1 < 10'd10)
			read_data1 <= (dirc_byte == 1'b0)?
				purposed_regester[read_addr1-16'd8][15:0]:
				purposed_regester[read_addr1-16'd8][31:16] ;
		else begin
			read_data1= 16'h0000;
			read_data1[N_CONTROL-1:0] = flag_regester[0][N_CONTROL-1:0];
		end


		if(read_addr2 < 16'd8)
		 	read_data2 <= general_regester[read_addr2];
		else if(read_addr1 < 10'd10)
			read_data2 <= (dirc_byte == 1'b0)?
				purposed_regester[read_addr2-16'd8][15:0]:
				purposed_regester[read_addr2-16'd8][31:16] ;
		else begin
			read_data2= 16'h0000;
			read_data2[N_CONTROL-1:0] = flag_regester[0][N_CONTROL-1:0];
		end

	end
		
	end 
	else if(write_enable == 0 )begin 
		if(write_addr < 16'd8)
			general_regester[write_addr]<= write_data;
		else if(write_addr < 16'd10)
			purposed_regester[write_addr-16'd8]<=(dirc_byte == 1'b0)?
				{purposed_regester[write_addr-16'd8][31:16],write_data} :
				{write_data,purposed_regester[write_addr-16'd8][15:0]} ;
		else
			flag_regester[0]<=write_data[N_CONTROL-1:0];
	end
end
always @ (negedge clk)begin
	//read in the nededge
	if (rst == 0) begin
		for(i=0;i<8;i=i+1)
			general_regester[i]=0;

		purposed_regester[0]=0;
		purposed_regester[1]=4095;
		
		flag_regester[0]=0;

		// read_data1 = general_regester[read_addr1];
		// read_data2 = general_regester[read_addr2];
	end 
	 if(read_enable==0 || rst==0)begin
		if(read_addr1 < 16'd8)
		 	read_data1 <= general_regester[read_addr1];
		else if(read_addr1 < 10'd10)
			read_data1 <= (dirc_byte == 1'b0)?
				purposed_regester[read_addr1-16'd8][15:0]:
				purposed_regester[read_addr1-16'd8][31:16] ;
		else begin
			read_data1= 16'h0000;
			read_data1[N_CONTROL-1:0] = flag_regester[0][N_CONTROL-1:0];
		end


		if(read_addr2 < 16'd8)
		 	read_data2 <= general_regester[read_addr2];
		else if(read_addr1 < 10'd10)
			read_data2 <= (dirc_byte == 1'b0)?
				purposed_regester[read_addr2-16'd8][15:0]:
				purposed_regester[read_addr2-16'd8][31:16] ;
		else begin
			read_data2= 16'h0000;
			read_data2[N_CONTROL-1:0] = flag_regester[0][N_CONTROL-1:0];
		end

	end
	
		
end
endmodule
