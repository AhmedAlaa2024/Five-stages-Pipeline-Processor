vsim -gui work.Processor_tb

add wave -position end -radix unsigned sim:/Processor_tb/cycles_counter

add wave -position 10  sim:/Processor_tb/processor/registers/general_regester

add wave -position end sim:/Processor_tb/processor/registers/read_sp

add wave -position end sim:/Processor_tb/processor/*



mem load -i {E:\Education\Computer Engineering\Third Year\First Semester\Computer Archeticture\MIPS-Microprocessor-Design\Phase 3\PipelineProcessor\memory_fabonacci_program.mem} /Processor_tb/processor/InstrCache/cache

run

mem save -o data.mem -f mti -data unsigned -addr decimal -wordsperline 1 /Processor_tb/processor/DM/cache
mem save -o regFile.mem -f mti -data unsigned -addr decimal -wordsperline 1 /Processor_tb/processor/registers/general_regester