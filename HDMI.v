`timescale 1ns/1ps

module my_hdmi (
    input clk_in,               //27Mhz
    input rst_in,               // Reset button
    input btn,                  // Button to change video data signal
    output tmds_clk,            // TMDS clock p
    output [2:0] tmds_out       // TMDS shiftout RGB
);
    
endmodule