vlog Source/Building_Blocks/tristate_buffer.v TestBench/Building_Blocks/tristate_buffer_tb.v
vsim tristate_buffer_tb

add wave tristate_buffer_tb/data_in
add wave tristate_buffer_tb/enable
add wave tristate_buffer_tb/data_out

run -all