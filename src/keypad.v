module keypad (
	input clk,
	output reg [3:0] row,
	input [3:0] col,
	output reg[31:0] keyword
);

	parameter zero = 4'd0, one = 4'd1, two = 4'd2, three = 4'd3, four = 4'd4, five = 4'd5, six = 4'd6, seven = 4'd7, eight = 4'd8, nine = 4'd9, A = 4'd10, B = 4'd11, C = 4'd12, D = 4'd13, hashtag = 4'd14, star = 4'd15;
	parameter clk_machine = 50000000;
	parameter delay_debounce = clk_machine / 100;
	
	reg[31:0] p_kw;
	reg[31:0] bf_kw = 0;
	reg[31:0] cnt_db = 0;
	reg[31:0] cnt = 0;
	
	always @ (*) begin
		if(cnt == 10000) begin
			row[0] = 0;
			row[1] = 1;
			row[2] = 1;
			row[3] = 1;
		end
		else if(cnt == 20000) begin
			row[0] = 1;
			row[1] = 0;
			row[2] = 1;
			row[3] = 1;
		end
		else if(cnt == 30000) begin
			row[0] = 1;
			row[1] = 1;
			row[2] = 0;
			row[3] = 1;
		end
		else if(cnt == 40000) begin
			row[0] = 1;
			row[1] = 1;
			row[2] = 1;
			row[3] = 0;
		end
		
		if(cnt >= 40000) cnt = 0;
		else cnt = cnt + 1;
	end
	
	always @ (*) begin
		if(~&col) begin
			if(~row[0] && ~col[0]) p_kw <= one;
			else if(~row[0] && ~col[1]) p_kw <= two;
			else if(~row[0] && ~col[2]) p_kw <= three;
			else if(~row[0] && ~col[3]) p_kw <= A;
			
			else if(~row[1] && ~col[0]) p_kw <= four;
			else if(~row[1] && ~col[1]) p_kw <= five;
			else if(~row[1] && ~col[2]) p_kw <= six;
			else if(~row[1] && ~col[3]) p_kw <= B;
			
			else if(~row[2] && ~col[0]) p_kw <= seven;
			else if(~row[2] && ~col[1]) p_kw <= eight;
			else if(~row[2] && ~col[2]) p_kw <= nine;
			else if(~row[2] && ~col[3]) p_kw <= C;
			
			else if(~row[3] && ~col[0]) p_kw <= star;
			else if(~row[3] && ~col[1]) p_kw <= zero;
			else if(~row[3] && ~col[2]) p_kw <= hashtag;
			else if(~row[3] && ~col[3]) p_kw <= D;
			
			else p_kw <= 0;
		end
	end
	
	always @ (posedge clk) begin
		if(bf_kw != p_kw) begin
			if(cnt_db < delay_debounce) begin
				cnt_db <= cnt_db + 1;
			end
			else begin
				cnt_db <= 0;
				keyword <= p_kw;
				bf_kw <= p_kw;
			end
		end
	end
	
endmodule
