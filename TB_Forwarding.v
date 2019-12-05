`include "Defines.v"

module TB_Forwarding();

    reg en_forwarding;
	reg WB_wb_en, MEM_wb_en;
    reg [`REG_ADDRESS_LEN - 1:0] MEM_dst, WB_dst, ID_src1, ID_src2;

    wire [1:0] sel_src1, sel_src2;
    wire ignore_hazard;



Formarding forw(
    .en_forwarding(en_forwarding),
	.WB_wb_en(WB_wb_en),
    .MEM_wb_en(MEM_wb_en),
    .MEM_dst(MEM_dst),
    .WB_dst(WB_dst),
    .ID_src1(ID_src1),
    .ID_src2(ID_src2),
    .sel_src1(sel_src1),
    .sel_src2(sel_src2),
    .ignore_hazard(ignore_hazard)
);

    initial begin
        #250
        en_forwarding = 1'b1;
        MEM_wb_en = 1'b1;
        MEM_dst = 4'd2;
        ID_src1 = 4'd2;
        #100
        ID_src1 = 4'd1;
        #100
        ID_src2 = 4'd2;


        #500
        MEM_wb_en = 1'b0;
        WB_wb_en = 1'b1;
        WB_dst = 4'd2;
        MEM_dst = 4'd2;
        ID_src1 = 4'd2;
        #100
        ID_src1 = 4'd1;
        #100
        ID_src2 = 4'd2;


        #500
        MEM_wb_en = 1'b1;
        WB_wb_en = 1'b1;
        WB_dst = 4'd3;
        MEM_dst = 4'd3;
        ID_src2 = 4'd3;
        #100
        ID_src2 = 4'd1;
        
    end

endmodule