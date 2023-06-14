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

    /* Pixel clock devider. Generate tmds_clk (or pixel clock) 25.2Mhz
     * PLL clk_in: 27Mhz ==> TMDS bit clock: 252Mhz
     * TMDS bit clock / 10 = Pixel clock: 25.2Mhz
    */
    reg [2:0] cnt_div = 4'd4;      // Counter for clock divider
    wire tmds_bit_clk = clk_in;  // Change 27Mhz clk_in to tmds_bit_clk for simulation
    always @(posedge tmds_bit_clk, negedge rst_in) begin
        if (rst_in == 0) begin
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
    reg DataArea = 0;
    
    always @(posedge tmds_clk, negedge rst_in) begin // Counter_X, Counter_Y
        if (rst_in == 0) begin
            cnt_x = (total_pixel_x - 1);
            cnt_y = (total_pixel_y - 1);
            Hsyn <= 0;
            Vsyn <= 0;
            DataArea <= 0;
        end
        else begin
            /* Counter X */
            if (cnt_x == (total_pixel_x - 1)) cnt_x = 0;
            else cnt_x = cnt_x + 1;

            /* Counter Y */
            if (cnt_y == (total_pixel_y - 1)) cnt_y = 0;
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
    reg [21:0] cnt4M = 0;
    reg [7:0] red = 8'hFF;
    reg [7:0] green = 0;
    reg [7:0] blue = 0;
    wire [7:0] W = {8{cnt_x[7:0] == cnt_y[7:0]}};
    wire [7:0] A = {8{(cnt_x[7:5] == 3'h2) && (cnt_y[7:5] == 3'h2)}};

    always @(posedge tmds_clk, negedge rst_in) begin
        if (rst_in == 0 || btn == 0) cnt4M <= 0;
        else cnt4M <= cnt4M + 1;
    end
    always @(posedge tmds_clk) begin
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
                if (cnt4M == 0) begin
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
endmodule