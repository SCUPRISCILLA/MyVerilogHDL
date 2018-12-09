module counter(clk50m, rst_n, l);
input clk50m;
input rst_n;
output reg l;
reg [24:0]cnt;

always@(posedge clk50m or negedge rst_n)
begin
if(rst_n == 1'b0)
	begin
	cnt <= 25'b0;
	l <= 1'b0;
	end
else if(cnt == 25'd24_999_999)
	begin
	cnt <= 25'b0;
	l <= ~l;
	end
else
	cnt <= cnt+1'b1;
end

endmodule