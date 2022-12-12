`include "regFile.v"
module regFileTB();
localparam N=16;
localparam CCR_SIZE=16;
localparam T=100;
//hello
reg write_en,sp_write,reset,clk;
reg [2:0]read_ad2;
reg [3:0] read_ad1,write_ad;
reg [N-1:0] write_da;
reg [31:0] write_sp_data,write_pc_data;
reg [CCR_SIZE-1 : 0] write_cc;

wire [N-1:0] read_da1,read_da2;
wire [31:0] read_sp,read_pc;
wire [CCR_SIZE-1:0] read_ccr;
regFile #(N,16,8) rf1(.Data_write1(write_en),.sp_write(sp_write),
     .Src1(read_da1),.Src2(read_da2),.read_sp(read_sp),.read_pc(read_pc),.read_ccr(read_ccr),
     .write_sp_data(write_sp_data) , .write_pc_data(write_pc_data) , .write_ccr(write_cc),.write_data1(write_da),
      .clk(clk),.rst(reset),.Opd1_Add(read_ad1),.Opd2_Add(read_ad2),.write_addr1(write_ad));


initial begin
        $dumpfile("regFileTB.vcd");
        $dumpvars;
    clk=0;
    reset=1;
    write_en=0;
    read_ad1=0;
    read_ad2=0;
    write_ad=0;
    write_da=0;

    sp_write=0;
    write_sp_data=0;
    write_pc_data=0;
    write_cc=0;
    #T
    
    ////////////////////////////////////////////////////

    reset=0;
    write_en=1;
    write_da=100;
    read_ad1=1;
    read_ad2=2;
    write_ad=1;

    sp_write=0;
    write_sp_data=0;
    write_pc_data=0;
    write_cc=0;
    
    #T
    if(read_da1 == 0 && read_da2==0 && read_sp==2047 && read_pc==32)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");
/////////////////////////////
    reset=1;
    write_en=1;
    write_da=100;
    read_ad1=1;
    read_ad2=1;
    write_ad=1;

    sp_write=0;
    write_sp_data=0;
    write_pc_data=0;
    write_cc=0;
    
    #T
    if(read_da1 == 100 && read_da2 == 100)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");
    //////////////////////////////////////////////
    reset=1;
    write_en=1;
    write_da=150;
    read_ad1=1;
    read_ad2=2;
    write_ad=2;

    sp_write=0;
    write_sp_data=0;
    write_pc_data=0;
    write_cc=0;
    
    #T
    if(read_da1 == 100 && read_da2 == 150)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");
    //////////////////////////////////////////////
    reset=1;
    write_en=1;
    write_da=500;
    read_ad1=1;
    read_ad2=7;
    write_ad=7;

    sp_write=0;
    write_sp_data=0;
    write_pc_data=0;
    write_cc=0;
    
    #T
    if(read_da1 == 100 && read_da2 == 500)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");

    //////////////////////////////////////////////
    reset=1;
    write_en=1;
    write_da=50;
    read_ad1=0;
    read_ad2=2;
    write_ad=0;
    
    sp_write=0;
    write_sp_data=0;
    write_pc_data=0;
    write_cc=0;
    #T
    if(read_da1 == 50 && read_da2 == 150)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");

    //////////////////////////////////////////////
    reset=0;
    write_en=1;
    write_da=100;
    read_ad1=0;
    read_ad2=1;
    write_ad=1;
    
    sp_write=0;
    write_sp_data=0;
    write_pc_data=0;
    write_cc=0;
    #T
    if(read_da1 == 0 && read_da2 == 0)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");
//////////////////////////////////////////////
    reset=1;
    write_en=0;
    write_da=100;
    read_ad1=0;
    read_ad2=1;
    write_ad=1;
    
    sp_write=1;
    write_sp_data=100;
    write_pc_data=0;
    write_cc=0;
    #T
    if(read_sp==100)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");
//////////////////////////////////////////////
//////////////////////////////////////////////
        reset=1;
    write_en=0;
    write_da=100;
    read_ad1=0;
    read_ad2=1;
    write_ad=1;
    
    sp_write=1;
    write_sp_data=2000;
    write_pc_data=0;
    write_cc=0;
    #T
//////////////////////////////////////////////
    reset=1;
    write_en=0;
    write_da=100;
    read_ad1=0;
    read_ad2=1;
    write_ad=1;
    
    sp_write=0;
    write_sp_data=1000;
    write_pc_data=3000;
    write_cc=0;
    #(T)
    if(read_pc==3000)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");
    if(read_sp==2000)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");
//////////////////////////////////////////////
    reset=1;
    write_en=0;
    write_da=100;
    read_ad1=0;
    read_ad2=1;
    write_ad=1;
    
    sp_write=0;
    write_sp_data=1000;
    write_pc_data=1000000;
    write_cc=0;
    #(T)
    if(read_pc==1000000)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");

//////////////////////////////////////////////
    reset=1;
    write_en=0;
    write_da=100;
    read_ad1=8;
    read_ad2=1;
    write_ad=1;
    
    sp_write=0;
    write_sp_data=1000;
    write_pc_data=65536;
    write_cc=0;
    #(T)
    if(read_da1==0)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");
//////////////////////////////////////////////
    reset=1;
    write_en=0;
    write_da=100;
    read_ad1=9;
    read_ad2=1;
    write_ad=1;
    
    sp_write=0;
    write_sp_data=1000;
    write_pc_data=65536;
    write_cc=0;
    #(T)
    if(read_da1==1)
            $display("passed output for this test case");
    else 
            $display("failed output for this test case");

#T

$finish;
end
always #(T/2) clk=~clk;
endmodule

