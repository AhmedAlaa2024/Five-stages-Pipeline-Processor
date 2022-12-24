vlog Full_FU.v Full_FU_tb.v
vsim Full_FU_tb

add wave -position end -radix unsigned sim:/Full_FU_tb/Current_Src_1_NUM
add wave -position end -radix unsigned sim:/Full_FU_tb/Current_Src_2_NUM
add wave -position end -radix unsigned sim:/Full_FU_tb/Old_Dst_1_NUM
add wave -position end -radix unsigned sim:/Full_FU_tb/Old_Dst_2_NUM
add wave -position end -radix hex  sim:/Full_FU_tb/Old_Dst_1_VALUE
add wave -position end -radix hex  sim:/Full_FU_tb/Old_Dst_2_VALUE
add wave -position end -radix hex  sim:/Full_FU_tb/Actual_Src_1_VALUE
add wave -position end -radix hex  sim:/Full_FU_tb/Actual_Src_2_VALUE
add wave -position end -radix bin sim:/Full_FU_tb/M2R1
add wave -position end -radix bin sim:/Full_FU_tb/M2R2
add wave -position end -radix bin sim:/Full_FU_tb/enable
add wave -position end -radix bin sim:/Full_FU_tb/clk
add wave -position end -radix unsigned sim:/Full_FU_tb/counter

run 100
run 100
run 100
run 100
run 100
run 100
run 100
run 100