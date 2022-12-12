module register #(parameter N=16) (read_data,write_data,read_enable,end_read,write_enable,reset);
input read_enable,write_enable,reset,end_read;
input [N-1:0] write_data;
output reg [N-1:0] read_data;
reg [N-1:0] data;
integer i;
initial begin
for(i=0;i<N;i=i+1) read_data[i]=1'bz;
end
always @(posedge reset)
begin
	data = 0 ;
end
always @(posedge read_enable)
begin
	 read_data = data ;
end
always @(posedge end_read)for(i=0;i<N;i=i+1) read_data[i]=1'bz;
always @(posedge write_enable)
begin
	data = write_data ;
end
endmodule 