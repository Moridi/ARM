`include "Defines.v"

// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//
// Major Functions: DE2 TOP LEVEL
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Chen       :| 05/08/19  :|      Initial Revision
//   V1.1 :| Johnny Chen       :| 05/11/16  :|      Added FLASH Address FL_ADDR[21:20]
//   V1.2 :| Johnny Chen       :| 05/11/16  :|      Fixed ISP1362 INT/DREQ Pin Direction.   
//   V1.3 :| Johnny Chen       :| 06/11/16  :|      Added the Dedicated TV Decoder Line-Locked-Clock Input
//                                                              for DE2 v2.X PCB.
//   V1.5 :| Eko    Yan        :| 12/01/30  :|      Update to version 11.1 sp1.
// ============================================================================

module ARM_Module
    (
        ////////////////////    Clock Input     ////////////////////     
        CLOCK_27,                       //  27 MHz
        CLOCK_50,                       //  50 MHz
        EXT_CLOCK,                      //  External Clock
        ////////////////////    Push Button     ////////////////////
        KEY,                            //  Pushbutton[3:0]
        ////////////////////    DPDT Switch     ////////////////////
        SW,                             //  Toggle Switch[17:0]
        ////////////////////    7-SEG Dispaly   ////////////////////
        HEX0,                           //  Seven Segment Digit 0
        HEX1,                           //  Seven Segment Digit 1
        HEX2,                           //  Seven Segment Digit 2
        HEX3,                           //  Seven Segment Digit 3
        HEX4,                           //  Seven Segment Digit 4
        HEX5,                           //  Seven Segment Digit 5
        HEX6,                           //  Seven Segment Digit 6
        HEX7,                           //  Seven Segment Digit 7
        ////////////////////////    LED     ////////////////////////
        LEDG,                           //  LED Green[8:0]
        LEDR,                           //  LED Red[17:0]
        ////////////////////////    UART    ////////////////////////
        //UART_TXD,                     //  UART Transmitter
        //UART_RXD,                     //  UART Receiver
        ////////////////////////    IRDA    ////////////////////////
        //IRDA_TXD,                     //  IRDA Transmitter
        //IRDA_RXD,                     //  IRDA Receiver
        /////////////////////   SDRAM Interface     ////////////////
        DRAM_DQ,                        //  SDRAM Data bus 16 Bits
        DRAM_ADDR,                      //  SDRAM Address bus 12 Bits
        DRAM_LDQM,                      //  SDRAM Low-byte Data Mask 
        DRAM_UDQM,                      //  SDRAM High-byte Data Mask
        DRAM_WE_N,                      //  SDRAM Write Enable
        DRAM_CAS_N,                     //  SDRAM Column Address Strobe
        DRAM_RAS_N,                     //  SDRAM Row Address Strobe
        DRAM_CS_N,                      //  SDRAM Chip Select
        DRAM_BA_0,                      //  SDRAM Bank Address 0
        DRAM_BA_1,                      //  SDRAM Bank Address 0
        DRAM_CLK,                       //  SDRAM Clock
        DRAM_CKE,                       //  SDRAM Clock Enable
        ////////////////////    Flash Interface     ////////////////
        FL_DQ,                          //  FLASH Data bus 8 Bits
        FL_ADDR,                        //  FLASH Address bus 22 Bits
        FL_WE_N,                        //  FLASH Write Enable
        FL_RST_N,                       //  FLASH Reset
        FL_OE_N,                        //  FLASH Output Enable
        FL_CE_N,                        //  FLASH Chip Enable
        ////////////////////    SRAM Interface      ////////////////
        SRAM_DQ,                        //  SRAM Data bus 16 Bits
        SRAM_ADDR,                      //  SRAM Address bus 18 Bits
        SRAM_UB_N,                      //  SRAM High-byte Data Mask 
        SRAM_LB_N,                      //  SRAM Low-byte Data Mask 
        SRAM_WE_N,                      //  SRAM Write Enable
        SRAM_CE_N,                      //  SRAM Chip Enable
        SRAM_OE_N,                      //  SRAM Output Enable
        ////////////////////    ISP1362 Interface   ////////////////
        OTG_DATA,                       //  ISP1362 Data bus 16 Bits
        OTG_ADDR,                       //  ISP1362 Address 2 Bits
        OTG_CS_N,                       //  ISP1362 Chip Select
        OTG_RD_N,                       //  ISP1362 Write
        OTG_WR_N,                       //  ISP1362 Read
        OTG_RST_N,                      //  ISP1362 Reset
        OTG_FSPEED,                     //  USB Full Speed, 0 = Enable, Z = Disable
        OTG_LSPEED,                     //  USB Low Speed,  0 = Enable, Z = Disable
        OTG_INT0,                       //  ISP1362 Interrupt 0
        OTG_INT1,                       //  ISP1362 Interrupt 1
        OTG_DREQ0,                      //  ISP1362 DMA Request 0
        OTG_DREQ1,                      //  ISP1362 DMA Request 1
        OTG_DACK0_N,                    //  ISP1362 DMA Acknowledge 0
        OTG_DACK1_N,                    //  ISP1362 DMA Acknowledge 1
        ////////////////////    LCD Module 16X2     ////////////////
        LCD_ON,                         //  LCD Power ON/OFF
        LCD_BLON,                       //  LCD Back Light ON/OFF
        LCD_RW,                         //  LCD Read/Write Select, 0 = Write, 1 = Read
        LCD_EN,                         //  LCD Enable
        LCD_RS,                         //  LCD Command/Data Select, 0 = Command, 1 = Data
        LCD_DATA,                       //  LCD Data bus 8 bits
        ////////////////////    SD_Card Interface   ////////////////
        //SD_DAT,                           //  SD Card Data
        //SD_WP_N,                         //   SD Write protect 
        //SD_CMD,                           //  SD Card Command Signal
        //SD_CLK,                           //  SD Card Clock
        ////////////////////    USB JTAG link   ////////////////////
        TDI,                            // CPLD -> FPGA (data in)
        TCK,                            // CPLD -> FPGA (CLOCK_50)
        TCS,                            // CPLD -> FPGA (CS)
       TDO,                             // FPGA -> CPLD (data out)
        ////////////////////    I2C     ////////////////////////////
        I2C_SDAT,                       //  I2C Data
        I2C_SCLK,                       //  I2C Clock
        ////////////////////    PS2     ////////////////////////////
        PS2_DAT,                        //  PS2 Data
        PS2_CLK,                        //  PS2 Clock
        ////////////////////    VGA     ////////////////////////////
        VGA_CLK,                        //  VGA Clock
        VGA_HS,                         //  VGA H_SYNC
        VGA_VS,                         //  VGA V_SYNC
        VGA_BLANK,                      //  VGA BLANK
        VGA_SYNC,                       //  VGA SYNC
        VGA_R,                          //  VGA Red[9:0]
        VGA_G,                          //  VGA Green[9:0]
        VGA_B,                          //  VGA Blue[9:0]
        ////////////    Ethernet Interface  ////////////////////////
        ENET_DATA,                      //  DM9000A DATA bus 16Bits
        ENET_CMD,                       //  DM9000A Command/Data Select, 0 = Command, 1 = Data
        ENET_CS_N,                      //  DM9000A Chip Select
        ENET_WR_N,                      //  DM9000A Write
        ENET_RD_N,                      //  DM9000A Read
        ENET_RST_N,                     //  DM9000A Reset
        ENET_INT,                       //  DM9000A Interrupt
        ENET_CLK,                       //  DM9000A Clock 25 MHz
        ////////////////    Audio CODEC     ////////////////////////
        AUD_ADCLRCK,                    //  Audio CODEC ADC LR Clock
        AUD_ADCDAT,                     //  Audio CODEC ADC Data
        AUD_DACLRCK,                    //  Audio CODEC DAC LR Clock
        AUD_DACDAT,                     //  Audio CODEC DAC Data
        AUD_BCLK,                       //  Audio CODEC Bit-Stream Clock
        AUD_XCK,                        //  Audio CODEC Chip Clock
        ////////////////    TV Decoder      ////////////////////////
        TD_DATA,                        //  TV Decoder Data bus 8 bits
        TD_HS,                          //  TV Decoder H_SYNC
        TD_VS,                          //  TV Decoder V_SYNC
        TD_RESET,                       //  TV Decoder Reset
        TD_CLK27,                  //   TV Decoder 27MHz CLK
        ////////////////////    GPIO    ////////////////////////////
        GPIO_0,                         //  GPIO Connection 0
        GPIO_1                          //  GPIO Connection 1
    );

////////////////////////    Clock Input     ////////////////////////
input           CLOCK_27;               //  27 MHz
input           CLOCK_50;               //  50 MHz
input              EXT_CLOCK;               //  External Clock
////////////////////////    Push Button     ////////////////////////
input      [3:0]    KEY;                    //  Pushbutton[3:0]
////////////////////////    DPDT Switch     ////////////////////////
input     [17:0]    SW;                     //  Toggle Switch[17:0]
////////////////////////    7-SEG Dispaly   ////////////////////////
output  [6:0]   HEX0;                   //  Seven Segment Digit 0
output  [6:0]   HEX1;                   //  Seven Segment Digit 1
output  [6:0]   HEX2;                   //  Seven Segment Digit 2
output  [6:0]   HEX3;                   //  Seven Segment Digit 3
output  [6:0]   HEX4;                   //  Seven Segment Digit 4
output  [6:0]   HEX5;                   //  Seven Segment Digit 5
output  [6:0]   HEX6;                   //  Seven Segment Digit 6
output  [6:0]   HEX7;                   //  Seven Segment Digit 7
////////////////////////////    LED     ////////////////////////////
output  [8:0]   LEDG;                   //  LED Green[8:0]
output  [17:0]  LEDR;                   //  LED Red[17:0]
////////////////////////////    UART    ////////////////////////////
//output            UART_TXD;               //  UART Transmitter
//input            UART_RXD;                //  UART Receiver
////////////////////////////    IRDA    ////////////////////////////
//output            IRDA_TXD;               //  IRDA Transmitter
//input            IRDA_RXD;                //  IRDA Receiver
///////////////////////     SDRAM Interface ////////////////////////
inout     [15:0]    DRAM_DQ;                //  SDRAM Data bus 16 Bits
output  [11:0]  DRAM_ADDR;              //  SDRAM Address bus 12 Bits
output          DRAM_LDQM;              //  SDRAM Low-byte Data Mask 
output          DRAM_UDQM;              //  SDRAM High-byte Data Mask
output          DRAM_WE_N;              //  SDRAM Write Enable
output          DRAM_CAS_N;             //  SDRAM Column Address Strobe
output          DRAM_RAS_N;             //  SDRAM Row Address Strobe
output          DRAM_CS_N;              //  SDRAM Chip Select
output          DRAM_BA_0;              //  SDRAM Bank Address 0
output          DRAM_BA_1;              //  SDRAM Bank Address 0
output          DRAM_CLK;               //  SDRAM Clock
output          DRAM_CKE;               //  SDRAM Clock Enable
////////////////////////    Flash Interface ////////////////////////
inout     [7:0] FL_DQ;                  //  FLASH Data bus 8 Bits
output [21:0]   FL_ADDR;                //  FLASH Address bus 22 Bits
output          FL_WE_N;                //  FLASH Write Enable
output          FL_RST_N;               //  FLASH Reset
output          FL_OE_N;                //  FLASH Output Enable
output          FL_CE_N;                //  FLASH Chip Enable
////////////////////////    SRAM Interface  ////////////////////////
inout    [15:0] SRAM_DQ;                //  SRAM Data bus 16 Bits
output [17:0]   SRAM_ADDR;              //  SRAM Address bus 18 Bits
output          SRAM_UB_N;              //  SRAM High-byte Data Mask 
output          SRAM_LB_N;              //  SRAM Low-byte Data Mask 
output          SRAM_WE_N;              //  SRAM Write Enable
output          SRAM_CE_N;              //  SRAM Chip Enable
output          SRAM_OE_N;              //  SRAM Output Enable
////////////////////    ISP1362 Interface   ////////////////////////
inout    [15:0] OTG_DATA;               //  ISP1362 Data bus 16 Bits
output  [1:0]   OTG_ADDR;               //  ISP1362 Address 2 Bits
output          OTG_CS_N;               //  ISP1362 Chip Select
output          OTG_RD_N;               //  ISP1362 Write
output          OTG_WR_N;               //  ISP1362 Read
output          OTG_RST_N;              //  ISP1362 Reset
output          OTG_FSPEED;             //  USB Full Speed, 0 = Enable, Z = Disable
output          OTG_LSPEED;             //  USB Low Speed,  0 = Enable, Z = Disable
input              OTG_INT0;                //  ISP1362 Interrupt 0
input              OTG_INT1;                //  ISP1362 Interrupt 1
input              OTG_DREQ0;               //  ISP1362 DMA Request 0
input              OTG_DREQ1;               //  ISP1362 DMA Request 1
output          OTG_DACK0_N;            //  ISP1362 DMA Acknowledge 0
output          OTG_DACK1_N;            //  ISP1362 DMA Acknowledge 1
////////////////////    LCD Module 16X2 ////////////////////////////
inout     [7:0] LCD_DATA;               //  LCD Data bus 8 bits
output          LCD_ON;                 //  LCD Power ON/OFF
output          LCD_BLON;               //  LCD Back Light ON/OFF
output          LCD_RW;                 //  LCD Read/Write Select, 0 = Write, 1 = Read
output          LCD_EN;                 //  LCD Enable
output          LCD_RS;                 //  LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////    SD Card Interface   ////////////////////////
//inout  [3:0]  SD_DAT;                 //  SD Card Data
//input            SD_WP_N;                //   SD write protect
//inout            SD_CMD;                  //  SD Card Command Signal
//output            SD_CLK;                 //  SD Card Clock
////////////////////////    I2C     ////////////////////////////////
inout              I2C_SDAT;                //  I2C Data
output          I2C_SCLK;               //  I2C Clock
////////////////////////    PS2     ////////////////////////////////
input              PS2_DAT;             //  PS2 Data
input              PS2_CLK;             //  PS2 Clock
////////////////////    USB JTAG link   ////////////////////////////
input           TDI;                    // CPLD -> FPGA (data in)
input           TCK;                    // CPLD -> FPGA (CLOCK_50)
input           TCS;                    // CPLD -> FPGA (CS)
output          TDO;                    // FPGA -> CPLD (data out)
////////////////////////    VGA         ////////////////////////////
output          VGA_CLK;                //  VGA Clock
output          VGA_HS;                 //  VGA H_SYNC
output          VGA_VS;                 //  VGA V_SYNC
output          VGA_BLANK;              //  VGA BLANK
output          VGA_SYNC;               //  VGA SYNC
output  [9:0]   VGA_R;                  //  VGA Red[9:0]
output  [9:0]   VGA_G;                  //  VGA Green[9:0]
output  [9:0]   VGA_B;                  //  VGA Blue[9:0]
////////////////    Ethernet Interface  ////////////////////////////
inout   [15:0]  ENET_DATA;              //  DM9000A DATA bus 16Bits
output          ENET_CMD;               //  DM9000A Command/Data Select, 0 = Command, 1 = Data
output          ENET_CS_N;              //  DM9000A Chip Select
output          ENET_WR_N;              //  DM9000A Write
output          ENET_RD_N;              //  DM9000A Read
output          ENET_RST_N;             //  DM9000A Reset
input              ENET_INT;                //  DM9000A Interrupt
output          ENET_CLK;               //  DM9000A Clock 25 MHz
////////////////////    Audio CODEC     ////////////////////////////
inout              AUD_ADCLRCK;         //  Audio CODEC ADC LR Clock
input              AUD_ADCDAT;              //  Audio CODEC ADC Data
inout              AUD_DACLRCK;         //  Audio CODEC DAC LR Clock
output          AUD_DACDAT;             //  Audio CODEC DAC Data
inout              AUD_BCLK;                //  Audio CODEC Bit-Stream Clock
output          AUD_XCK;                //  Audio CODEC Chip Clock
////////////////////    TV Devoder      ////////////////////////////
input    [7:0]  TD_DATA;                //  TV Decoder Data bus 8 bits
input              TD_HS;                   //  TV Decoder H_SYNC
input              TD_VS;                   //  TV Decoder V_SYNC
output          TD_RESET;               //  TV Decoder Reset
input          TD_CLK27;            //  TV Decoder 27MHz CLK
////////////////////////    GPIO    ////////////////////////////////
inout   [35:0]  GPIO_0;                 //  GPIO Connection 0
inout   [35:0]  GPIO_1;                 //  GPIO Connection 1

    wire en_forwarding, rst;
    assign en_forwarding = SW[10];
    assign rst = SW[13];
    wire MEM_ready;

    // ##############################               
    // ########## IF Stage ##########
    // ##############################               

    wire branch_taken_EXE_out, branch_taken_ID_out;
    wire hazard_detected, flush;
    wire[`ADDRESS_LEN - 1:0] branch_address;
    wire[`ADDRESS_LEN - 1:0] PC_IF, PC_ID;
                                
    wire[`INSTRUCTION_LEN - 1:0] Instruction_IF;
    
    assign flush = branch_taken_ID_out;
    
    IF_Stage_Module IF_Stage_Module(
        // inputs:
            .clk(CLOCK_50), .rst(rst),
            .freeze_in(hazard_detected | ~MEM_ready),
            .Branch_taken_in(branch_taken_ID_out),
            .flush_in(flush),
            .BranchAddr_in(branch_address),

        //outputs from reg:
            .PC_out(PC_IF),
            .Instruction_out(Instruction_IF)
    );  
            
    // ##############################               
    // ########## ID Stage ##########
    // ##############################
    wire ID_two_src, ignore_hazard_ID_out;
    wire [`REG_ADDRESS_LEN - 1:0] reg_file_second_src_out, reg_file_first_src_out;
    wire [3:0] status_reg_ID_out;
    
    wire mem_read_ID_out, mem_write_ID_out,
        wb_enable_ID_out, immediate_ID_out,
        status_write_enable_ID_out;
        
    wire [`EXECUTE_COMMAND_LEN - 1 : 0] execute_command_ID_out;
    wire [`REGISTER_LEN - 1:0] reg_file_ID_out1, reg_file_ID_out2;
    wire [`REG_ADDRESS_LEN - 1:0] staged_reg_file_ID_out1, staged_reg_file_ID_out2;
    wire [`REG_ADDRESS_LEN - 1:0] dest_reg_ID_out;
    wire [`SIGNED_IMMEDIATE_LEN - 1:0] signed_immediate_ID_out;
    wire [`SHIFT_OPERAND_LEN - 1:0] shift_operand_ID_out;
    
    wire wb_enable_WB_out;  
    wire [`REG_ADDRESS_LEN - 1:0] wb_dest_WB_out;
    wire [`REGISTER_LEN - 1:0] wb_value_WB;
    wire[3:0] status_reg_ID_in;
                
    ID_Stage_Module ID_Stage_Module(
        // Inputs:
            .clk(CLOCK_50), .rst(rst), .PC_in(PC_IF),
            .Instruction_in(Instruction_IF),
            .status_reg_in(status_reg_ID_in),
            .hazard(hazard_detected),
            .flush(flush),
            .freeze(~MEM_ready),

        // Register file inputs:
            .reg_file_wb_data(wb_value_WB),
            .reg_file_wb_address(wb_dest_WB_out),
            .reg_file_wb_en(wb_enable_WB_out),

        // Wired Outputs:
            .two_src_out(ID_two_src),
            .reg_file_second_src_out(reg_file_second_src_out),
            .reg_file_first_src_out(reg_file_first_src_out),
            .ignore_hazard_out(ignore_hazard_ID_out),

        // Registered Outputs:
            .PC_out(PC_ID),
            .mem_read_en_out(mem_read_ID_out),
            .mem_write_en_out(mem_write_ID_out),
            .wb_enable_out(wb_enable_ID_out),
            .immediate_out(immediate_ID_out),
            .branch_taken_out(branch_taken_ID_out),
            .status_write_enable_out(status_write_enable_ID_out),       
            .execute_command_out(execute_command_ID_out),
            .reg_file_out1(reg_file_ID_out1),
            .reg_file_out2(reg_file_ID_out2),
            .dest_reg_out(dest_reg_ID_out),
            .signed_immediate_out(signed_immediate_ID_out),
            .shift_operand_out(shift_operand_ID_out),
            .status_reg_out(status_reg_ID_out),

            .staged_reg_file_first_src_out(staged_reg_file_ID_out1),
            .staged_reg_file_second_src_out(staged_reg_file_ID_out2)
        );

    // ###############################              
    // ########## EXE Stage ##########
    // ###############################  
    wire [1:0] EXE_alu_mux_sel_src1, EXE_alu_mux_sel_src2;
    wire wb_enable_EXE_out, mem_read_EXE_out, mem_write_EXE_out;
    wire [`REGISTER_LEN - 1:0] alu_res_EXE_out, val_Rm_EXE_out;
    wire [`REG_ADDRESS_LEN - 1:0] dest_EXE_out;

    wire wb_en_hazard_EXE_out;
    wire [`REG_ADDRESS_LEN - 1:0] dest_hazard_EXE_out;
    wire status_w_en_EXE_out;
    wire [3:0] status_reg_EXE_out;
            
    EX_Stage_Module EX_Stage_Module(
        //inputs to main moduel:
            .clk(CLOCK_50), .rst(rst),
            .freeze(~MEM_ready),
            .PC_in(PC_ID),
            .wb_en_in(wb_enable_ID_out), .mem_r_en_in(mem_read_ID_out),
            .mem_w_en_in(mem_write_ID_out),
            .status_w_en_in(status_write_enable_ID_out),
            .branch_taken_in(branch_taken_ID_out),
            .immd(immediate_ID_out),
            .exe_cmd(execute_command_ID_out),
            .val_Rn(reg_file_ID_out1),
            .val_Rm_in(reg_file_ID_out2),
            .dest_in(dest_reg_ID_out),
            .signed_immd_24(signed_immediate_ID_out),
            .shift_operand(shift_operand_ID_out),
            .status_reg_in(status_reg_ID_out),

        //forwarding inputs:
            .alu_mux_sel_src1(EXE_alu_mux_sel_src1),
            .alu_mux_sel_src2(EXE_alu_mux_sel_src2),
            .MEM_wb_value(alu_res_EXE_out),
            .WB_wb_value(wb_value_WB),


        // outputs from Reg:
            .wb_en_out(wb_enable_EXE_out),
            .mem_r_en_out(mem_read_EXE_out),
            .mem_w_en_out(mem_write_EXE_out),
            .alu_res_out(alu_res_EXE_out),
            .val_Rm_out(val_Rm_EXE_out),
            .dest_out(dest_EXE_out),

        //outputs from main module:
            .wb_en_hazard_in(wb_en_hazard_EXE_out),
            .dest_hazard_in(dest_hazard_EXE_out),
            .status_w_en_out(status_w_en_EXE_out),
            .branch_taken_out(branch_taken_EXE_out),
            .statusRegister_out(status_reg_EXE_out),
            .branch_address_out(branch_address)
    );
    

    // ##############################               
    // ########## MEM Stage ##########
    // ##############################               

    wire wb_en_MEM_out, mem_r_en_MEM_out;
    wire [`REGISTER_LEN - 1:0] alu_res_MEM_out, mem_res_MEM_out;
    wire [`REG_ADDRESS_LEN - 1:0] dest_MEM_out;

    wire wb_en_hazard_MEM_out;
    wire [`REG_ADDRESS_LEN - 1:0] dest_hazard_MEM_out;
    
    MEM_Stage_Module MEM_Stage_Module(
        //inputs to main moduel:
            .clk(CLOCK_50), .rst(rst),
            .freeze(~MEM_ready),
            .wb_en_in(wb_enable_EXE_out),
            .mem_r_en_in(mem_read_EXE_out),
            .mem_w_en_in(mem_write_EXE_out),
            .alu_res_in(alu_res_EXE_out), .val_Rm(val_Rm_EXE_out),
            .dest_in(dest_EXE_out),

        // outputs from Reg:
            .wb_en_out(wb_en_MEM_out), .mem_r_en_out(mem_r_en_MEM_out),
            .alu_res_out(alu_res_MEM_out), .mem_res_out(mem_res_MEM_out),
            .dest_out(dest_MEM_out),

        //outputs from stage:
            .wb_en_hazard_in(wb_en_hazard_MEM_out),
            .dest_hazard_in(dest_hazard_MEM_out),
            .ready(MEM_ready),

        ////////////////////////    SRAM Interface  ////////////////////////
            .SRAM_DQ(SRAM_DQ),                  //  SRAM Data bus 16 Bits
            .SRAM_ADDR(SRAM_ADDR),              //  SRAM Address bus 18 Bits
            .SRAM_UB_N(SRAM_UB_N),              //  SRAM High-byte Data Mask 
            .SRAM_LB_N(SRAM_LB_N),              //  SRAM Low-byte Data Mask 
            .SRAM_WE_N(SRAM_WE_N),              //  SRAM Write Enable
            .SRAM_CE_N(SRAM_CE_N),              //  SRAM Chip Enable
            .SRAM_OE_N(SRAM_OE_N)               //  SRAM Output Enable
    );

    // ##############################       
    // ########## WB Stage ##########       
    // ##############################

    WB_Stage WB_Stage(
        // inputs:
            .clk(CLOCK_50),
            .rst(rst),
            .mem_read_enable(mem_r_en_MEM_out),
            .wb_enable_in(wb_en_MEM_out),
            
            .alu_result(alu_res_MEM_out),
            .data_memory(mem_res_MEM_out),
            .wb_dest_in(dest_MEM_out),
        
        // outputs:
            .wb_enable_out(wb_enable_WB_out),
            
            .wb_dest_out(wb_dest_WB_out),
            .wb_value(wb_value_WB)
    );

    // ##############################
    // #### top module elements #####
    // ##############################
    wire ignore_hazard_forwarding_out;

    Status_Register Status_Register(
    .clk(CLOCK_50), .rst(rst),
    .ld(status_w_en_EXE_out),
    .data_out(status_reg_ID_in),
    .data_in(status_reg_EXE_out)
    );
    
    Hazard_Detection_Unit hazard_detection_unit(
        //inputs:
            .with_forwarding(en_forwarding),
            .have_two_src(ID_two_src),
            .src1_address(reg_file_first_src_out),
            .src2_address(reg_file_second_src_out),
            .ignore_hazard(ignore_hazard_ID_out),
            .ignore_from_forwarding(ignore_hazard_forwarding_out),
            // TODO : get it from EXE
            .EXE_mem_read_en(mem_read_ID_out),

            .exe_wb_dest(dest_hazard_EXE_out),
            .exe_wb_en(wb_en_hazard_EXE_out),
            
            .mem_wb_dest(dest_hazard_MEM_out),
            .mem_wb_en(wb_en_hazard_MEM_out),
        // outputs:
            .hazard_detected(hazard_detected)
    );

    Forwarding forwarding(
        .en_forwarding(en_forwarding),

        .ID_src1(staged_reg_file_ID_out1),
        .ID_src2(staged_reg_file_ID_out2),

        .MEM_wb_en(wb_en_hazard_MEM_out),
        .MEM_dst(dest_hazard_MEM_out),

        .WB_wb_en(wb_enable_WB_out),
        .WB_dst(wb_dest_WB_out),
        
        .sel_src1(EXE_alu_mux_sel_src1),
        .sel_src2(EXE_alu_mux_sel_src2),
        .ignore_hazard(ignore_hazard_forwarding_out)
    );

endmodule
