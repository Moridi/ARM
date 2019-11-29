`include "Defines.v"

module IF_Stage_Reg (
	input clk, rst, freeze, flush,
	input[`ADDRESS_LEN - 1:0] PC_in, Instruction_in,
	output wire[`ADDRESS_LEN - 1:0] PC, Instruction
);

Register_Flush #(.WORD_LENGTH(`ADDRESS_LEN)) reg_PC_in(.clk(clk), .rst(rst), .flush(flush),
		.ld(~freeze), .in(PC_in), .out(PC));

Register_Flush #(.WORD_LENGTH(`ADDRESS_LEN)) reg_Instruction(.clk(clk), .rst(rst), .flush(flush),
		.ld(~freeze), .in(Instruction_in), .out(Instruction));

endmodule