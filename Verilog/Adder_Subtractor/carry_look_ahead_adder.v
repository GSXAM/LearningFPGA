`timescale 1ns/1ps

module CLA (
    input [3:0] g,
    input [3:0] p,
    input Select,
    output [4:0] Co
);
    assign Co[0] = Select;
    assign Co[1] = g[0] | (p[0]&Co[0]);
    assign Co[2] = g[1] | (p[1]&g[0]) | (p[0]&p[1]&Co[0]);
    assign Co[3] = g[2] | (p[2]&g[1]) | (p[1]&p[2]&g[0]) | (p[0]&p[1]&p[2]&Co[0]);
    assign Co[4] = g[3] | (p[3]&g[2]) | (p[2]&p[3]&g[1]) | (p[1]&p[2]&p[3]&g[0]) | (p[0]&p[1]&p[2]&p[3]&Co[0]);
endmodule