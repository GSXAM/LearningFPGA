`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2023 03:36:49 PM
// Design Name: 
// Module Name: tb_Decoder4to16
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


module tb_Decoder4to16(

    );
    
    reg [3:0] input4bit;
    wire [15:0] output16bit;
    
    Decoder4to16 DUT (.in4(input4bit), .out16(output16bit));
    
    initial
    begin
        assign input4bit = 4'h0;
        #10 assign input4bit = 4'h1;
        #10 assign input4bit = 4'h2;
        #10 assign input4bit = 4'h3;
        #10 assign input4bit = 4'h4;
        #10 assign input4bit = 4'h5;
        #10 assign input4bit = 4'h6;
        #10 assign input4bit = 4'h7;
        #10 assign input4bit = 4'h8;
        #10 assign input4bit = 4'h9;
        #10 assign input4bit = 4'hA;
        #10 assign input4bit = 4'hB;
        #10 assign input4bit = 4'hC;
        #10 assign input4bit = 4'hD;
        #10 assign input4bit = 4'hE;
        #10 assign input4bit = 4'hF;
        #10 $finish;
    end
    initial
    $monitor ($time, input4bit, output16bit);
endmodule
