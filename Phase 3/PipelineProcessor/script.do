vsim -gui work.Processor_tb

add wave -position end -radix unsigned sim:/Processor_tb/cycles_counter

add wave -position 10  sim:/Processor_tb/processor/registers/general_regester

add wave -position end sim:/Processor_tb/processor/registers/read_sp

add wave -position end sim:/Processor_tb/processor/*



mem load -i {D:\Material\3rd CMP\First term\Computer arch\Project\processor\memory_test.mem} /Processor_tb/processor/InstrCache/cache
mem load -i {D:\Material\3rd CMP\First term\Computer arch\Project\processor\test_data_memory.mem} /Processor_tb/processor/DM/cache

run

mem save -o data.mem -f mti -data unsigned -addr decimal -wordsperline 1 /Processor_tb/processor/DM/cache
mem save -o regFile.mem -f mti -data unsigned -addr decimal -wordsperline 1 /Processor_tb/processor/registers/general_regester