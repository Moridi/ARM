`include "Defines.v"

module ARM(input clk, rst);

	// ########## IF Stage ##########

	wire freeze, Branch_taken, flush;
	wire[`ADDRESS_LEN - 1:0] branch_address;
	wire[`ADDRESS_LEN - 1:0] PC_IF, PC_ID;
								
	wire[`INSTRUCTION_LEN - 1:0] Instruction_IF;
	
	assign Branch_taken = 1'b0;
	assign freeze = 1'b0;
	assign branch_address = `ADDRESS_LEN'b0;
	assign flush = 1'b0;
	
	IF_Stage_Module IF_Stage_Module(
		// inputs:
			.clk(clk), .rst(rst),
			.freeze_in(freeze),
			.Branch_taken_in(Branch_taken),
			.flush_in(flush),
			.BranchAddr_in(branch_address),

		//outputs from reg:
			.PC_out(PC_IF),
			.Instruction_out(Instruction_IF)
	);
			
			
	// ########## ID Stage ##########
	wire two_src;
	wire [`REG_ADDRESS_LEN - 1:0] reg_file_second_src_out;
	
	wire mem_read_ID_out, mem_write_ID_out,
		wb_enable_ID_out, immediate_ID_out,
		branch_taken_ID_out, status_write_enable_ID_out;
		
	wire [`EXECUTE_COMMAND_LEN - 1 : 0] execute_command_ID_out;
	wire [`REGISTER_LEN - 1:0] reg_file_ID_out1, reg_file_ID_out2;
	wire [`REG_ADDRESS_LEN - 1:0] dest_reg_ID_out;
	wire [`SIGNED_IMMEDIATE_LEN - 1:0] signed_immediate_ID_out;
	wire [`SHIFT_OPERAND_LEN - 1:0] shift_operand_ID_out;
	
	wire wb_enable_WB_out;	
	wire [`REG_ADDRESS_LEN - 1:0] wb_dest_WB_out;
	wire [`REGISTER_LEN - 1:0] wb_value_WB;
				
	ID_Stage_Module ID_Stage_Module(
		// Inputs:
			.clk(clk), .rst(rst), .PC_in(PC_IF),
			.Instruction_in(Instruction_IF),

		// Register file inputs:
			.reg_file_wb_data(wb_value_WB),
			.reg_file_wb_address(wb_dest_WB_out),
			.reg_file_wb_en(wb_enable_WB_out),

		// Wired Outputs:
			.two_src_out(two_ID_out),
			.reg_file_second_src_out(reg_file_second_src_out),

		// Registered Outputs:
			.PC_out(PC_ID),
			.mem_read_en_out(mem_read_ID_out),
			.mem_write_en_out(mem_write_ID_out),
			.wb_enable_out(wb_enable_ID_out),
			.immediate_out(immediate_ID_out),
			.branch_taken_out(branch_taken_ID_out),
			.status_write_enable_out(status_write_enable_ID_out),		
			.execute_command_out(execute_command_ID_out),
			.reg_file_out1(reg_file_ID_out1),
			.reg_file_out2(reg_file_ID_out2),
			.dest_reg_out(dest_reg_ID_out),
			.signed_immediate_out(signed_immediate_ID_out),
			.shift_operand_out(shift_operand_ID_out)
		);

	// ########## EXE Stage ##########
    wire wb_enable_EXE_out, mem_read_EXE_out, mem_write_EXE_out;
	wire [`REGISTER_LEN - 1:0] alu_res_EXE_out, val_Rm_EXE_out;
	wire [`REG_ADDRESS_LEN - 1:0] dest_EXE_out;

    wire wb_en_hazard_EXE_out;
    wire [`REG_ADDRESS_LEN - 1:0] dest_hazard_EXE_out;
	wire status_w_en_out, branch_taken_out;
	wire [3:0] statusRegister_out;
			
	EX_Stage_Module EX_Stage_Module(
		//inputs to main moduel:
			.clk(clk), .rst(rst),
			.PC_in(PC_ID),
			.wb_en_in(wb_enable_ID_out), .mem_r_en_in(mem_read_ID_out),
			.mem_w_en_in(mem_write_ID_out),
			.status_w_en_in(status_write_enable_ID_out),
			.branch_taken_in(branch_taken_ID_out),
			.immd(immediate_ID_out),
			.exe_cmd(execute_command_ID_out),
			.val_Rn(reg_file_ID_out1),
			.val_Rm_in(reg_file_ID_out2),
			.dest_in(dest_reg_ID_out),
			.signed_immd_24(signed_immediate_ID_out),
			.shift_operand(shift_operand_ID_out),

		// outputs from Reg:
			.wb_en_out(wb_enable_EXE_out),
			.mem_r_en_out(mem_read_EXE_out),
			.mem_w_en_out(mem_write_EXE_out),
			.alu_res_out(alu_res_EXE_out),
			.val_Rm_out(val_Rm_EXE_out),
			.dest_out(dest_EXE_out),

		//outputs from main module:
			.wb_en_hazard_in(wb_en_hazard_EXE_out),
			.dest_hazard_in(dest_hazard_EXE_out),
			.status_w_en_out(status_w_en_out),
			.branch_taken_out(branch_taken_out),
			.statusRegister_out(statusRegister_out),
			.branch_address_out(branch_address)
	);
	
	
	// ########## MEM Stage ##########
	wire wb_en_MEM_out, mem_r_en_MEM_out;
	wire [`REGISTER_LEN - 1:0] alu_res_MEM_out, mem_res_MEM_out;
	wire [`REG_ADDRESS_LEN - 1:0] dest_MEM_out;

	wire wb_en_hazard_MEM_out;
	wire [`REG_ADDRESS_LEN - 1:0] dest_hazard_MEM_out;
	
	MEM_Stage_Module MEM_Stage_Module(
		//inputs to main moduel:
			.clk(clk), .rst(rst),
			.wb_en_in(wb_enable_EXE_out),
			.mem_r_en_in(mem_read_EXE_out),
			.mem_w_en_in(mem_write_EXE_out),
			.alu_res_in(alu_res_EXE_out), .val_Rm(val_Rm_EXE_out),
			.dest_in(dest_EXE_out),

		// outputs from Reg:
			.wb_en_out(wb_en_MEM_out), .mem_r_en_out(mem_r_en_MEM_out),
			.alu_res_out(alu_res_MEM_out), .mem_res_out(mem_res_MEM_out),
			.dest_out(dest_MEM_out),

		//outputs from stage:
			.wb_en_hazard_in(wb_en_hazard_MEM_out),
			.dest_hazard_in(dest_hazard_MEM_out)
	);

	// ########## WB Stage ##########		
	WB_Stage WB_Stage(
		// inputs:
			.clk(clk),
			.rst(rst),
			.mem_read_enable(mem_r_en_MEM_out),
			.wb_enable_in(wb_en_MEM_out),
			
			.alu_result(alu_res_MEM_out),
			.data_memory(mem_res_MEM_out),
			.wb_dest_in(dest_MEM_out),
		
		// outputs:
			.wb_enable_out(wb_enable_WB_out),
			
			.wb_dest_out(wb_dest_WB_out),
			.wb_value(wb_value_WB)
	);
	

endmodule