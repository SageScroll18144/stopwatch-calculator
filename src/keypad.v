module keypad(
	 input clk,
    output reg [3:0] row,
    input [3:0] col,
    output reg [31:0] KeypadPress
);
	parameter zero = 4'd0, one = 4'd1, two = 4'd2, three = 4'd3, four = 4'd4, five = 4'd5, six = 4'd6, seven = 4'd7, eight = 4'd8, nine = 4'd9, A = 4'd10, B = 4'd11, C = 4'd12, D = 4'd13, hashtag = 4'd14, star = 4'd15;
	parameter clock_freq = 50000000;
	parameter debounce_time = clock_freq/100;
	
	reg[31:0] cnt_clk = 0;
	reg[31:0] cnt_it = 0;
	
	
	always @ (posedge clk) begin
		if(cnt_clk < debounce_time) begin
			cnt_clk <= cnt_clk + 1;
		end
		else begin
			cnt_clk <= 0;
		
			if(cnt_it == 0) row <= 4'b0111;
			else if(cnt_it == 1) row <= 4'b1011;
			else if(cnt_it == 2) row <= 4'b1101;
			else if(cnt_it == 3) row <= 4'b1110;
			
			if(cnt_it >= 3) cnt_it <= 0;
			else cnt_it <= cnt_it + 1;
			
			if(~&col) begin
				if(~row[0] && ~col[0]) KeypadPress <= one;
				else if(~row[0] && ~col[1]) KeypadPress <= two;
				else if(~row[0] && ~col[2]) KeypadPress <= three;
				else if(~row[0] && ~col[3]) KeypadPress <= A;
				
				else if(~row[1] && ~col[0]) KeypadPress <= four;
				else if(~row[1] && ~col[1]) KeypadPress <= five;
				else if(~row[1] && ~col[2]) KeypadPress <= six;
				else if(~row[1] && ~col[3]) KeypadPress <= B;
				
				else if(~row[2] && ~col[0]) KeypadPress <= seven;
				else if(~row[2] && ~col[1]) KeypadPress <= eight;
				else if(~row[2] && ~col[2]) KeypadPress <= nine;
				else if(~row[2] && ~col[3]) KeypadPress <= C;
				
				else if(~row[3] && ~col[0]) KeypadPress <= star;
				else if(~row[3] && ~col[1]) KeypadPress <= zero;
				else if(~row[3] && ~col[2]) KeypadPress <= hashtag;
				else if(~row[3] && ~col[3]) KeypadPress <= D;  
			end
		end 
		
	end
	
endmodule 
