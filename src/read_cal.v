module read_cal(
	input clk,
	input[31:0] number,
	input[1:0] pressed, 
	output reg [31:0] In1
);
	
	reg[1:0] flag;
	reg[1:0] cnt_click;
	
	initial begin
		flag = pressed;
		cnt_click = 0;
		In1 = 0;
	end
		
	always @ (posedge clk) begin
		if(flag != pressed && cnt_click == 0) begin
			cnt_click <= cnt_click + 1;
			In1 <= 10 * number;
		end
		
		else if(flag == pressed && cnt_click == 1) begin
			cnt_click <= 0;
			In1 <= In1 + number;
		end
		
	end
		
endmodule 