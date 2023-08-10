`timescale 1ns/1ps

module full_adder_modified (
    input [31:0] A,
    input [31:0] B,
    input [31:0] Ci,
    output [31:0] Sum,
    output [31:0] g,
    output [31:0] p
);
    assign Sum = A^B^Ci;
    assign g = A&B;
    assign p = A|B;
endmodule