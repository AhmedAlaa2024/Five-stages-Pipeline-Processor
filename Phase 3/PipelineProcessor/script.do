vsim -gui work.Processor_tb

add wave -position 10  sim:/Processor_tb/processor/registers/general_regester

add wave -position end sim:/Processor_tb/processor/*

mem load -i {D:/Engineering/Third_Year/CMP_2023/First_Term/Arch/project/Phase3/PipelineProcessor/memory_test.mem} /Processor_tb/processor/InstrCache/cache

run

mem save -o data.mem -f mti -data unsigned -addr decimal -wordsperline 1 /Processor_tb/processor/DM/cache
mem save -o regFile.mem -f mti -data unsigned -addr decimal -wordsperline 1 /Processor_tb/processor/registers/general_regester
