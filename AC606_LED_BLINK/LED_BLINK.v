module LED_BLINK(clk, rst_n, q);
	input clk;
	input rst_n;
	output reg q;

	reg[31:0] cnt;
	
	always@(posedge clk, negedge rst_n)
		if(rst_n == 1'b0)begin
			q <= 1'b1;
			cnt <= 32'd0;
		end
		else if(cnt == 32'd24999999)begin
			q <= ~q;
			cnt <= 32'd0;
		end
		else
			cnt <= cnt + 1'b1;
		
endmodule
			
