module LED_1S_50M(clk, rst_n, led, cnt);
	input clk;
	input rst_n;

	output reg led;
	
	output reg [3:0]cnt;

	always@(posedge clk, negedge rst_n)
	begin
		if(rst_n == 1'b0)
			begin
			cnt <= 4'd0;
			led <= 1'b0;
			end
		else if(cnt == 4'b1111)
			begin
			led <= ~led;
			cnt <= 4'd0;
			end
		else
			cnt <= cnt + 1'b1;
	end

endmodule
