vlog ICU_v2.v ICU_v2_tb.v
vsim ICU_tb

add wave -position end -radix bin sim:/ICU_tb/*
add wave -position end -radix unsigned sim:/ICU_tb/cycles_counter

set num_clk_cycles_needed      32

for {set i 0} {$i < ${num_clk_cycles_needed}} {incr i} {
    run 100
}