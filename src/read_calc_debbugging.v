module read_cal(
	input clk,
	input[31:0] number,
	input [1:0] pressed,
	output reg [31:0] In1
);
	reg flag_enter1;
	reg flag_enter2;
	
	initial begin
		flag_enter1 = 0;
		flag_enter2 = 0;
		In1 = 0;
	end
		
	always @ (posedge pressed) begin
		if(~flag_enter1) begin
			In1 <= 10 * number;
			flag_enter1 <= 1;
		end
		
		else if(~flag_enter2 && flag_enter1) begin
			In1 <= In1 + number;
			flag_enter2 <= 1;
		end
	end
		
endmodule 
