module tristate_buffer_tb ();

localparam T = 100;
reg counter;

reg data_in;
reg enable;
wire data_out;

tristate_buffer #(1) tri_bufO(data_in, enable, data_out);

initial 
begin
    $display("data_in   enable  data_out");
    $monitor("  %b\t\t%b\t%b", data_in, enable, data_out);

    counter = 0;

    /*********** Test Case 1 ***********/
    data_in = 0;
    enable = 1;

    #T;

    /*********** Test Case 2 ***********/
    data_in = 1;
    enable = 1;

    #T;

    /*********** Test Case 3 ***********/
    data_in = 0;
    enable = 0;

    #T;

    /*********** Test Case 4 ***********/
    data_in = 1;
    enable = 0;

    #T;
    
end

endmodule
