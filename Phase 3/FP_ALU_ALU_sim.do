vlog FU_ALU_ALU.v FU_ALU_ALU_tb.v
vsim FU_ALU_ALU_tb

add wave -position end  sim:/FU_ALU_ALU_tb/Current_Src_1_NUM
add wave -position end  sim:/FU_ALU_ALU_tb/Current_Src_2_NUM
add wave -position end  sim:/FU_ALU_ALU_tb/Old_Dst_1_NUM
add wave -position end  sim:/FU_ALU_ALU_tb/Old_Dst_2_NUM
add wave -position end -radix hex  sim:/FU_ALU_ALU_tb/Old_Dst_1_VALUE
add wave -position end -radix hex  sim:/FU_ALU_ALU_tb/Old_Dst_2_VALUE
add wave -position end -radix hex  sim:/FU_ALU_ALU_tb/Actual_Src_1_VALUE
add wave -position end -radix hex  sim:/FU_ALU_ALU_tb/Actual_Src_2_VALUE
add wave -position end  sim:/FU_ALU_ALU_tb/M2R1
add wave -position end  sim:/FU_ALU_ALU_tb/M2R2
add wave -position end  sim:/FU_ALU_ALU_tb/enable
add wave -position end  sim:/FU_ALU_ALU_tb/clk

run 100
run 100
run 100
run 100
run 100
run 100
run 100
run 100