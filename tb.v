`timescale 1ns / 1ps
// `include "tmds_encoder.v"
`include "temp.v"


/* module tmds_encode_dvi_tb();

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
        for (i = 0; i<25; i=i+1) begin
            data=i; #10;
            // $display("%d\t%h\t\t%h\t\t%h\t\t%h", data, tmds_dvi, tmds_svo, tmds_HDMI, tmds_m);
            if ((tmds_dvi ^ tmds_svo ^ tmds_HDMI ^ tmds_m) == 10'd0) begin
                $display("*********** PASS ***********\n");
            end
            else begin
                $display("*********** FAIL **********\n");
            end
        end
        $display("*********** PASS ***********\n");
        $finish;
    end

    always
       #5 clk = ~clk;
endmodule */

module tb_HDMI ();
	reg pixclk;  // 25MHz
	reg clk_TMDS;	// 250Mhz
	wire [2:0] TMDSp;/* TMDSn,*/
	wire TMDSp_clock;/*, TMDSn_clock*/

    reg [3:0] cnt = 0;

    always #2 clk_TMDS <= ~clk_TMDS;
    always @(posedge clk_TMDS) begin
        if (cnt == 4'd4) begin
            cnt <= 0;
        end
        else begin
            cnt <= cnt + 4'd1;
        end

        if (cnt == 4'd4) begin
            pixclk <= ~pixclk;
        end
        $display("cnt: %d", cnt);
    end
    always @(TMDSp) begin
        $display("Bit red: %b\tBit green:%b\tBit blue:%b", TMDSp[2], TMDSp[1], TMDSp[0]);
    end

    HDMI_test UUT(.pixclk(pixclk), .clk_TMDS(clk_TMDS), .TMDSp(TMDSp), .TMDSp_clock(TMDSp_clock));

    initial begin
        pixclk = 0;
        clk_TMDS = 0;
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_HDMI);
        #1000 $finish;
    end
endmodule