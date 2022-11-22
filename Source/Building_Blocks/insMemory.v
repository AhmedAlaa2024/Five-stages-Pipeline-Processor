module  insMemory #(parameter INST_SIZE=16,parameter ADDRESS_SIZE=21) (read_address,instr);
input [ADDRESS_SIZE-1:0]read_address;
output  [INST_SIZE-1:0] instr;

reg [INST_SIZE-1:0] memory[2 ** ADDRESS_SIZE -1:0];
assign instr=memory[read_address];
//assuem rst , read_enable and write_enable is active heigh
endmodule
