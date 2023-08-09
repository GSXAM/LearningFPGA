`timescale 1ns/1ps

`define FA
// `define CLA
// `define TOP

`ifdef FA
    `include "full_adder_modified.v"
`elsif CLA
    `include "carry_look_ahead_adder.v"
`elsif TOP
    `include "adder_subtractor_top.v"
`endif

module tb_FFA (
    // ports
);
/*---------- Declare wire, reg ----------*/
`ifdef FA
    reg [31:0] A;
    reg [31:0] B;
    reg [31:0] C;
    wire [31:0] Sum;
    wire [31:0] g;
    wire [31:0] p;
`elsif CLA
    reg [3:0] g;
    reg [3:0] p;
    reg Select;
    wire [4:0] C;
`elsif TOP
    reg [31:0] A;
    reg [31:0] B;
    reg Select;
    output [31:0] Sum;
    output CarryOut;
`endif
/*---------- Declare hierarchy module -----------*/
`ifdef FA
    full_adder_modified FA_Test(.A(A), .B(B), .C(C), .Sum(Sum), .g(g), .p(p));
`elsif CLA
    CLA CLA_Test(.g(g), .p(p), .Select(Select), .C(C));
`elsif TOP
    adder_subtractor_top UUT(.A(A), .B(B), .Select(Select), .Sum(Sum), .CarryOut(CarryOut));
`endif

/*---------- Sequence signal ----------*/
    initial begin
        $dumpfile("dumpwave.vcd");
        $dumpvars(0, tb_FFA);
`ifdef FA
`elsif CLA
`elsif TOP
`else
        $display("No module has found!");
`endif
    end
endmodule