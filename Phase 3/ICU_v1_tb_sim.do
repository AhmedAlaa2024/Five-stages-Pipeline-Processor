vlog ICU.v ICU_tb.v
vsim ICU_tb

add wave -position end -radix unsigned sim:/ICU_tb/cycles_counter
add wave -position end -radix bin sim:/ICU_tb/U/*

set num_clk_cycles_needed      32

for {set i 0} {$i < ${num_test_cases}} {incr i} {
    run 100
}