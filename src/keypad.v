module keypad(
	 input clk,
    output [3:0] row,
    input [3:0] col,
    output reg [31:0] KeypadPress
);
parameter zero = 4'd0, one = 4'd1, two = 4'd2, three = 4'd3, four = 4'd4, five = 4'd5, six = 4'd6, seven = 4'd7, eight = 4'd8, nine = 4'd9, A = 4'd10, B = 4'd11, C = 4'd12, D = 4'd13, hashtag = 4'd14, star = 4'd15;
parameter clock_freq = 50000000;
parameter debounce_time = clock_freq/100;
reg [31:0] counter;
reg [3:0] state;
reg [3:0] row2;
reg [15:0] vector = 4'hFFFF; // hexadecimal pra tudo 1
reg sum;
reg espera;
parameter inicial = 4'd0, debounce = 4'd1, confirm = 4'd2, decode = 4'd3;

initial begin
	KeypadPress = 0;
	row2 = 4'b0111;
	espera = 0;
end

assign row[0] = row2[0];
assign row[1] = row2[1];
assign row[2] = row2[2];
assign row[3] = row2[3];

always @(posedge clk) begin
	case(state)
		inicial: begin
			if(sum) begin
				state <= debounce;
			end
		end
		debounce: begin
			if(counter != debounce_time) begin
				counter <= counter + 1;
			end
			else begin
				state <= confirm;
				counter <= 0;
			end
		end
		confirm: begin
			if(sum) begin
				state <= decode;
			end
			else begin
				state <= inicial;
			end
		end
		decode: begin
			state <= inicial;
		end
	endcase
end

always @(*) begin
	if(state == decode) begin
		if(~vector[12]) KeypadPress = one;
		else if(~vector[13]) KeypadPress = two;
		else if(~vector[14]) KeypadPress = three;
		else if(~vector[15]) KeypadPress = A;
		else if(~vector[8]) KeypadPress = four;
		else if(~vector[9]) KeypadPress = five;
		else if(~vector[10]) KeypadPress = six;
		else if(~vector[11]) KeypadPress = B;
		else if(~vector[4]) KeypadPress = seven;
		else if(~vector[5]) KeypadPress = eight;
		else if(~vector[6]) KeypadPress = nine;
		else if(~vector[7]) KeypadPress = C;
		else if(~vector[0]) KeypadPress = star;
		else if(~vector[1]) KeypadPress = zero;
		else if(~vector[2]) KeypadPress = hashtag;
		else if(~vector[3]) KeypadPress = D;
	end
end

always @ (posedge clk) begin
		case(row2)
			4'b0111: begin
				if(espera == 0) begin
					espera <= 1;
					end else begin
						espera <= 0;
						vector[3:0] <= col;
						row2 <= 4'b1011;
					end
				end
			4'b1011: begin
					if(espera == 0) begin
						espera <= 1;
						end else begin
							espera <= 0;
							vector[7:4] <= col;
							row2 <= 4'b1101;
						end
					end
			4'b1101: begin
					if(espera == 0) begin
						espera <= 1;
						end else begin
							espera <= 0;
							vector[11:8] <= col;
							row2 <= 4'b1110;
						end
					end
			4'b1110: begin
					if(espera == 0) begin
						espera <= 1;
						end else begin
							espera <= 0;
							vector[15:12] <= col;
							sum = ~&vector;
							row2 <= 4'b0111;
						end
					end
		endcase
end
endmodule
 
