module sixtyhzcounter(enable, clk, reset_n, out);
	input clk, enable, reset_n;
	output [27:0] out;
	//reg enable;
	// 20'b11001011011100110101 for 1/60 rate.
	ratedivider r(enable, 28'b0000000011001011011100110101, clk, reset_n, out);
endmodule


module ratedivider(enable, load, clk, reset_n, qout);
	input enable, clk, reset_n;
	input [27:0] load;
	reg [27:0] q;
	output reg qout;

	always @(posedge clk)
	begin
		if (reset_n == 1'b0)
			begin
				q <= load;
				qout <= 0;
			end
		else if (enable == 1'b1)
			begin
				if (q == 0)
				begin
					q <= load;
					qout <= 1;
				end
				else
				begin
					q <= q - 1'b1;
					qout <= 0;
				end
			end

	end
endmodule
