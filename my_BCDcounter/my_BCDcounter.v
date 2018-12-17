module my_BCDcounter(clk, rst_n, cout, q);
	input clk;
	input rst_n;
	
	output reg cout;
	output [3:0] q;
	
	reg[3:0] cnt;
	
	always@(posedge clk, negedge rst_n)
		if(!rst_n)
		begin
			cout <= 0;
			cnt <= 4'd0;
		end
		
		else if(cnt != 4'b1010)
		begin
			if(cnt == 4'b1001)
			begin
				cnt <= 4'd0;
				cout <= ~cout;
			end
			else
				cnt <= cnt + 1'b1;
		end
	assign q = cnt;
endmodule