`include "Defines.v"

module EX_Stage_Module(
    //inputs to main moduel:
    input clk, rst,
	input[`ADDRESS_LEN - 1:0] PC_in,
	input wb_en_in, mem_r_en_in, mem_w_en_in, status_w_en_in, branch_taken_in,
	input immd,
	input [`EXECUTE_COMMAND_LEN - 1:0] exe_cmd,
	input [`REGISTER_LEN - 1:0] val_Rn, val_Rm_in,
	input [`REG_ADDRESS_LEN - 1:0] dest_in,
	input [23:0] signed_immd_24,
	input [11:0] shift_operand,
	input [3:0] status_reg_in,

    // outputs from Reg:
    output wb_en_out, mem_r_en_out, mem_w_en_out,
	output [`REGISTER_LEN - 1:0] alu_res_out, val_Rm_out,
	output [`REG_ADDRESS_LEN - 1:0] dest_out,

    //outputs from main module:
    output wb_en_hazard_in,
    output [`REG_ADDRESS_LEN - 1:0] dest_hazard_in,
	output status_w_en_out, branch_taken_out,
	output [3:0] statusRegister_out,
	output[`ADDRESS_LEN - 1:0] branch_address_out
);


	wire wb_en_middle, mem_r_en_middle, mem_w_en_middle;
	wire [`REGISTER_LEN - 1:0] alu_res_middle, val_Rm_middle;
	wire [`REG_ADDRESS_LEN - 1:0] dest_middle;

    assign wb_en_hazard_in = wb_en_in;
    assign dest_hazard_in = dest_in;

    EX_Stage ex_stage(
        // inputs:
            .clk(clk),
            .rst(rst),
            .PC_in(PC_in),
            .wb_en_in(wb_en_in),
            .mem_r_en_in(mem_r_en_in),
            .mem_w_en_in(mem_w_en_in),
            .status_w_en_in(status_w_en_in),
            .branch_taken_in(branch_taken_in),
            .immd(immd),
            .exe_cmd(exe_cmd),
            .val_Rn(val_Rn),
			.val_Rm_in(val_Rm_in),
            .dest_in(dest_in),
            .signed_immd_24(signed_immd_24),
            .shift_operand(shift_operand),
			.status_reg_in(status_reg_in),
        
        // outputs to Reg:
            .wb_en_out(wb_en_middle),
            .mem_r_en_out(mem_r_en_middle),
            .mem_w_en_out(mem_w_en_middle),
            .dest_out(dest_middle),
            .alu_res(alu_res_middle),
            .val_Rm_out(val_Rm_middle),

        // outputs:
            .status_w_en_out(status_w_en_out),
            .branch_taken_out(branch_taken_out),
            .statusRegister(statusRegister_out),
            .branch_address(branch_address_out)
	);

    EX_Stage_Reg ex_stage_reg(
        // inputs:
            .clk(clk),
            .rst(rst),
	        .wb_en_in(wb_en_middle),
            .mem_r_en_in(mem_r_en_middle),
            .mem_w_en_in(mem_w_en_middle),
	        .alu_res_in(alu_res_middle),
            .val_Rm_in(val_Rm_middle),
	        .dest_in(dest_middle),
        // outputs:
            .wb_en_out(wb_en_out),
            .mem_r_en_out(mem_r_en_out),
            .mem_w_en_out(mem_w_en_out),
            .alu_res_out(alu_res_out),
            .val_Rm_out(val_Rm_out),
            .dest_out(dest_out)
        );
	
endmodule
