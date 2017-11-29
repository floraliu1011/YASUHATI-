module Signal_Analyser (left, read, read_ready, clk_50, clk_60hz, resetn, vol);

  input [23:0] left;
  input read_ready;
  input clk_60hz;
  input clk_50;
  input resetn;
  output vol;
  output reg read;

  volumn vlm(valid_left, read_ready, clk_50, resetn, clk_60hz, vol);
	always @(posedge clk_50)
	begin
	read = 0;
	if(read_ready == 1) begin
	   valid_left <= left;
		read <= 1;
		end
	else
		valid_left <= valid_left;
	end

endmodule //Signal_Analyser


// output 3 states according to the privious pitch before the clock edge

module volumn (left, read_ready, clk_50, resetn, clk_60hz, out);

  input [23:0] left;
  input read_ready;
  input clk_50;
  input clk_60hz;
  input resetn;
  output reg out;

  wire [23:0] abs_left;
  reg [23:0] maximum;


  absolute_value abs(left, abs_left);

  always @(posedge clk_50)
  begin
	if(read_ready == 1)
	begin
		if (abs_left >= 24'h00ffff)
		out <= 1;
		else
		out <= 0;
	end
	else
		out <= out;
  end

//  always @ ( posedge clk_50)
//	begin
//		if (resetn == 0 | clk_60hz == 1'b1)
//		 maximum <= 24'h000000;
//		else if(read_ready == 1)
//			begin
//				if (abs_left > maximum)
//						maximum <= left;
//				else
//						maximum <= maximum;
//
//			end
//		else
//			maximum <= maximum;
//  end
////    if (resetn == 0)
////		maximum <= 24'h000000;
////	 else if (clk_60hz == 1'b1)
////      maximum <= 24'h000000;
////    else if (abs_left > maximum)
////      maximum <= left;
////    else
////      maximum <= maximum;
//
//
//  always @(posedge clk_60hz)
//  begin
//    if (maximum >= 24'h3fffff)
//      out <= 1;
//    else
//      out <= 0;
//  end

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
