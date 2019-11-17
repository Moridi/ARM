`include "Defines.v"

module ARM(input clk, rst);
	wire freeze, Branch_taken, flush;
	wire[`ADDRESS_LEN - 1:0] BranchAddr;
	wire[`ADDRESS_LEN - 1:0] 	PC_IF, PC_IF_Reg,
								PC_ID, PC_ID_Reg,
								PC_EX, PC_EX_Reg,
								PC_MEM, PC_MEM_Reg,
								PC_WB
								;
								
	wire[`INSTRUCTION_LEN - 1:0] 	Instruction_IF, Instruction_IF_Reg;
	
	assign Branch_taken = 1'b0;
	assign freeze = 1'b0;
	assign BranchAddr = `ADDRESS_LEN'b0;
	assign flush = 1'b0;
	
	IF_Stage IF_Stage(
		.clk(clk), .rst(rst),
		.freeze(freeze), .Branch_taken(Branch_taken),
		.BranchAddr(BranchAddr),
		.PC(PC_IF),
		.Instruction(Instruction_IF)
		);

	IF_Stage_Reg IF_Stage_Reg(.clk(clk), .rst(rst),
			.freeze(freeze), .flush(flush),
			.PC_in(PC_IF), .Instruction_in(Instruction_IF),
			.PC(PC_IF_Reg), .Instruction(Instruction_IF_Reg));
				

	// ID Stage
	
	wire mem_read_ID_reg_in, mem_write_ID_reg_in,
		wb_enable_ID_reg_in, immediate_ID_reg_in,
		branch_taken_ID_reg_in, status_write_enable_ID_reg_in;
		
	wire[`EXECUTE_COMMAND_LEN - 1 : 0] execute_command_ID_reg_in;
	wire[`REGISTER_LEN - 1:0] reg_file_ID_reg_in1, reg_file_ID_reg_in2;
	wire two_src;
	wire [`REG_ADDRESS_LEN - 1:0] dest_reg_ID_reg_in;
	wire [24 - 1:0] signed_immediate_ID_reg_in;
	wire [`SHIFT_OPERAND_LEN - 1:0] shift_operand_ID_reg_in;
				
	ID_Stage id_Stage(
		.clk(clk), .rst(rst), .PC_in(PC_IF_Reg),
		.Instruction_in(Instruction_IF_Reg), .PC(PC_ID),
		.mem_read_out(mem_read_ID_reg_in),
		.mem_write_out(mem_write_ID_reg_in),
		.wb_enable_out(wb_enable_ID_reg_in),
		.immediate_out(immediate_ID_reg_in),
		.branch_taken_out(branch_taken_ID_reg_in),
		.status_write_enable_out(status_write_enable_ID_reg_in),		
		.execute_command_out(execute_command_ID_reg_in),
		.reg_file_out1(reg_file_ID_reg_in1),
		.reg_file_out2(reg_file_ID_reg_in2),
		.two_src(two_ID_reg_in),
		.dest_reg_out(dest_reg_ID_reg_in),
		.signed_immediate(signed_immediate_ID_reg_in),
		.shift_operand(shift_operand_ID_reg_in)
		);
		
	
	// ID_Stage_Reg ID_Stage_Reg(.clk(clk), .rst(rst), .PC_in(PC_ID), .PC(PC_ID_Reg));

	
	
	
	
	// EX_Stage EX_Stage(.clk(clk), .rst(rst), .PC_in(PC_ID_Reg), .PC(PC_EX));

	// EX_Stage_Reg EX_Stage_Reg(.clk(clk), .rst(rst),
		// .PC_in(PC_EX), .PC(PC_EX_Reg));

	// MEM_Stage MEM_Stage(.clk(clk), .rst(rst), .PC_in(PC_EX_Reg), .PC(PC_MEM));

	// MEM_Stage_Reg MEM_Stage_Reg(.clk(clk), .rst(rst),
		// .PC_in(PC_MEM), .PC(PC_MEM_Reg));

	// WB_Stage WB_Stage(.clk(clk), .rst(rst), .PC_in(PC_MEM_Reg), .PC(PC_WB));
		
endmodule