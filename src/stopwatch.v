module stopwatch(input clk, output reg[31:0] seconds, output reg[31:0] m_seconds);
	
	initial begin
		seconds = 0;
		m_seconds = 0;
	end	
	
	parameter clk_machine = 50000000;
	reg[31:0] sec_cnt = 0;
	reg[31:0] m_sec_cnt = 0;	
	
	always @ (posedge clk) begin
		if(sec_cnt < clk_machine) begin
			sec_cnt <= sec_cnt + 1;
		end
		else begin 
			sec_cnt <= 0;
			seconds <= seconds + 1;
		end
		
		if(seconds > 999) begin
			seconds <= 0;
		end
	end
	
	always @ (posedge clk) begin
		if(m_sec_cnt < clk_machine / 100) begin
			m_sec_cnt <= m_sec_cnt + 1;
		end
		else begin 
			m_sec_cnt <= 0;
			m_seconds <= m_seconds + 1;
		end
		
		if(m_seconds > 9) begin
			m_seconds <= 0;
		end
		
	end
	
endmodule 