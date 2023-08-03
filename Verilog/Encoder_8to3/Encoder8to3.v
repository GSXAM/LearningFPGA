`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2023 09:43:28 PM
// Design Name: 
// Module Name: Encoder8to3
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


module Encoder8to3(
    input [7:0] in8,
    output [2:0] out3
    );

    /*--------------------*/
    /* Condition operator */
    /*--------------------*/
    // assign out3 = (in8 == 8'b1) ? 3'h0 :
    //               (in8 == 8'b10) ? 3'h1 :
    //               (in8 == 8'b100) ? 3'h2 :
    //               (in8 == 8'b1000) ? 3'h3 :
    //               (in8 == 8'b10000) ? 3'h4 :
    //               (in8 == 8'b100000) ? 3'h5 :
    //               (in8 == 8'b1000000) ? 3'h6 :
    //               (in8 == 8'b10000000) ? 3'h7 :
    //               3'hX;

    /*------------------*/
    /* Logical operator */
    /*------------------*/
    // assign out3[0] = (~|in8[7:2]&in8[1]) | (~|in8[7:4]&in8[3]) | (~|in8[7:6]&in8[5]) | in8[7];
    // assign out3[1] = (~|in8[7:3]&in8[2]) | (~|in8[7:4]&in8[3]) | (~in8[7]&in8[6]) | in8[7];
    // assign out3[2] = (~|in8[7:5]&in8[4]) | (~|in8[7:6]&in8[5]) | (~in8[7]&in8[6]) | in8[7];

    /*----------------------*/
    /* Gate-level primitive */
    /*----------------------*/
    wire in8_a7_inv;
    wire [4:0] row;
    wire [5:0] col;

    nor(row[0], in8[2], in8[3], in8[4], in8[5], in8[6], in8[7]);
    nor(row[1], in8[3], in8[4], in8[5], in8[6], in8[7]);
    nor(row[2], in8[4], in8[5], in8[6], in8[7]);
    nor(row[3], in8[5], in8[6], in8[7]);
    nor(row[4], in8[6], in8[7]);
    
    not(in8_a7_inv, in8[7]);

    and(col[0], row[0], in8[1]);
    and(col[1], row[1], in8[2]);
    and(col[2], row[2], in8[3]);
    and(col[3], row[3], in8[4]);
    and(col[4], row[4], in8[5]);
    and(col[5], in8_a7_inv, in8[6]);

    or(out3[0], col[0], col[2], col[4], in8[7]);
    or(out3[1], col[1], col[2], col[5], in8[7]);
    or(out3[2], col[3], col[4], col[5], in8[7]);
endmodule
