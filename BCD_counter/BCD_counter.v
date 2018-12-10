module BCD_counter(Clk, Rst_n, Cin, Cout, q);
	input Clk;
	input Rst_n;
	input Cin;
	
	output reg Cout;
	output [3:0]q;
	
	reg [3:0]cnt;
	
	always@(posedge Clk or negedge Rst_n)
	if(Rst_n == 1'b0)
		cnt <= 4'd0;
	else if(Cin == 1'b1) begin
		if(cnt == 4'd9)
			cnt <= 4'd0;
		else
			cnt <= cnt + 1;
	end
	else
		cnt <= cnt;
		
	always@(posedge Clk or negedge Rst_n)
	if(Rst_n == 1'b0)
		Cout <= 1'b0;
	else if(Cin == 1'b1 && cnt == 4'd9)
		Cout <= 1'b1;
	else
		Cout <= 1'b0;
		
	assign q = cnt;
		
endmodule