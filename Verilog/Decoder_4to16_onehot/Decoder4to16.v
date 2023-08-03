`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2023 03:21:28 PM
// Design Name: 
// Module Name: Decoder4to16
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


module Decoder4to16(
    input [3:0] in4,
    output [15:0] out16
    );
    
    /*--------------------*/
    /* Condition operator */
    /*--------------------*/
    assign out16 = (in4 == 4'h0) ? 16'h0001 :
                   (in4 == 4'h1) ? 16'h0002 :
                   (in4 == 4'h2) ? 16'h0004 :
                   (in4 == 4'h3) ? 16'h0008 :
                   (in4 == 4'h4) ? 16'h0010 :
                   (in4 == 4'h5) ? 16'h0020 :
                   (in4 == 4'h6) ? 16'h0040 :
                   (in4 == 4'h7) ? 16'h0080 :
                   (in4 == 4'h8) ? 16'h0100 :
                   (in4 == 4'h9) ? 16'h0200 :
                   (in4 == 4'hA) ? 16'h0400 :
                   (in4 == 4'hB) ? 16'h0800 :
                   (in4 == 4'hC) ? 16'h1000 :
                   (in4 == 4'hD) ? 16'h2000 :
                   (in4 == 4'hE) ? 16'h4000 :
                   (in4 == 4'hF) ? 16'h8000 :
                   16'hXXXX;

    /*------------------*/
    /* Logical operator */
    /*------------------*/
    // assign out16[0] = ~|in4;
    // assign out16[1] = ~in4[3] & ~in4[2] & ~in4[1] & in4[0];
    // assign out16[2] = ~in4[3] & ~in4[2] & in4[1] & ~in4[0];
    // assign out16[3] = ~in4[3] & ~in4[2] & in4[1] & in4[0];
    // assign out16[4] = ~in4[3] & in4[2] & ~in4[1] & ~in4[0];
    // assign out16[5] = ~in4[3] & in4[2] & ~in4[1] & in4[0];
    // assign out16[6] = ~in4[3] & in4[2] & in4[1] & ~in4[0];
    // assign out16[7] = ~in4[3] & in4[2] & in4[1] & in4[0];
    // assign out16[8] = in4[3] & ~in4[2] & ~in4[1] & ~in4[0];
    // assign out16[9] = in4[3] & ~in4[2] & ~in4[1] & in4[0];
    // assign out16[10] = in4[3] & ~in4[2] & in4[1] & ~in4[0];
    // assign out16[11] = in4[3] & ~in4[2] & in4[1] & in4[0];
    // assign out16[12] = in4[3] & in4[2] & ~in4[1] & ~in4[0];
    // assign out16[13] = in4[3] & in4[2] & ~in4[1] & in4[0];
    // assign out16[14] = in4[3] & in4[2] & in4[1] & ~in4[0];
    // assign out16[15] = &in4;

    /*----------------------*/
    /* Gate-level primitive */
    /*----------------------*/
    // wire [3:0] in4_inv;

    // not(in4_inv[3], in4[3]);
    // not(in4_inv[2], in4[2]);
    // not(in4_inv[1], in4[1]);
    // not(in4_inv[0], in4[0]);

    // and(out16[0], in4_inv[3], in4_inv[2], in4_inv[1], in4_inv[0]);
    // and(out16[1], in4_inv[3], in4_inv[2], in4_inv[1], in4[0]);
    // and(out16[2], in4_inv[3], in4_inv[2], in4[1], in4_inv[0]);
    // and(out16[3], in4_inv[3], in4_inv[2], in4[1], in4[0]);
    // and(out16[4], in4_inv[3], in4[2], in4_inv[1], in4_inv[0]);
    // and(out16[5], in4_inv[3], in4[2], in4_inv[1], in4[0]);
    // and(out16[6], in4_inv[3], in4[2], in4[1], in4_inv[0]);
    // and(out16[7], in4_inv[3], in4[2], in4[1], in4[0]);
    // and(out16[8], in4[3], in4_inv[2], in4_inv[1], in4_inv[0]);
    // and(out16[9], in4[3], in4_inv[2], in4_inv[1], in4[0]);
    // and(out16[10], in4[3], in4_inv[2], in4[1], in4_inv[0]);
    // and(out16[11], in4[3], in4_inv[2], in4[1], in4[0]);
    // and(out16[12], in4[3], in4[2], in4_inv[1], in4_inv[0]);
    // and(out16[13], in4[3], in4[2], in4_inv[1], in4[0]);
    // and(out16[14], in4[3], in4[2], in4[1], in4_inv[0]);
    // and(out16[15], in4[3], in4[2], in4[1], in4[0]);

endmodule
