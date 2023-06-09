`timescale 1ns/1ps
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
 *  Clock TMDS: 25.2Mhz x 10bit = 252Mhz
*/

module my_hdmi (
    // input clk_in,                   // 27Mhz
    input rst_in,                   // Reset button
    input btn,                      // Button to change video data signal
    output tmds_clk = 0,            // TMDS clock P
    output [2:0] tmds_out = 0       // TMDS shiftout RGB
);
    /* PLL clk_in: 27Mhz ==> TMDS clock: 252Mhz
     * TMDS clock / 10 = Pixel clock: 25.2Mhz
    */
    reg pixel_clk = 0;          // Pixel clock 25.2Mhz
    reg cnt_div [2:0] = 0;      // Counter for clock divider
    /* Modeling 252Mhz PLL clock */
    always begin
        if (rst_in == 0)
            tmds_clk = 0;
        else
            #2 tmds_clk = ~tmds_clk;
    end
    /* Pixel clock devider */
    always @(rst_in, tmds_clk) begin
        if (negedge rst_in) begin
            pixel_clk = 0;
            cnt_div = 0;
        end
        else if (posedge tmds_clk) begin
            if (cnt_div == 3'd4) begin
                pixel_clk <= ~pixel_clk;
                cnt_div <= 0;
            end
            else
                cnt_div <= cnt_div + 1;
        end
    end

    /* Data prepare
     *      + Under reset   : no TMDS clock and Data are send to monitor
     *      + Press button  : single white color send to monitor
     *      + Release button: send data like @fpga4fun page
    */
endmodule