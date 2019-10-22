`include "Defines.v"

module RegisterFile (
	input clk, rst, 
    input [`REG_ADDRESS_LEN - 1:0] src1, src2, dest_wb,
	input[`REGISTER_LEN - 1:0] result_wb,
    input writeBackEn,
	output [`REGISTER_LEN - 1:0] reg1, reg2
);
    integer counter = 0;
    reg[`REGISTER_LEN - 1:0] data[0:`REGISTER_MEM_SIZE - 1];

    assign reg1 = data[src1];
    assign reg2 = data[src2];

    always @(negedge clk, posedge rst) begin
		if (rst) begin
			for(counter=0; counter < `REGISTER_MEM_SIZE; counter=counter+1)
				data[counter] <= counter;
        end
        else if (writeBackEn) data[dest_wb] = result_wb;
	end

endmodule