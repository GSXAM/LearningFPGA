clean:
	cls
	del /s run.vvp dumwave.vcd runtest.vvp dumptest.vcd
compile:
	iverilog -o run.vvp tb.v
run:
	vvp run.vvp
openwave:
	gtkwave dumpwave.vcd
runtest:
	iverilog -o runtest.vvp tb_test.v
	vvp runtest.vvp
wavetest:
	gtkwave dumptest.vcd