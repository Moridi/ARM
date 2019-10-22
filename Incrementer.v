module Incrementer(in, out);

	parameter WORD_LENGTH = 32;
	input[WORD_LENGTH - 1:0] in;
	output[WORD_LENGTH - 1:0] out;

	assign out = in + 1;	
	
endmodule
