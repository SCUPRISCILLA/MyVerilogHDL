module UART_BYTE(clk, rst_n, data_byte, send_en, baud_set, rs232_tx, tx_done, uart_state);
	input clk;
	input rst_n;
	input [7:0] data_byte;
	input send_en;
	input [2:0] baud_set;
	
	output reg rs232_tx;
	output reg tx_done;
	output reg uart_state;
	
	reg[15:0] div_cnt; //分频计数器
	reg bps_clk;       //波特率时钟
	reg[15:0] bps_dr;  //分频计数最大值
	reg[3:0] bps_cnt;  //波特率时钟计数
	reg[7:0] r_data_byte; //发送数据寄存器
	
	localparam start_bit = 1'b0;
	localparam stop_bit = 1'b1;
	
	always@(posedge clk, negedge rst_n)
	if(!rst_n)
		uart_state <= 1'b0;
	else if(send_en)
		uart_state <= 1'b1;
	else if(tx_done)
		uart_state <= 1'b0;
	else
		uart_state <= uart_state;
	
	
	always@(posedge clk, negedge rst_n)
	if(!rst_n)
		r_data_byte <= 8'd0;
	else if(send_en)
		r_data_byte <= data_byte;
	
	//使用查找表设置波特率
	always@(posedge clk, negedge rst_n)
	if(!rst_n)
		bps_dr <= 16'd5207;
	else begin
		case(baud_set)
			0: bps_dr <= 16'd5207;
			1: bps_dr <= 16'd2603;
			2: bps_dr <= 16'd1301;
			3: bps_dr <= 16'd867;
			4: bps_dr <= 16'd433;
			default: bps_dr <= 16'd5207;
		endcase
	end
	
	//div_cnt为分频计数
	always@(posedge clk, negedge rst_n)
	if(!rst_n)
		div_cnt <= 16'd0;
	else if(uart_state) begin
		if(div_cnt == bps_dr)
			div_cnt <= 16'd0;
		else 
			div_cnt <= div_cnt + 1'b1;
	end
	else
		div_cnt <= 16'd0;
		
	//bps_clk为波特率时钟
	always@(posedge clk, negedge rst_n)
	if(!rst_n)
		bps_clk <= 1'b0;
	else if(div_cnt == 1'd1)
		bps_clk <= 1'b1;
	else
		bps_clk <= 1'b0;
	
	//bps_cnt波特率时钟计数
	always@(posedge clk, negedge rst_n)
	if(!rst_n)
		bps_cnt <= 4'd0;
	else if(tx_done)
		bps_cnt <= 4'd0;
	else if(bps_clk)
		bps_cnt <= bps_cnt+1'b1;
	else
		bps_cnt <= bps_cnt;
		
	always@(posedge clk, negedge rst_n)
	if(!rst_n)
		tx_done <= 1'b0;
	else if(bps_cnt == 4'd11)
		tx_done <= 1'b1;
	else
		tx_done <= 1'b0;
		
	always@(posedge clk, negedge rst_n)
	if(!rst_n)
		rs232_tx <= 1'b1;
	else begin
		case(bps_cnt)
			0: rs232_tx <= 1'b1;
			1: rs232_tx <= start_bit;
			2: rs232_tx <= r_data_byte[0];
			3: rs232_tx <= r_data_byte[1];
			4: rs232_tx <= r_data_byte[2];
			5: rs232_tx <= r_data_byte[3];
			6: rs232_tx <= r_data_byte[4];
			7: rs232_tx <= r_data_byte[5];
			8: rs232_tx <= r_data_byte[6];
			9: rs232_tx <= r_data_byte[7];
			10: rs232_tx <= stop_bit;
			default: rs232_tx <= 1'b1;
		endcase
	end
	
		
	
		
		
	
endmodule