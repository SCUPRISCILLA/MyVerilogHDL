module n_bit_counter(clk, rst_n, q);
	input clk;
	input rst_n;

	output reg q;
	
	reg[3:0] cnt;
	
	always@(posedge clk, negedge rst_n)
		if(!rst_n)
		begin
			q <= 1'b0;
			cnt <= 4'd0;
		end
		else if(cnt == 4'b1111)
		begin
			q <= ~q;
			cnt <= 4'd0;
		end
		else
			cnt <= cnt + 1'b1;
endmodule