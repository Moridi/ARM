`include "Defines.v"

module TB_SRAM_Controller();

    reg clk = 1'b0, rst = 1'b0;

    // Input from Memory Stage
    reg write_enable = 1'b0, read_enable = 1'b0;
    reg [`ADDRESS_LEN - 1 : 0] address;
    reg [`REGISTER_LEN - 1 : 0] write_data;

    // To WB Stage
    wire [`REGISTER_LEN - 1 : 0] read_data;

    // To Freeze other Stages
    wire ready;

    ////////////////////////    SRAM Interface  ////////////////////////
    wire [`SRAM_DATA_BUS - 1 : 0] SRAM_DQ;                    //  SRAM Data bus 16 Bits
    wire [`SRAM_ADDRESS_BUS - 1 : 0]  SRAM_ADDR;              //  SRAM Address bus 18 Bits

    // Active Low Signals
    wire SRAM_UB_N;              //  SRAM High-byte Data Mask 
    wire SRAM_LB_N;              //  SRAM Low-byte Data Mask 
    wire SRAM_WE_N;              //  SRAM Write Enable
    wire SRAM_CE_N;              //  SRAM Chip Enable
    wire SRAM_OE_N;              //  SRAM Output Enable

    SRAM_Controller SRAM_Controller(
        .clk(clk), .rst(rst),

        // Input from Memory .Stage(Stag)
        .write_enable(write_enable), .read_enable(read_enable),
        .address(address),
        .write_data(write_data),

        // To WB Stage
        .read_data(read_data),

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

    initial repeat(1000) #100 clk = ~clk;
    
    initial begin
        #200
        rst = 1'b1;
        #100
        rst = 1'b0;
       
        #2000
        write_enable = 1'b1;
        read_enable = 1'b0;
        address = `ADDRESS_LEN'd12;
        write_data = `REGISTER_LEN'd31;

        #200
        write_enable = 1'b0;
        #200
       
        #2000
        read_enable = 1'b1;
        address = `ADDRESS_LEN'd15;

        #200
        read_enable = 1'b0;
    end

endmodule
