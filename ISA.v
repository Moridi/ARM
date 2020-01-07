`define COND_LEN 4
`define OPCODE_LEN 4
`define EXECUTE_COMMAND_LEN 4
`define MODE_LEN 2

// Instruction OpCode
`define MOV 4'b1101
`define MOVN 4'b1111
`define ADD 4'b0100
`define ADC 4'b0101
`define SUB 4'b0010
`define SBC 4'b0110
`define AND 4'b0000
`define ORR 4'b1100
`define EOR 4'b0001
`define CMP 4'b1010
`define TST 4'b1000
`define LDR 4'b0100
`define STR 4'b0100
// `define MUL 4'b0000