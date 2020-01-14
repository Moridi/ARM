`include "Defines.v"

module CACHE_Controller(
    input clk, rst, write_en, read_en, mem_ready,
    input [`ADDRESS_LEN - 1 : 0] address,
    input [`REGISTER_LEN + `REGISTER_LEN - 1 : 0] sram_data_in,
    input [`REGISTER_LEN - 1 : 0] data_in,

    output miss,
    output [`REGISTER_LEN - 1 : 0] cache_out
);

    wire [5:0] idx;
    wire [9:0] address_tag;
    reg [`CACHE_BLOCK_LEN - 1:0] cache_mem [0:`CACHE_CAPACITY - 1];

    assign idx = address[`MEM_ADDRESS_LEN - 11 : `MEM_ADDRESS_LEN - 16];
    assign address_tag = address[`MEM_ADDRESS_LEN - 1 : `MEM_ADDRESS_LEN - 10];

    assign miss = (address_tag != cache_mem[idx][`CACHE_BLOCK_LEN - 2 : `CACHE_BLOCK_LEN - 11]) 
			| (~cache_mem[idx][`CACHE_BLOCK_LEN - 1]);
    // assign miss = 1'b1;

    integer i;
	always@(posedge clk, posedge rst) begin
		if (rst) begin
            for (i=0; i < `CACHE_CAPACITY; i=i+1)
                cache_mem[i] <= `CACHE_BLOCK_LEN'd0;

        end else if (miss && mem_ready && read_en)
			cache_mem[idx] <= {1'b1, address_tag, sram_data_in};

        else if (mem_ready && write_en && cache_mem[idx][`CACHE_BLOCK_LEN - 1] == 1'b1) begin
            if (address[2] == 1'b1)
                cache_mem[idx][31:0] <= data_in;
            else
                cache_mem[idx][63:32] <= data_in;

        end
	end


    assign cache_out = (address[2] == 1'b1) ? cache_mem[idx][31:0] : cache_mem[idx][63:32];
	// always @(address, read_en) begin
	// 	if(read_en)begin
	// 		case (address[2])
	// 			1'b0 :
	// 				cache_out <= cache_mem[idx][31:0];
	// 			1'b1 :
	// 				cache_out <= cache_mem[idx][63:32];
	// 		endcase
	// 	end
	// end

endmodule