module key(clk, rst_n, key_in, key_flag, key_state);
	input clk;
	input rst_n;
	input key_in;
	
	output reg key_flag;
	output reg key_state;
	
	localparam
	idel = 4'b0000,  //复位状态
		filter0 = 4'b0010,  //按下滤波
		down = 4'b0100,  //按下稳定
		filter = 4'b1000;  //释放
		
	reg[3:0] state;
	reg key_tmp0, key_tmp1;
	wire pedge;
	wire nedge;
	
	reg[19:0] cnt;
	reg en_cnt;  //计数使能
	reg cnt_full;  //计数满
	
	always@(posedge clk, negedge rst_n)
		if(!rst_n)
			cnt <= 20'd0;
		else if(en_cnt)
			cnt <= cnt+1'b1;
		else
			cnt <= 20'd0;
		
	always@(posedge clk, negedge rst_n)
		if(!rst_n)
			cnt_full <= 1'b0;
		else if(cnt <= 999_999)
			cnt_full <= 1'b1;
		else
			cnt_full <= 1'b0;
	
	always@(posedge clk, negedge rst_n)
		if(!rst_n)
		begin
			key_tmp0 <= 1'b0;
			key_tmp1 <= 1'b0;
		end
		else
		begin
			key_tmp0 <= key_in;
			key_tmp1 <= key_tmp0;
		end
		
		assign nedge = !key_tmp0 & key_tmp1;
		assign pedge = key_tmp0 & (!key_tmp1);
		
	always@(posedge clk, negedge rst_n)
		if(!rst_n)
		begin
			state <= idel;
			en_cnt <= 1'b0;
			key_flag <= 1'b0;
			key_state <= 1'b1;
		end
		else 
		begin
			case(state)
				idel: 
					begin
						key_flag <= 1'b0;
					if(nedge)
					begin
						state <= filter0;
						en_cnt <= 1'b1;
					end
					else
						state <= idel;
				filter0:
					if(cnt_full)
					begin
						state <= down;
						en_cnt <= 1'b0;
						key_flag <= 1'b1;
						key_state <= 1'b0;
					end
					else if(pedge)
					begin
						state <= idel;
						en_cnt <= 1b'0;
					end
					else
						state <= filter0;
				down:
				begin
					key_flag <= 1'b0;
					if(pedge)
					begin
						state <= filter1;
						en_cnt <= 1'b1;
					end
					else
						state <= down;
				end
				filter1:
					if(cnt_full)
					begin
						key_flag <= 1'b1;
						key_state <= 1'b1;
						state <= idel;
					end
					else if(nedge)
					begin
						en_cnt <= 1'b0;
						state <= down;
					end
					else
						state <= filter1;
				default: state <= idel;

endmodule