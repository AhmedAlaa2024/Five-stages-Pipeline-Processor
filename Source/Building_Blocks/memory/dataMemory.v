module  dataMemory #(parameter WORD_SIZE=16,parameter ADDRESS_SIZE=12) (read_address,data_out);
input [ADDRESS_SIZE-1:0]read_address;
output  [WORD_SIZE-1:0] data_out;

reg [WORD_SIZE-1:0] memory[2 ** ADDRESS_SIZE -1:0];
assign data_out=memory[read_address];
endmodule
