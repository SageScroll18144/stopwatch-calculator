module main(
	input clk,
	inout reg[2:0] tag1,
	output [31:0] seconds, 
	output signal,	
	output [0:6] display_centenas,
	output [0:6] display_dezenas,
	output [0:6] display_unidades,	
	output [0:6] display_m_seconds, 
	
	output [31:0] answer,
	
	output[3:0] LINE,
	input [3:0] COLLUMMN,
	output [3:0] keyword,
	inout[1:0] flag_pressed,
	output[31:0] In1,
	output[31:0] In2,
	output led1,
	output led2,
	output flag_answer,
	output [0:6] display_dezenas_rc,
	output [0:6] display_unidades_rc,
	output [0:6] display_dezenas_rc2,
	output [0:6] display_unidades_rc2
);
	
	reg[3:0] dezena_rc;
	reg[3:0] unidade_rc;
	reg[3:0] dezena_rc2;
	reg[3:0] unidade_rc2;
	
	reg modo;
	
	reg[3:0] centena;
	reg[3:0] dezena;
	reg[3:0] unidade;	
	reg[3:0] dec_seconds;
	
	reg [31:0] real_seconds;
	
	
	initial begin
		tag1 <= 0;
		real_seconds <= 0;
		modo = 0;
	end
	
	stopwatch(clk, tag1, seconds);
	keypad(clk, LINE, COLLUMMN, keyword, flag_pressed);
	read_cal(clk, keyword, flag_pressed, In1, In2, led1, led2);
	calculator(In1, In2, keyword, modo, answer, signal, flag_answer);
	
	always @ (posedge clk) begin
		if(~modo &&(keyword == 14 || keyword == 15)) modo <= 1; 
		else if(modo && keyword == 13) modo <= 0;
		
		if(modo == 0) begin
			
			dezena_rc <= 11;
			unidade_rc <= 11;
			dezena_rc2 <= 11;
			unidade_rc2 <= 11;
			
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
		if(modo == 1) begin
			dezena_rc <= In1 / 10;
			unidade_rc <= In1 % 10;
			dezena_rc2 <= In2 / 10;
			unidade_rc2 <= In2 % 10;
			
			if(~flag_answer) begin
				centena <= 11;
				dezena <= 11;
				unidade <= 11;
				dec_seconds <= 11;
			end
			
			else if(~signal) begin	
				centena <= answer / 1000;
				dezena <= (answer % 1000) / 100;
				unidade <= (answer % 100) / 10;
				dec_seconds <= answer % 10;
			end
			
			 else if(signal) begin
				centena <= 11;
				dezena <= 10;
				unidade <= (answer % 100) / 10;
				dec_seconds <= answer % 10;
			end
		end 
	end
	
	//modulo cronometro
	display(centena, display_centenas);
	display(dezena, display_dezenas);
	display(unidade, display_unidades);
	display(dec_seconds, display_m_seconds);
	
	//modulo calculadora
	display(dezena_rc, display_dezenas_rc);
	display(unidade_rc, display_unidades_rc);	
	
	display(dezena_rc2, display_dezenas_rc2);
	display(unidade_rc2, display_unidades_rc2);	
	
endmodule 
