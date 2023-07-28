`timescale 1ns/1ps
module clk_div_odd (
    input clkin, reset, en,
    input [15:0] divisor,
    output reg clkout
);
    reg [15:0] cnt = 0;
    wire [15:0] half_divisor = (divisor >> 1) - 1;
    always @(posedge clkin) begin
        if (!reset) begin
            cnt <= 0;
            clkout <= 0;
        end
        else if (en) begin
            if (cnt == half_divisor) begin
                clkout <= !clkout;
                cnt <= 0;
            end
            else begin
                cnt <= cnt + 1;
            end
        end
        else begin
            clkout <= clkout;
            cnt <= cnt;
        end
    end
endmodule