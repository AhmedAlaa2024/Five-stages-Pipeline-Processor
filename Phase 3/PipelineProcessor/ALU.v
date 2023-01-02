
module ALU (op1,op2,func,result,inFlags,outFlags);

//input writeFlags;
input [15:0] op1,op2;
input [3:0] func;
output reg [15:0] result;
input wire [4:0] inFlags;
output reg [4:0] outFlags;
//reg [4:0] flags;    // 0 -> zero , 1 -> sign  2-> carry 
//assign outFlags = flags; // assign outFlags with flag register so flags are already read from ALU (continous Read)
always @(*) begin
    outFlags = inFlags;
    case (func)
    4'b0000: begin  // No Operation
        result <= 16'b0;
    end
     4'b0001: begin  // Set Carry Flag
        result <= 16'b0;
        outFlags[2] <= 1; 
    end
    4'b0010: begin  // Clear Carry Flag
        result <= 16'b0;
        outFlags[2] <= 0; 
    end
    4'b0011: begin  // Move Operand 1
        result = op1;
        //outFlags[0] = 0;
        // if(op1 == 0) begin
        //     outFlags[0] = 1;// Flags should be affected
        // end
        // outFlags[1] = op1[15];// Flags should be affected
    end
    4'b0100: begin  // Move Operand 2
        result = op2;
        //outFlags[0] = 0;
        // if(op2 == 0) begin
        //     outFlags[0] = 1;// Flags should be affected
        // end
        // outFlags[1] = op2[15];// Flags should be affected
    end
    4'b0101: begin  // NOT operand 1
        result = ~ op1;
        outFlags[0] = 0;
        if(result == 0) begin
            outFlags[0] = 1;// Flags should be affected
        end
        outFlags[1] = result[15];// Flags should be affected
    end
    4'b0110: begin  // INC operand 1 (need to check overflow flag)
        {outFlags[2] ,result} = op1 + 16'b0000_0000_0000_0001; 
        outFlags[0] = 0;
        if(result == 0) begin
            outFlags[0] = 1;// Flags should be affected
        end
        outFlags[1] = result[15];// Flags should be affected
    end
    4'b0111: begin  // DEC operand 1 (need to check overflow flag)
        {outFlags[2] ,result} = op1 - 16'b0000_0000_0000_0001; 
        outFlags[0] = 0;
        if(result == 0) begin
            outFlags[0] = 1;// Flags should be affected
        end
        outFlags[1] = result[15];// Flags should be affected
    end
    4'b1000: begin  // ADD (need to check overflow flag)
        {outFlags[2] ,result} = op1 + op2 ; 
        outFlags[0] = 0;
        if(result == 0) begin
            outFlags[0] = 1;// Flags should be affected
        end
        outFlags[1] = result[15];// Flags should be affected
    end
    4'b1001: begin  // SUB (need to check overflow flag)
        result = 16'b0;
        {outFlags[2] ,result} = op2 - op1 ; 
        outFlags[0] = 0;
        if(result == 0) begin
            outFlags[0] = 1;// Flags should be affected
        end
        outFlags[1] = result[15];// Flags should be affected
    end
    4'b1010: begin // AND
        result = op1 & op2;
        outFlags[0] = 0;
        if(result == 0) begin
            outFlags[0] = 1;// Flags should be affected
        end
        outFlags[1] = result[15];// Flags should be affected
    end
    4'b1011: begin  // OR
        result = op1 | op2;
        outFlags[0] = 0;
        if(result == 0) begin
            outFlags[0] = 1;// Flags should be affected
        end
        outFlags[1] = result[15];// Flags should be affected
    end
    4'b1100: begin   // SHL
        {outFlags[2],result} = {1'b0,op2} << op1;
        outFlags[0] = 0;
        if(result == 0) begin
            outFlags[0] = 1;// Flags should be affected
        end
        outFlags[1] = result[15];// Flags should be affected
    end
    4'b1101: begin   // SHR
        {result,outFlags[2]} = {op2,1'b0} >> op1;
        outFlags[0] = 0;
        if(result == 0) begin
            outFlags[0] = 1;// Flags should be affected
        end
        outFlags[1] = result[15];// Flags should be affected
    end
    
    4'b1101: begin // Addition
        result = {11'b0,inFlags};
    end
    /*    
    4'b1110: // Addition
        result = 16'b0;
        flags = 16'b0;
    4'b1111: // Addition
        result = 16'b0;
        flags = 16'b0;
    */
        default: 
            result <= 16'b0;
    endcase
end

endmodule

