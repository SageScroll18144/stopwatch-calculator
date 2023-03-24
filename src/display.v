module display(
	input[3:0] number, 
	output reg[0:6] hex
);
	
	always @(*) begin
		case(number) 
			1: hex = 7'b1001111;
			2: hex = 7'b0010010;
			3: hex = 7'b0000110;
			4: hex = 7'b1001100;
			5: hex = 7'b0100100;
			6: hex = 7'b0100000;
			7: hex = 7'b0001101;
			8: hex = 7'b0000000;
			9: hex = 7'b0000100;
			0: hex = 7'b0000001;
			default: hex = 7'b1111111;
		endcase
	end
endmodule 