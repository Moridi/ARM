module RegisterToggle(clk, rst, in, out);

	parameter WORD_LENGTH = 1;
	input clk, rst;
	input[WORD_LENGTH - 1:0] in;
	output reg[WORD_LENGTH - 1:0] out;

	always@(posedge clk, posedge rst) 
	begin
		if (rst) out <= 0;
        else if (out == 1'b1) out <= 1'b0;
		else if (in == 1'b1) out <= 1'b1;
	end
	
endmodule