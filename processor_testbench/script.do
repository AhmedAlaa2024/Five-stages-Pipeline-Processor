vsim -gui work.Processor_tb

add wave -position 10  sim:/Processor_tb/processor/registers/general_regester

add wave -position end sim:/Processor_tb/processor/*

mem load -i {D:/Material/3rd CMP/First term/Computer arch/Project/processor_testbench/memory_test.mem} /Processor_tb/processor/InstrCache/cache

run