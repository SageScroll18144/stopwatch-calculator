module keypad(
	input clk,
	input[3:0] LINE,
	input[3:0] COLLUMMN,
	output reg[3:0] keyword
);
	
	reg[2:0] flag_line = 3'd7;
	reg[2:0] flag_collumn = 3'd7;
	// reg[1:0] before_flag_line = -1;
	// reg[1:0] before_flag_collumn = -1;
	
	parameter clk_machine = 50000000;
	parameter delay_debounce = clk_machine / 100;
	reg[25:0] cnt_clk = 0;
	
	parameter zero=4'd0, one=4'd1, two=4'd2, three=4'd3, four=4'd4, five=4'd5, six=4'd6, seven=4'd7, eight=4'd8, nine=4'd9, A=4'd10, B=4'd11, C=4'd12, D=4'd13, hashtag=4'd14, star=4'd15;
	
	reg[3:0] mat_ans[0:3][0:3];
	
	initial begin
		mat_ans[0][0] = one;
		mat_ans[0][1] = two;
		mat_ans[0][2] = three;
		mat_ans[0][3] = A;
		
		mat_ans[1][0] = four;
		mat_ans[1][1] = five;
		mat_ans[1][2] = six;
		mat_ans[1][3] = B;
		
		mat_ans[2][0] = seven;
		mat_ans[2][1] = eight;
		mat_ans[2][2] = nine;
		mat_ans[2][3] = C;
		
		mat_ans[3][0] = star;
		mat_ans[3][1] = zero;
		mat_ans[3][2] = hashtag;
		mat_ans[3][3] = D;
	end
	
	always @ (posedge clk) begin
		if(~LINE[0] & 1) flag_line = 3'd0;
		else if(~LINE[1] & 1) flag_line = 3'd1;
		else if(~LINE[2] & 1) flag_line = 3'd2;
		else if(~LINE[3] & 1) flag_line = 3'd3;
		else flag_line = 3'd7;
		
		if(~COLLUMMN[0] & 1) flag_collumn = 3'd0;
		else if(~COLLUMMN[1] & 1) flag_collumn = 3'd1;
		else if(~COLLUMMN[2] & 1) flag_collumn = 3'd2;
		else if(~COLLUMMN[3] & 1) flag_collumn = 3'd3;
		else flag_collumn = 3'd7;
		
		// if(before_flag_line != flag_line) before_flag_line = flag_line;
		// if(before_flag_collumn != flag_collumn) before_flag_collumn = flag_collumn;		
	end
	
	always @ (posedge clk) begin
		if(flag_line != 3'd7 && flag_collumn != 3'd7) begin
			if(cnt_clk < delay_debounce) cnt_clk <= cnt_clk + 1;
			else begin
				keyword <= mat_ans[flag_line][flag_collumn];
				cnt_clk <= 26'd0;
			end
		end
	end
	
	
endmodule 