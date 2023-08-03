`timescale 1ns/1ps
// `include "tmds_encoder.v"
/* HDMI specifications
 *  Resolutions: 640 x 480
 *  Frame rate: 60Hz
 *  Horizon:
 *          + Back porch : 16
 *          + Retrace    : 96
 *          + Front porch: 48
 *  Vertical:
 *          + Back porch : 33
 *          + Retrace    : 2
 *          + Front porch: 10
 *  Total pixel: 800 x 525 = 420kpxl
 *  Clock pixel: 420kpxl x 60Hz = 25.2Mhz
 *  Clock TMDS: 25.2Mhz x 10bit / 2 = 126Mhz
*/

module my_hdmi(
    input clk_in,                       // 27Mhz, but for simulation purpose, tmds_bit_clk is 252Mhz
    input rst_in,                       // Reset button
    input btn,                          // Button to change video data signal
    output tmds_clk,                    // TMDS pixel clock output 25.2Mhz
    output [2:0] tmds_out       // TMDS shiftout RGB
);
    localparam pixel_x          = 640;
    localparam pixel_y          = 480;
    localparam H_back_porch     = 16;
    localparam H_retrace        = 96;
    localparam H_front_porch    = 48;
    localparam V_back_porch     = 33;
    localparam V_retrace        = 2;
    localparam V_front_porch    = 10;
    localparam total_pixel_x    = (pixel_x + H_back_porch + H_retrace + H_front_porch); // 800
    localparam total_pixel_y    = (pixel_y + V_back_porch + V_retrace + V_front_porch); // 525
    localparam H_pix_BP         = pixel_x  + H_back_porch    ;                          // 656
    localparam H_pix_BP_RT      = H_pix_BP + H_retrace       ;                          // 752
    localparam V_pix_BP         = pixel_y  + V_back_porch    ;                          // 513
    localparam V_pix_BP_RT      = V_pix_BP + V_retrace       ;                          // 515

    /* Clock source */
    wire tmds_bit_clk, pixel_clk;
    assign tmds_clk = pixel_clk;
    PLLVR_126Mhz clock_126(
        .clkout(tmds_bit_clk), //output clkout
        .clkin(clk_in) //input clkin
    );
    CLKDIV_25Mhz clock_25(
        .clkout(pixel_clk), //output clkout
        .hclkin(tmds_bit_clk), //input hclkin
        .resetn(rst_in) //input resetn
    );

    /* Create Hsyn, Vsyn and DataArea
     *      + Create Counter_X for sweep horizon
     *      + Create Counter_Y for sweep veritcal
     * Create Hsyn, Vsyn and DataArea signal
    */
    reg [9:0] cnt_x;
    reg [9:0] cnt_y;
    reg Hsyn = 0;
    reg Vsyn = 0;
    reg DataArea = 0;
    
    always @(posedge pixel_clk, negedge rst_in) begin // Counter_X, Counter_Y
        if (rst_in == 0) begin
            cnt_x <= (total_pixel_x - 1);
            cnt_y <= (total_pixel_y - 1);
            Hsyn <= 0;
            Vsyn <= 0;
            DataArea <= 0;
        end
        else begin
            /* Counter X */
            if (cnt_x == (total_pixel_x - 1)) cnt_x <= 0;
            else cnt_x <= cnt_x + 1;

            /* Counter Y */
            if (cnt_y == (total_pixel_y - 1)) cnt_y <= 0;
            else if (cnt_x == (total_pixel_x - 1)) cnt_y <= cnt_y + 1;

            /* Hsyn */
            if ((cnt_x >= H_pix_BP) && (cnt_x < H_pix_BP_RT)) Hsyn <= 1;
            else Hsyn <= 0;

            /* Vsyn */
            if ((cnt_y >= V_pix_BP) && (cnt_y < V_pix_BP_RT)) Vsyn <= 1;
            else Vsyn <= 0;

            /* DataArea */
            if ((cnt_x < pixel_x) && (cnt_y < pixel_y)) DataArea <= 1;
            else DataArea <= 0;
        end
    end


    /* Data prepare
     *      + Under reset   : no TMDS clock and Data are send to monitor
     *      + Press button  : send data like @fpga4fun page
     *      + Release button: color change (default)
    */
    reg [16:0] cnt_data = 0; // 17-bit
    reg [7:0] red = 8'hFF;
    reg [7:0] green = 0;
    reg [7:0] blue = 0;
    wire [7:0] W = {8{cnt_x[7:0] == cnt_y[7:0]}};
    wire [7:0] A = {8{(cnt_x[7:5] == 3'h2) && (cnt_y[7:5] == 3'h2)}};

    always @(posedge pixel_clk, negedge rst_in) begin
        if (rst_in == 0 || btn == 0) cnt_data <= 0;
        else cnt_data <= cnt_data + 1;
    end
    always @(posedge pixel_clk, negedge rst_in) begin
        if(rst_in == 0) begin
            red   <= 8'hFF;
            green <= 0;
            blue  <= 0;
        end
        else begin
            if (btn == 0) begin
                red   <= ({cnt_x[5:0] & {6{cnt_y[4:3] == ~cnt_x[4:3]}}, 2'b00} |W) & ~A;
                green <= (cnt_x[7:0] & {8{cnt_y[6]}} | W) & ~A;
                blue  <= cnt_y[7:0] | W | A;
            end
            else begin
                if (cnt_data == 0) begin
                    if ((red == 8'hFF) && (green < 8'hFF) && (blue == 0)) green <= green + 1;       // Green increase   --> Red to Yellow
                    else if ((red > 0) && (green == 8'hFF) && (blue == 0)) red <= red - 1;          // Red decrease     --> Yellow to Green
                    else if ((red == 0) && (green == 8'hFF) && (blue < 8'hFF)) blue <= blue + 1;    // Blue increase    --> Green to Aqua
                    else if ((red == 0) && (green > 0) && (blue == 8'hFF)) green <= green - 1;      // Green decrease   --> Aqua to Blue
                    else if ((red < 8'hFF) && (green == 0) && (blue == 8'hFF)) red <= red + 1;      // Red increase     --> Blue to Pink
                    else if ((red == 8'hFF) && (green == 0) && (blue > 0)) blue <= blue - 1;        // Blue decrease    --> Pink to Red
                    else begin
                        red <= 8'hFF;
                        green <= 0;
                        blue <= 0;
                    end
                end
            end
        end
    end

    /* TMDS Encoder */
    wire [9:0] TMDS_RED, TMDS_GREEN, TMDS_BLUE;
    my_tmds_encoder TMDS_encode_RED     (.clk(pixel_clk), .rst(rst_in), .DE(DataArea), .CD(2'b00),          .D(red),    .q_out(TMDS_RED))   ;
    my_tmds_encoder TMDS_encode_GREEN   (.clk(pixel_clk), .rst(rst_in), .DE(DataArea), .CD(2'b00),          .D(green),  .q_out(TMDS_GREEN)) ;
    my_tmds_encoder TMDS_encode_BLUE    (.clk(pixel_clk), .rst(rst_in), .DE(DataArea), .CD({Vsyn, Hsyn}),   .D(blue),   .q_out(TMDS_BLUE))  ;

    /* Shiftout by OSER10 IPs on Tang Nano 4k */
    OSER10 shift_red(
        .Q(tmds_out[2]),
        .RESET(~rst_in),
        .PCLK(pixel_clk),
        .FCLK(tmds_bit_clk),
        .D0(TMDS_RED[0]),
        .D1(TMDS_RED[1]),
        .D2(TMDS_RED[2]),
        .D3(TMDS_RED[3]),
        .D4(TMDS_RED[4]),
        .D5(TMDS_RED[5]),
        .D6(TMDS_RED[6]),
        .D7(TMDS_RED[7]),
        .D8(TMDS_RED[8]),
        .D9(TMDS_RED[9])
    );
    defparam shift_red.GSREN="false";
    defparam shift_red.LSREN="true";

    OSER10 shift_green(
        .Q(tmds_out[1]),
        .RESET(~rst_in),
        .PCLK(pixel_clk),
        .FCLK(tmds_bit_clk),
        .D0(TMDS_GREEN[0]),
        .D1(TMDS_GREEN[1]),
        .D2(TMDS_GREEN[2]),
        .D3(TMDS_GREEN[3]),
        .D4(TMDS_GREEN[4]),
        .D5(TMDS_GREEN[5]),
        .D6(TMDS_GREEN[6]),
        .D7(TMDS_GREEN[7]),
        .D8(TMDS_GREEN[8]),
        .D9(TMDS_GREEN[9])
    );
    defparam shift_green.GSREN="false";
    defparam shift_green.LSREN="true";

    OSER10 shift_blue(
        .Q(tmds_out[0]),
        .RESET(~rst_in),
        .PCLK(pixel_clk),
        .FCLK(tmds_bit_clk),
        .D0(TMDS_BLUE[0]),
        .D1(TMDS_BLUE[1]),
        .D2(TMDS_BLUE[2]),
        .D3(TMDS_BLUE[3]),
        .D4(TMDS_BLUE[4]),
        .D5(TMDS_BLUE[5]),
        .D6(TMDS_BLUE[6]),
        .D7(TMDS_BLUE[7]),
        .D8(TMDS_BLUE[8]),
        .D9(TMDS_BLUE[9])
    );
    defparam shift_blue.GSREN="false";
    defparam shift_blue.LSREN="true";
endmodule