module clk_div_top (
    input clkin, reset,
    input [15:0] divisor,
    output reg clkout = 0
);
    
    reg [15:0] cnt = 0;
    wire [15:0] half_divisor = (divisor >> 1);

    always @(posedge clkin, negedge clkin, reset) begin
        if (!reset) begin
            clkout <= 0;
            cnt <= 0;
        end
        else begin
            if (!divisor[0]) begin     // divisor must be minused by 1. Then divisor[0] = 0 is odd and divisor[0] = 1 is even
                cnt <= cnt + 1;
            end
            else begin  // increasing cnt at only posedge clkin
                cnt <= clkin ? (cnt + 1) : cnt;
            end

            if (((cnt == divisor) && (!divisor[0])) || ((cnt == half_divisor) && divisor[0])) begin
                cnt <= 0;
                clkout <= ~clkout;
            end
        end
    end
endmodule