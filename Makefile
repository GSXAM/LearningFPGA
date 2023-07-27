clean:
	cls
	del /s run.vvp dumpwave.vcd
	
compile: clean
	iverilog -o run.vvp tb.v

run: compile
	vvp run.vvp

run-with-gtkwave: run
	gtkwave dumpwave.vcd

open-wave:
	gtkwave dumpwave.vcd