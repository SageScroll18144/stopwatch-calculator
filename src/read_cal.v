module read_cal(
	input clk,
	input[31:0] number,
	input [1:0] pressed,
	output reg [31:0] In1,
	output reg [31:0] In2,
	output reg led1,
	output reg led2
);
	reg flag_enter1;
	reg flag_enter2;
	reg flagIn2;
	reg[31:0] cnt = 0;
	parameter delay_time = 3;
	
	initial begin
		flag_enter1 = 0;
		flag_enter2 = 0;
		flagIn2 = 0;
		In1 = 0;
		led1 = 0;
		led2 = 0;
	end
		
	always @ (posedge pressed) begin
		if(cnt < delay_time) begin
			cnt <= cnt + 1;
		end
		else begin 
			cnt <= 0;
		
			if(~flag_enter1 && number < 10) begin
				if(~flagIn2) In1 <= 10 * number;
				else In2 <= 10 * number;
				flag_enter1 <= 1;
			end
			
			else if(~flag_enter2 && flag_enter1 && number < 10) begin
				if(~flagIn2) In1 <= In1 + number;
				else In2 <= In2 + number;
				flag_enter2 <= 1;
			end
			
			else if(number == 15) begin
				flag_enter1 <= 0;
				flag_enter2 <= 0;
				led1 <= 1;
				led2 <= 0;
				flagIn2 <= 0;
				In1 <= 0;
			end
			
			else if(number == 14) begin
				flag_enter1 <= 0;
				flag_enter2 <= 0;
				led1 <= 0;
				led2 <= 1;
				flagIn2 <= 1;
				In2 <= 0;
			end
		end
	end
		
endmodule  
