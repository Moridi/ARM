module TB();

    // // reg clk = 1'b0, rst = 1'b0;
    // reg CLOCK_27;
    // reg  CLOCK_50 = 1'b0;
    // reg  EXT_CLOCK;
    // reg  [3:0]   KEY;
    // reg  [17:0]  SW;
    // wire [6:0]   HEX0;
    // wire [6:0]   HEX1;
    // wire [6:0]   HEX2;
    // wire [6:0]   HEX3;
    // wire [6:0]   HEX4;
    // wire [6:0]   HEX5;
    // wire [6:0]   HEX6;
    // wire [6:0]   HEX7;
    // wire [8:0]   LEDG;
    // wire [17:0]  LEDR;
    // reg [15:0]   DRAM_DQ;
    // wire [11:0]  DRAM_ADDR;
    // wire DRAM_LDQM;
    // wire DRAM_UDQM;
    // wire DRAM_WE_N;
    // wire DRAM_CAS_N;
    // wire DRAM_RAS_N;
    // wire DRAM_CS_N;
    // wire DRAM_BA_0;
    // wire DRAM_BA_1;
    // wire DRAM_CLK;
    // wire DRAM_CKE;
    // reg  [7:0]   FL_DQ;
    // wire [21:0]  FL_ADDR;
    // wire FL_WE_N;
    // wire FL_RST_N;
    // wire FL_OE_N;
    // wire FL_CE_N;
    // reg [15:0]   SRAM_DQ;
    // wire [17:0]  SRAM_ADDR;
    // wire SRAM_UB_N;
    // wire SRAM_LB_N;
    // wire SRAM_WE_N;
    // wire SRAM_CE_N;
    // wire SRAM_OE_N;
    // reg [15:0]   OTG_DATA;
    // wire [1:0] OTG_ADDR;
    // wire OTG_CS_N;
    // wire OTG_RD_N;
    // wire OTG_WR_N;
    // wire OTG_RST_N;
    // wire OTG_FSPEED;
    // wire OTG_LSPEED;
    // reg OTG_INT0;
    // reg OTG_INT1;
    // reg OTG_DREQ0;
    // reg OTG_DREQ1;
    // wire OTG_DACK0_N;
    // wire OTG_DACK1_N;
    // wire LCD_ON;
    // wire LCD_BLON;
    // wire LCD_RW;
    // wire LCD_EN;
    // wire LCD_RS;
    // reg [7:0] LCD_DATA;
    // reg TDI;
    // reg TCK;
    // reg TCS;
    // reg TDO;
    // reg I2C_SDAT;
    // wire I2C_SCLK;
    // wire PS2_DAT;
    // wire PS2_CLK;
    // wire VGA_CLK;
    // wire VGA_HS;
    // wire VGA_VS;
    // wire VGA_BLANK;
    // wire VGA_SYNC;
    // wire VGA_R;
    // wire VGA_G;
    // wire VGA_B;
    // wire ENET_DATA;
    // wire ENET_CMD;
    // wire ENET_CS_N;
    // wire ENET_WR_N;
    // wire ENET_RD_N;
    // wire ENET_RST_N;
    // wire ENET_INT;
    // wire ENET_CLK;
    // wire AUD_ADCLRCK;
    // wire AUD_ADCDAT;
    // wire AUD_DACLRCK;
    // wire AUD_DACDAT;
    // wire AUD_BCLK;
    // wire AUD_XCK;
    // wire TD_DATA;
    // wire TD_HS;
    // wire TD_VS;
    // wire TD_RESET;
    // wire TD_CLK27;
    // wire GPIO_0;
    // wire GPIO_1
    // ;

    ////////////////////////    Clock reg       ////////////////////////
