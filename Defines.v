`define ADDRESS_LEN	32
`define INSTRUCTION_LEN	32
`define INSTRUCTION_MEM_LEN 8
`define INSTRUCTION_MEM_SIZE 256

`define REG_ADDRESS_LEN 4
`define REGISTER_LEN 32
`define REGISTER_MEM_SIZE 15

`define MODE_LEN 2
`define ARITHMETHIC_TYPE 2'b00
`define MEMORY_TYPE 2'b01
`define BRANCH_TYPE 2'b10

`define OPCODE_LEN 4

`define EXECUTE_COMMAND_LEN 4
`define MOV 4'b0001
`define MOVN 4'b1001
`define ADD 4'b0010
`define ADC 4'b0011
`define SUB 4'b0100
`define SBC 4'b0101
`define AND 4'b0110
`define ORR 4'b0111
`define EOR 4'b1000
`define CMP 4'b0100
`define TST 4'b0110
`define LDR 4'b0010
`define STR 4'b0010