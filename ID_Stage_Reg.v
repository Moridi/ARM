module ID_Stage_Reg(
	input clk,
	input rst,
	input[31:0] PC_in,
	output reg[31:0] PC
);
	always @(clk, rst) PC <= PC_in;
endmodule
