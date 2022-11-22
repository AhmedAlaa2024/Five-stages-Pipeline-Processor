module regFileTB();
localparam N=16;
localparam T=100;
//hello
reg write_en,reset,clk;
reg [3:0] read_ad1,read_ad2,write_ad;
reg [N-1:0] write_da;
wire [N-1:0] read_da1,read_da2;
regFile #(N,8) rf1(.write_enable(write_en),
     .read_data1(read_da1),.read_data2(read_da2),.write_data(write_da),
      .clk(clk),.rst(reset),.read_addr1(read_ad1),.read_addr2(read_ad2),.write_addr(write_ad));


initial begin
    clk=0;
    reset=1;
    write_en=1;
    read_ad1=0;
    read_ad2=0;
    write_ad=0;
    write_da=0;
    #T
    reset=0;
    write_en=0;
    write_da=100;
    read_ad1=1;
    read_ad2=2;
    write_ad=1;
    
    #T
    if(read_da1 == 0 && read_da2==0)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");
    //////////////////////////////////////////////
    reset=1;
    write_en=0;
    write_da=100;
    read_ad1=1;
    read_ad2=1;
    write_ad=1;
    
    #T
    if(read_da1 == 100 && read_da2 == 100)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");
    //////////////////////////////////////////////
    reset=1;
    write_en=0;
    write_da=150;
    read_ad1=1;
    read_ad2=2;
    write_ad=2;
    
    #T
    if(read_da1 == 100 && read_da2 == 150)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");
    //////////////////////////////////////////////
    reset=1;
    write_en=0;
    write_da=500;
    read_ad1=1;
    read_ad2=7;
    write_ad=7;
    
    #T
    if(read_da1 == 100 && read_da2 == 500)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");

    //////////////////////////////////////////////
    reset=1;
    write_en=0;
    write_da=50;
    read_ad1=0;
    read_ad2=2;
    write_ad=0;
    
    #T
    if(read_da1 == 50 && read_da2 == 150)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");

    //////////////////////////////////////////////
    reset=0;
    write_en=0;
    write_da=100;
    read_ad1=0;
    read_ad2=1;
    write_ad=1;
    
    #T
    if(read_da1 == 0 && read_da2 == 0)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");
#T
$finish;
end
always #(T/2) clk=~clk;
endmodule
