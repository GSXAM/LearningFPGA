`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 09:42:32 AM
// Design Name: 
// Module Name: NAND_gate
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


module NAND_gate(
    input wire[7:0] d_in,
    output wire[3:0] count0,
    output wire[3:0] count1
    );
    
    reg [3:0] ones_d_in;
    reg [3:0] zeros_d_in;
    always @(d_in)
    begin: count_b
        integer i;
        ones_d_in = 0;
        zeros_d_in = 0;   
        for(i=0;i<8;i=i+1)
        begin
//            ones_d_in = ones_d_in + d_in[i];
//            zeros_d_in = zeros_d_in + ~d_in[i];
            if(d_in[i] == 1)
                ones_d_in = ones_d_in + 1;
//            else
//                zeros_d_in = zeros_d_in + 1;                
        end
    end
    
    assign count1 = ones_d_in;
    assign count0 = zeros_d_in;
endmodule

