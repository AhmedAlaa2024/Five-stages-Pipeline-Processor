

module ALU_1 (op1,op2,func,result,outFlags);

//input writeFlags;
input [15:0] op1,op2;
input [1:0] func;
output reg [15:0] result;
output wire [5:0]  outFlags;
reg [5:0] flags;    // 0 -> zero , 1 -> sign  2-> carry 
assign outFlags = flags; // assign outFlags with flag register so flags are already read from ALU (continous Read)
always @(*) begin
    case (func)
    2'b00: begin  // No Operation
        result <= 16'b0;
    end
     2'b01: begin  // NOT
        result = ~ op1;
        flags[0] = 0;
        if(result == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = result[15];// Flags should be affected
    end
    2'b10: begin  //  mov operand 1
        result = op1;
        flags[0] = 0;
        if(op1 == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = op1[15];// Flags should be affected
    end
    2'b11: begin  // ADD
        {flags[2] ,result} = op1 + op2 ; 
        flags[0] = 0;
        if(result == 0) begin
            flags[0] = 1;// Flags should be affected
        end
        flags[1] = result[15];// Flags should be affected
    end
     default: 
            result <= 16'b0;
    endcase
end

endmodule

