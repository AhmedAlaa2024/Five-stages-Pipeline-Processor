vlog BU.v BU_tb.v
vsim BU_tb

add wave -position end -radix bin sim:/BU_tb/*

set num_test_cases      8

for {set i 0} {$i < ${num_test_cases}} {incr i} {
    run
}