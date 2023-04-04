module key(
	input clk,
	input[3:0] LINE,
	output reg[3:0] COLLUMMN,
	output reg[3:0] keyword, output reg led
);
	
	parameter clk_machine = 50000000;
	parameter delay_debounce = clk_machine / 100;
	reg[25:0] cnt_clk = 0;
	
	parameter zero=4'd0, one=4'd1, two=4'd2, three=4'd3, four=4'd4, five=4'd5, six=4'd6, seven=4'd7, eight=4'd8, nine=4'd9, A=4'd10, B=4'd11, C=4'd12, D=4'd13, hashtag=4'd14, star=4'd15;
	
	reg[5:0] partial_keyword = 17;
	 
	always @ (*) begin
		if(~LINE[0] && LINE[1] && LINE[2] && LINE[3]) begin
			led <= 1;
			if(COLLUMMN[0]) partial_keyword <= one;
			else if(COLLUMMN[1]) partial_keyword <= two;
			else if(COLLUMMN[2]) partial_keyword <= three;
			else if(COLLUMMN[3]) partial_keyword <= A;
		end
		
		else if(LINE[0] && ~LINE[1] && LINE[2] && LINE[3]) begin
			led <= 0;
			if(COLLUMMN[0]) partial_keyword <= four;
			else if(COLLUMMN[1]) partial_keyword <= five;
			else if(COLLUMMN[2]) partial_keyword <= six;
			else if(COLLUMMN[3]) partial_keyword <= B;
		end
		
		else if(LINE[0] && LINE[1] && ~LINE[2] && LINE[3]) begin
			led <= 0;
			if(COLLUMMN[0]) partial_keyword <= seven;
			else if(COLLUMMN[1]) partial_keyword <= eight;
			else if(COLLUMMN[2]) partial_keyword <= nine;
			else if(COLLUMMN[3]) partial_keyword <= C;
		end
		
		else if(LINE[0] && LINE[1] && LINE[2] && ~LINE[3]) begin
			led <= 0;
			if(COLLUMMN[0]) partial_keyword <= star;
			else if(COLLUMMN[1]) partial_keyword <= zero;
			else if(COLLUMMN[2]) partial_keyword <= hashtag;
			else if(COLLUMMN[3]) partial_keyword <= D;
		end
		else begin
			partial_keyword <= 17;
			led <= 0;
		end
	end
	
	always @ (posedge clk) begin
		if(cnt_clk < delay_debounce) begin
			cnt_clk <= cnt_clk + 1;
		end
		else begin
			cnt_clk <= 0;
			if(partial_keyword != 17) begin
				//led <= 1;
				if(partial_keyword == one && COLLUMMN[0] && LINE[0]) keyword <= one;
				else if(partial_keyword == two && COLLUMMN[1] && LINE[0]) keyword <= two;
				else if(partial_keyword == three && COLLUMMN[2] && LINE[0]) keyword <= three;
				else if(partial_keyword == A && COLLUMMN[3] && LINE[0]) keyword <= A;
				
				else if(partial_keyword == four && COLLUMMN[0] && LINE[1]) keyword <= four;
				else if(partial_keyword == five && COLLUMMN[1] && LINE[1]) keyword <= five;
				else if(partial_keyword == six && COLLUMMN[2] && LINE[1]) keyword <= six;
				else if(partial_keyword == B && COLLUMMN[3] && LINE[1]) keyword <= B;
				
				else if(partial_keyword == seven && COLLUMMN[0] && LINE[2]) keyword <= seven;
				else if(partial_keyword == eight && COLLUMMN[1] && LINE[2]) keyword <= eight;
				else if(partial_keyword == nine && COLLUMMN[2] && LINE[2]) keyword <= nine;
				else if(partial_keyword == C && COLLUMMN[3] && LINE[2]) keyword <= C;
				
				else if(partial_keyword == star && COLLUMMN[0] && LINE[3]) keyword <= star;
				else if(partial_keyword == zero && COLLUMMN[1] && LINE[3]) keyword <= zero;
				else if(partial_keyword == hashtag && COLLUMMN[2] && LINE[3]) keyword <= hashtag;
				else if(partial_keyword == D && COLLUMMN[3] && LINE[3]) keyword <= D;
				
				else begin
					keyword <= 17;
					//led <= 0;
				end
			end
		end
	end
	
endmodule 