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
    output                              SRAM_UB_N,              //  SRAM High-byte Data Mask 
    output                              SRAM_LB_N,              //  SRAM Low-byte Data Mask 
    output                              SRAM_WE_N,              //  SRAM Write Enable
    output                              SRAM_CE_N,              //  SRAM Chip Enable
    output                              SRAM_OE_N               //  SRAM Output Enable
);



endmodule