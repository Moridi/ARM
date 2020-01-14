`include "Defines.v"

module SRAM_Controller(
    input clk, rst, write_en, read_en, mem_ready,
    input [`ADDRESS_LEN - 1 : 0] address,
    input [`REGISTER_LEN + `REGISTER_LEN - 1 : 0] data_in,

    output miss,
    output [`REGISTER_LEN - 1 : 0] cache_out
);

    wire [5:0] idx;
    wire [9:0] address_tag;
    reg [`CACHE_BLOCK_LEN - 1:0] cache_mem [0:`CACHE_CAPACITY - 1];

    assign idx = address[`ADDRESS_LEN - 11 : `ADDRESS_LEN - 16];
    assign address_tag = address[`ADDRESS_LEN - 1 : `ADDRESS_LEN - 10];

    assign miss = (address_tag != cache_mem[idx][`CACHE_BLOCK_LEN - 2 : `CACHE_BLOCK_LEN - 11]) 
			| (~cache_mem[idx][`CACHE_BLOCK_LEN - 1]);



	always@(posedge clk, posedge rst) begin
		if (rst) begin
			cache_mem <= '{default:`CACHE_BLOCK_LEN'b0};
        end else if (write_en && mem_ready)
			cache_mem[idx] <= {1'b1, address_tag, data_in};
	end


	always @(address, read_en) begin
		if(read_en)begin
			case (address[0])
				1'b0 :
					cache_out <= cache_mem[idx][31:0];
				1'b1 :
					cache_out <= cache_mem[idx][63:32];
			endcase
		end
	end

endmodule