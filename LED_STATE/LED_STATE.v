module LED_STATE(clk, rst_n, key1, key2, q);
	input clk;
	input rst_n;
	input key1;
	input key2;
	
	output reg[3:0] q;
	
	localparam s1 = 4'b0001;
	localparam s2 = 4'b0010;
	localparam s3 = 4'b0011;
	localparam s4 = 4'b0100;

	reg[31:0] tim;
	
	reg[31:0] cnt;
	reg [3:0] state;
	
	always@(posedge clk, negedge rst_n)
		if(!rst_n)
		begin
			cnt <= 32'd0;
			q <= 4'b0000;
			state <= s1;
		end
		else if(!key1)
		begin
			tim <= 32'd24999999;
			state <= s1;
		end
		else if(!key2)
		begin
			tim <= 32'd49999999;
			state <= s1;
		end
		else if(cnt == tim)
		begin
			case(state)
			s1:begin
				q <= 4'b0001;
				cnt <= 32'd0;
				state <= s2;
				end
			s2:begin
				q <= 4'b0010;
				cnt <= 32'd0;
				state <= s3;
				end
			s3:begin
				q <= 4'b0100;
				cnt <= 32'd0;
				state <= s4;
				end
			s4:begin
				q <= 4'b1000;
				cnt <= 32'd0;
				state <= s1;
				end
			default : state <= s1;
			endcase
		end
		else
			cnt <= cnt + 1'b1;

		
		
endmodule