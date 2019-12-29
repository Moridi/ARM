`include "Defines.v"

module TB_SRAM();
    wire    [15:0] SRAM_DQ;                //  SRAM Data bus 16 Bits
    reg [17:0]   SRAM_ADDR;              //  SRAM Address bus 18 Bits
    reg          SRAM_UB_N;              //  SRAM High-byte Data Mask 
    reg          SRAM_LB_N;              //  SRAM Low-byte Data Mask 
    reg          SRAM_WE_N;              //  SRAM Write Enable
    reg          SRAM_CE_N;              //  SRAM Chip Enable
    reg          SRAM_OE_N;             //  SRAM Output Enable

    reg [15:0] DQ_temp;
    assign SRAM_DQ = (SRAM_WE_N == 1'b0) ? DQ_temp : 16'bz;

    SRAM sram(
        .SRAM_DQ(SRAM_DQ),                //  SRAM Data bus 16 Bits
        .SRAM_ADDR(SRAM_ADDR),              //  SRAM Address bus 18 Bits
        .SRAM_UB_N(SRAM_UB_N),              //  SRAM High-byte Data Mask 
        .SRAM_LB_N(SRAM_LB_N),              //  SRAM Low-byte Data Mask 
        .SRAM_WE_N(SRAM_WE_N),              //  SRAM Write Enable
        .SRAM_CE_N(SRAM_CE_N),              //  SRAM Chip Enable
        .SRAM_OE_N(SRAM_OE_N)              //  SRAM Output Enable
    );

    initial begin
        #250
        SRAM_WE_N = 1'b0; //write
        DQ_temp = 16'd7;
        SRAM_ADDR = 18'd20;

        #250
        // SRAM_WE_N = 1'b0; //write
        DQ_temp = 16'd11;
        SRAM_ADDR = 18'd21;

        #250
        // SRAM_WE_N = 1'b0; //write
        DQ_temp = 16'd13;
        SRAM_ADDR = 18'd22;

        #250
        SRAM_WE_N = 1'b1; //read
        DQ_temp = 16'bz;
        SRAM_ADDR = 18'd21;

        #250
        SRAM_WE_N = 1'b1; //read
        DQ_temp = 16'bz;
        SRAM_ADDR = 18'd20;
        #250

        SRAM_WE_N = 1'b0; //read
    end

endmodule
