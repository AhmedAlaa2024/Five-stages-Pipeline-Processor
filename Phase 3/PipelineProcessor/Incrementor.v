module Incrementor  #(parameter WORD_LENGTH=32)(in,en,out);

input [WORD_LENGTH-1:0] in;
input en;
output [WORD_LENGTH-1:0] out;

assign out = (en)? in + 1 :in;

endmodule
