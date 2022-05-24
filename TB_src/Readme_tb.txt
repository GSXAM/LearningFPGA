+ Step1: import all source code in directory "Srcs"
+ Step2: open 2 source code file "Clock_divider_1Hz.vhd" and "clock_divider_50Hz.vhd"
+ Step3:
	--With clock_divider_50Hz.vhd file: At line 49, change condition if stagement "if(counter = 999999) then" into "if (counter = 1) then".
	--With Clock_divider_1Hz.vhd file: At line 50, change condition if stagement "if(counter = 49999999) then" into "if (counter = 50) then".
+ Step 4: import file testbench in directory "TB_src", then run simulation with time duration: 50us

--- end! ---