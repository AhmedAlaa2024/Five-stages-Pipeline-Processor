vlog FD_pipeline_register.v FD_pipeline_register_tb.v
vsim -gui work.FD_pipeline_register_tb

add wave sim:/FD_pipeline_register_tb/*

add wave sim/FD_pipeline_register_tb/FD_pipeline_register/*

run