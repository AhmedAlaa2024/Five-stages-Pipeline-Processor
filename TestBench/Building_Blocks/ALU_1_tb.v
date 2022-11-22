
module ALU_1_tb();

 reg[15:0] op1,op2;
 reg[1:0] func;
 wire[15:0] result;
 wire[5:0] flags; 

reg [15:0] inputTests1 [0:15];
reg [15:0] inputTests2 [0:15];
reg [15:0] resultTests [0:15];
reg [5:0] flagsTests [0:15];
reg [1:0] funcTests [0:15];
ALU_1 alu(.op1(op1),.op2(op2),.func(func),.result(result),.outFlags(flags));
 integer i;
initial begin
    // hold reset state for 100 ns.
    inputTests1[0] = 16'b0000_0000_0000_0001;
    inputTests2[0] = 16'b0000_0000_0000_0001;
    funcTests[0] = 2'b11;                     // ADD
    resultTests[0] = 16'b0000_0000_0000_0010;   

    inputTests1[1] = 16'b1111_1111_1111_1111;
    inputTests2[1] = 16'b0000_0000_0000_0001;
    funcTests[1] = 2'b11;                     // ADD
    resultTests[1] = 16'b0000_0000_0000_0000;   

    inputTests1[2] = 16'b0000_0000_1111_1111;
    inputTests2[2] = 16'b0000_0000_0000_0101;
    funcTests[2] = 2'b10;                     // MOV
    resultTests[2] = 16'b0000_0000_1111_1111;   
        
    inputTests1[3] = 16'b0000_1111_0000_1111;
    inputTests2[3] = 16'b0000_0000_0000_0001;
    funcTests[3] = 2'b01;                     // NOT
    resultTests[3] = 16'b1111_0000_1111_0000;   
    
    inputTests1[4] = 16'b1111_0000_0000_1111;
    inputTests2[4] = 16'b1111_0000_0000_1111;
    funcTests[4] = 2'b01;                     // NOT
    resultTests[4] = 16'b0000_1111_1111_0000;

    // op1 = 16'b0000_0000_0000_0001;
    // op2 = 116'b0000_0000_0000_0001;
    // func = 4'b0111; 
    // #10;
    for (i=0;i<=4;i=i+1)
    begin
        op1 = inputTests1[i];
        op2 = inputTests2[i];
        func = funcTests[i];
        #10;
        if(result == resultTests[i]) begin
            $display("success");
        end
        else begin
          $display("fail in %b,ouput: %b ,expected result: %b",i,result,resultTests[i]);
        end
    end
$finish;
end
endmodule

