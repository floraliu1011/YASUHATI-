module character (
  input [7:0] x,
  input [6:0] y,
  input clk,
  input enable,
  input resetn,
  output [7:0] out_x,
  output [6:0] out_y,
  output done);

  `include "definition.vh";
  wire [3:0] increment_x;
  wire [4:0] increment_y;
  wire [5:0] counter_out;

  counter_23 counter(
    .clk(clk),
    .enable(enable),
    .resetn(resetn),
    .out(counter_out)
  )
  always @ ( * ) begin
    case (counter_out)
      5'd01: begin
      increment_x = x1;
      increment_y = y1;
      end;
      5'd02: begin
      increment_x = x2;
      increment_y = y2;
      end;
      5'd03: begin
      increment_x = x3;
      increment_y = y3;
      end;
      5'd04: begin
      increment_x = x4;
      increment_y = y4;
      end;
      5'd05: begin
      increment_x = x5;
      increment_y = y5;
      end;
      5'd06: begin
      increment_x = x6;
      increment_y = y6;
      end;
      5'd07: begin
      increment_x = x7;
      increment_y = y7;
      end;
      5'd08: begin
      increment_x = x8;
      increment_y = y8;
      end;
      5'd09: begin
      increment_x = x9;
      increment_y = y9;
      end;
      5'd10: begin
      increment_x = x10;
      increment_y = y10;
      end;
      5'd11: begin
      increment_x = x11;
      increment_y = y11;
      end;
      5'd12: begin
      increment_x = x12;
      increment_y = y12;
      end;
      5'd13: begin
      increment_x = x13;
      increment_y = y13;
      end;
      5'd14: begin
      increment_x = x14;
      increment_y = y14;
      end;
      5'd15: begin
      increment_x = x15;
      increment_y = y15;
      end;
      5'd16: begin
      increment_x = x16;
      increment_y = y16;
      end;
      5'd17: begin
      increment_x = x17;
      increment_y = y17;
      end;
      5'd18: begin
      increment_x = x18;
      increment_y = y18;
      end;
      5'd19: begin
      increment_x = x19;
      increment_y = y19;
      end;
      5'd20: begin
      increment_x = x20;
      increment_y = y20;
      end;
      5'd21: begin
      increment_x = x21;
      increment_y = y21;
      end;
      5'd22: begin
      increment_x = x22;
      increment_y = y22;
      end;
      5'd23: begin
      increment_x = x23;
      increment_y = y23;
      end;
      default:
      begin
      increment_x = 0;
      increment_y = 0;
      end;
    endcase
  end

endmodule //character

module counter_23 (
  input clk,
  input enable,
  input resetn,
  output reg [5:0] out
  );

  always @ ( posedge clk ) begin
    if (!resetn)
      out <= 5'b00000;
    else if (enable)
      begin
        if (out >= 5'd23)
          out <= 5'd00;
        else
          out <= out + 1'b1;
      end
    else
      out <= out;
  end


endmodule //counter_23
