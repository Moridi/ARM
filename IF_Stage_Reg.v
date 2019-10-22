module IF_Stage_Reg (
	input clk, rst, freeze, flush,
	input[31:0] PC_in, Instruction_in,
	output reg[31:0] PC, Instruction
);
	always @(clk, rst) begin
		PC <= PC_in;
		Instruction <= Instruction_in;
	end

endmodule