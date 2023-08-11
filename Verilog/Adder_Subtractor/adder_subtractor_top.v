`timescale 1ns/1ps
`include "carry_look_ahead_adder.v"
`include "full_adder_modified.v"

module adder_subtractor_top (
    input [31:0] A,
    input [31:0] B,
    input Select,
    output [31:0] Sum,
    output CarryOut
);
    wire [31:0] g;
    wire [31:0] p;
    wire [31:0] C;
    wire [8:0] CLA_Ci;

    /*----- XOR gate for B input -----*/
    wire [31:0] xor_B = B^{32{Select}};

    /*----- Full adder -----*/
    full_adder_modified FA(.A(A), .B(xor_B), .Ci(C), .Sum(Sum), .g(g), .p(p));

    /*----- Carry look ahead adder -----*/
    assign CLA_Ci[0] = Select;
    assign CarryOut = CLA_Ci[8];
    genvar i;
    generate
        for (i=0; i<8; i=i+1) begin
            CLA CLA(.g(g[(4*i)+3 : 4*i]), .p(p[(4*i)+3 : 4*i]), .Select(CLA_Ci[i]), .Co({CLA_Ci[i+1], C[(4*i)+3 : 4*i]}));
        end
    endgenerate
endmodule