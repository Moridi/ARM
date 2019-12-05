`include "Defines.v"

module Formarding (
	input EXE_wb_en, MEM_wb_en;
    input [3:0] MEM_dst, EXE_dst, ID_src1, ID_src2; 
	
    output [1:0] sel_src1, sel_src2;
    output ignore_hazard;

);
	always@(*) begin
		sel_src1 = 2'b0;
		sel_src2 = 2'b0;
        ignore_hazard = 1'b0;
        
        if (MEM_wb_en) begin
            if (MEM_dst == ID_src1) begin
                sel_src1 = `FORW_SEL_FROM_MEM;
                ignore_hazard = 1'b1;
            end
            
            if (MEM_dst == ID_src2) begin
                sel_src2 = `FORW_SEL_FROM_MEM;
                ignore_hazard = 1'b1;
            end
        end
        if (EXE_wb_en) begin
            if (EXE_dst == ID_src1) begin
                sel_src1 = `FORW_SEL_FROM_EXE;
                ignore_hazard = 1'b1;
            end
            
            if (EXE_dst == ID_src2) begin
                sel_src2 = `FORW_SEL_FROM_EXE;
                ignore_hazard = 1'b1;
            end
        end
	end
endmodule