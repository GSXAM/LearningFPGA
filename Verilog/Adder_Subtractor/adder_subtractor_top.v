`timescale 1ns/1ps
`include "carry_look_ahead_adder.v"
`include "full_adder_modified.v"

module adder_subtractor_top (
    input [31:0] A,
    input [31:0] B,
    input Select,
    output [31:0] Sum,
    output CarryOut
);
    
endmodule