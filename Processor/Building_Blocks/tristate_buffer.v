module tristate_buffer #(parameter N = 1) (data_in, enable, data_out);

/*********** Inputs ***********/
input [N-1:0] data_in;
input enable;

/*********** Outputs ***********/
output [N-1:0] data_out;

/*********** Logic ***********/
assign data_out = enable? data_in: 'bz;

endmodule