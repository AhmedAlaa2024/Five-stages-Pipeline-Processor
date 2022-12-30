module ICU(int_flag, ack, stall, reg_id, stack_op, push_pop, branch, PC_VALUE, clk, enable, reset);

localparam NUM_STATES = 6;

localparam IDLE_STATE = 3'd0;
localparam STALL_1_STATE = 3'd1;
localparam PUSH_CCR_STATE = 3'd2;
localparam PUSH_PCL_STATE = 3'd3;
localparam PUSH_PCH_STATE = 3'd4;
localparam PC_CHANGE_STATE = 3'd5;

localparam PCL_ID = 8;
localparam PCH_ID = 9;
localparam CCR_ID = 10;

input int_flag;
output reg ack;
output reg stall;
output reg [3:0] reg_id;
output reg stack_op;
output reg push_pop;
output reg branch;
output reg [31:0] PC_VALUE;

input clk, enable, reset;

reg int_flag_signal;

reg [2:0] state_reg;
reg [2:0] state_next;

/* [TODO] The user must clear the interrupt flag once the ack is fired! */

always @(posedge clk)
    begin
        if (enable == 1)
            begin
                int_flag_signal <= int_flag;

                if (reset == 0)
                    begin
                        state_reg <= IDLE_STATE;
                    end
                else
                    begin
                        state_reg <= state_next;
                    end
            end
        else
            begin
                state_reg <= IDLE_STATE;
                int_flag_signal <= 0;
            end        
    end

always @(state_reg, int_flag_signal)
    begin
        case (state_reg)
            IDLE_STATE:
                begin
                    stall <= 1'bz;
                    stack_op <= 1'bz;
                    push_pop <= 1'bz;
                    branch <= 1'bz;
                    reg_id <= 4'bz;
                    PC_VALUE <= 32'bz;

                    if ((int_flag_signal == 1) && (ack == 0))       /* This is a new interrupt! */
                        begin
                            state_next <= STALL_1_STATE;
                        end
                    else if ((int_flag_signal == 1) && (ack == 1))  /* The user doesn't konw that ICU has already handled his interrupt! */
                        begin
                            state_next <= IDLE_STATE;
                        end
                    else /* The user realized that the interrupt is handled! */
                        begin
                            ack <= 0;
                            state_next <= IDLE_STATE;
                        end
                end
            STALL_1_STATE:
                begin
                    /* I need one stall until last instruction write back the last update of CCR */
                    ack <= 0;
                    stall <= 1;
                    stack_op <= 0;
                    push_pop <= 0;
                    branch <= 0;
                    reg_id = 4'bz;
                    PC_VALUE <= 32'bz;
                    state_next <= PUSH_CCR_STATE;
                end
            PUSH_CCR_STATE:
                begin
                    ack <= 0;
                    stall <= 0;
                    stack_op <= 1;
                    push_pop <= 1;
                    branch <= 0;
                    reg_id <= CCR_ID;
                    PC_VALUE <= 32'bz;
                    state_next <= PUSH_PCL_STATE;
                end
            PUSH_PCL_STATE:
                begin
                    ack <= 0;
                    stall <= 0;
                    stack_op <= 1;
                    push_pop <= 1;
                    branch <= 0;
                    reg_id <= PCL_ID;
                    PC_VALUE <= 32'bz;
                    state_next <= PUSH_PCH_STATE;
                end
            PUSH_PCH_STATE:
                begin
                    ack <= 0;
                    stall <= 0;
                    stack_op <= 1;
                    push_pop <= 1;
                    branch <= 0;
                    reg_id <= PCH_ID;
                    PC_VALUE <= 32'bz;
                    state_next <= PC_CHANGE_STATE;
                end
            PC_CHANGE_STATE:
                begin
                    ack <= 1;
                    stall <= 0;
                    stack_op <= 0;
                    push_pop <= 0;
                    branch <= 1;
                    reg_id <= 4'bz;
                    PC_VALUE <= 32'b0;
                    state_next <= IDLE_STATE;
                end
            default:
                begin
                    state_next <= IDLE_STATE;
                end
        endcase
    end

endmodule