vlog SP_FU.v SP_FU_tb.v
vsim SP_FU_tb

add wave -position end -radix hex sim:/SP_FU_tb/*

set num_test_cases      6

for {set i 0} {$i < ${num_test_cases}} {incr i} {
    run
}