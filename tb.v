`timescale 1ns / 1ps
`default_nettype none
`include "tmds_encoder.v"
// Project F: Display DVI TMDS Encoder Test Bench
// (C)2019 Will Green, Open source hardware released under the MIT License
// Learn more at https://projectf.io

module tmds_encode_dvi_tb();

    reg rst;
    reg clk;

    reg [7:0] data;
    reg [1:0] ctrl;
    reg de;
    wire [9:0] tmds_dvi, tmds_svo, tmds_HDMI, tmds_m;
    reg [7:0] i;

    tmds_encoder_dvi tmds_test1(
        .i_clk(clk),
        .i_rst(rst),
        .i_data(data),
        .i_ctrl(ctrl),
        .i_de(de),
        .o_tmds(tmds_dvi)
    );

    svo_tmds tmds_test2(
        .clk(clk),
        .resetn(rst),
        .de(de),
        .ctrl(ctrl),
        .din(data),
        .dout(tmds_svo)
    );

    TMDS_encoder tmds_test3(
        .clk(clk),
        .VD(data),
        .CD(ctrl),
        .VDE(de),
        .TMDS(tmds_HDMI)
    );

    my_tmds_encoder tmds_my(
        .clk(clk),
        .rst(rst),
        .DE(de),
        .CD(ctrl),
        .D(data),
        .q_out(tmds_m)
    );

    initial begin
        rst=1;
        clk = 0;
        ctrl = 0;
        data=0;
        i=0;
        de = 0;
        #20 de=1;
        // $display("Data:\tdvi:\t\tsvo:\t\tHDMI:\t\tTMDS_my:");
        for (i = 0; i<10; i=i+1) begin
            data=i; #10;
            // $display("%d\t%h\t\t%h\t\t%h\t\t%h", data, tmds_dvi, tmds_svo, tmds_HDMI, tmds_m);
        end
        $finish;
    end

    always
       #5 clk = ~clk;

endmodule