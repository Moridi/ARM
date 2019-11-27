`include "Defines.v"

module ARM(input clk, rst);

	// ##############################				
	// ########## IF Stage ##########
	// ##############################				

	wire branch_taken_EXE_out;
	wire hazard_detected, flush;
	wire[`ADDRESS_LEN - 1:0] branch_address;
	wire[`ADDRESS_LEN - 1:0] PC_IF, PC_ID;
								
	wire[`INSTRUCTION_LEN - 1:0] Instruction_IF;
	
	assign flush = branch_taken_EXE_out;
	
	IF_Stage_Module IF_Stage_Module(
		// inputs:
			.clk(clk), .rst(rst),
			.freeze_in(hazard_detected),
			.Branch_taken_in(branch_taken_EXE_out),
			.flush_in(flush),
			.BranchAddr_in(branch_address),

		//outputs from reg:
			.PC_out(PC_IF),
			.Instruction_out(Instruction_IF)
	);	
			
	// ##############################				
	// ########## ID Stage ##########
	// ##############################				
	wire ID_two_src;
	wire [`REG_ADDRESS_LEN - 1:0] reg_file_second_src_out, reg_file_first_src_out;
	wire [3:0] status_reg_ID_out;
	
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
	wire[3:0] status_reg_ID_in;
				
	ID_Stage_Module ID_Stage_Module(
		// Inputs:
			.clk(clk), .rst(rst), .PC_in(PC_IF),
			.Instruction_in(Instruction_IF),
			.status_reg_in(status_reg_ID_in),
			.hazard(hazard_detected),
			.flush(flush),

		// Register file inputs:
			.reg_file_wb_data(wb_value_WB),
			.reg_file_wb_address(wb_dest_WB_out),
			.reg_file_wb_en(wb_enable_WB_out),

		// Wired Outputs:
			.two_src_out(ID_two_src),
			.reg_file_second_src_out(reg_file_second_src_out),
			.reg_file_first_src_out(reg_file_first_src_out),

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
			.shift_operand_out(shift_operand_ID_out),
			.status_reg_out(status_reg_ID_out)
		);

	// ###############################				
	// ########## EXE Stage ##########
	// ###############################	

    wire wb_enable_EXE_out, mem_read_EXE_out, mem_write_EXE_out;
	wire [`REGISTER_LEN - 1:0] alu_res_EXE_out, val_Rm_EXE_out;
	wire [`REG_ADDRESS_LEN - 1:0] dest_EXE_out;

    wire wb_en_hazard_EXE_out;
    wire [`REG_ADDRESS_LEN - 1:0] dest_hazard_EXE_out;
	wire status_w_en_EXE_out;
	wire [3:0] status_reg_EXE_out;
			
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
			.status_reg_in(status_reg_ID_out),

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
			.status_w_en_out(status_w_en_EXE_out),
			.branch_taken_out(branch_taken_EXE_out),
			.statusRegister_out(status_reg_EXE_out),
			.branch_address_out(branch_address)
	);
	

	// ##############################				
	// ########## MEM Stage ##########
	// ##############################				

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

	// ##############################		
	// ########## WB Stage ##########		
	// ##############################

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

	// ##############################
	// #### top module elements #####
	// ##############################

	Status_Register Status_Register(
    .clk(clk), .rst(rst),
	.ld(status_w_en_EXE_out),
	.data_out(status_reg_ID_in),
    .data_in(status_reg_EXE_out)
	);
	
	Hazard_Detection_Unit hazard_detection_unit(
		//inputs:
			.have_two_src(ID_two_src),
			.src1_address(reg_file_first_src_out),
			.src2_address(reg_file_second_src_out),

			.exe_wb_dest(dest_hazard_EXE_out),
			.exe_wb_en(wb_en_hazard_EXE_out),
			
			.mem_wb_dest(dest_hazard_MEM_out),
			.mem_wb_en(wb_en_hazard_MEM_out),
		// outputs:
    		.hazard_detected(hazard_detected)
	);

endmodule