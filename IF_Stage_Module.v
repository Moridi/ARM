`include "Defines.v"

module IF_Stage_Module (
	input clk, rst,
    input freeze_in, Branch_taken_in, flush_in,
	input[`ADDRESS_LEN - 1:0] BranchAddr_in,

    //outputs from reg:
    output wire [`INSTRUCTION_LEN - 1:0] PC_out, Instruction_out
);
	wire [`ADDRESS_LEN - 1:0] PC_middle;
	wire [`INSTRUCTION_LEN - 1:0] Instruction_middle;

    IF_Stage IF_stage(
        //inputs:
            .clk(clk),
            .rst(rst),
            .freeze(freeze_in),
            .Branch_taken(Branch_taken_in),
            .BranchAddr(BranchAddr_in),
        //outputs to reg:
        	.PC(PC_middle),
	        .Instruction(Instruction_middle)
    );
    IF_Stage_Reg IF_stage_reg(
        //inputs:
            .clk(clk),
            .rst(rst),
            .freeze(freeze_in),
            .flush(flush_in),
            .PC_in(PC_middle),
            .Instruction_in(Instruction_middle),

        //outputs:
            .PC(PC_out),
            .Instruction(Instruction_out)
    );

endmodule