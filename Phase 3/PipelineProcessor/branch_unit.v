module BranchUnit (CCR,branch,jmp_type,is_taken);

input [3:0] CCR;
input branch;
input [1:0] jmp_type;
output reg is_taken;

always @ (*) begin
    is_taken =1'b0;
    if(branch) begin

        case (jmp_type)
        2'b00: begin  
            if( CCR[0] == 1'b1 ) begin
                is_taken = 1'b1;
            end
        end
        2'b01: begin  
            if( CCR[1] == 1'b1) begin
                is_taken = 1'b1;
            end
        end
        2'b10: begin  
            if(CCR[2]== 1'b1 ) begin
                is_taken = 1'b1;
            end
        end
        2'b11: begin  
            is_taken = 1'b1;
        end
        default: 
            is_taken = 1'b0;
        endcase
    end
end

endmodule
