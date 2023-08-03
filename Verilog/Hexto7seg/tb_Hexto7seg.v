`timescale 1ns/1ps
`include "Hexto7seg.v"
module tb_hexto7seg ();
    
    reg [3:0] inhex;
    wire [6:0] seg;

    Hexto7seg UUT (.inhex(inhex), .seg(seg));

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_hexto7seg);
        inhex = 0;
        repeat(16) begin
            #10 inhex = inhex + 1;
        end
        #10 $finish;
    end
endmodule