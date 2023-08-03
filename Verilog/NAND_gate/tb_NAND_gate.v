`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2023 09:47:19 AM
// Design Name: 
// Module Name: tb_NAND_gate
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


module tb_NAND_gate;
    reg [7:0] in;
    wire [3:0] count0;
    wire [3:0] count1;

NAND_gate UUT (.d_in(in), .count0(count0), .count1(count1));
initial
begin
    in = 0;
    #10 in = 8'h42;
    #10 in = 8'hB1;
    #10 $finish;
end
initial
$monitor ($time, in, count0, count1);
endmodule
