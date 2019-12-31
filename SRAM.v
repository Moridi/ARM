`include "Defines.v"

module SRAM (
    inout    [15:0] SRAM_DQ,                //  SRAM Data bus 16 Bits
    input [17:0]   SRAM_ADDR,              //  SRAM Address bus 18 Bits
    input          SRAM_UB_N,              //  SRAM High-byte Data Mask 
    input          SRAM_LB_N,              //  SRAM Low-byte Data Mask 
    input          SRAM_WE_N,              //  SRAM Write Enable
    input          SRAM_CE_N,              //  SRAM Chip Enable
    input          SRAM_OE_N              //  SRAM Output Enable

);
    reg [15:0] data[0:511];
    wire [8:0] local_address;

    assign local_address = SRAM_ADDR[8:0];
    assign SRAM_DQ = (SRAM_WE_N == `SRAM_DISABLE) ? data[local_address]: 16'bz;

    always @(*) begin
        if (SRAM_WE_N == `SRAM_ENABLE) begin
            //read from bus
            data[local_address] <= SRAM_DQ;
        end
    end

endmodule