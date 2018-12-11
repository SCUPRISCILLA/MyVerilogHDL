module block_unblock(clk, rst_n, a, b, c, q);
	input clk;
	input rst_n;
	input a;
	input b;
	input c;
	
	output reg[1:0] q;  //q = a+b+c
	
	reg [1:0] d;  //d = a+b, q = d+c
	
	always@(posedge clk, negedge rst_n)
		if(rst_n == 1'b0)
			q = 2'd0;
		else begin
			d = a+b;
			q = d+c;
		end
			
	
endmodule