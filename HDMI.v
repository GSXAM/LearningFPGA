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

module my_hdmi(
    input clk_in,                   // 27Mhz, but now this signal is tmds_bit_clk 252Mhz
    input rst_in,                   // Reset button
    input btn,                      // Button to change video data signal
    output reg pixel_clk,           // Pixel clock output 25.2Mhz
    output reg [2:0] tmds_out       // TMDS shiftout RGB
);
    /* PLL clk_in: 27Mhz ==> TMDS bit clock: 252Mhz
     * TMDS bit clock / 10 = Pixel clock: 25.2Mhz
    */
    reg [2:0] cnt_div = 3'h0;      // Counter for clock divider
    /* Pixel clock devider */
    always @(posedge clk_in) begin
        if(rst_in != 1) begin
            pixel_clk <= 0;
            cnt_div <= 3'h0;
        end
        else if (cnt_div == 3'd4) begin
            pixel_clk <= ~pixel_clk;
            cnt_div <= 3'h0;
        end
        else
            cnt_div <= cnt_div + 1;
    end

    /* Data prepare
     *      + Under reset   : no TMDS clock and Data are send to monitor
     *      + Press button  : single white color send to monitor
     *      + Release button: send data like @fpga4fun page
    */
endmodule