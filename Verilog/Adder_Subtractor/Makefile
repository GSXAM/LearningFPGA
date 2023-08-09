clean:
	cls
	del /s run.vvp dumwave.vcd runtest.vvp dumptest.vcd

conpile:
	iverilog -o run.vvp tb.v

run: conpile
	vvp run.vvp

runall: run
	gtkwave dumpwave.vcd

runtest: clean
	iverilog -o runtest.vvp tb_test.v
	vvp runtest.vvp
	gtkwave dumptest.vcd