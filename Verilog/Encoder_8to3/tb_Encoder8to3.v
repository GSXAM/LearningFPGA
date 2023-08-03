`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2023 09:54:29 PM
// Design Name: 
// Module Name: tb_Encoder8to3
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


module tb_Encoder8to3(

    );

    reg [7:0] in;
    wire [2:0] out;

    Encoder8to3 DUT (.in8(in), .out3(out));

    initial
    begin
        in = 8'h01;
        #10 in = 8'h02;
        #10 in = 8'h04;
        #10 in = 8'h08;
        #10 in = 8'h10;
        #10 in = 8'h20;
        #10 in = 8'h40;
        #10 in = 8'h80;
        #10 in = 8'h07;
        #40 in = 8'h77;
        #40 $finish;
    end

    initial
    $monitor ($time, in, out);
endmodule
