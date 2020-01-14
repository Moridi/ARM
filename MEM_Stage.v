`include "Defines.v"

module MEM_Stage(
	input clk, rst,
	input wb_en_in, mem_r_en_in, mem_w_en_in,
	input [`REGISTER_LEN - 1:0] alu_res_in, val_Rm,
	input [`REG_ADDRESS_LEN - 1:0] dest_in,

	output wb_en_out, mem_r_en_out,
	output [`REGISTER_LEN - 1:0] mem_out, alu_res_out,
	output [`REG_ADDRESS_LEN - 1:0] dest_out,
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

    wire [`REGISTER_LEN + `REGISTER_LEN - 1 : 0] sram_out;
    wire [`REGISTER_LEN - 1 : 0] cache_out;
    wire cache_miss;

	assign wb_en_out = wb_en_in;
	assign mem_r_en_out = mem_r_en_in;
	assign alu_res_out = alu_res_in;
	assign dest_out = dest_in;

    wire [`ADDRESS_LEN - 1:0] address4k = {alu_res_in[`ADDRESS_LEN - 1:2], 2'b0} - `ADDRESS_LEN'd1024;

    assign mem_out = (cache_miss == 1'b1) ?
        ((address4k[2] == 1'b1) ? sram_out[31:0] : sram_out[63:32])
        :
        (cache_out)
    ;

	SRAM_Controller SRAM_Controller(
        .clk(clk), .rst(rst),

        // Input from Memory .Stage(Stag)
        .write_enable(mem_w_en_in),
        .read_enable(mem_r_en_in & cache_miss),
        .address(address4k),
        .write_data(val_Rm),

        // To WB Stage
        .read_data(sram_out),

        // To Freeze other Stages
        .ready(ready),

        ////////////////////////    SRAM Interface  ////////////////////////
        .SRAM_DQ(SRAM_DQ),                //  SRAM Data bus 16 Bits
        .SRAM_ADDR(SRAM_ADDR),              //  SRAM Address bus 18 Bits

        // Active Low Signals
        .SRAM_UB_N(SRAM_UB_N),              //  SRAM High-byte Data Mask 
        .SRAM_LB_N(SRAM_LB_N),              //  SRAM Low-byte Data Mask 
        .SRAM_WE_N(SRAM_WE_N),              //  SRAM Write Enable
        .SRAM_CE_N(SRAM_CE_N),              //  SRAM Chip Enable
        .SRAM_OE_N(SRAM_OE_N)               //  SRAM Output Enable
    );


CACHE_Controller CACHE_Controller(
    .clk(clk),
    .rst(rst),

    .write_en(mem_w_en_in),
    .read_en(mem_r_en_in),
    .mem_ready(ready),

    .address(address4k),
    .sram_data_in(sram_out),
    .data_in(val_Rm),

    .miss(cache_miss),
    .cache_out(cache_out)
);



	// assign SRAM_DQ = 16'bz;
	// assign SRAM_ADDR = 18'b0;
	// assign SRAM_UB_N = 1'b1;
	// assign SRAM_LB_N = 1'b1;
	// assign SRAM_WE_N = 1'b1;
	// assign SRAM_CE_N = 1'b1;
	// assign SRAM_OE_N = 1'b1;
	// Memory memory(.clk(clk), .rst(rst), .address(alu_res_in),
	// 		.WriteData(val_Rm), .MemRead(mem_r_en_in), .MemWrite(mem_w_en_in),
	// 		.ReadData(mem_out),
	// 		.ready(ready)
	// );

endmodule