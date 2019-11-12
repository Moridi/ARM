module Adder(in1, in2, out);

	parameter WORD_LENGTH = 32;
	input[WORD_LENGTH - 1:0] in1;
	input[WORD_LENGTH - 1:0] in2;
	output[WORD_LENGTH - 1:0] out;

	assign out = in1 + in2;	
	
endmodule
