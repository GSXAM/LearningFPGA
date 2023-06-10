# This Makefile run in Windows environment
# If you have Visual Studio, run the Visual Studio Command prompt from the
# start menu, change to the directory containing Makefile.win and type this:
#		nmake -f Makefile.win
# If you have installed MinGW, use this:
#		mingw32-make <target> 

compile: clean
	iverilog -o run.vvp tb.v
build: compile
	vvp run.vvp
runall: build
	gtkwave wave.vcd

clean:
	cls
	del /s run.vvp wave.vcd