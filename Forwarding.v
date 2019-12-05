`include "Defines.v"

module Formarding (
    input en_forwarding,
	input WB_wb_en, MEM_wb_en,
    input [3:0] MEM_dst, WB_dst, ID_src1, ID_src2,
	
    output [1:0] sel_src1, sel_src2,
    output ignore_hazard

);

    reg ignore_hazard_temp;
    reg [1:0] sel_src1_temp, sel_src2_temp;

    assign ignore_hazard = ignore_hazard_temp;
    assign sel_src1 = sel_src1_temp;
    assign sel_src2 = sel_src2_temp;

	always@(*) begin
		sel_src1_temp = 2'b0;
		sel_src2_temp = 2'b0;
        ignore_hazard_temp = 1'b0;
        
        if (en_forwarding && WB_wb_en) begin
            if (WB_dst == ID_src1) begin
                sel_src1_temp = `FORW_SEL_FROM_WB;
                ignore_hazard_temp = 1'b1;
            end
            
            if (WB_dst == ID_src2) begin
                sel_src2_temp = `FORW_SEL_FROM_WB;
                ignore_hazard_temp = 1'b1;
            end
        end

        if (en_forwarding && MEM_wb_en) begin
            if (MEM_dst == ID_src1) begin
                sel_src1_temp = `FORW_SEL_FROM_MEM;
                ignore_hazard_temp = 1'b1;
            end
            
            if (MEM_dst == ID_src2) begin
                sel_src2_temp = `FORW_SEL_FROM_MEM;
                ignore_hazard_temp = 1'b1;
            end
        end
	end
endmodule