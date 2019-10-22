`include "Defines.v"

module IF_Stage_Reg (
	input clk, rst, freeze, flush,
	input[`ADDRESS_LEN - 1:0] PC_in, Instruction_in,
	output reg[`INSTRUCTION_LEN - 1:0] PC, Instruction
);
	always @(posedge clk, posedge rst) begin
		PC <= PC_in;
		Instruction <= Instruction_in;
	end

endmodule