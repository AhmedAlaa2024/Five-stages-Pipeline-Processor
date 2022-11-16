module ALU (op1,op2,func,result,outFlags);

//input writeFlags;
input [15:0] op1,op2;
input [3:0] func;
output reg [15:0] result,outFlags;
reg [15:0] flags;
assign outFlags = flags; // assign outFlags with flag register so flags are already read from ALU (continous Read)
always @(*) begin
    if(func == 4'b0000) begin  // No Operation
        result <= 16'b0;
    end
    if(func == 4'b0001) begin  // Set Carry Flag
        result <= 16'b0;
        flags[2] <= 1; 
    end
    else if(func == 4'b0010) begin  // Clear Flag
        result <= 16'b0;
        flags[2] <= 0; 
    end
    else if(func == 4'b0011) begin  // Move Operand 1
        result = op1;
        flags[0] = 0;
        if(op1 == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = op1[15];// Flags should be affected
    end
    else if(func == 4'b0100) begin  // Move Operand 1
        result = op2;
        flags[0] = 0;
        if(op2 == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = op2[15];// Flags should be affected
    end
    else if(func == 4'b0101) begin  // NOT operand 1
        result = ~ op1;
        flags[0] = 0;
        if(result == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = result[15];// Flags should be affected
    end
    else if(func == 4'b0110) begin  // INC operand 1 (need to check overflow flag)
        {flags[2] ,result} = op1 + 16'b0000_0000_0000_0001; 
        flags[0] = 0;
        if(result == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = result[15];// Flags should be affected
    end
    else if(func == 4'b0111) begin  // DEC operand 1 (need to check overflow flag)
        {flags[2] ,result} = op1 - 16'b0000_0000_0000_0001; 
        flags[0] = 0;
        if(result == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = result[15];// Flags should be affected
    end
    else if(func == 4'b1000) begin  // ADD (need to check overflow flag)
        {flags[2] ,result} = op1 + op2 ; 
        flags[0] = 0;
        if(result == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = result[15];// Flags should be affected
    end
    else if(func == 4'b1001) begin  // SUB (need to check overflow flag)
        result = 16'b0;
        {flags[2] ,result} = op1 - op2 ; 
        flags[0] = 0;
        if(result == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = result[15];// Flags should be affected
    end
    else if(func == 4'b1010) begin // AND
        result = op1 & op2;
        flags[0] = 0;
        if(result == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = result[15];// Flags should be affected
    end
    else if(func == 4'b1011) begin  // OR
        result = op1 | op2;
        flags[0] = 0;
        if(result == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = result[15];// Flags should be affected
    end
    else if(func == 4'b1100) begin   // SHL
        {flags[2],result} = {1'b0,op1} << op2;
        flags[0] = 0;
        if(result == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = result[15];// Flags should be affected
    end
    else if(func == 4'b1101) begin   // SHR
        {result,flags[2]} = {op1,1'b0} >> op2;
        flags[0] = 0;
        if(result == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = result[15];// Flags should be affected
    end
    /*
    4'b1101: // Addition
        result = 16'b0;
        flags = 16'b0;
    4'b1110: // Addition
        result = 16'b0;
        flags = 16'b0;
    4'b1111: // Addition
        result = 16'b0;
        flags = 16'b0;
    */
    else begin
        result = 16'b0;
    end
end

endmodule
