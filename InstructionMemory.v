`include "Defines.v"

module InstructionMemory(clk, rst, address, WriteData, MemRead, MemWrite, ReadData);
	input[`INSTRUCTION_LEN - 1:0] address, WriteData;
	input clk, rst, MemRead, MemWrite;
	output reg[`INSTRUCTION_LEN - 1:0] ReadData;
	integer counter = 0;

	reg[`INSTRUCTION_MEM_LEN - 1:0] data[0:`INSTRUCTION_MEM_SIZE - 1];

	// always @(posedge clk, posedge rst) begin
	always @(*) begin
		if (rst) begin
			//for(counter=16; counter < `INSTRUCTION_MEM_SIZE; counter=counter+1)
				//data[counter] <= `INSTRUCTION_LEN'b0;
			data[0] <= 8'b11100000;
			data[1] <= 8'b00000000;
			data[2] <= 8'b00000000;
			data[3] <= 8'b00000000;
			
			// // R0 = 20
			// {data[4], data[5], data[6], data[7]} = 
					// {4'b1110, 2'b00, 1'b1, 4'b1101,
					// 1'b0, 4'b0000, 4'b0000, 12'b000000010100};
					
			// // R1 = 2049
			// {data[8], data[9], data[10], data[11]} =
					// {4'b1110, 2'b00, 1'b1, 4'b1101,
					// 1'b0, 4'b0000, 4'b0001, 12'b100000000001};
			
			// // R2 = R3 + R4
			// {data[12], data[13], data[14], data[15]} =		
					// {4'b1110, 2'b00, 1'b0, 4'b0100, 1'b1,
					// 4'b0011, 4'b0010, 12'b000000000100};
			
			// // Store R5 to 10 + 1024
			// {data[16], data[17], data[18], data[19]} =
					// {4'b1110, 2'b01, 1'b0, 4'b0100,
					// 1'b0, 4'b1010, 4'b0101, 12'b010000000000};	
					
			// // Load Data[1035] to R7
			// {data[20], data[21], data[22], data[23]} =
					// {4'b1110, 2'b01, 1'b0, 4'b0100,
					// 1'b1, 4'b1010, 4'b0111, 12'b010000000001};

			
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






		{data[4], data[5], data[6], data[7]} = 32'b1110_00_1_1101_0_0000_0000_000000010100; //MOV R0 ,#20 //R0 = 20
		{data[8], data[9], data[10], data[11]} = 32'b1110_00_1_1101_0_0000_0001_101000000001; //MOV R1 ,#4096 //R1 = 4096
		
		{data[12], data[13], data[14], data[15]} = {`COND_GT, 2'b10, 1'b1, 1'b0, 24'd188};
		
		data[16] <= 8'b11100000;
		data[17] <= 8'b00000000;
		data[18] <= 8'b00000000;
		data[19] <= 8'b00000000;
	
	
		data[20] <= 8'b11100000;
		data[21] <= 8'b00000000;
		data[22] <= 8'b00000000;
		data[23] <= 8'b00000000;
	
		{data[204], data[205], data[206], data[207]} = 32'b1110_00_1_1101_0_0000_0010_000100000011; //MOV R2 ,#0xC0000000 //R2 = -1073741824
		
		{data[208], data[209], data[210], data[211]} = 32'b1110_00_1_1101_0_0000_0010_000100000011; //MOV R2 ,#0xC0000000 //R2 = -1073741824
	
		data[212] <= 8'b11100000;
		data[213] <= 8'b00000000;
		data[214] <= 8'b00000000;
		data[215] <= 8'b00000000;
		
		
		data[216] <= 8'b11100000;
		data[217] <= 8'b00000000;
		data[218] <= 8'b00000000;
		data[219] <= 8'b00000000;
		
		
		data[220] <= 8'b11100000;
		data[221] <= 8'b00000000;
		data[222] <= 8'b00000000;
		data[223] <= 8'b00000000;
		
		// {data[16], data[17], data[18], data[19]} = 32'b1110_00_0_0100_1_0010_0011_000000000010; //ADDS R3 ,R2,R2 //R3 = -2147483648
		// {data[20], data[21], data[22], data[23]} = 32'b1110_00_0_0101_0_0000_0100_000000000000; //ADC R4 ,R0,R0 //R4 = 41
		// {data[24], data[25], data[26], data[27]} = 32'b1110_00_0_0010_0_0100_0101_000100000100; //SUB R5 ,R4,R4,LSL #2 //R5 = -123
		// {data[28], data[29], data[30], data[31]} = 32'b1110_00_0_0110_0_0000_0110_000010100000; //SBC R6 ,R0,R0,LSR #1 //R6 = 9
		// {data[32], data[33], data[34], data[35]} = 32'b1110_00_0_1100_0_0101_0111_000101000010; //ORR R7 ,R5,R2,ASR #2 //R7 = -123
		// {data[36], data[37], data[38], data[39]} = 32'b1110_00_0_0000_0_0111_1000_000000000011; //AND R8 ,R7,R3 //R8 = -2147483648
		// {data[40], data[41], data[42], data[43]} = 32'b1110_00_0_1111_0_0000_1001_000000000110; //MVN R9 ,R6 //R9 = 10
		// {data[44], data[45], data[46], data[47]} = 32'b1110_00_0_0001_0_0100_1010_000000000101; //EOR R10,R4,R5 //R10 = -84
		// {data[48], data[49], data[50], data[51]} = 32'b1110_00_0_1010_1_1000_0000_000000000110; //CMP R8 ,R6
		// {data[52], data[53], data[54], data[55]} = 32'b0001_00_0_0100_0_0001_0001_000000000001; //ADDNE R1 ,R1,R1 //R1 = 8192
		// {data[56], data[57], data[58], data[59]} = 32'b1110_00_0_1000_1_1001_0000_000000001000; //TST R9 ,R8
		// {data[60], data[61], data[62], data[63]} = 32'b0000_00_0_0100_0_0010_0010_000000000010; //ADDEQ R2 ,R2,R2 //R2 = -1073741824
		// {data[64], data[65], data[66], data[67]} = 32'b1110_00_1_1101_0_0000_0000_101100000001; //MOV R0 ,#1024 //R0 = 1024
		// {data[68], data[69], data[70], data[71]} = 32'b1110_01_0_0100_0_0000_0001_000000000000; //STR R1 ,[R0],#0 //MEM[1024] = 8192
		// {data[72], data[73], data[74], data[75]} = 32'b1110_01_0_0100_1_0000_1011_000000000000; //LDR R11,[R0],#0 //R11 = 8192
		// {data[76], data[77], data[78], data[79]} = 32'b1110_01_0_0100_0_0000_0010_000000000100; //STR R2 ,[R0],#4 //MEM[1028] = -1073741824
		// {data[80], data[81], data[82], data[83]} = 32'b1110_01_0_0100_0_0000_0011_000000001000; //STR R3 ,[R0],#8 //MEM[1032] = -2147483648


		

			
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
