module keypad(
	input clk,
	input [3:0] LINE,
	output reg [3:0] COLUMN,
	output reg [3:0] keyword,
	output reg led
);
	
	parameter clk_machine = 50000000;
	parameter delay_debounce = clk_machine / 100;
	reg [25:0] cnt_clk = 0;
	
	parameter zero = 4'd0, one = 4'd1, two = 4'd2, three = 4'd3, four = 4'd4, five = 4'd5, six = 4'd6, seven = 4'd7, eight = 4'd8, nine = 4'd9, A = 4'd10, B = 4'd11, C = 4'd12, D = 4'd13, hashtag = 4'd14, star = 4'd15;
	
	reg [3:0] keypad_ [0:3][0:3] ;
	
	initial begin
		keypad_[0][0] = one;
		keypad_[0][1] = two;
		keypad_[0][2] = three;
		keypad_[0][3] = A;
		
		keypad_[1][0] = four;
		keypad_[1][1] = five;
		keypad_[1][2] = six;
		keypad_[1][3] = B;
		
		keypad_[2][0] = seven;
		keypad_[2][1] = eight;
		keypad_[2][2] = nine;
		keypad_[2][3] = C;
		
		keypad_[3][0] = star;
		keypad_[3][1] = zero;
		keypad_[3][2] = hashtag;
		keypad_[3][3] = D;
	end
	
	reg [2:0] l;
	reg [2:0] c;
	
	always @(*) begin
		l = (~LINE[0] ? 0 : (~LINE[1] ? 1 : (~LINE[2] ? 2 : (~LINE[3] ? 3 : 4))));
		c = (~COLUMN[0] ? 0 : (~COLUMN[1] ? 1 : (~COLUMN[2] ? 2 : (~COLUMN[3] ? 3 : 4))));
	end
	
	always @(*) begin
		keyword = keypad_[l][c];
	end
	
endmodule
