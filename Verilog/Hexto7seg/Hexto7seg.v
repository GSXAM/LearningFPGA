`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2023 09:10:07 PM
// Design Name: 
// Module Name: Hexto7seg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define common_anode
// `define common_cathode
`define OP_logic
// `define OP_cond

module Hexto7seg(
    input [3:0] inhex,
    output [6:0] seg
    );

`ifdef common_cathode
    /*----------------*/
    /* Common Cathode */
    /*----------------*/
    `ifdef OP_logic
    /* Logical operation */
    assign seg[0] = (~inhex[2] & ~inhex[0]) | (~inhex[3] & inhex[1]) | (~inhex[3] & inhex[2] & inhex[0]) | (inhex[3] & ~inhex[2] & ~inhex[1]) | (inhex[2] & inhex[1]);
    assign seg[1] = (~inhex[3] & ~inhex[1] & ~inhex[0]) | (~inhex[3] & inhex[1] & inhex[0]) | (~inhex[2] & ~inhex[0]) | (inhex[3] & ~inhex[1] & inhex[0]) | (~inhex[3] & ~inhex[2]);
    assign seg[2] = (~inhex[3] & inhex[2]) | (inhex[3] & ~inhex[2]) | (~inhex[1] & inhex[0]) | (~inhex[3] & ~inhex[1]) | (~inhex[3] & inhex[0]);
    assign seg[3] = (inhex[2] & ~inhex[1] & inhex[0]) | (~inhex[3] & ~inhex[2] & ~inhex[0]) | (~inhex[2] & inhex[1] & inhex[0]) | (inhex[2] & inhex[1] & ~inhex[0]) | (inhex[3] & ~inhex[1]);
    assign seg[4] = (~inhex[2] & ~inhex[0]) | (inhex[1] & ~inhex[0]) | (inhex[3] & inhex[1]) | (inhex[3] & inhex[2]);
    assign seg[5] = (~inhex[3] & inhex[2] & ~inhex[1]) | (inhex[3] & ~inhex[2]) | (inhex[3] & inhex[1]) | (~inhex[3] & ~inhex[1] & ~inhex[0]) | (~inhex[3] & inhex[2] & ~inhex[0]);
    assign seg[6] = (~inhex[2] & inhex[1]) | (inhex[2] & ~inhex[1]) | (inhex[3]) | (inhex[1] & ~inhex[0]);
    `else
    /* Conditional operators */
    assign seg = (inhex == 4'h0) ? 7'b1111110 :
                 (inhex == 4'h1) ? 7'b0110000 :
                 (inhex == 4'h2) ? 7'b1101101 :
                 (inhex == 4'h3) ? 7'b1111001 :
                 (inhex == 4'h4) ? 7'b0110011 :
                 (inhex == 4'h5) ? 7'b1011011 :
                 (inhex == 4'h6) ? 7'b1011111 :
                 (inhex == 4'h7) ? 7'b1110000 :
                 (inhex == 4'h8) ? 7'b1111111 :
                 (inhex == 4'h9) ? 7'b1111011 :
                 (inhex == 4'hA) ? 7'b1110111 :
                 (inhex == 4'hB) ? 7'b0011111 :
                 (inhex == 4'hC) ? 7'b0001101 :
                 (inhex == 4'hD) ? 7'b0111101 :
                 (inhex == 4'hE) ? 7'b1001111 :
                 (inhex == 4'hF) ? 7'b1000111 :
                 7'bXXXXXXX;
    `endif
`elsif common_anode
    /*--------------*/
    /* Common anode */
    /*--------------*/
    `ifdef OP_logic
    /* Logical operation */
    assign seg[0] = (inhex[2] | inhex[0]) & (inhex[3] | ~inhex[1]) & (inhex[3] | ~inhex[2] | ~inhex[0]) & (~inhex[3] | inhex[2] | inhex[1]) & (~inhex[2] | ~inhex[1]);
    assign seg[1] = (inhex[3] | inhex[1] | inhex[0]) & (inhex[3] | ~inhex[1] | ~inhex[0]) & (inhex[2] | inhex[0]) & (~inhex[3] | inhex[1] | ~inhex[0]) & (inhex[3] | inhex[2]);
    assign seg[2] = (inhex[3] | ~inhex[2]) & (~inhex[3] | inhex[2]) & (inhex[1] | ~inhex[0]) & (inhex[3] | inhex[1]) & (inhex[3] | ~inhex[0]);
    assign seg[3] = (~inhex[2] | inhex[1] | ~inhex[0]) & (inhex[3] | inhex[2] | inhex[0]) & (inhex[2] | ~inhex[1] | ~inhex[0]) & (~inhex[2] | ~inhex[1] | inhex[0]) & (~inhex[3] | inhex[1]);
    assign seg[4] = (inhex[2] | inhex[0]) & (~inhex[1] | inhex[0]) & (~inhex[3] | ~inhex[1]) & (~inhex[3] | ~inhex[2]);
    assign seg[5] = (inhex[3] | ~inhex[2] | inhex[1]) & (~inhex[3] | inhex[2]) & (~inhex[3] | ~inhex[1]) & (inhex[3] | inhex[1] | inhex[0]) & (inhex[3] | ~inhex[2] | inhex[0]);
    assign seg[6] = (inhex[2] | ~inhex[1]) & (~inhex[2] | inhex[1]) & (~inhex[3]) & (~inhex[1] | inhex[0]);
    `else
    /* Conditional operation */
    assign seg = (inhex = 4'h0) ? 7'b0000001 :
                 (inhex = 4'h1) ? 7'b1001111 :
                 (inhex = 4'h2) ? 7'b0010010 :
                 (inhex = 4'h3) ? 7'b0000110 :
                 (inhex = 4'h4) ? 7'b1001100 :
                 (inhex = 4'h5) ? 7'b0100100 :
                 (inhex = 4'h6) ? 7'b0100000 :
                 (inhex = 4'h7) ? 7'b0001111 :
                 (inhex = 4'h8) ? 7'b0000000 :
                 (inhex = 4'h9) ? 7'b0000100 :
                 (inhex = 4'hA) ? 7'b0001000 :
                 (inhex = 4'hB) ? 7'b1100000 :
                 (inhex = 4'hC) ? 7'b1110010 :
                 (inhex = 4'hD) ? 7'b1000010 :
                 (inhex = 4'hE) ? 7'b0110000 :
                 (inhex = 4'hF) ? 7'b0111000 :
                 7'hXX;
    `endif
`endif
endmodule
