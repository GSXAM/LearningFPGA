`timescale 1ns/1ps
`include "clk_div_even.v"
module tb (
    // ports
);
    reg clk, reset, en;
    reg [15:0] divisor;
    wire clkout;

    clk_div_even UUT(.clkin(clk), .reset(reset), .en(en), .divisor(divisor), .clkout(clkout));

    always begin
        #1 clk <= !clk;
    end

    initial begin
        $dumpfile("dumpwave.vcd");
        $dumpvars(0, tb);
        clk = 0;
        reset = 0;          // No reset
        en = 0;             // Disable
        divisor = 16'd10;
        #20 en = 1;         // Enable
        #20 reset = 0;      // reset
        #10 reset = 1;
        #50 en = 0;
        #50 en = 1;
        #200 $finish;
    end
endmodule