`include "Defines.v"

module Memory(clk, rst, address, WriteData, MemRead, MemWrite, ReadData);
	input[`INSTRUCTION_LEN - 1:0] address, WriteData;
	input clk, rst, MemRead, MemWrite;
	output reg[`INSTRUCTION_LEN - 1:0] ReadData;
	integer counter = 0;

	reg[`INSTRUCTION_LEN - 1:0] data[0:`INSTRUCTION_MEM_SIZE - 1];

	always @(MemRead, address) begin
		if (MemRead) ReadData = data[address];
	end

	always @(address, MemWrite, WriteData) begin
		if (MemWrite) data[address] = WriteData;
	end
	
	always @(posedge clk, rst) begin
		if (rst) begin
			for(counter=0; counter < `INSTRUCTION_MEM_SIZE; counter=counter+1)
				data[counter] <= `INSTRUCTION_LEN'b0;
			
			data[1] <= {6'b000000, 5'b00001, 5'b00010, 5'b00000, 11'b00000000000};
			data[2] <= {6'b000000, 5'b00011, 5'b00100, 5'b00000, 11'b00000000000};
			data[3] <= {6'b000000, 5'b00101, 5'b00110, 5'b00000, 11'b00000000000};
			data[4] <= {6'b000000, 5'b00111, 5'b01000, 5'b00010, 11'b00000000000};
			data[5] <= {6'b000000, 5'b01001, 5'b01010, 5'b00011, 11'b00000000000};
			data[6] <= {6'b000000, 5'b01011, 5'b01100, 5'b00000, 11'b00000000000};
			data[7] <= {6'b000000, 5'b01101, 5'b01110, 5'b00000, 11'b00000000000};
			
		end
	end

endmodule
