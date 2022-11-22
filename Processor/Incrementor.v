module Incrementor  #(parameter WORD_LENGTH=32)(in,out);

input [WORD_LENGTH-1:0] in;
output [WORD_LENGTH-1:0] out;

assign out = in + 2 ;

endmodule
