`timescale 1ns/1ps

module full_adder_modified (
    input [31:0] A,
    input [31:0] B,
    input [31:0] Ci,
    output [31:0] Sum,
    output [31:0] g,
    output [31:0] p
);
    assign #2 Sum = A^B^Ci;
    assign #1 g = A&B;
    assign #1 p = A|B;
endmodule