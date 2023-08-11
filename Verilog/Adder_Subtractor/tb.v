`timescale 1ns/1ps

// `define FA
// `define CLA
`define TOP

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
    reg [1:0] Select;
    wire [4:0] Co;
    wire [4:0] i = {g | (p&i[3:0]), Select[0]};
`elsif TOP
    reg signed [31:0] A;
    reg signed [31:0] B;
    reg Select;
    wire signed [31:0] Sum;
    wire CarryOut;
    wire signed [31:0] Sum_test = Select ? A-B : A+B;
`endif
/*---------- Declare hierarchy module -----------*/
`ifdef FA
    full_adder_modified FA_Test(.A(A), .B(B), .Ci(Ci), .Sum(Sum), .g(g), .p(p));
`elsif CLA
    CLA CLA_Test(.g(g[3:0]), .p(p[3:0]), .Select(Select[0]), .Co(Co));
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
        #1;
        for (Select=0; Select<2'h2; Select=Select+1) begin
            for (g=0; g<5'h10; g=g+1) begin
                for (p=0; p<5'h10; p=p+1) begin
                    #1;
                    if (i == Co) begin
                        $display("%t: Select=%h, g=%h, p=%h, Co=%h, i=%h ----- PASS", $time, Select[0], g[3:0], p[3:0], Co, i);
                    end
                    else begin
                        $display("%t: Select=%h, g=%h, p=%h, Co=%h, i=%h ----- FAIL", $time, Select[0], g[3:0], p[3:0], Co, i);
                        // $finish;
                    end
                end
                $display("\n");
            end
        end
`elsif TOP
        A=0; B=0; Select=0;
        #1;
        for (B=32'hFFFF_FFFD; B!=32'h0000_0003; B=B+1) begin
            for (A=32'hFFFF_FFFD; A!=32'h0000_0003; A=A+1) begin
                #1;
                if ((Sum_test == Sum)/* && (Sum_test[32] == CarryOut)*/) begin
                    $display("%t: Select=%h A+B = %d + %d = %d --> Sum=%d, CarryOut=%h ----- PASS",
                            $time, Select, A, B, Sum_test, Sum, CarryOut);
                end
                else begin
                    $display("%t: Select=%h A+B = %d + %d = %d --> Sum=%d, CarryOut=%h ----- FAIL",
                            $time, Select, A, B, Sum_test, Sum, CarryOut);
                end
            end
            $display("\n");
        end
        $display("\n");
        Select=1;
        #1;
        for (B=32'hFFFF_FFFD; B!=32'h0000_0003; B=B+1) begin
            for (A=32'hFFFF_FFFD; A!=32'h0000_0003; A=A+1) begin
                #1;
                if ((Sum_test == Sum) /*&& (Sum_test[32] == CarryOut)*/) begin
                    $display("%t: Select=%h A-B = %d - %d = %d --> Sum=%d, CarryOut=%h ----- PASS",
                            $time, Select, A, B, Sum_test, Sum, CarryOut);
                end
                else begin
                    $display("%t: Select=%h A-B = %d - %d = %d --> Sum=%d, CarryOut=%h ----- FAIL",
                            $time, Select, A, B, Sum_test, Sum, CarryOut);
                end
            end
            $display("\n");
        end
`else
        $display("No module has found!");
`endif
    end
endmodule