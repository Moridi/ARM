
`include "Defines.v"

module InstructionMemory(clk, rst, address, WriteData, MemRead, MemWrite, ReadData);
	input[`INSTRUCTION_LEN - 1:0] address, WriteData;
	input clk, rst, MemRead, MemWrite;
	output reg[`INSTRUCTION_LEN - 1:0] ReadData;
	integer counter = 0;

	reg[`INSTRUCTION_MEM_LEN - 1:0] data[0:`INSTRUCTION_MEM_SIZE - 1];

	always @(posedge clk, posedge rst) begin
		if (rst) begin
			//for(counter=16; counter < `INSTRUCTION_MEM_SIZE; counter=counter+1)
				//data[counter] <= `INSTRUCTION_LEN'b0;
			data[0] <= 8'b11100000;
			data[1] <= 8'b00000000;
			data[2] <= 8'b00000000;
			data[3] <= 8'b00000000;
			
			
			{data[4], data[5], data[6], data[7]} = 
					{4'b1110, 2'b00, 1'b1, 4'b1101,
					1'b0, 4'b0000, 4'b0000, 12'b000000010100};
					
			{data[8], data[9], data[10], data[11]} =
					{4'b1110, 2'b00, 1'b1, 4'b1101,
					1'b0, 4'b0000, 4'b0001, 12'b100000000001};
					
			{data[12], data[13], data[14], data[15]} =		
					{4'b1110, 2'b00, 1'b0, 4'b0100, 1'b1,
					4'b0001, 4'b0010, 12'b000000000000};
			
			{data[16], data[17], data[18], data[19]} =
					{4'b1110, 2'b01, 1'b0, 4'b0100,
					1'b0, 4'b0001, 4'b0000, 12'b000000000000};	
					
			{data[20], data[21], data[22], data[23]} =
					{4'b1110, 2'b01, 1'b0, 4'b0100,
					1'b1, 4'b0001, 4'b1000, 12'b000000000000};

			
			// data[4] <= 8'b11000000;
			// data[5] <= 8'b00100010;
			// data[6] <= 8'b00000000;
			// data[7] <= 8'b00000000;
			
			// data[8] <= 8'b00000000;
			// data[9] <= 8'b01100100;
			// data[10] <= 8'b00000000;
			// data[11] <= 8'b00000000;
			
			// data[12] <= 8'b00000000;
			// data[13] <= 8'b10100110;
			// data[14] <= 8'b00000000;
			// data[15] <= 8'b00000000;
			
//			data[4] <= {6'b000000, 5'b00111, 5'b01000, 5'b00010, 11'b00000000000};
//			data[5] <= {6'b000000, 5'b01001, 5'b01010, 5'b00011, 11'b00000000000};
//			data[6] <= {6'b000000, 5'b01011, 5'b01100, 5'b00000, 11'b00000000000};
//			data[7] <= {6'b000000, 5'b01101, 5'b01110, 5'b00000, 11'b00000000000};
			
		end
		else if (MemWrite) begin
			data[address] = WriteData[`INSTRUCTION_MEM_LEN - 1:0];
			data[address + 1] = WriteData[`INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN - 1 : `INSTRUCTION_MEM_LEN];
			data[address + 2] = WriteData[`INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN - 1 : `INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN];
			data[address + 3] = WriteData[`INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN - 1 : `INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN + `INSTRUCTION_MEM_LEN];
		end
		else if (MemRead)
			ReadData = {data[address], data[address + 1], data[address + 2], data[address + 3]};
	end

endmodule
