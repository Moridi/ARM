module Register(clk, rst, ld, in, out);

	parameter WORD_LENGTH = 32;
	input clk, rst, ld;
	input[WORD_LENGTH - 1:0] in;
	output reg[WORD_LENGTH - 1:0] out;
 
	always@(posedge clk, posedge rst) 
	begin
		if (ld) out <= in;
		if (rst) out <= 0;
	end
	
endmodule