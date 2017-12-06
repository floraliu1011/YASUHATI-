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
       (increment_x == `x23 && increment_y == `y23))
		 color = 3'b011;
		else
	   color = 3'b111;
  end
endmodule
