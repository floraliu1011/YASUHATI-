module Signal_Analyser (left, read_ready, clk_60hz, resetn, pitch, vol);

  input [23:0] left;
  input read_ready;
  input clk_60hz;
  input resetn;
  output [1:0] pitch;
  output vol;

  pitch_counter pitch_cnter(left, read_ready, resetn, pitch);

  volumn vlm(left, read_ready, resetn, clk_60hz, vol);


endmodule //Signal_Analyser

module pitch_counter (value, read_ready, resetn, out);
  input [23:0] value;
  input read_ready;
  input resetn;
  output reg [1:0] out;

  reg [14:0] count;
  wire [1:0] category;
  wire sign;

  assign sign = value[23];

  always @(posedge read_ready)
  begin
    if (sign == 1'b1 | resetn == 1'b0)
      count <= 15'h0000;
    else
      count <= count + 1'b1;
  end

  // always @(posedge clk_48k)
  // begin
  //   if (sign == 1'b1 | resetn == 1'b0)
  //     count <= 15'h0000;
  //   else
  //     count <= count + 1'b1;
  // end

  always @ (posedge sign) begin
    if (count > 15'h0004 | resetn == 1'b0)
    // if(count > 15'h0078)
      out <= 2'b00;
    else if (count >= 15'h0002)
    // else if (count >= 15'h003C)
      out <= 2'b01;
    else
      out <= 2'b11;
  end
endmodule //pitch_counter


// output 3 states according to the privious pitch before the clock edge

module volumn (left, read_ready, resetn, clk_60hz, out);

  input [23:0] left;
  input read_ready;
  input clk_60hz;
  input resetn;
  output reg out;

  wire [23:0] abs_left;
  reg [23:0] maximum;


  absolute_value abs(left, abs_left);

  always @ ( posedge read_ready, posedge clk_60hz) begin
	if (clk_60hz == 1'b1)
		maximum <= 24'h000000;
	else
		begin
			if (resetn == 0)
				maximum <= 24'h000000;
			else if (abs_left > maximum)
				maximum <= left;
			else
				maximum <= maximum;
		end
//    if (resetn == 0)
//		maximum <= 24'h000000;
//	 else if (clk_60hz == 1'b1)
//      maximum <= 24'h000000;
//    else if (abs_left > maximum)
//      maximum <= left;
//    else
//      maximum <= maximum;
  end

  always @(posedge clk_60hz)
  begin
    if (maximum >= 24'h3fffff)
      out <= 1;
    else
      out <= 0;
  end

endmodule //

module absolute_value(in, out);
  input [23:0] in;
  output reg [23:0] out;

  always @ ( * ) begin
    if (in[23] == 1'b1)
      out = -in;
    else
      out = in;
  end
endmodule

