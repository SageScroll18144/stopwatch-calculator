module keypad(
	input clk,
	input[3:0] L,
	input[3:0] C,
	output reg[3:0] keyword
);
	
	reg[3:0] state = -1;
	reg[3:0] before_state = -1;
	
	always @ (*) begin
		if(~L[0] && ~C[0]) begin
			state = 1;
		end
		else if(~L[0] && ~C[1]) begin
			state = 2;
		end
		else if(~L[0] && ~C[2]) begin
			state = 3;
		end
		else if(~L[0] && ~C[3]) begin
			state = 65;//A ascii code
		end
		else if(~L[1] && ~C[0]) begin
			state = 4;
		end
		else if(~L[1] && ~C[1]) begin
			state = 5;
		end
		else if(~L[1] && ~C[2]) begin
			state = 6;
		end
		else if(~L[1] && ~C[3]) begin
			state = 66;//B ascii code
		end
		else if(~L[2] && ~C[0]) begin
			state = 7;
		end
		else if(~L[2] && ~C[1]) begin
			state = 8;
		end
		else if(~L[2] && ~C[2]) begin
			state = 9;
		end
		else if(~L[2] && ~C[3]) begin
			state = 67;//C ascii code
		end
		else if(~L[3] && ~C[0]) begin
			state = 42;//* ascii code
		end
		else if(~L[3] && ~C[1]) begin
			state = 0;
		end
		else if(~L[3] && ~C[2]) begin
			state = 35;
		end
		else if(~L[3] && ~C[3]) begin
			state = 68;
		end
		else begin
			state = -1;
		end
	end

	parameter clk_machine = 500000;//10ms, after converting
	reg[31:0] cnt_clk = 0;
	reg[3:0] curr_state;
	always @ (posedge clk) begin
		if(cnt_clk == 0) begin
			curr_state = state;
		end
	
		if(cnt_clk < clk_machine) begin
			cnt_clk = cnt_clk + 1;
		end
		else begin
			cnt_clk = 0;
			if(state != -1 && state != before_state && state == curr_state) begin
				keyword <= state;
				before_state <= state;
			end
		end
	end
	
endmodule 