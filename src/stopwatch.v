module stopwatch(input clk, input[2:0] tag1, output reg[31:0] seconds);
	
	initial begin
		seconds = 0;
	end	
	
	parameter clk_machine = 50000000;
	reg[31:0] sec_cnt = 0;
	reg[3:0] m_sec_cnt = 0;	
	
	always @ (posedge clk) begin
		if(tag1 == 1) begin
			if(sec_cnt < clk_machine / 10) begin
				sec_cnt <= sec_cnt + 1;
			end
			else begin 
				sec_cnt <= 0;
				seconds <= seconds + 1;
			end
			
			if(seconds > 9999) begin
				seconds <= 0;
			end
		end
		else if(tag1 == 2) begin
			seconds <= 0;
		end
	end
endmodule 
