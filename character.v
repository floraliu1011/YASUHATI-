 `include "definition.vh"
module character (
  input [7:0] x,
  input [6:0] y,
  input [7:0] yasu_x,
  input [6:0] yasu_y,
  output reg [2:0] color);

  wire [3:0] increment_x;
  wire [4:0] increment_y;

  assign increment_x = x - yasu_x;
  assign increment_y = y - yasu_y + 7'd9;

  always @ ( * ) begin
    if ((increment_x == `x1 && increment_y == `y1) ||
       (increment_x == `x2 && increment_y == `y2) ||
       (increment_x == `x3 && increment_y == `y3) ||
       (increment_x == `x4 && increment_y == `y4) ||
       (increment_x == `x5 && increment_y == `y5) ||
       (increment_x == `x6 && increment_y == `y6) ||
       (increment_x == `x7 && increment_y == `y7) ||
       (increment_x == `x8 && increment_y == `y8) ||
       (increment_x == `x9 && increment_y == `y9) ||
       (increment_x == `x10 && increment_y == `y10) ||
       (increment_x == `x11 && increment_y == `y11) ||
       (increment_x == `x12 && increment_y == `y12) ||
       (increment_x == `x13 && increment_y == `y13) ||
       (increment_x == `x14 && increment_y == `y14) ||
       (increment_x == `x15 && increment_y == `y15) ||
       (increment_x == `x16 && increment_y == `y16) ||
       (increment_x == `x17 && increment_y == `y17) ||
       (increment_x == `x18 && increment_y == `y18) ||
       (increment_x == `x19 && increment_y == `y19) ||
       (increment_x == `x20 && increment_y == `y20) ||
       (increment_x == `x21 && increment_y == `y21) ||
       (increment_x == `x22 && increment_y == `y22) ||
       (increment_x == `x23 && increment_y == `y23) ||
       (increment_x == `x24 && increment_y == `y24) ||
       (increment_x == `x25 && increment_y == `y25) ||
       (increment_x == `x26 && increment_y == `y26) ||
       (increment_x == `x27 && increment_y == `y27) ||
       (increment_x == `x28 && increment_y == `y28) ||
       (increment_x == `x29 && increment_y == `y29) ||
       (increment_x == `x30 && increment_y == `y30) ||
       (increment_x == `x31 && increment_y == `y31) ||
       (increment_x == `x32 && increment_y == `y32) ||
       (increment_x == `x33 && increment_y == `y33) ||
       (increment_x == `x34 && increment_y == `y34) ||
       (increment_x == `x35 && increment_y == `y35) ||
       (increment_x == `x36 && increment_y == `y36) ||
       (increment_x == `x37 && increment_y == `y37) ||
       (increment_x == `x38 && increment_y == `y38) ||
       (increment_x == `x39 && increment_y == `y39) ||
       (increment_x == `x40 && increment_y == `y40) ||
       (increment_x == `x41 && increment_y == `y41) ||
       (increment_x == `x42 && increment_y == `y42) ||
       (increment_x == `x43 && increment_y == `y43) ||
       (increment_x == `x44 && increment_y == `y44) ||
       (increment_x == `x45 && increment_y == `y45) ||
       (increment_x == `x46 && increment_y == `y46) ||
       (increment_x == `x47 && increment_y == `y47) ||
       (increment_x == `x48 && increment_y == `y48) ||
       (increment_x == `x49 && increment_y == `y49) ||
       (increment_x == `x50 && increment_y == `y50) ||
       (increment_x == `x51 && increment_y == `y51) ||
       (increment_x == `x52 && increment_y == `y52) ||
       (increment_x == `x53 && increment_y == `y53) ||
       (increment_x == `x54 && increment_y == `y54) ||
       (increment_x == `x55 && increment_y == `y55) ||
       (increment_x == `x56 && increment_y == `y56) ||
       (increment_x == `x57 && increment_y == `y57) ||
       (increment_x == `x58 && increment_y == `y58) ||
       (increment_x == `x59 && increment_y == `y59) ||
       (increment_x == `x60 && increment_y == `y60) ||
       (increment_x == `x61 && increment_y == `y61) ||
       (increment_x == `x62 && increment_y == `y62) ||
       (increment_x == `x63 && increment_y == `y63) ||
       (increment_x == `x64 && increment_y == `y64) ||
       (increment_x == `x65 && increment_y == `y65))
		 color = 3'b011;
		else
	   color = 3'b111;
  end
endmodule
