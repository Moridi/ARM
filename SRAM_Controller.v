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

    reg [`REGISTER_LEN - 1 : 0] read_data_local;
    reg [`SRAM_DATA_BUS - 1 : 0] SRAM_DQ_reg;
    reg [`SRAM_ADDRESS_BUS - 1 : 0]  SRAM_ADDR_reg;
    reg ready_reg, SRAM_WE_N_reg;

    wire [`ADDRESS_LEN - 1:0] address4k = {address[`ADDRESS_LEN - 1:2], 2'b0} - `ADDRESS_LEN'd1024;    
    wire [`ADDRESS_LEN - 1:0] address4k_div_2 = {1'b0, address4k[`ADDRESS_LEN - 1 : 1]};

    assign SRAM_DQ = SRAM_DQ_reg;
    assign ready = ready_reg;
    assign read_data = read_data_local;
    assign SRAM_WE_N = SRAM_WE_N_reg;
    assign SRAM_ADDR = SRAM_ADDR_reg;

    parameter IDLE = 2'b00, READ_STATE = 2'b01, WRITE_STATE = 2'b10;

    reg [1 : 0] ps, ns;
    reg [2 : 0] sram_counter;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            ps <= IDLE;
            ns <= IDLE;
            ready_reg <= 1'b1;
        end else
            ps <= ns;
    end

    always @(posedge clk, posedge rst) begin
        case (ps)
            IDLE: begin
                sram_counter <= 3'd0;
            end

            READ_STATE: begin  
                if (sram_counter == 3'd6)
                    sram_counter <= 3'd0;
                else
                    sram_counter <= sram_counter + 1;
            end
            
            WRITE_STATE: begin  
                if (sram_counter == 3'd6)
                    sram_counter <= 3'd0;
                else
                    sram_counter <= sram_counter + 1;
            end
        endcase
    end

    always @(ps, read_enable, write_enable, sram_counter) begin
        ready_reg = `DISABLE;

        case (ps)
            IDLE: begin
                sram_counter = 3'd0;
                ready_reg = 1'b1;

                if (read_enable) begin
                    ns = READ_STATE;
                    ready_reg = `DISABLE;
                end
                else if (write_enable) begin
                    ns = WRITE_STATE;
                    ready_reg = `DISABLE;
                end
            end

            READ_STATE: begin  
                
                SRAM_WE_N_reg = `SRAM_DISABLE;              
                
                case (sram_counter)
                    3'd0: begin
                        SRAM_DQ_reg = `SRAM_DATA_BUS'bz;
                        // MSB
                        SRAM_ADDR_reg = {address4k_div_2[17 : 1], 1'b0};
                    end

                    3'd1: begin
                        read_data_local[31 : 16] = SRAM_DQ_reg;
                        SRAM_ADDR_reg = {address4k_div_2[17 : 1], 1'b1};
                    end

                    3'd2: begin
                        // LSB
                        read_data_local[15 : 0] = SRAM_DQ_reg;
                    end

                    // @TODO: Check it out.
                    3'd6: begin
                        ready_reg = `ENABLE;
                        ns = IDLE;
                    end
                endcase
            end

            WRITE_STATE: begin                
                case (sram_counter)
                    3'd0: begin
                        // MSB
                        SRAM_DQ_reg = write_data[31 : 16];
                        SRAM_ADDR_reg = {address4k_div_2[17 : 1], 1'b0};
                        SRAM_WE_N_reg = `SRAM_ENABLE;
                    end

                    3'd2: begin
                        // LSB
                        SRAM_DQ_reg = write_data[15 : 0];
                        SRAM_ADDR_reg = {address4k_div_2[17 : 1], 1'b1};
                        SRAM_WE_N_reg = `SRAM_ENABLE;
                    end

                    // @TODO: Check it out.
                    3'd6: begin
                        ready_reg = `ENABLE;
                        ns = IDLE;
                    end

                    default: begin
                        SRAM_WE_N_reg = `SRAM_DISABLE;
                    end
                endcase
            end
        endcase
    end

endmodule