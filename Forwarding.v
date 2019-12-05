`include "Defines.v"

module Formarding (
	input EXE_wb_en, MEM_wb_en,
    input [3:0] MEM_dst, EXE_dst, ID_src1, ID_src2,
	
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
        
        if (MEM_wb_en) begin
            if (MEM_dst == ID_src1) begin
                sel_src1_temp = `FORW_SEL_FROM_MEM;
                ignore_hazard_temp = 1'b1;
            end
            
            if (MEM_dst == ID_src2) begin
                sel_src2_temp = `FORW_SEL_FROM_MEM;
                ignore_hazard_temp = 1'b1;
            end
        end
        if (EXE_wb_en) begin
            if (EXE_dst == ID_src1) begin
                sel_src1_temp = `FORW_SEL_FROM_EXE;
                ignore_hazard_temp = 1'b1;
            end
            
            if (EXE_dst == ID_src2) begin
                sel_src2_temp = `FORW_SEL_FROM_EXE;
                ignore_hazard_temp = 1'b1;
            end
        end
	end
endmodule