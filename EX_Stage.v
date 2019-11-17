`include "Defines.v"

module EX_Stage(
	input clk, rst,
	input[`ADDRESS_LEN - 1:0] PC_in,
	input wb_en_in, mem_r_en_in, mem_w_en_in, status_w_en_in, branch_taken_in,
	input immd,
	input [`EXECUTE_COMMAND_LEN - 1:0] exe_cmd,
	input [`REGISTER_LEN - 1:0] val_Rn, val_Rm_in,
	input [`REG_ADDRESS_LEN - 1:0] dest_in,
	input [23:0] signed_immd_24,
	input [11:0] shift_operand,

	// output[`ADDRESS_LEN - 1:0] PC_out,
	output wb_en_out, mem_r_en_out, mem_w_en_out, status_w_en_out, branch_taken_out,
	output [`REG_ADDRESS_LEN - 1:0] dest_out,
	output [`REGISTER_LEN - 1:0] alu_res, val_Rm_out,
	output [3:0] statusRegister,
	output[`ADDRESS_LEN - 1:0] branch_address
);
	wire is_mem_command;
	wire [`REGISTER_LEN - 1:0] val2;

	// @TODO: Check it out
	// assign PC_out = PC_in;
	assign wb_en_out = wb_en_in;
	assign mem_r_en_out = mem_r_en_in;
	assign mem_w_en_out = mem_w_en_in;
	assign status_w_en_out = status_w_en_in;
	assign branch_taken_out = branch_taken_in;
	assign val_Rm_out = val_Rm_in;
	assign dest_out = dest_in;

	assign is_mem_command = mem_r_en_in | mem_r_en_in;

	// branch_address = PC_in + signed_immd_24;
	Adder #(.WORD_LENGTH(`ADDRESS_LEN)) adder(.in1(PC_in), .in2({8'b0, signed_immd_24[23:2], 2'b0}),
			.out(branch_address)
	);
	
	Val2Generator val2_generator(.Rm(val_Rm_in), .shift_operand(shift_operand), .immd(immd),
			.is_mem_command(is_mem_command), .val2_out(val2)
	);

	// @TODO: Check the cin port
	ALU alu(.alu_in1(val_Rn), .alu_in2(val2), .alu_command(exe_cmd), .cin(1'b0),
			.alu_out(alu_res), .statusRegister(statusRegister)
	);

endmodule
