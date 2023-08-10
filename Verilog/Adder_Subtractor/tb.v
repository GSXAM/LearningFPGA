`timescale 1ns/1ps

// `define FA
`define CLA
// `define TOP

`ifdef FA
    `include "full_adder_modified.v"
`elsif CLA
    `include "carry_look_ahead_adder.v"
`elsif TOP
    `include "adder_subtractor_top.v"
`endif

module tb_FFA (
    // ports
);
/*---------- Declare wire, reg ----------*/
`ifdef FA
    reg [31:0] A;
    reg [31:0] B;
    reg [31:0] Ci;
    wire [31:0] Sum;
    wire [31:0] g;
    wire [31:0] p;
`elsif CLA
    reg [4:0] g;
    reg [4:0] p;
    reg Select;
    wire [4:0] Co;
    reg [4:0] i;
`elsif TOP
    reg [31:0] A;
    reg [31:0] B;
    reg Select;
    output [31:0] Sum;
    output CarryOut;
`endif
/*---------- Declare hierarchy module -----------*/
`ifdef FA
    full_adder_modified FA_Test(.A(A), .B(B), .Ci(Ci), .Sum(Sum), .g(g), .p(p));
`elsif CLA
    CLA CLA_Test(.g(g[3:0]), .p(p[3:0]), .Select(Select), .Co(Co));
`elsif TOP
    adder_subtractor_top UUT(.A(A), .B(B), .Select(Select), .Sum(Sum), .CarryOut(CarryOut));
`endif

/*---------- Sequence signal ----------*/
    initial begin
        $dumpfile("dumpwave.vcd");
        $dumpvars(0, tb_FFA);
        $timeformat(-9, 0, "ns", 10);
`ifdef FA
        $monitor("%t: A=%h, B=%h, Ci=%h\n\tSum=%h, g=%h, p=%h\n", $time, A, B, Ci, Sum, g, p);
        A=0; B=0; Ci=0;
        #10 A=32'hF23A_08B7; B=32'h9BA2_01EC; Ci=32'h1111_1111;
        #10;
        if (Sum == (A^B^Ci))
            $display("----- Sum PASS -----");
        else
            $display("----- Sum FAIL -----");

        if (g == (A&B))
            $display("----- g PASS -----");
        else
            $display("----- g FAIL -----");

        if (p == (A|B))
            $display("----- p PASS -----");
        else
            $display("----- p FAIL -----");

        #10 $finish;
`elsif CLA
        Select=0; g=0; p=0;
        i = {g | (p&i[3:0]), Select};
        #1;
        for (g=0; g<5'h10; g=g+1) begin
            for (p=0; p<5'h10; p=p+1) begin
                if (i == Co) begin
                    #1 $display("%t: Select=%h, g=%h, p=%h, Co=%h, i=%h ----- PASS", $time, Select, g, p, Co, i);
                end
                else begin
                    #1 $display("%t: Select=%h, g=%h, p=%h, Co=%h, i=%h ----- FAIL", $time, Select, g, p, Co, i);
                    // $finish;
                end
            end
            $display("\n");
        end
`elsif TOP
`else
        $display("No module has found!");
`endif
    end
endmodule