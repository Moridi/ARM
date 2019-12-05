`include "ISA.v"

`define ADDRESS_LEN	32
`define INSTRUCTION_LEN	32
`define SIGNED_IMMEDIATE_LEN 24
`define INSTRUCTION_MEM_LEN 8
`define INSTRUCTION_MEM_SIZE 256
// @TODO: Change it
`define DATA_MEMORY_SIZE 512
`define DATA_MEMORY_LEN 8
`define SHIFT_OPERAND_LEN 12
`define SHIFT_OPERAND_INDEX 12

`define REG_ADDRESS_LEN 4
`define REGISTER_LEN 32
`define REGISTER_MEM_SIZE 16

`define ARITHMETHIC_TYPE 2'b00
`define MEMORY_TYPE 2'b01
`define BRANCH_TYPE 2'b10

// Instruction OpCode
`define MOV_EXE 4'b0001
`define MOVN_EXE 4'b1001
`define ADD_EXE 4'b0010
`define ADC_EXE 4'b0011
`define SUB_EXE 4'b0100
`define SBC_EXE 4'b0101
`define AND_EXE 4'b0110
`define ORR_EXE 4'b0111
`define EOR_EXE 4'b1000
`define CMP_EXE 4'b1100
`define TST_EXE 4'b1110
`define LDR_EXE 4'b1010
`define STR_EXE 4'b1010

`define COND_EQ 4'b0000
`define COND_NE 4'b0001
`define COND_CS_HS 4'b0010
`define COND_CC_LO 4'b0011
`define COND_MI 4'b0100
`define COND_PL 4'b0101
`define COND_VS 4'b0110
`define COND_VC 4'b0111
`define COND_HI 4'b1000
`define COND_LS 4'b1001
`define COND_GE 4'b1010
`define COND_LT 4'b1011
`define COND_GT 4'b1100
`define COND_LE 4'b1101
`define COND_AL 4'b1110

`define S_ZERO 1'b0
`define S_ONE 1'b1
`define ENABLE 1'b1
`define DISABLE 1'b0

`define LSL_SHIFT_STATE 2'b00
`define LSR_SHIFT_STATE 2'b01
`define ASR_SHIFT_STATE 2'b10
`define ROR_SHIFT_STATE 2'b11

//forwarding
`define FORW_SEL_FROM_ID 2'b00
`define FORW_SEL_FROM_EXE 2'b01
`define FORW_SEL_FROM_MEM 2'b10