// (c) fpga4fun.com & KNJN LLC 2013-2023
`include "tmds_encoder.v"

////////////////////////////////////////////////////////////////////////
module HDMI_svo(
	input pixclk,  // 25MHz
	input clk_TMDS,	// 250Mhz
	output [2:0] TMDSp,/* TMDSn,*/
	output TMDSp_clock/*, TMDSn_clock*/
);

////////////////////////////////////////////////////////////////////////
reg [9:0] CounterX=0, CounterY=0;
reg hSync=0, vSync=0, DrawArea=0;
always @(posedge pixclk) DrawArea <= (CounterX<640) && (CounterY<480);

always @(posedge pixclk) CounterX <= (CounterX==799) ? 0 : CounterX+1;
always @(posedge pixclk) if(CounterX==799) CounterY <= (CounterY==524) ? 0 : CounterY+1;

always @(posedge pixclk) hSync <= (CounterX>=656) && (CounterX<752);
always @(posedge pixclk) vSync <= (CounterY>=490) && (CounterY<492);

////////////////
wire [7:0] W = {8{CounterX[7:0]==CounterY[7:0]}};
wire [7:0] A = {8{CounterX[7:5]==3'h2 && CounterY[7:5]==3'h2}};
reg [7:0] red=0, green=0, blue=0;
always @(posedge pixclk) red <= ({CounterX[5:0] & {6{CounterY[4:3]==~CounterX[4:3]}}, 2'b00} | W) & ~A;
always @(posedge pixclk) green <= (CounterX[7:0] & {8{CounterY[6]}} | W) & ~A;
always @(posedge pixclk) blue <= CounterY[7:0] | W | A;

////////////////////////////////////////////////////////////////////////
wire [9:0] TMDS_red, TMDS_green, TMDS_blue;
// TMDS_encoder encode_R(.clk(pixclk), .VD(red  ), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_red));
// TMDS_encoder encode_G(.clk(pixclk), .VD(green), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_green));
// TMDS_encoder encode_B(.clk(pixclk), .VD(blue ), .CD({vSync,hSync}), .VDE(DrawArea), .TMDS(TMDS_blue));
// TMDS_encoder_x encode_R(.clk(pixclk), .VD(red  ), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_red));
// TMDS_encoder_x encode_G(.clk(pixclk), .VD(green), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_green));
// TMDS_encoder_x encode_B(.clk(pixclk), .VD(blue ), .CD({vSync,hSync}), .VDE(DrawArea), .TMDS(TMDS_blue));
// my_tmds_encoder my_encode_R (.clk(pixclk), .D(red)  , .CD(2'b00)        , .DE(DrawArea), .q_out(TMDS_red)  , .rst(1'b1));
// my_tmds_encoder my_encode_G (.clk(pixclk), .D(green), .CD(2'b00)        , .DE(DrawArea), .q_out(TMDS_green), .rst(1'b1));
// my_tmds_encoder my_encode_B (.clk(pixclk), .D(blue) , .CD({vSync,hSync}), .DE(DrawArea), .q_out(TMDS_blue) , .rst(1'b1));
svo_tmds my_encode_R (.clk(pixclk), .din(red)  , .ctrl(2'b00)		 , .de(DrawArea), .dout(TMDS_red)  , .resetn(1'b1));
svo_tmds my_encode_G (.clk(pixclk), .din(green), .ctrl(2'b00)		 , .de(DrawArea), .dout(TMDS_green), .resetn(1'b1));
svo_tmds my_encode_B (.clk(pixclk), .din(blue) , .ctrl({vSync,hSync}), .de(DrawArea), .dout(TMDS_blue) , .resetn(1'b1));
// tmds_encoder_dvi encode_R(.i_clk(pixclk), .i_data(red  ), .i_ctrl(2'b00)        , .i_de(DrawArea), .o_tmds(TMDS_red)  , .i_rst(1'b1));
// tmds_encoder_dvi encode_G(.i_clk(pixclk), .i_data(green), .i_ctrl(2'b00)        , .i_de(DrawArea), .o_tmds(TMDS_green), .i_rst(1'b1));
// tmds_encoder_dvi encode_B(.i_clk(pixclk), .i_data(blue ), .i_ctrl({vSync,hSync}), .i_de(DrawArea), .o_tmds(TMDS_blue) , .i_rst(1'b1));
always @(posedge pixclk) $display("\nHDMI_svo: Red:%b\tGreen:%b\tBlue:%b", TMDS_red, TMDS_green, TMDS_blue);

////////////////////////////////////////////////////////////////////////
// wire clk_TMDS, DCM_TMDS_CLKFX;  // 25MHz x 10 = 250MHz
// DCM_SP #(.CLKFX_MULTIPLY(10)) DCM_TMDS_inst(.CLKIN(pixclk), .CLKFX(DCM_TMDS_CLKFX), .RST(1'b0));
// BUFG BUFG_TMDSp(.I(DCM_TMDS_CLKFX), .O(clk_TMDS));

////////////////////////////////////////////////////////////////////////
reg [3:0] TMDS_mod10=0;  // modulus 10 counter
reg [9:0] TMDS_shift_red=0, TMDS_shift_green=0, TMDS_shift_blue=0;
reg TMDS_shift_load=0;
always @(posedge clk_TMDS) TMDS_shift_load <= (TMDS_mod10==4'd9);

always @(posedge clk_TMDS)
begin
	TMDS_shift_red   <= TMDS_shift_load ? TMDS_red   : TMDS_shift_red  [9:1];
	TMDS_shift_green <= TMDS_shift_load ? TMDS_green : TMDS_shift_green[9:1];
	TMDS_shift_blue  <= TMDS_shift_load ? TMDS_blue  : TMDS_shift_blue [9:1];	
	TMDS_mod10 <= (TMDS_mod10==4'd9) ? 4'd0 : TMDS_mod10+4'd1;
end

// OBUFDS OBUFDS_red  (.I(TMDS_shift_red  [0]), .O(TMDSp[2]), .OB(TMDSn[2]));
// OBUFDS OBUFDS_green(.I(TMDS_shift_green[0]), .O(TMDSp[1]), .OB(TMDSn[1]));
// OBUFDS OBUFDS_blue (.I(TMDS_shift_blue [0]), .O(TMDSp[0]), .OB(TMDSn[0]));
// OBUFDS OBUFDS_clock(.I(pixclk), .O(TMDSp_clock), .OB(TMDSn_clock));
assign TMDSp[0] = TMDS_shift_blue[0];
assign TMDSp[1] = TMDS_shift_green[0];
assign TMDSp[2] = TMDS_shift_red[0];
assign TMDSp_clock = pixclk;
endmodule


////////////////////////////////////////////////////////////////////////
/*
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
endmodule
*/

////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////
module HDMI_my(
	input pixclk,  // 25MHz
	input clk_TMDS,	// 250Mhz
	output [2:0] TMDSp,/* TMDSn,*/
	output TMDSp_clock/*, TMDSn_clock*/
);

	////////////////////////////////////////////////////////////////////////
	reg [9:0] CounterX=0, CounterY=0;
	reg hSync=0, vSync=0, DrawArea=0;
	always @(posedge pixclk) DrawArea <= (CounterX<640) && (CounterY<480);

	always @(posedge pixclk) CounterX <= (CounterX==799) ? 0 : CounterX+1;
	always @(posedge pixclk) if(CounterX==799) CounterY <= (CounterY==524) ? 0 : CounterY+1;

	always @(posedge pixclk) hSync <= (CounterX>=656) && (CounterX<752);
	always @(posedge pixclk) vSync <= (CounterY>=490) && (CounterY<492);

	////////////////
	wire [7:0] W = {8{CounterX[7:0]==CounterY[7:0]}};
	wire [7:0] A = {8{CounterX[7:5]==3'h2 && CounterY[7:5]==3'h2}};
	reg [7:0] red=0, green=0, blue=0;
	always @(posedge pixclk) red <= ({CounterX[5:0] & {6{CounterY[4:3]==~CounterX[4:3]}}, 2'b00} | W) & ~A;
	always @(posedge pixclk) green <= (CounterX[7:0] & {8{CounterY[6]}} | W) & ~A;
	always @(posedge pixclk) blue <= CounterY[7:0] | W | A;

	////////////////////////////////////////////////////////////////////////
	wire [9:0] TMDS_red, TMDS_green, TMDS_blue;
	// TMDS_encoder encode_R(.clk(pixclk), .VD(red  ), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_red));
	// TMDS_encoder encode_G(.clk(pixclk), .VD(green), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_green));
	// TMDS_encoder encode_B(.clk(pixclk), .VD(blue ), .CD({vSync,hSync}), .VDE(DrawArea), .TMDS(TMDS_blue));
	// TMDS_encoder_x encode_R(.clk(pixclk), .VD(red  ), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_red));
	// TMDS_encoder_x encode_G(.clk(pixclk), .VD(green), .CD(2'b00)        , .VDE(DrawArea), .TMDS(TMDS_green));
	// TMDS_encoder_x encode_B(.clk(pixclk), .VD(blue ), .CD({vSync,hSync}), .VDE(DrawArea), .TMDS(TMDS_blue));
	my_tmds_encoder my_encode_R (.clk(pixclk), .D(red)  , .CD(2'b00)        , .DE(DrawArea), .q_out(TMDS_red)  , .rst(1'b1));
	my_tmds_encoder my_encode_G (.clk(pixclk), .D(green), .CD(2'b00)        , .DE(DrawArea), .q_out(TMDS_green), .rst(1'b1));
	my_tmds_encoder my_encode_B (.clk(pixclk), .D(blue) , .CD({vSync,hSync}), .DE(DrawArea), .q_out(TMDS_blue) , .rst(1'b1));
	// svo_tmds my_encode_R (.clk(pixclk), .din(red), .ctrl(2'b00), .de(DrawArea), .dout(TMDS_red), .resetn(1'b1));
	// svo_tmds my_encode_G (.clk(pixclk), .din(green), .ctrl(2'b00), .de(DrawArea), .dout(TMDS_green), .resetn(1'b1));
	// svo_tmds my_encode_B (.clk(pixclk), .din(blue), .ctrl({vSync,hSync}), .de(DrawArea), .dout(TMDS_blue), .resetn(1'b1));
	// tmds_encoder_dvi encode_R(.i_clk(pixclk), .i_data(red  ), .i_ctrl(2'b00)        , .i_de(DrawArea), .o_tmds(TMDS_red)  , .i_rst(1'b1));
	// tmds_encoder_dvi encode_G(.i_clk(pixclk), .i_data(green), .i_ctrl(2'b00)        , .i_de(DrawArea), .o_tmds(TMDS_green), .i_rst(1'b1));
	// tmds_encoder_dvi encode_B(.i_clk(pixclk), .i_data(blue ), .i_ctrl({vSync,hSync}), .i_de(DrawArea), .o_tmds(TMDS_blue) , .i_rst(1'b1));
	always @(posedge pixclk) $display("\nHDMI_my:  Red:%b\tGreen:%b\tBlue:%b", TMDS_red, TMDS_green, TMDS_blue);

	////////////////////////////////////////////////////////////////////////
	// wire clk_TMDS, DCM_TMDS_CLKFX;  // 25MHz x 10 = 250MHz
	// DCM_SP #(.CLKFX_MULTIPLY(10)) DCM_TMDS_inst(.CLKIN(pixclk), .CLKFX(DCM_TMDS_CLKFX), .RST(1'b0));
	// BUFG BUFG_TMDSp(.I(DCM_TMDS_CLKFX), .O(clk_TMDS));

	////////////////////////////////////////////////////////////////////////
	reg [3:0] TMDS_mod10=0;  // modulus 10 counter
	reg [9:0] TMDS_shift_red=0, TMDS_shift_green=0, TMDS_shift_blue=0;
	reg TMDS_shift_load=0;
	always @(posedge clk_TMDS) TMDS_shift_load <= (TMDS_mod10==4'd9);

	always @(posedge clk_TMDS)
	begin
		TMDS_shift_red   <= TMDS_shift_load ? TMDS_red   : TMDS_shift_red  [9:1];
		TMDS_shift_green <= TMDS_shift_load ? TMDS_green : TMDS_shift_green[9:1];
		TMDS_shift_blue  <= TMDS_shift_load ? TMDS_blue  : TMDS_shift_blue [9:1];	
		TMDS_mod10 <= (TMDS_mod10==4'd9) ? 4'd0 : TMDS_mod10+4'd1;
	end

	// OBUFDS OBUFDS_red  (.I(TMDS_shift_red  [0]), .O(TMDSp[2]), .OB(TMDSn[2]));
	// OBUFDS OBUFDS_green(.I(TMDS_shift_green[0]), .O(TMDSp[1]), .OB(TMDSn[1]));
	// OBUFDS OBUFDS_blue (.I(TMDS_shift_blue [0]), .O(TMDSp[0]), .OB(TMDSn[0]));
	// OBUFDS OBUFDS_clock(.I(pixclk), .O(TMDSp_clock), .OB(TMDSn_clock));
	assign TMDSp[0] = TMDS_shift_blue[0];
	assign TMDSp[1] = TMDS_shift_green[0];
	assign TMDSp[2] = TMDS_shift_red[0];
	assign TMDSp_clock = pixclk;
endmodule


////////////////////////////////////////////////////////////////////////
/*
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
endmodule
*/

////////////////////////////////////////////////////////////////////////
