module muxfour(a1, a2, a3, a4, x1, x2, l);
input a1, a2, a3, a4;
input x1, x2;
output reg l;

always@( * )
begin
	case ({x2, x1})
		2'b00: l <= a1;
		2'b01: l <= a2;
		2'b10: l <= a3;
		2'b11: l <= a4;
	endcase
end
endmodule
	
