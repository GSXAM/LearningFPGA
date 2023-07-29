clean:
	cls
	del /s run.vvp run_test.vvp dumpwave.vcd wave_test.vcd
compile-tb: clean
	iverilog -o run.vvp tb.v
run-tb: compile-tb
	vvp run.vvp
run-wave-tb: run-tb
	gtkwave dumpwave.vcd



compile-tb-test: clean
	iverilog -o run_test.vvp tb_test.v
run-tb-test: compile-tb-test
	vvp run_test.vvp
run-wave-tb-test: run-tb-test
	gtkwave wave_test.vcd