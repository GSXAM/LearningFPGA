`timescale 1ns/1ps
/* HDMI specifications
 *  Resolutions: 640 x 480
 *  Frame rate: 60Hz
 *  Horizon:
 *          + Back porch :
 *          + Retrace    :
 *          + Front porch:
 *  Vertical:
 *          + Back porch :
 *          + Retrace    : 2
 *          + Front porch:
 *  Total pixel: 800 x 525 = 420kpxl
 *  Clock pixel: 420kpxl x 60Hz = 25.2Mhz
 *  Clock TMDS: 25.2Mhz x 10bit = 252Mhz
*/

module my_hdmi (
    input clk_in,               // 27Mhz
    input rst_in,               // Reset button
    input btn,                  // Button to change video data signal
    output tmds_clk,            // TMDS clock P
    output [2:0] tmds_out       // TMDS shiftout RGB
);
    /* PLL clk_in: 27Mhz ==> 252Mhz */
endmodule