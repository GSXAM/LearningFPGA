# Clock divider for both odd and even divisor

- Divisor range: 1 to 65535 (16-bit counter register).
- Reset stage:
  - counter register:  **cnt** = 0x0000
  - output: **clkout** = 0
- Counter register counts up at both positive and negative edge of clock input **clkin**, followed by odd or even **divisor** input.
---------
Block diagram:
![clock-divider-diagram](https://github.com/GSXAM/LearningFPGA/tree/master/Verilog/Clock_divider/clock-divider-diagram.svg)