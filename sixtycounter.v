module milestone(volume, pitch, out);
	input volume;
	input [1:0] pitch;
	output [2:0] out;
	assign out = {volume, pitch};
endmodule


module main(volume, pitch, LEDR, CLOCK_50);
  input CLOCK_50;
	input volume;
	input [1:0] pitch;
	output [9:0] LEDR;
  //sixtyhzcounter clk1(1, CLOCK_50, 1, LEDR[5]); // always enable and never reset.
	milestone m1(volume, pitch, {LEDR[9], LEDR[1:0]});
endmodule


// 0b11001011011100110101  rate of 1/60 hz clock.



module sixtyhzcounter(enable,  clk, reset_n, out);
	input clk, enable, par_load, reset_n;
	output [3:0] out;

	wire hz;
	reg enable;

	ratedivider r(enable, {8’b00000000, 20’b11001011011100110101}, clk, reset_n, hz);
endmodule


module ratedivider(enable, load, clk, reset_n, q);
	input enable, clk, reset_n;
	input [27:0] load;
	output reg [27:0] q;

	always @(posedge clk)
	begin
		if (reset_n == 1'b0)
			q <= load;
		else if (enable == 1'b1)
			begin
				if (q == 0)
					q <= load;
				else
					q <= q - 1'b1;
			end
	end
endmodule
