
module ALU_tb();

 reg[15:0] op1,op2;
 reg[3:0] func;
 wire[15:0] result;
 wire[15:0] flags; 

reg [15:0] inputTests1 [0:15];
reg [15:0] inputTests2 [0:15];
reg [15:0] resultTests [0:15];
reg [15:0] flagsTests [0:15];
reg [3:0] funcTests [0:15];
ALU alu(.op1(op1),.op2(op2),.func(func),.result(result),.outFlags(flags));
 integer i;
initial begin
    // hold reset state for 100 ns.
    inputTests1[0] = 16'b0000_0000_0000_0001;
    inputTests2[0] = 16'b0000_0000_0000_0001;
    funcTests[0] = 4'b1000;                     // ADD
    resultTests[0] = 16'b0000_0000_0000_0010;   

    inputTests1[1] = 16'b0000_0000_0000_0001;
    inputTests2[1] = 16'b0000_0000_0000_0001;
    funcTests[1] = 4'b1001;                     // SUB
    resultTests[1] = 16'b0000_0000_0000_0000;   

    inputTests1[2] = 16'b0000_0000_0000_0011;
    inputTests2[2] = 16'b0000_0000_0000_0101;
    funcTests[2] = 4'b1011;                     // OR
    resultTests[2] = 16'b0000_0000_0000_0111;   
        
    inputTests1[3] = 16'b1000_0000_0000_0001;
    inputTests2[3] = 16'b0000_0000_0000_0001;
    funcTests[3] = 4'b1100;                     // SHL
    resultTests[3] = 16'b0000_0000_0000_0010;   
    
    inputTests1[4] = 16'b0000_0000_0000_0011;
    inputTests2[4] = 16'b0000_0000_0000_0001;
    funcTests[4] = 4'b1101;                     // SHR
    resultTests[4] = 16'b0000_0000_0000_0001;

    inputTests1[5] = 16'b0111_1111_1111_1111;
    inputTests2[5] = 16'b0000_0000_0000_0001;
    funcTests[5] = 4'b0110;                     // INC
    resultTests[5] = 16'b1000_0000_0000_0000;   // overflow bit is should be one

    inputTests1[6] = 16'b0000_0000_0000_0000;
    inputTests2[6] = 16'b0000_0000_0000_0001;
    funcTests[6] = 4'b0111;                     // DEC
    resultTests[6] = 16'b1111_1111_1111_1111;   // overflow bit is should be one


    inputTests1[7] = 16'b0000_0000_0000_0000;
    inputTests2[7] = 16'b0000_0000_0000_0001;
    funcTests[7] = 4'b0000;                     // NOP
    resultTests[7] = 16'b0000_0000_0000_0000;   // flags should not change

    inputTests1[8] = 16'b0000_0000_1111_0000;
    inputTests2[8] = 16'b0000_0000_0000_0001;
    funcTests[8] = 4'b0011;                     // Mov operand 1
    resultTests[8] = 16'b0000_0000_1111_0000;   // flags should not change

    inputTests1[9] = 16'b0000_0000_0000_0000;
    inputTests2[9] = 16'b0000_1111_0000_1111;
    funcTests[9] = 4'b0100;                     // Mov operand 2
    resultTests[9] = 16'b0000_1111_0000_1111;   // flags should not change

    inputTests1[10] = 16'b0000_0000_1111_0000;
    inputTests2[10] = 16'b0000_1111_0000_1111;
    funcTests[10] = 4'b0101;                     // Not
    resultTests[10] = 16'b1111_1111_0000_1111;   // flags should not change
    // op1 = 16'b0000_0000_0000_0001;
    // op2 = 116'b0000_0000_0000_0001;
    // func = 4'b0111; 
    // #10;
    for (i=0;i<=10;i=i+1)
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
