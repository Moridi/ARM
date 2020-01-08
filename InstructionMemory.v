`include "Defines.v"

module InstructionMemory(clk, rst, address, WriteData, MemRead, MemWrite, ReadData);
	input[`INSTRUCTION_LEN - 1:0] address, WriteData;
	input clk, rst, MemRead, MemWrite;
	output [`INSTRUCTION_LEN - 1:0] ReadData;
	integer counter = 0;

	reg [`INSTRUCTION_LEN - 1:0] ReadDataTemp;

	assign ReadData = ReadDataTemp;
	reg[`INSTRUCTION_MEM_LEN - 1:0] data[0:`INSTRUCTION_MEM_SIZE - 1];

	always @(*) begin
		if (rst) begin
			data[0] <= 8'b11100000;
			data[1] <= 8'b00000000;
			data[2] <= 8'b00000000;
			data[3] <= 8'b00000000;
			
			// {data[4], data[5], data[6], data[7]} = 32'b1110_00_1_1101_0_0000_0000_000000010100; //MOV R0 ,#20 //R0 = 20
			// {data[8], data[9], data[10], data[11]} = 32'b1110_00_1_1101_0_0000_0001_101000000001; //MOV R1 ,#4096 //R1 = 4096

			{data[4], data[5], data[6], data[7]} = 32'b1110_00_1_1101_0_0000_0000_000000010100; //MOV R0 ,#20 //R0 = 20
			{data[8], data[9], data[10], data[11]} = 32'b1110_00_1_1101_0_0000_0001_101000000001; //MOV R1 ,#4096 //R1 = 4096
			{data[12], data[13], data[14], data[15]} = 32'b1110_00_1_1101_0_0000_0010_000100000011; //MOV R2 ,#0xC0000000 //R2 = -1073741824
			{data[16], data[17], data[18], data[19]} = 32'b1110_00_0_0100_1_0010_0011_000000000010; //ADDS R3 ,R2,R2 //R3 = -2147483648
			{data[20], data[21], data[22], data[23]} = 32'b1110_00_0_0101_0_0000_0100_000000000000; //ADC R4 ,R0,R0 //R4 = 41
			{data[24], data[25], data[26], data[27]} = 32'b1110_00_0_0010_0_0100_0101_000100000100; //SUB R5 ,R4,R4,LSL #2 //R5 = -123
			{data[28], data[29], data[30], data[31]} = 32'b1110_00_0_0110_0_0000_0110_000010100000; //SBC R6 ,R0,R0,LSR #1 //R6 = 9
			{data[32], data[33], data[34], data[35]} = 32'b1110_00_0_1100_0_0101_0111_000101000010; //ORR R7 ,R5,R2,ASR #2 //R7 = -123
			{data[36], data[37], data[38], data[39]} = 32'b1110_00_0_0000_0_0111_1000_000000000011; //AND R8 ,R7,R3 //R8 = -2147483648
			{data[40], data[41], data[42], data[43]} = 32'b1110_00_0_1111_0_0000_1001_000000000110; //MVN R9 ,R6 //R9 = 10
			{data[44], data[45], data[46], data[47]} = 32'b1110_00_0_0001_0_0100_1010_000000000101; //EOR R10,R4,R5 //R10 = -84
			{data[48], data[49], data[50], data[51]} = 32'b1110_00_0_1010_1_1000_0000_000000000110; //CMP R8 ,R6
			{data[52], data[53], data[54], data[55]} = 32'b0001_00_0_0100_0_0001_0001_000000000001; //ADDNE R1 ,R1,R1 //R1 = 8192
			{data[56], data[57], data[58], data[59]} = 32'b1110_00_0_1000_1_1001_0000_000000001000; //TST R9 ,R8
			{data[60], data[61], data[62], data[63]} = 32'b0000_00_0_0100_0_0010_0010_000000000010; //ADDEQ R2 ,R2,R2 //R2 = -1073741824
			{data[64], data[65], data[66], data[67]} = 32'b1110_00_1_1101_0_0000_0000_101100000001; //MOV R0 ,#1024 //R0 = 1024
			{data[68], data[69], data[70], data[71]} = 32'b1110_01_0_0100_0_0000_0001_000000000000; //STR R1 ,[R0],#0 //MEM[1024] = 8192
			{data[72], data[73], data[74], data[75]} = 32'b1110_01_0_0100_1_0000_1011_000000000000; //LDR R11,[R0],#0 //R11 = 8192
			{data[76], data[77], data[78], data[79]} = 32'b1110_01_0_0100_0_0000_0010_000000000100; //STR R2 ,[R0],#4 //MEM[1028] = -1073741824
			{data[80], data[81], data[82], data[83]} = 32'b1110_01_0_0100_0_0000_0011_000000001000; //STR R3 ,[R0],#8 //MEM[1032] = -2147483648
			{data[84], data[85], data[86], data[87]} = 32'b1110_01_0_0100_0_0000_0011_000000001000; //STR
			
			{data[88], data[89], data[90], data[91]} = 32'b1110_01_0_0100_0_0000_0100_000000001101; //STR
			{data[92], data[93], data[94], data[95]} = 32'b1110_01_0_0100_0_0000_0101_000000010000; //STR
			{data[96], data[97], data[98], data[99]} = 32'b1110_01_0_0100_0_0000_0110_000000010100; //STR
			
			{data[100], data[101], data[102], data[103]} = 32'b1110_01_0_0100_1_0000_1010_000000000100; //LDR
			{data[104], data[105], data[106], data[107]} = 32'b1110_01_0_0100_0_0000_0111_000000011000; //STR
			{data[108], data[109], data[110], data[111]} = 32'b1110_00_1_1101_0_0000_0001_000000000100; //MOV
			{data[112], data[113], data[114], data[115]} = 32'b1110_00_1_1101_0_0000_0010_000000000000; //MOV
			{data[116], data[117], data[118], data[119]} = 32'b1110_00_1_1101_0_0000_0011_000000000000; //MOV
			{data[120], data[121], data[122], data[123]} = 32'b1110_00_0_0100_0_0000_0100_000100000011; //ADD
			{data[124], data[125], data[126], data[127]} = 32'b1110_01_0_0100_1_0100_0101_000000000000; //LDR
			{data[128], data[129], data[130], data[131]} = 32'b1110_01_0_0100_1_0100_0110_000000000100; //LDR
			{data[132], data[133], data[134], data[135]} = 32'b1110_00_0_1010_1_0101_0000_000000000110; //CMP
			{data[136], data[137], data[138], data[139]} = 32'b1100_01_0_0100_0_0100_0110_000000000000; //STRGT
			{data[140], data[141], data[142], data[143]} = 32'b1100_01_0_0100_0_0100_0101_000000000100; //STRGT
			{data[144], data[145], data[146], data[147]} = 32'b1110_00_1_0100_0_0011_0011_000000000001; //ADD
			
			{data[148], data[149], data[150], data[151]} = 32'b1110_00_1_1010_1_0011_0000_000000000011; //CMP
			
			{data[152], data[153], data[154], data[155]} = 32'b1011_10_1_0_111111111111111111110111 ; //BLT
			
			{data[156], data[157], data[158], data[159]} = 32'b1110_00_1_0100_0_0010_0010_000000000001; //ADD
			{data[160], data[161], data[162], data[163]} = 32'b1110_00_0_1010_1_0010_0000_000000000001; //CMP

			{data[164], data[165], data[166], data[167]} = 32'b1011_10_1_0_111111111111111111110011 ; //BLT
			
			{data[168], data[169], data[170], data[171]} = 32'b1110_01_0_0100_1_0000_0001_000000000000; //LDR
			{data[172], data[173], data[174], data[175]} = 32'b1110_01_0_0100_1_0000_0010_000000000100; //LDR
			{data[176], data[177], data[178], data[179]} = 32'b1110_01_0_0100_1_0000_0011_000000001000; //STR
			{data[180], data[181], data[182], data[183]} = 32'b1110_01_0_0100_1_0000_0100_000000001100; //STR
			{data[184], data[185], data[186], data[187]} = 32'b1110_01_0_0100_1_0000_0101_000000010000; //STR
			{data[188], data[189], data[190], data[191]} = 32'b1110_01_0_0100_1_0000_0110_000000010100; //STR
			{data[192], data[193], data[194], data[195]} = 32'b1110_10_1_0_111111111111111111111111 ; //B

			
			data[196] <= 8'b11100000;
			data[197] <= 8'b00000000;
			data[198] <= 8'b00000000;
			data[199] <= 8'b00000000;
					
			data[200] <= 8'b11100000;
			data[201] <= 8'b00000000;
			data[202] <= 8'b00000000;
			data[203] <= 8'b00000000;
			
			data[204] <= 8'b11100000;
			data[205] <= 8'b00000000;
			data[206] <= 8'b00000000;
			data[207] <= 8'b00000000;

			data[208] <= 8'b11100000;
			data[209] <= 8'b00000000;
			data[210] <= 8'b00000000;
			data[211] <= 8'b00000000;
	
		end
		else if (MemRead) begin
			ReadDataTemp <= {
				data[{address[`INSTRUCTION_LEN - 1:2], 2'b00}],
				data[{address[`INSTRUCTION_LEN - 1:2], 2'b01}],
				data[{address[`INSTRUCTION_LEN - 1:2], 2'b10}],
				data[{address[`INSTRUCTION_LEN - 1:2], 2'b11}]
			};
		end
	end
endmodule
