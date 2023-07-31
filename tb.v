`timescale 1ns/1ps
`include "clk_div_top.v"
module tb (
    // ports
);
    reg clk, reset;
    reg [15:0] divisor;
    wire clkout;

    clk_div_top UUT(.clkin(clk), .reset(reset), .divisor(divisor), .clkout(clkout));

    always begin
        #1 clk <= !clk;
    end

    initial begin
        $dumpfile("dumpwave.vcd");
        $dumpvars(0, tb);
        clk = 0;
        reset = 1;          // No reset
        divisor = 16'd6 - 16'd1;    // clkin/6: even
        #18.5 reset = 0;      // reset
        #30 reset = 1;
        #100 divisor = 16'd5 - 16'd1;   // clkin/9: odd
        #200 $finish;
    end
endmodule