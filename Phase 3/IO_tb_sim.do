vlog IO.v IO_tb.v
vsim IO_tb

add wave -position end -radix bin sim:/IO_tb/*
add wave -position end -radix bin sim:/IO_tb/IO_inst/PORTIN_DATA
add wave -position end -radix bin sim:/IO_tb/IO_inst/PORTOUT_DATA

set num_test_cases      12

for {set i 0} {$i < ${num_test_cases}} {incr i} {
    run
}