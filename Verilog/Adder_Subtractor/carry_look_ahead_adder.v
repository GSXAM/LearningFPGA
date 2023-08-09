`timescale 1ns/1ps

module CLA (
    input [3:0] g,
    input [3:0] p,
    input Select,
    output [4:0] C
);
    assign C[0] = Select;
    assign C[1] = g[0] | (p[0]&C[0]);
    assign C[2] = g[1] | (p[1]&g[0]) | (p[0]&p[1]&C[0]);
    assign C[3] = g[2] | (p[2]&g[1]) | (p[1]&p[2]&g[0]) | (p[0]&p[1]&p[2]&C[0]);
    assign C[4] = g[3] | (p[3]&g[2]) | (p[2]&p[3]&g[1]) | (p[1]&p[2]&p[3]&g[0]) | (p[0]&p[1]&p[2]&p[3]&C[0]);
endmodule