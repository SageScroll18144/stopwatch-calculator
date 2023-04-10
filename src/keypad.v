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
reg result [31:0] result;
reg sum;
reg espera;
parameter inicial = 4'd0, debounce = 4'd1, confirm = 4'd2, decode = 4'd3;

initial begin
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
			KeypadPress <= result;
			state <= inicial;
		end
	endcase
end

always @(*) begin
	if(state == decode) begin
		case(row)
		4'b0111: begin
			case(col)
			4'b0111: begin
				result = star;
			end
			4'b1011: begin
				result = zero;
			end
			4'b1101: begin
				result = hashtag;
			end
			4'b1110: begin
				result = D;
			end
			endcase
		4'b1011: begin
			case(col)
			4'b0111: begin
				result = seven;
			end
			4'b1011: begin
				result = eight;
			end
			4'b1101: begin
				result = nine;
			end
			4'b1110: begin
				result = C;
			end
			endcase
		end
		4'b1101: begin
			case(col)
			4'b0111: begin
				result = four;
			end
			4'b1011: begin
				result = five;
			end
			4'b1101: begin
				result = six;
			end
			4'b1110: begin
				result = B;
			end
			endcase
		end
		4'b1110: begin
			case(col)
			4'b0111: begin
				result = one;
			end
			4'b1011: begin
				result = two;
			end
			4'b1101: begin
				result = three;
			end
			4'b1110: begin
				result = A;
			end
			endcase
		end
		endcase
	end
end

always @ (posedge clk) begin
		case(row2)
			4'b0111: begin
				if(espera == 0) begin
					espera <= 1;
					end else begin
							espera <= 0;
							sum <= ~&col;
							if(state == inicial) begin
								if(~sum) begin
									row2 <= 4'b1011;
								end
							end
					end
				end
			4'b1011: begin
					if(espera == 0) begin
						espera <= 1;
						end else begin
							espera <= 0;
							sum <= ~&col;
							if(state == inicial) begin
								if(~sum) begin
									row2 <= 4'b1101;
								end
							end
						end
					end
			4'b1101: begin
					if(espera == 0) begin
						espera <= 1;
						end else begin
							espera <= 0;
							sum <= ~&col;
							if(state == inicial) begin
								if(~sum) begin
									row2 <= 4'b1110;
								end
							end
						end
					end
			4'b1110: begin
					if(espera == 0) begin
						espera <= 1;
						end else begin
							espera <= 0;
							sum <= ~&col;
							if(state == inicial) begin
								if(~sum) begin
									row2 <= 4'b0111;
								end
							end
						end
					end
		endcase
end
endmodule
