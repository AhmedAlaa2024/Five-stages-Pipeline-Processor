module mux #(parameter DATA_LENGTH = 8) (in1, in2, out, sel);
input  wire [DATA_LENGTH-1:0] in1;
input  wire [DATA_LENGTH-1:0] in2;
input  wire 				  sel;
output wire [DATA_LENGTH-1:0] out;


assign out =  sel? in1 : in2;


endmodule