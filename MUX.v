module MUX_2_to_1(first, second, sel_first, sel_second, out);
  
	parameter WORD_LENGTH = 32;
	input[WORD_LENGTH - 1:0] first, second;
	input sel_first, sel_second;
	output[WORD_LENGTH - 1:0] out;
	
	assign out = sel_first ? first : (sel_second ? second : out); 
	
endmodule
