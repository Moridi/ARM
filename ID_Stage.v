`include "Defines.v"

module ID_Stage(
	input clk,
	input rst,
	input[31:0] PC_in,
	input [`INSTRUCTION_LEN - 1 : 0] Instruction_in,
	output[31:0] PC
);

	wire[`EXECUTE_COMMAND_LEN - 1 : 0] execute_command;

	wire mem_read, mem_write,
		wb_enable, immediate,
		branch_taken, status_write_enable;
	
	ControlUnit control_unit(
		.mode(Instruction_in[27 : 26]), .opcode(Instruction_in[24 : 21]),
		.s(Instruction_in[20]), .immediate_in(Instruction_in[25]), .execute_command(execute_command),
		.mem_read(mem_read), .mem_write(mem_write),
		.wb_enable(wb_enable), .immediate(immediate),
		.branch_taken(branch_taken),
		.status_write_enable(status_write_enable));

	assign PC = PC_in;
endmodule