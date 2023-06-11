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
    input clk_in,                       // 27Mhz, but now this signal is tmds_bit_clk 252Mhz
    input rst_in,                       // Reset button
    input btn,                          // Button to change video data signal
    output reg tmds_clk = 0,            // TMDS pixel clock output 25.2Mhz
    output reg [2:0] tmds_out = 0       // TMDS shiftout RGB
);
    parameter pixel_x            = 640;
    parameter pixel_y            = 480;
    parameter H_back_porch       = 16;
    parameter H_retrace          = 96;
    parameter H_front_porch      = 48;
    parameter V_back_porch       = 33;
    parameter V_retrace          = 2;
    parameter V_front_porch      = 10;
    parameter total_pixel_x      = (pixel_x + H_back_porch + H_retrace + H_front_porch);
    parameter total_pixel_y      = (pixel_y + V_back_porch + V_retrace + V_front_porch);
    /* PLL clk_in: 27Mhz ==> TMDS bit clock: 252Mhz
     * TMDS bit clock / 10 = Pixel clock: 25.2Mhz
    */
    reg [2:0] cnt_div = 4'd4;      // Counter for clock divider
    wire tmds_bit_clk = clk_in;  // Change 27Mhz clk_in to tmds_bit_clk for simulation
    
    /* Pixel clock devider. Generate tmds_clk (or pixel clock) 25.2Mhz */
    always @(posedge tmds_bit_clk, negedge rst_in) begin
        if(rst_in == 0) begin
            tmds_clk <= 0;
            cnt_div <= 4'd4;
        end
        else if (cnt_div == 3'd4) begin
            tmds_clk <= ~tmds_clk;
            cnt_div <= 0;
        end
        else cnt_div <= cnt_div + 1;
    end

    /* Create Hsyn, Vsyn and DataArea
     *      + Create Counter_X for sweep horizon
     *      + Create Counter_Y for sweep veritcal
     * Create Hsyn, Vsyn and DataArea signal
    */
    reg [9:0] cnt_x = 0;
    reg [9:0] cnt_y = 0;
    reg Hsyn = 0;
    reg Vsyn = 0;
    always @(posedge tmds_bit_clk, negedge rst_in) begin // Counter_X
        if(rst_in == 0) cnt_x <= 0;
        else if(cnt_x == (total_pixel_x - 1)) cnt_x <= 0;
        else cnt_x <= cnt_x + 1;
    end
    always @(posedge tmds_bit_clk, rst_in, negedge rst_in) begin // Counter_Y
        if(rst_in == 0) cnt_y <= 0;
        else if(cnt_x == (total_pixel_x - 1)) begin
            if(cnt_y == (total_pixel_y - 1)) cnt_y <= 0;
            else cnt_y <= cnt_y + 1;
        end
    end
    // always @(posedge tmds_bit_clk, rst_in) begin // Hsyn
    //     if((cnt_x >= (pixel_x + H_back_porch)) && (cnt_x < (pixel_x + H_back_porch + H_retrace))) Hsyn <= 1;
    //     else Hsyn <= 0;
    // end
    // always @(posedge tmds_bit_clk, rst_in) begin // Vsyn
    //     if((cnt_y >= (pixel_y + V_back_porch)) && (cnt_y < (pixel_y + V_back_porch + V_retrace))) Vsyn <= 1;
    //     else Vsyn <= 0;
    // end


    /* Data prepare
     *      + Under reset   : no TMDS clock and Data are send to monitor
     *      + Press button  : single white color send to monitor
     *      + Release button: send data like @fpga4fun page (default)
    */
    // reg [7:0] red = 0;
    // reg [7:0] green = 0;
    // reg [7:0] blue = 0;
    // always @(posedge tmds_clk) begin
    //     if(rst_in == 0) begin
    //         red <= 0;
    //         green <= 0;
    //         blue <= 0;
    //     end
    //     else if(btn == 0) begin
    //         red <= 8'hFF;
    //         green <= 8'hFF;
    //         blue <= 8'hFF;
    //     end
    //     else begin
    //         red <=
    //     end
    // end
endmodule