reg         CLOCK_27;               //  27 MHz
reg         CLOCK_50 = 1'b0;               //  50 MHz
reg            EXT_CLOCK;               //  External Clock
////////////////////////    Push Button     ////////////////////////
reg    [3:0]    KEY;                    //  Pushbutton[3:0]
////////////////////////    DPDT Switch     ////////////////////////
reg   [17:0]    SW;                     //  Toggle Switch[17:0]
////////////////////////    7-SEG Dispaly   ////////////////////////
wire    [6:0]   HEX0;                   //  Seven Segment Digit 0
wire    [6:0]   HEX1;                   //  Seven Segment Digit 1
wire    [6:0]   HEX2;                   //  Seven Segment Digit 2
wire    [6:0]   HEX3;                   //  Seven Segment Digit 3
wire    [6:0]   HEX4;                   //  Seven Segment Digit 4
wire    [6:0]   HEX5;                   //  Seven Segment Digit 5
wire    [6:0]   HEX6;                   //  Seven Segment Digit 6
wire    [6:0]   HEX7;                   //  Seven Segment Digit 7
////////////////////////////    LED     ////////////////////////////
wire    [8:0]   LEDG;                   //  LED Green[8:0]
wire  [17:0]    LEDR;                   //  LED Red[17:0]
////////////////////////////    UART    ////////////////////////////
//wire          UART_TXD;               //  UART Transmitter
//reg              UART_RXD;                //  UART Receiver
////////////////////////////    IRDA    ////////////////////////////
//wire          IRDA_TXD;               //  IRDA Transmitter
//reg              IRDA_RXD;                //  IRDA Receiver
///////////////////////     SDRAM Interface ////////////////////////
wire      [15:0]    DRAM_DQ;                //  SDRAM Data bus 16 Bits
wire  [11:0]    DRAM_ADDR;              //  SDRAM Address bus 12 Bits
wire            DRAM_LDQM;              //  SDRAM Low-byte Data Mask 
wire            DRAM_UDQM;              //  SDRAM High-byte Data Mask
wire            DRAM_WE_N;              //  SDRAM Write Enable
wire            DRAM_CAS_N;             //  SDRAM Column Address Strobe
wire            DRAM_RAS_N;             //  SDRAM Row Address Strobe
wire            DRAM_CS_N;              //  SDRAM Chip Select
wire            DRAM_BA_0;              //  SDRAM Bank Address 0
wire            DRAM_BA_1;              //  SDRAM Bank Address 0
wire            DRAM_CLK;               //  SDRAM Clock
wire            DRAM_CKE;               //  SDRAM Clock Enable
////////////////////////    Flash Interface ////////////////////////
wire      [7:0] FL_DQ;                  //  FLASH Data bus 8 Bits
wire [21:0] FL_ADDR;                //  FLASH Address bus 22 Bits
wire            FL_WE_N;                //  FLASH Write Enable
wire            FL_RST_N;               //  FLASH Reset
wire            FL_OE_N;                //  FLASH wire Enable
wire            FL_CE_N;                //  FLASH Chip Enable
////////////////////////    SRAM Interface  ////////////////////////
wire     [15:0] SRAM_DQ;                //  SRAM Data bus 16 Bits
wire [17:0] SRAM_ADDR;              //  SRAM Address bus 18 Bits
wire            SRAM_UB_N;              //  SRAM High-byte Data Mask 
wire            SRAM_LB_N;              //  SRAM Low-byte Data Mask 
wire            SRAM_WE_N;              //  SRAM Write Enable
wire            SRAM_CE_N;              //  SRAM Chip Enable
wire            SRAM_OE_N;              //  SRAM wire Enable
////////////////////    ISP1362 Interface   ////////////////////////
wire     [15:0] OTG_DATA;               //  ISP1362 Data bus 16 Bits
wire  [1:0] OTG_ADDR;               //  ISP1362 Address 2 Bits
wire            OTG_CS_N;               //  ISP1362 Chip Select
wire            OTG_RD_N;               //  ISP1362 Write
wire            OTG_WR_N;               //  ISP1362 Read
wire            OTG_RST_N;              //  ISP1362 Reset
wire            OTG_FSPEED;             //  USB Full Speed, 0 = Enable, Z = Disable
wire            OTG_LSPEED;             //  USB Low Speed,  0 = Enable, Z = Disable
reg            OTG_INT0;                //  ISP1362 Interrupt 0
reg            OTG_INT1;                //  ISP1362 Interrupt 1
reg            OTG_DREQ0;               //  ISP1362 DMA Request 0
reg            OTG_DREQ1;               //  ISP1362 DMA Request 1
wire            OTG_DACK0_N;            //  ISP1362 DMA Acknowledge 0
wire            OTG_DACK1_N;            //  ISP1362 DMA Acknowledge 1
////////////////////    LCD Module 16X2 ////////////////////////////
wire      [7:0] LCD_DATA;               //  LCD Data bus 8 bits
wire            LCD_ON;                 //  LCD Power ON/OFF
wire            LCD_BLON;               //  LCD Back Light ON/OFF
wire            LCD_RW;                 //  LCD Read/Write Select, 0 = Write, 1 = Read
wire            LCD_EN;                 //  LCD Enable
wire            LCD_RS;                 //  LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////    SD Card Interface   ////////////////////////
//wire   [3:0]  SD_DAT;                 //  SD Card Data
//reg              SD_WP_N;                //   SD write protect
//wire             SD_CMD;                  //  SD Card Command Signal
//wire          SD_CLK;                 //  SD Card Clock
////////////////////////    I2C     ////////////////////////////////
wire               I2C_SDAT;                //  I2C Data
wire            I2C_SCLK;               //  I2C Clock
////////////////////////    PS2     ////////////////////////////////
reg            PS2_DAT;             //  PS2 Data
reg            PS2_CLK;             //  PS2 Clock
////////////////////    USB JTAG link   ////////////////////////////
reg             TDI;                    // CPLD -> FPGA (data in)
reg             TCK;                    // CPLD -> FPGA (CLOCK_50)
reg             TCS;                    // CPLD -> FPGA (CS)
wire            TDO;                    // FPGA -> CPLD (data out)
////////////////////////    VGA         ////////////////////////////
wire            VGA_CLK;                //  VGA Clock
wire            VGA_HS;                 //  VGA H_SYNC
wire            VGA_VS;                 //  VGA V_SYNC
wire            VGA_BLANK;              //  VGA BLANK
wire            VGA_SYNC;               //  VGA SYNC
wire    [9:0]   VGA_R;                  //  VGA Red[9:0]
wire    [9:0]   VGA_G;                  //  VGA Green[9:0]
wire    [9:0]   VGA_B;                  //  VGA Blue[9:0]
////////////////    Ethernet Interface  ////////////////////////////
wire    [15:0]  ENET_DATA;              //  DM9000A DATA bus 16Bits
wire            ENET_CMD;               //  DM9000A Command/Data Select, 0 = Command, 1 = Data
wire            ENET_CS_N;              //  DM9000A Chip Select
wire            ENET_WR_N;              //  DM9000A Write
wire            ENET_RD_N;              //  DM9000A Read
wire            ENET_RST_N;             //  DM9000A Reset
reg            ENET_INT;                //  DM9000A Interrupt
wire            ENET_CLK;               //  DM9000A Clock 25 MHz
////////////////////    Audio CODEC     ////////////////////////////
wire               AUD_ADCLRCK;         //  Audio CODEC ADC LR Clock
reg            AUD_ADCDAT;              //  Audio CODEC ADC Data
wire               AUD_DACLRCK;         //  Audio CODEC DAC LR Clock
wire            AUD_DACDAT;             //  Audio CODEC DAC Data
wire               AUD_BCLK;                //  Audio CODEC Bit-Stream Clock
wire            AUD_XCK;                //  Audio CODEC Chip Clock
////////////////////    TV Devoder      ////////////////////////////
reg  [7:0]  TD_DATA;                //  TV Decoder Data bus 8 bits
reg            TD_HS;                   //  TV Decoder H_SYNC
reg            TD_VS;                   //  TV Decoder V_SYNC
wire            TD_RESET;               //  TV Decoder Reset
reg          TD_CLK27;            //    TV Decoder 27MHz CLK
////////////////////////    GPIO    ////////////////////////////////
wire    [35:0]  GPIO_0;                 //  GPIO Connection 0
wire    [35:0]  GPIO_1;                 //  GPIO Connection 1

    
    ARM_Module ARM(
        .CLOCK_27(CLOCK_27),                        //  27 MHz
        .CLOCK_50(CLOCK_50),                        //  50 MHz
        .EXT_CLOCK(EXT_CLOCK),                      //  External Clock
        .KEY(KEY),                          //  Pushbutton[3:0]
        .SW(SW),                                //  Toggle Switch[17:0]
        .HEX0(HEX0),                            //  Seven Segment Digit 0
        .HEX1(HEX1),                            //  Seven Segment Digit 1
        .HEX2(HEX2),                            //  Seven Segment Digit 2
        .HEX3(HEX3),                            //  Seven Segment Digit 3
        .HEX4(HEX4),                            //  Seven Segment Digit 4
        .HEX5(HEX5),                            //  Seven Segment Digit 5
        .HEX6(HEX6),                            //  Seven Segment Digit 6
        .HEX7(HEX7),                            //  Seven Segment Digit 7
        .LEDG(LEDG),                            //  LED Green[8:0]
        .LEDR(LEDR),                            //  LED Red[17:0]
        .DRAM_DQ(DRAM_DQ),                      //  SDRAM Data bus 16 Bits
        .DRAM_ADDR(DRAM_ADDR),                      //  SDRAM Address bus 12 Bits
        .DRAM_LDQM(DRAM_LDQM),                      //  SDRAM Low-byte Data Mask 
        .DRAM_UDQM(DRAM_UDQM),                      //  SDRAM High-byte Data Mask
        .DRAM_WE_N(DRAM_WE_N),                      //  SDRAM Write Enable
        .DRAM_CAS_N(DRAM_CAS_N),                        //  SDRAM Column Address Strobe
        .DRAM_RAS_N(DRAM_RAS_N),                        //  SDRAM Row Address Strobe
        .DRAM_CS_N(DRAM_CS_N),                      //  SDRAM Chip Select
        .DRAM_BA_0(DRAM_BA_0),                      //  SDRAM Bank Address 0
        .DRAM_BA_1(DRAM_BA_1),                      //  SDRAM Bank Address 0
        .DRAM_CLK(DRAM_CLK),                        //  SDRAM Clock
        .DRAM_CKE(DRAM_CKE),                        //  SDRAM Clock Enable
        .FL_DQ(FL_DQ),                          //  FLASH Data bus 8 Bits
        .FL_ADDR(FL_ADDR),                      //  FLASH Address bus 22 Bits
        .FL_WE_N(FL_WE_N),                      //  FLASH Write Enable
        .FL_RST_N(FL_RST_N),                        //  FLASH Reset
        .FL_OE_N(FL_OE_N),                      //  FLASH wire Enable
        .FL_CE_N(FL_CE_N),                      //  FLASH Chip Enable
        .SRAM_DQ(SRAM_DQ),                      //  SRAM Data bus 16 Bits
        .SRAM_ADDR(SRAM_ADDR),                      //  SRAM Address bus 18 Bits
        .SRAM_UB_N(SRAM_UB_N),                      //  SRAM High-byte Data Mask 
        .SRAM_LB_N(SRAM_LB_N),                      //  SRAM Low-byte Data Mask 
        .SRAM_WE_N(SRAM_WE_N),                      //  SRAM Write Enable
        .SRAM_CE_N(SRAM_CE_N),                      //  SRAM Chip Enable
        .SRAM_OE_N(SRAM_OE_N),                      //  SRAM wire Enable
        .OTG_DATA(OTG_DATA),                        //  ISP1362 Data bus 16 Bits
        .OTG_ADDR(OTG_ADDR),                        //  ISP1362 Address 2 Bits
        .OTG_CS_N(OTG_CS_N),                        //  ISP1362 Chip Select
        .OTG_RD_N(OTG_RD_N),                        //  ISP1362 Write
        .OTG_WR_N(OTG_WR_N),                        //  ISP1362 Read
        .OTG_RST_N(OTG_RST_N),                      //  ISP1362 Reset
        .OTG_FSPEED(OTG_FSPEED),                        //  USB Full Speed, 0 = Enable, Z = Disable
        .OTG_LSPEED(OTG_LSPEED),                        //  USB Low Speed,  0 = Enable, Z = Disable
        .OTG_INT0(OTG_INT0),                        //  ISP1362 Interrupt 0
        .OTG_INT1(OTG_INT1),                        //  ISP1362 Interrupt 1
        .OTG_DREQ0(OTG_DREQ0),                      //  ISP1362 DMA Request 0
        .OTG_DREQ1(OTG_DREQ1),                      //  ISP1362 DMA Request 1
        .OTG_DACK0_N(OTG_DACK0_N),                  //  ISP1362 DMA Acknowledge 0
        .OTG_DACK1_N(OTG_DACK1_N),                  //  ISP1362 DMA Acknowledge 1
        .LCD_ON(LCD_ON),                            //  LCD Power ON/OFF
        .LCD_BLON(LCD_BLON),                        //  LCD Back Light ON/OFF
        .LCD_RW(LCD_RW),                            //  LCD Read/Write Select, 0 = Write, 1 = Read
        .LCD_EN(LCD_EN),                            //  LCD Enable
        .LCD_RS(LCD_RS),                            //  LCD Command/Data Select, 0 = Command, 1 = Data
        .LCD_DATA(LCD_DATA),                        //  LCD Data bus 8 bits
        .TDI(TDI),                              // CPLD -> FPGA (data in)
        .TCK(TCK),                              // CPLD -> FPGA (CLOCK_50)
        .TCS(TCS),                              // CPLD -> FPGA (CS)
        .TDO(TDO),                              // FPGA -> CPLD (data out)
        .I2C_SDAT(I2C_SDAT),                        //  I2C Data
        .I2C_SCLK(I2C_SCLK),                        //  I2C Clock
        .PS2_DAT(PS2_DAT),                      //  PS2 Data
        .PS2_CLK(PS2_CLK),                      //  PS2 Clock
        .VGA_CLK(VGA_CLK),                          //  VGA Clock
        .VGA_HS(VGA_HS),                            //  VGA H_SYNC
        .VGA_VS(VGA_VS),                            //  VGA V_SYNC
        .VGA_BLANK(VGA_BLANK),                      //  VGA BLANK
        .VGA_SYNC(VGA_SYNC),                        //  VGA SYNC
        .VGA_R(VGA_R),                          //  VGA Red[9:0]
        .VGA_G(VGA_G),                          //  VGA Green[9:0]
        .VGA_B(VGA_B),                          //  VGA Blue[9:0]
        .ENET_DATA(ENET_DATA),                      //  DM9000A DATA bus 16Bits
        .ENET_CMD(ENET_CMD),                        //  DM9000A Command/Data Select, 0 = Command, 1 = Data
        .ENET_CS_N(ENET_CS_N),                      //  DM9000A Chip Select
        .ENET_WR_N(ENET_WR_N),                      //  DM9000A Write
        .ENET_RD_N(ENET_RD_N),                      //  DM9000A Read
        .ENET_RST_N(ENET_RST_N),                        //  DM9000A Reset
        .ENET_INT(ENET_INT),                        //  DM9000A Interrupt
        .ENET_CLK(ENET_CLK),                        //  DM9000A Clock 25 MHz
        .AUD_ADCLRCK(AUD_ADCLRCK),                  //  Audio CODEC ADC LR Clock
        .AUD_ADCDAT(AUD_ADCDAT),                        //  Audio CODEC ADC Data
        .AUD_DACLRCK(AUD_DACLRCK),                  //  Audio CODEC DAC LR Clock
        .AUD_DACDAT(AUD_DACDAT),                        //  Audio CODEC DAC Data
        .AUD_BCLK(AUD_BCLK),                        //  Audio CODEC Bit-Stream Clock
        .AUD_XCK(AUD_XCK),                      //  Audio CODEC Chip Clock
        .TD_DATA(TD_DATA),                      //  TV Decoder Data bus 8 bits
        .TD_HS(TD_HS),                          //  TV Decoder H_SYNC
        .TD_VS(TD_VS),                          //  TV Decoder V_SYNC
        .TD_RESET(TD_RESET),                        //  TV Decoder Reset
        .TD_CLK27(TD_CLK27),                  //    TV Decoder 27MHz CLK        
        .GPIO_0(GPIO_0),                            //  GPIO Connection 0
        .GPIO_1(GPIO_1)                         //  GPIO Connection 1
        );
    

    SRAM sram(
        .SRAM_DQ(SRAM_DQ),                //  SRAM Data bus 16 Bits
        .SRAM_ADDR(SRAM_ADDR),              //  SRAM Address bus 18 Bits
        .SRAM_UB_N(SRAM_UB_N),              //  SRAM High-byte Data Mask 
        .SRAM_LB_N(SRAM_LB_N),              //  SRAM Low-byte Data Mask 
        .SRAM_WE_N(SRAM_WE_N),              //  SRAM Write Enable
        .SRAM_CE_N(SRAM_CE_N),              //  SRAM Chip Enable
        .SRAM_OE_N(SRAM_OE_N)              //  SRAM Output Enable
    );
    initial repeat(100000) #100 CLOCK_50 = ~CLOCK_50;
    
    initial begin
        #250
        SW[13] = 1'b1;
        SW[10] = 1'b1;
        #100
        SW[13] = 1'b0;
    end
    
endmodule

