module calculator(
	input [6:0] In1,
	input [6:0] In2, 
	input [3:0] keyboard, 
	output reg [31:0] answer, 
	output reg signal
); 
	
	initial begin 
		answer = 0; 
		signal = 0;
	end 
	
	parameter A = 4'd10, B = 4'd11, C = 4'd12, D = 4'd13;
	
	always @ (*) begin
	
		if(keyboard == A) begin 
			answer <= In1 + In2; 
			signal <= 0; 
		end 
		else if(keyboard == B) begin 
			if(In2 > In1) begin
				answer <= In2 - In1; 
				signal <= 1
			end
			
			else begin 
				answer <= In1 - In2;
				signal <= 0;
			end 
		end 
		else if(keyboard == C) begin 
			answer <=  In1 * In2; 
			signal <= 0; 
		end 
		if(keyboard == D) begin
			answer <= 0;
			signal <= 0; 
		end 
			
	end
	
endmodule 
