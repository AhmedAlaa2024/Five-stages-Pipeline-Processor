vsim -gui work.Fabonacci_Processor_tb

add wave -position end -radix unsigned sim:/Fabonacci_Processor_tb/cycles_counter
add wave -position end -radix hex sim:/Fabonacci_Processor_tb/portIn
add wave -position end -radix hex sim:/Fabonacci_Processor_tb/portOut
add wave -position end -radix bin sim:/Fabonacci_Processor_tb/int
add wave -position end -radix bin sim:/Fabonacci_Processor_tb/clk
add wave -position end -radix bin sim:/Fabonacci_Processor_tb/reset
add wave -position end -radix bin sim:/Fabonacci_Processor_tb/ack
add wave -position end -radix unsigned sim:/Fabonacci_Processor_tb/processor/registers/general_regester



mem load -i {E:\Education\Computer Engineering\Third Year\First Semester\Computer Archeticture\MIPS-Microprocessor-Design\Phase 3\PipelineProcessor\memory_fabonacci_program.mem} /Fabonacci_Processor_tb/processor/InstrCache/cache
mem load -i {E:\Education\Computer Engineering\Third Year\First Semester\Computer Archeticture\MIPS-Microprocessor-Design\Phase 3\PipelineProcessor\data.mem} /Fabonacci_Processor_tb/processor/DM/cache

set NUM_CLOCK_CYCLES              200
set CLOCK_CYCLE_PERIOD            100

run 20000

mem save -o data_out.mem -f mti -data unsigned -addr decimal -wordsperline 1 /Fabonacci_Processor_tb/processor/DM/cache
mem save -o regFile.mem -f mti -data unsigned -addr decimal -wordsperline 1 /Fabonacci_Processor_tb/processor/registers/general_regester