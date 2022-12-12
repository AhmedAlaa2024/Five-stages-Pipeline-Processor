module regFile #(parameter REG_SIZE=16 , CCR_SIZE=16,parameter REG_NUMBER=8) (Data_write1,sp_write , Src1,Src2 , read_sp, read_pc ,read_ccr
,write_sp_data , write_pc_data , write_ccr , write_data1 , clk,rst , Opd1_Add , Opd2_Add , write_addr1 );

input Data_write1,sp_write,clk,rst;
input [2:0] Opd2_Add;
input [3:0] Opd1_Add,write_addr1;
input [REG_SIZE-1:0] write_data1;
input [31:0] write_sp_data,write_pc_data;
input [CCR_SIZE-1 : 0] write_ccr;

output   [REG_SIZE-1:0] Src1,Src2;
output  [31:0] read_sp,read_pc;
output [CCR_SIZE-1 : 0] read_ccr;
//assuem rst , read_enable and Data_write1 is active heigh
reg [REG_SIZE-1:0] general_regester[0:REG_NUMBER-1 + 2];
reg [31:0] SP , PC;
reg [CCR_SIZE-1 : 0]CCR;

assign Src1 = general_regester[Opd1_Add];
assign Src2 = general_regester[Opd2_Add];
assign read_sp = SP;
assign read_pc={ general_regester[REG_NUMBER] , general_regester[REG_NUMBER+1] };
assign read_ccr=CCR;
integer i;
always @ (posedge clk)begin
	//write in the posedge
	if(rst != 1)begin
		CCR=write_ccr;
	end

	if (rst == 0) begin
		for(i=0;i<REG_NUMBER;i=i+1)begin
			general_regester[i]=0;
		end
		SP = 2047;
		PC = 32;
		CCR = 0;
	end 
	else if(Data_write1 == 1'b1 )begin 
		general_regester[write_addr1]= write_data1;
	end

	if( sp_write == 1 && rst != 0)begin
		SP=write_sp_data;
	end

	else if( sp_write == 1 && rst != 0)begin
		PC = write_pc_data;
	end

end

endmodule