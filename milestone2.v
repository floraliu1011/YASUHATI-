module milestone2
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		CLOCK2_50,
		FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK,
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT,
        KEY,
        SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,
  		LEDR//	VGA Blue[9:0]
	);
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;

	input			CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input   [3:0]   KEY;
	input CLOCK2_50;
	input [9:0] LEDR;
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]

	wire resetn;
	assign resetn = KEY[0];

	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;
	wire jump;

	wire walk;
	milestone1 (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK,
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT, LEDR, jump, walk
				 );

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(1),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";

  background b(walk,jump, x, y, CLOCK_50, resetn, colour);

	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.

    // Instansiate datapath
	// datapath d0(...);

    // Instansiate FSM control
    // control c0(...);

endmodule

module background(walk, jump, x, y, clock, reset, color);
  input walk;
  input jump;
  input clock;
  input reset;
  output reg [7:0] x;
  output reg [6:0] y;
  output reg [2:0] color;
  wire y_enable;
  wire [7:0] right;

  reg [7:0] hole_left;
  reg [7:0] hole_right;
  reg [25:0] sclkk;
  reg sclkk_edge;
  reg fall = 0;
  reg fall_block = 0;
  integer yasuhati;
  integer yasuhati_x;
  reg scroll = 0;

  initial begin
    yasuhati = 90;
    yasuhati_x = 50;
    scroll = 0;
	 hole_left = 70;
	 hole_right = 90;
  end

  always @ (posedge clock) begin
	 sclkk_edge <= 0;
    sclkk <= sclkk + 1;
	 if (sclkk == 26'h2DC6BF)
		sclkk_edge <= 1;
    if (sclkk == 26'h2DC6C0)
    begin
		begin
      sclkk <= 0;
		sclkk_edge <= 0;
		end
      if (jump && !fall)
        yasuhati = yasuhati - 10; // jump
      else if (walk && !fall)
        scroll <= 1;
      else if (fall_block || (!reset))
      begin
        // reset to normal state.
        yasuhati = 90;
        fall <= 0;
        yasuhati_x = 50;
      end
      else if (yasuhati == 15)
        yasuhati = 14; // upper bound.
		else if (yasuhati >= 90)
		begin
			if (yasuhati_x >= hole_left && yasuhati_x <= hole_right)
			begin
				if (yasuhati <= 115)
					yasuhati = yasuhati + 8;
				else
				begin
					fall <= 1;
				end
			end
			else
				yasuhati = 90;

		//			yasuhati = 90;
//      else if (yasuhati >= 90 && yasuhati_x >= hole_left && yasuhati_x <= hole_right)
//		begin
//        yasuhati = yasuhati + 8; // fall in the hole.
//        fall <= 1;
      end
		else
		  yasuhati = yasuhati + 8; // fall
    end
  end

  randomgenerator cnm(CLOCK_50, right);

//  always @(negedge sclkk_edge)
//  begin
//	if (fall || (!reset))
//		begin
//			hole_left <= 120;
//			hole_right <= 140;
//		end
//  end

  always @ (posedge sclkk_edge)
  begin
	fall_block = 0;
	if (fall || (!reset))
	begin
	  hole_left <= 120;
     hole_right <= 140;
	  fall_block <= 1;
	end
	else if (walk)
	begin
		if (hole_right != 0)
			begin
				hole_left = hole_left - 1;
				hole_right = hole_right - 1;
			end
		else
		begin
			hole_left = 159;
			hole_right = hole_left + right;
		end
	end
	else
		begin
			hole_left = hole_left;
			hole_right = hole_right;
		end
  end
  always @(posedge clock) begin
		if (!reset)
			x <= 8'd0;
		else if (1) begin
			if (x == 8'd159)
				x <= 8'd0;
			else begin
				x <= x + 1'b1;
			end
		end
	end



	assign y_enable = (x == 8'd159) ? 1 : 0;



	// counter for y

	always @(posedge clock) begin
		if (!reset)
			y <= 7'd0;
		else if (y_enable) begin
			if (y != 7'd119)
				y <= y + 1'b1;
			else
				y <= 7'd0;
		end
	end

  wire [2:0] character_color;
	character ch(x, y, yasuhati_x, yasuhati, character_color);
  always @ ( * ) begin
    // graphics part.
    if (x >= 0 && x <= 8'd159 && y >= 7'd0 && y <= 7'd119)
      color <= 3'b111; // background white;
    if (x >= 0 && x <= 8'd159 && y >= 7'd90 && y <= 7'd119)
      color <= 3'b000; // ground;

	 if (x >= hole_left && x <= hole_right && y >= 7'd90 && y <= 7'd119)
		color <= 3'b111; // hole.

    if (x >= yasuhati_x && x <= yasuhati_x + 7'd6 && y >= yasuhati - 7'd9 && y <= yasuhati)
      color <= character_color; // yasuhati; can improve this later.

    if (fall)
    begin
      color <= 3'b0;
    end
  end


endmodule

module randomgenerator(clock, hole_width);
	input clock;
	output reg [7:0] hole_width;
	reg [2:0] ran = 3'b111;
	always @(posedge clock)
		ran <= {ran[2]^ran[1], ran[2]&ran[1], ran[0]};
	always
	begin
		case(ran)
			1:hole_width <= 7'd27;
			2:hole_width <= 7'd20;
			3:hole_width <= 7'd25;
			4:hole_width <= 7'd23;
			5:hole_width <= 7'd22;
			6:hole_width <= 7'd21;
			7:hole_width <= 7'd30;
		endcase
	end
endmodule
