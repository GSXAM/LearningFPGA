`timescale 1ns / 1ps
`default_nettype none

// Project F: Display TMDS Encoder for DVI
// (C)2019 Will Green, Open source hardware released under the MIT License
// Learn more at https://projectf.io

module tmds_encoder_dvi(
    input  wire i_clk,          // clock
    input  wire i_rst,          // reset (active high)
    input  wire [7:0] i_data,   // colour data
    input  wire [1:0] i_ctrl,   // control data
    input  wire i_de,           // display enable (active high)
    output reg [9:0] o_tmds     // encoded TMDS data
    );

    // select basic encoding based on the ones in the input data
    wire [3:0] d_ones = {3'b0,i_data[0]} + {3'b0,i_data[1]} + {3'b0,i_data[2]}
        + {3'b0,i_data[3]} + {3'b0,i_data[4]} + {3'b0,i_data[5]}
        + {3'b0,i_data[6]} + {3'b0,i_data[7]};
    wire use_xnor = (d_ones > 4'd4) || ((d_ones == 4'd4) && (i_data[0] == 0));

    // encode colour data with xor/xnor
    /* verilator lint_off UNOPTFLAT */
    wire [8:0] enc_qm;
    assign enc_qm[0] = i_data[0];
    assign enc_qm[1] = (use_xnor) ? (enc_qm[0] ~^ i_data[1]) : (enc_qm[0] ^ i_data[1]);
    assign enc_qm[2] = (use_xnor) ? (enc_qm[1] ~^ i_data[2]) : (enc_qm[1] ^ i_data[2]);
    assign enc_qm[3] = (use_xnor) ? (enc_qm[2] ~^ i_data[3]) : (enc_qm[2] ^ i_data[3]);
    assign enc_qm[4] = (use_xnor) ? (enc_qm[3] ~^ i_data[4]) : (enc_qm[3] ^ i_data[4]);
    assign enc_qm[5] = (use_xnor) ? (enc_qm[4] ~^ i_data[5]) : (enc_qm[4] ^ i_data[5]);
    assign enc_qm[6] = (use_xnor) ? (enc_qm[5] ~^ i_data[6]) : (enc_qm[5] ^ i_data[6]);
    assign enc_qm[7] = (use_xnor) ? (enc_qm[6] ~^ i_data[7]) : (enc_qm[6] ^ i_data[7]);
    assign enc_qm[8] = (use_xnor) ? 0 : 1;
    /* verilator lint_on UNOPTFLAT */

    // disparity in encoded data for DC balancing: needs to cover -8 to +8
    wire signed [4:0] ones = {4'b0,enc_qm[0]} + {4'b0,enc_qm[1]}
            + {4'b0,enc_qm[2]} + {4'b0,enc_qm[3]} + {4'b0,enc_qm[4]}
            + {4'b0,enc_qm[5]} + {4'b0,enc_qm[6]} + {4'b0,enc_qm[7]};

    wire signed [4:0] zeros = 5'b01000 - ones;
    wire signed [4:0] balance = ones - zeros;

    // record ongoing DC bias
    reg signed [4:0] bias =0;

    always @ (posedge i_clk)
    begin
        if (!i_rst)
        begin
            o_tmds <= 10'b1101010100;  // equivalent to ctrl 2'b00
            bias <= 5'sb00000;
        end
        else if (i_de == 0)  // send control data in blanking interval
        begin
            case (i_ctrl)  // ctrl sequences (always have 7 transitions)
                2'b00:   o_tmds <= 10'b1101010100;
                2'b01:   o_tmds <= 10'b0010101011;
                2'b10:   o_tmds <= 10'b0101010100;
                default: o_tmds <= 10'b1010101011;
            endcase
            bias <= 5'sb00000;
        end
        else  // send pixel colour data (at most 5 transitions)
        begin
            if (bias == 0 || balance == 0)  // no prior bias or disparity
            begin
                if (enc_qm[8] == 0)
                begin
                    // $display("\t%d %b %d, %d, A1", i_data, enc_qm, ones, bias);
                    o_tmds[9:0] <= {2'b10, ~enc_qm[7:0]};
                    bias <= bias - balance;
                end
                else begin
                    // $display("\t%d %b %d, %d, A0", i_data, enc_qm, ones, bias);
                    o_tmds[9:0] <= {2'b01, enc_qm[7:0]};
                    bias <= bias + balance;
                end
            end
            else if ((bias > 0 && balance > 0) || (bias < 0 && balance < 0))
            begin
                // $display("\t%d %b %d, %d, B1", i_data, enc_qm, ones, bias);
                o_tmds[9:0] <= {1'b1, enc_qm[8], ~enc_qm[7:0]};
                bias <= bias + {3'b0, enc_qm[8], 1'b0} - balance;
            end
            else
            begin
                // $display("\t%d %b %d, %d, B0", i_data, enc_qm, ones, bias);
                o_tmds[9:0] <= {1'b0, enc_qm[8], enc_qm[7:0]};
                bias <= bias - {3'b0, ~enc_qm[8], 1'b0} + balance;
            end
        end
		$display("dvi-D:%d\tq_m:%h\tq_out:%h\tcnt_pre:%d", i_data, enc_qm, o_tmds, bias);
    end
endmodule

/*
 *  SVO - Simple Video Out FPGA Core
 *
 *  Copyright (C) 2014  Clifford Wolf <clifford@clifford.at>
 *  
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *  
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */

// `timescale 1ns / 1ps
// `include "svo_defines.vh"

module svo_tmds (
	input clk, resetn, de,
	input [1:0] ctrl,
	input [7:0] din,
	output reg [9:0] dout
);


	// Variable and function names below match the spec names for
	// better readability when comparing to spec encoder flow diagram.
	wire [7:0] D = din;

	function [3:0] N1;
		// Count the number of '1' bits.
		input [7:0] bits;
		integer i;
		begin
			N1 = 0;
			for (i = 0; i < 8; i = i+1)
				N1 = N1 + bits[i];
		end
	endfunction

	function [3:0] N0;
		// Count the number of '0' bits.
		input [7:0] bits;
		integer i;
		begin
			N0 = 0;
			for (i = 0; i < 8; i = i+1)
				N0 = N0 + !bits[i];
		end
	endfunction

	reg [9:0] dout_buf2, q_out, q_out_next;
	reg [3:0] N0_q_m, N1_q_m;
	reg signed [7:0] cnt, cnt_next, cnt_tmp;
	reg [8:0] q_m;

	always @(posedge clk, resetn) begin
		if (!resetn) begin
			cnt   <= 0; // Data stream disparity count used for DC balance
			q_out <= 0;
		end else if (!de) begin
			cnt   <= 0; // Reset disaprity when not actively displaying
			case (ctrl) // See spec section "Control Period Coding"
				2'b00: q_out <= 10'b1101010100;
				2'b01: q_out <= 10'b0010101011;
				2'b10: q_out <= 10'b0101010100;
				2'b11: q_out <= 10'b1010101011;
			endcase
		end else begin
			// See spec flow diagram in section "Video Data Coding"
			if ((N1(D) > 4) | ((N1(D) == 4) & (D[0] == 0))) begin
				q_m[0] =           D[0];
				q_m[1] = q_m[0] ^~ D[1];
				q_m[2] = q_m[1] ^~ D[2];
				q_m[3] = q_m[2] ^~ D[3];
				q_m[4] = q_m[3] ^~ D[4];
				q_m[5] = q_m[4] ^~ D[5];
				q_m[6] = q_m[5] ^~ D[6];
				q_m[7] = q_m[6] ^~ D[7];
				q_m[8] = 1'b0;
			end
			else begin
				q_m[0] =          D[0];
				q_m[1] = q_m[0] ^ D[1];
				q_m[2] = q_m[1] ^ D[2];
				q_m[3] = q_m[2] ^ D[3];
				q_m[4] = q_m[3] ^ D[4];
				q_m[5] = q_m[4] ^ D[5];
				q_m[6] = q_m[5] ^ D[6];
				q_m[7] = q_m[6] ^ D[7];
				q_m[8] = 1'b1;
			end

			N0_q_m = N0(q_m[7:0]);
			N1_q_m = N1(q_m[7:0]);

			if ((cnt == 0) | (N1_q_m == N0_q_m)) begin
				q_out_next[9]    = ~q_m[8];
				q_out_next[8]    =  q_m[8];
				q_out_next[7:0]  = (q_m[8] ? q_m[7:0] : ~q_m[7:0]);
				if (q_m[8] == 0) begin
					cnt_next = cnt + (N0_q_m - N1_q_m);
				end else begin
					cnt_next = cnt + (N1_q_m - N0_q_m);
				end
			end else if (((cnt > 0) & (N1_q_m > N0_q_m)) | (((cnt < 0) & (N0_q_m > N1_q_m)))) begin
				q_out_next[9]    =  1'b1;
				q_out_next[8]    =  q_m[8];
				q_out_next[7:0]  = ~q_m[7:0];
				cnt_tmp          = cnt + (N0_q_m - N1_q_m);
				if (q_m[8]) begin
					cnt_next = cnt_tmp + 2'h2;
				end else begin
					cnt_next = cnt_tmp;
				end
			end else begin
				q_out_next[9]    =  1'b0;
				q_out_next[8]    =  q_m[8];
				q_out_next[7:0]  =  q_m[7:0];
				cnt_tmp          = cnt + (N1_q_m - N0_q_m);
				if (q_m[8]) begin
					cnt_next = cnt_tmp;
				end else begin
					cnt_next = cnt_tmp - 2'h2;
				end
			end
			cnt   <= cnt_next;
			dout <= q_out_next;
		end
		$display("svo-D:%d\tq_m:%h\tq_out:%h\tcnt_pre:%d", D, q_m, dout, cnt);
	end
endmodule


// `timescale 1ns/1ps
module TMDS_encoder(
	input clk,
	input [7:0] VD,  // video data (red, green or blue)
	input [1:0] CD,  // control data
	input VDE,  // video data enable, to choose between CD (when VDE=0) and VD (when VDE=1)
	output reg [9:0] TMDS = 0
);

wire [3:0] Nb1s = VD[0] + VD[1] + VD[2] + VD[3] + VD[4] + VD[5] + VD[6] + VD[7];
wire XNOR = (Nb1s>4'd4) || (Nb1s==4'd4 && VD[0]==1'b0);
wire [8:0] q_m = {~XNOR, q_m[6:0] ^ VD[7:1] ^ {7{XNOR}}, VD[0]};

reg [3:0] balance_acc = 0;
wire [3:0] balance = q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7] - 4'd4;
wire balance_sign_eq = (balance[3] == balance_acc[3]);
wire invert_q_m = (balance==0 || balance_acc==0) ? ~q_m[8] : balance_sign_eq;
wire [3:0] balance_acc_inc = balance - ({q_m[8] ^ ~balance_sign_eq} & ~(balance==0 || balance_acc==0));
wire [3:0] balance_acc_new = invert_q_m ? balance_acc-balance_acc_inc : balance_acc+balance_acc_inc;
wire [9:0] TMDS_data = {invert_q_m, q_m[8], q_m[7:0] ^ {8{invert_q_m}}};
wire [9:0] TMDS_code = CD[1] ? (CD[0] ? 10'b1010101011 : 10'b0101010100) : (CD[0] ? 10'b0010101011 : 10'b1101010100);

always @(posedge clk) TMDS <= VDE ? TMDS_data : TMDS_code;
always @(posedge clk) balance_acc <= VDE ? balance_acc_new : 4'h0;
always @(posedge clk) $display("HDMI-D:%d\tq_m:%h\tq_out:%h\tcnt_pre:%d", VD, q_m, TMDS, balance_acc);
endmodule


module my_tmds_encoder (
	input clk, rst, DE,
	input [1:0] CD, // C1 = Vsyn, C0 = Hsyn
	input [7:0] D,
	output reg [9:0] q_out = 10'd0
);
	reg signed [4:0] cnt_pre =5'd0; // cnt(t-1). 5bit signed range: -16 to 15

	wire [3:0] N1_D = D[7] + D[6] + D[5] + D[4] + D[3] + D[2] + D[1] + D[0];
	wire [8:0] q_m = ((N1_D>4'd4) || (N1_D==4'd4 && D[0]==1'b0)) ? {1'b0, q_m[6:0] ^~ D[7:1], D[0]} : {1'b1, q_m[6:0] ^ D[7:1], D[0]};
	wire [3:0] N0_qm = ~q_m[7] + ~q_m[6] + ~q_m[5] + ~q_m[4] + ~q_m[3] + ~q_m[2] + ~q_m[1] + ~q_m[0];
	wire [3:0] N1_qm = q_m[7] + q_m[6] + q_m[5] + q_m[4] + q_m[3] + q_m[2] + q_m[1] + q_m[0];
	wire [4:0] diff = N1_qm - N0_qm;
	wire balance = (cnt_pre==0 || diff==0);
	wire equal = ((cnt_pre>0 && diff>0) || (cnt_pre<0 && diff<0));
	wire [9:0] tmds_out = balance ? {~q_m[8], q_m[8], (q_m[8] ? q_m[7:0] : ~q_m[7:0])} : {equal, q_m[8], q_m[7:0]^{8{equal}}};
	wire signed [4:0] cnt = balance ? (q_m[8] ? (cnt_pre + diff) : (cnt_pre - diff)) : (equal ? (cnt_pre + {3'b000, q_m[8], 1'b0} - diff) : (cnt_pre + {3'b000, ~q_m[8], 1'b0} + diff));
	always @(posedge clk, rst) begin
		if(!rst) begin
			q_out <= 10'd0;
			cnt_pre <= 5'd0;
		end
		else begin
			q_out <= (DE ? tmds_out : (CD[1] ? (CD[0] ? 10'b1010101011 : 10'b0101010100) : (CD[0] ? 10'b0010101011 : 10'b1101010100)));
			cnt_pre <= (DE ? cnt : 5'd0);
		end
		$display("MY-D:%d\tq_m:%h\tq_out:%h\tcnt_pre:%d", D, q_m, q_out, cnt_pre);
	end

endmodule
