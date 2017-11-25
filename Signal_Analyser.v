module Signal_Analyser (left, read, read_ready, clk_50, clk_60hz, resetn, pitch, vol, valid_left, count);

  input [23:0] left;
  input read_ready;
  input clk_60hz;
  input clk_50;
  input resetn;
  output [1:0] pitch;
  output vol;
  output reg read;
  output reg [23:0] valid_left;
  output [14:0] count;

  pitch_counter pitch_cnter(valid_left, read_ready, clk_50, resetn, pitch, count);

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

module pitch_counter (value, read_ready, clk_50, resetn, out, count);
  input [23:0] value;
  input clk_50;
  input read_ready;
  input resetn;
  output reg [1:0] out;
  output reg [14:0] count;
  wire [1:0] category;
  wire sign;
  reg presign;

  assign sign = value[23];

  always @(posedge clk_50)
  begin
  if (resetn == 1'b0)
		begin
      count <= 15'h0000;
		presign <= 0;
		end
	 else if (sign != presign)
		begin
		count <= 15'h0000;
		presign <= sign;
		end
	 else if (read_ready == 1)
		begin
      count <= count + 1'b1;
		presign <= sign;
		end
	 else
		count <= count;
  end
  

  // always @(posedge clk_48k)
  // begin
  //   if (sign == 1'b1 | resetn == 1'b0)
  //     count <= 15'h0000;
  //   else
  //     count <= count + 1'b1;
  // end

  always @ (posedge sign) begin
//    if (count > 15'h0004 | resetn == 1'b0)
	if (resetn == 1'b0)
		out <= 2'b00;
    else 
	 begin
	 if(count > 15'h0078)
      out <= 2'b10;
//    else if (count >= 15'h0002)
    else if (count >= 15'h003C)
      out <= 2'b01;
    else
      out <= 2'b11;
	end
  end
endmodule //pitch_counter


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

