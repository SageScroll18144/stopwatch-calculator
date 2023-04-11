module main(
	input clk,
	inout reg[2:0] tag1,
	output [31:0] seconds, 
	output [0:6] display_centenas,
	output [0:6] display_dezenas,
	output [0:6] display_unidades,	
	output [0:6] display_m_seconds, 

	output[3:0] LINE,
	input [3:0] COLLUMMN,
	output [3:0] keyword
);
	
	reg[3:0] centena;
	reg[3:0] dezena;
	reg[3:0] unidade;	
	reg[3:0] dec_seconds;
	
	reg [31:0] real_seconds;
	
	initial begin
		tag1 <= 1;
		real_seconds <= 0;
	end
	
	stopwatch(clk, tag1, seconds);
	keypad(clk, LINE, COLLUMMN, keyword);
	
	always @ (posedge clk) begin
		if(keyword == 11) begin
			tag1 <= 1;
			real_seconds <= seconds; 
		end
		else if(keyword == 10) begin
			real_seconds <= 0;
			tag1 <= 2;
		end
		else if(keyword == 12) begin
			tag1 <= 1;
		end
		else if(keyword == 13) begin
			tag1 <= 0;
		end
	
		centena <= real_seconds / 1000;
		dezena <= (real_seconds % 1000) / 100;
		unidade <= (real_seconds % 100) / 10;
		dec_seconds <= real_seconds % 10;
	end
	
	display(centena, display_centenas);
	display(dezena, display_dezenas);
	display(unidade, display_unidades);
	display(dec_seconds, display_m_seconds);
	//modulo keypad
	
	//modulo cronometro
	
	//modulo calculadora
	
endmodule 
