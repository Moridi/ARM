`include "Defines.v"

module SRAM_Controller(
    input clk, rst,

    // Input from Memory Stage
    input write_enable, read_enable,
    input [`ADDRESS_LEN - 1 : 0] address,
    input [`REGISTER_LEN - 1 : 0] write_data,

    // To WB Stage
    output [`REGISTER_LEN - 1 : 0] read_data,

    // To Freeze other Stages
    output ready,

    ////////////////////////    SRAM Interface  ////////////////////////
    inout [`SRAM_DATA_BUS - 1 : 0]      SRAM_DQ,                //  SRAM Data bus 16 Bits
    output [`SRAM_ADDRESS_BUS - 1 : 0]  SRAM_ADDR,              //  SRAM Address bus 18 Bits

    // Active Low Signals
    output                              SRAM_UB_N,              //  SRAM High-byte Data Mask 
    output                              SRAM_LB_N,              //  SRAM Low-byte Data Mask 
    output                              SRAM_WE_N,              //  SRAM Write Enable
    output                              SRAM_CE_N,              //  SRAM Chip Enable
    output                              SRAM_OE_N               //  SRAM Output Enable
);

    assign SRAM_UB_N = `SRAM_DISABLE;
    assign SRAM_LB_N = `SRAM_DISABLE;
    assign SRAM_CE_N = `SRAM_DISABLE;
    assign SRAM_OE_N = `SRAM_DISABLE;

    wire [`REGISTER_LEN - 1 : 0] read_data_local;
    // reg [`SRAM_DATA_BUS - 1 : 0] SRAM_DQ_reg;
    // reg [`SRAM_ADDRESS_BUS - 1 : 0]  SRAM_ADDR_reg;
    // reg SRAM_WE_N_reg;

    wire [`ADDRESS_LEN - 1:0] address4k = {address[`ADDRESS_LEN - 1:2], 2'b0} - `ADDRESS_LEN'd1024;    
    wire [`ADDRESS_LEN - 1:0] address4k_div_2 = {1'b0, address4k[`ADDRESS_LEN - 1 : 1]};

    // assign SRAM_DQ = SRAM_DQ_reg;
    // assign read_data = read_data_local;
    // assign SRAM_WE_N = SRAM_WE_N_reg;
    // assign SRAM_ADDR = SRAM_ADDR_reg;

    parameter IDLE = 2'b00, READ_STATE = 2'b01, WRITE_STATE = 2'b10;

    wire [1 : 0] ps, ns;
    wire [2 : 0] sram_counter, next_sram_counter;

    Register #(.WORD_LENGTH(3)) sram_counter_reg(.clk(clk), .rst(rst),
			.ld(1'b1), .in(next_sram_counter), .out(sram_counter)
	);

    Register #(.WORD_LENGTH(2)) ps_reg(.clk(clk), .rst(rst),
			.ld(1'b1), .in(ns), .out(ps)
	);
    Register #(.WORD_LENGTH(32)) read_data_reg(.clk(clk), .rst(rst),
			.ld(1'b1), .in(read_data_local), .out(read_data)
	);

    assign ready = (rst == 1'b1) ? `ENABLE
        : (
            ((ps == IDLE) && (read_enable == 1'b1 || write_enable == 1'b1)) ? `DISABLE
            : (ps == IDLE)                                                  ? `ENABLE
            : (ps == READ_STATE && (sram_counter == 3'd6))                  ? `ENABLE
            : (ps == READ_STATE)                                            ? `DISABLE
            : (ps == WRITE_STATE && (sram_counter == 3'd6))                 ? `ENABLE
            : (ps == WRITE_STATE)                                           ? `DISABLE
            : `ENABLE
        );

    assign next_sram_counter = (ps == IDLE)                 ? 3'd0
        : (ps == READ_STATE && sram_counter == 3'd6)        ? 3'd0
        : (ps == READ_STATE)                                ? sram_counter + 3'd1
        : (ps == WRITE_STATE && sram_counter == 3'd6)       ? 3'd0
        : (ps == WRITE_STATE)                               ? sram_counter + 3'd1
        : 3'd0;


    assign ns = (rst == 1'b1) ? IDLE
        : (
            (ps == IDLE && read_enable == 1'b1)                 ? READ_STATE
            : (ps == IDLE && write_enable == 1'b1)              ? WRITE_STATE
            : (ps == IDLE)                                      ? IDLE
            : (ps == READ_STATE && (sram_counter == 3'd6))      ? IDLE
            : (ps == READ_STATE)                                ? READ_STATE
            : (ps == WRITE_STATE && (sram_counter == 3'd6))     ? IDLE
            : (ps == WRITE_STATE)                               ? WRITE_STATE
            : IDLE
        );


    assign SRAM_DQ = 
        (ps == WRITE_STATE && (sram_counter == 3'd0))       ? write_data[31 : 16]
        : (ps == WRITE_STATE && (sram_counter == 3'd1))       ? write_data[31 : 16]

        : (ps == WRITE_STATE && (sram_counter == 3'd2))     ? write_data[15 : 0]
        : (ps == WRITE_STATE && (sram_counter == 3'd3))     ? write_data[15 : 0]
        : `SRAM_DATA_BUS'bz;

    assign SRAM_ADDR = 
        (ps == READ_STATE && (sram_counter == 3'd1))       ? {address4k_div_2[17 : 1], 1'b0}
        : (ps == READ_STATE && (sram_counter == 3'd2))       ? {address4k_div_2[17 : 1], 1'b0}

        : (ps == READ_STATE && (sram_counter == 3'd3))       ? {address4k_div_2[17 : 1], 1'b1}
        : (ps == READ_STATE && (sram_counter == 3'd4))       ? {address4k_div_2[17 : 1], 1'b1}

        : (ps == WRITE_STATE && (sram_counter == 3'd0))       ? {address4k_div_2[17 : 1], 1'b0}
        : (ps == WRITE_STATE && (sram_counter == 3'd1))       ? {address4k_div_2[17 : 1], 1'b0}
        : (ps == WRITE_STATE && (sram_counter == 3'd2))       ? {address4k_div_2[17 : 1], 1'b1}
        : (ps == WRITE_STATE && (sram_counter == 3'd3))       ? {address4k_div_2[17 : 1], 1'b1}
        : 18'b0;
    
    assign SRAM_WE_N = 
        (ps == WRITE_STATE && (sram_counter == 3'd1))         ? `SRAM_ENABLE
        : (ps == WRITE_STATE && (sram_counter == 3'd3))       ? `SRAM_ENABLE
        : `SRAM_DISABLE;

    assign read_data_local =
        (ps == READ_STATE && (sram_counter == 3'd2))       ? {SRAM_DQ, read_data[15:0]}
        : (ps == READ_STATE && (sram_counter == 3'd4))     ? {read_data[31:16], SRAM_DQ}
        : read_data;

endmodule