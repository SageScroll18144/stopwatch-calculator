module main(
	input clk,
	output [31:0] seconds, 
	output [0:6] display_centenas,
	output [0:6] display_dezenas,
	output [0:6] display_unidades,	
	output [0:6] display_m_seconds, 

	input[3:0] LINE,
	output reg[3:0] COLLUMMN,
	output reg[3:0] keyword
);
	
	stopwatch(clk, seconds);
	keypad(clk, LINE, COLLUMMN, keyword);
	
	reg[3:0] centena;
	reg[3:0] dezena;
	reg[3:0] unidade;	
	reg[3:0] dec_seconds;
	
	always @ (*) begin
		centena <= seconds / 1000;
		dezena <= (seconds % 1000) / 100;
		unidade <= (seconds % 100) / 10;
		dec_seconds <= seconds % 10;
	end
	
	display(centena, display_centenas);
	display(dezena, display_dezenas);
	display(unidade, display_unidades);
	display(dec_seconds, display_m_seconds);
	//modulo keypad
	
	//modulo cronometro
	
	//modulo calculadora
	
endmodule 