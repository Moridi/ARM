`include "Defines.v"

module MEM_Stage_Module(
    //inputs to main moduel:
	input clk, rst,
	input wb_en_in, mem_r_en_in, mem_w_en_in,
	input [`REGISTER_LEN - 1:0] alu_res_in, val_Rm,
	input [`REG_ADDRESS_LEN - 1:0] dest_in,

    // outputs from Reg:
    output wb_en_out, mem_r_en_out,
	output [`REGISTER_LEN - 1:0] alu_res_out, mem_res_out,
	output [`REG_ADDRESS_LEN - 1:0] dest_out,

    //outputs from stage:
    output wb_en_hazard_in,
    output [`REG_ADDRESS_LEN - 1:0] dest_hazard_in,
    output ready,

    ////////////////////////    SRAM Interface  ////////////////////////
    inout    [15:0] SRAM_DQ,                //  SRAM Data bus 16 Bits
    output   [17:0] SRAM_ADDR,              //  SRAM Address bus 18 Bits
    output          SRAM_UB_N,              //  SRAM High-byte Data Mask 
    output          SRAM_LB_N,              //  SRAM Low-byte Data Mask 
    output          SRAM_WE_N,              //  SRAM Write Enable
    output          SRAM_CE_N,              //  SRAM Chip Enable
    output          SRAM_OE_N               //  SRAM Output Enable
);

    wire wb_en_middle, mem_r_en_middle;
	wire [`REGISTER_LEN - 1:0] alu_res_middle, mem_res_middle;
	wire [`REG_ADDRESS_LEN - 1:0] dest_middle;

    assign wb_en_hazard_in = wb_en_in;
    assign dest_hazard_in = dest_in;

	MEM_Stage memory_stage(
        //inputs:
            .clk(clk),
            .rst(rst),
            .wb_en_in(wb_en_in),
            .mem_r_en_in(mem_r_en_in),
            .mem_w_en_in(mem_w_en_in),
            .alu_res_in(alu_res_in),
            .val_Rm(val_Rm),
            .dest_in(dest_in),

        // outputs to Reg:
            .wb_en_out(wb_en_middle),
            .mem_r_en_out(mem_r_en_middle),
            .mem_out(mem_res_middle),
            .alu_res_out(alu_res_middle),
            .dest_out(dest_middle),
        //outputs to top module:
            .ready(ready),

        ////////////////////////    SRAM Interface  ////////////////////////
            .SRAM_DQ(SRAM_DQ),                  //  SRAM Data bus 16 Bits
            .SRAM_ADDR(SRAM_ADDR),              //  SRAM Address bus 18 Bits
            .SRAM_UB_N(SRAM_UB_N),              //  SRAM High-byte Data Mask 
            .SRAM_LB_N(SRAM_LB_N),              //  SRAM Low-byte Data Mask 
            .SRAM_WE_N(SRAM_WE_N),              //  SRAM Write Enable
            .SRAM_CE_N(SRAM_CE_N),              //  SRAM Chip Enable
            .SRAM_OE_N(SRAM_OE_N)               //  SRAM Output Enable
    );

    MEM_Stage_Reg mem_stage_reg(
			.clk(clk), .rst(rst),
        //inputs:
            .wb_en_in(wb_en_middle),
            .mem_r_en_in(mem_r_en_middle),
            .alu_res_in(alu_res_middle),
            .mem_res_in(mem_res_middle),
            .dest_in(dest_middle),
        //outputs:
            .wb_en_out(wb_en_out),
            .mem_r_en_out(mem_r_en_out),
            .alu_res_out(alu_res_out),
            .mem_res_out(mem_res_out),
            .dest_out(dest_out)
    );
	

endmodule