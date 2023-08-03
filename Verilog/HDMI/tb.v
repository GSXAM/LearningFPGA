`timescale 1ns / 1ps
// `include "tmds_encoder.v"
// `include "temp.v"
`include "HDMI.v"

/*
module tmds_encode_dvi_tb();

    reg rst;
    reg clk;

    reg [7:0] data;
    reg [1:0] ctrl;
    reg de;
    wire [9:0] tmds_svo, tmds_m;
    reg [7:0] i;

    svo_tmds tmds_test2(
        .clk(clk),
        .resetn(rst),
        .de(de),
        .ctrl(ctrl),
        .din(data),
        .dout(tmds_svo)
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
        $dumpfile("wave.vcd");
        $dumpvars(0, tmds_encode_dvi_tb);
        rst=1;
        clk = 0;
        ctrl = 0;
        data=0;
        i=0;
        de = 0;
        #20 de=1;
        // $display("Data:\tdvi:\t\tsvo:\t\tHDMI:\t\tTMDS_my:");
        for (i = 0; i<10; i=i+1) begin
            data=0; #10;
            // $display("%d\t%h\t\t%h\t\t%h\t\t%h", data, tmds_dvi, tmds_svo, tmds_HDMI, tmds_m);
            if ((tmds_svo ^ tmds_m) == 10'd0) begin
                $display("*********** PASS ***********\n");
            end
            else begin
                $display("*********** FAIL **********\n");
            end
        end
        $display("*********** END ***********\n");
        $finish;
    end

    always
       #5 clk = ~clk;
endmodule
*/

/*
module tb_HDMI ();
	reg pixclk;  // 25MHz
	reg clk_TMDS;	// 250Mhz
	wire [2:0] TMDSp_svo, TMDSp_my;
	wire TMDSp_clock_svo, TMDSp_clock_my;

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
        // $display("cnt: %d", cnt);
    end
    always @(TMDSp_svo, TMDSp_my) begin
        $display("MY : Red:%b\tGreen:%b\tBlue:%b", TMDSp_my[2] , TMDSp_my[1] , TMDSp_my[0]) ;
        $display("SVO: Red:%b\tGreen:%b\tBlue:%b", TMDSp_svo[2], TMDSp_svo[1], TMDSp_svo[0]);
    end

    HDMI_svo SVO(.pixclk(pixclk), .clk_TMDS(clk_TMDS), .TMDSp(TMDSp_svo), .TMDSp_clock(TMDSp_clock_svo));
    HDMI_my  MY (.pixclk(pixclk), .clk_TMDS(clk_TMDS), .TMDSp(TMDSp_my) , .TMDSp_clock(TMDSp_clock_my)) ;

    initial begin
        pixclk = 0;
        clk_TMDS = 0;
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_HDMI);
        #1000 $finish;
    end
endmodule
*/

module tb_my_HDMI();
    reg tmds_bit_clk;             // 27Mhz, but now this signal is tmds_bit_clk 252Mhz
    reg rst_in;             // Reset button
    reg btn;                // Button to change video data signal
    wire tmds_clk;          // TMDS pixel clock output 25.2Mhz
    wire [2:0] tmds_out;    // TMDS shiftout RGB

    my_hdmi clock_UT(
        .clk_in(tmds_bit_clk),
        .rst_in(rst_in),
        .btn(btn),
        .tmds_clk(tmds_clk),
        .tmds_out(tmds_out)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_my_HDMI.clock_UT);
        tmds_bit_clk = 0;
        rst_in = 1;
        btn = 1;
        #85 rst_in = 0;
        #20 rst_in = 1;
        #100 btn = 0;
        #10000 btn = 1;
        #17000000 $finish;
    end

    // initial begin
    //     #200 $dumpoff;
    //     #16000000 $dumpon;
    // end

    /* Modeling 252Mhz PLL internal clock */
    always begin
        #2 tmds_bit_clk <= ~tmds_bit_clk;
    end
endmodule