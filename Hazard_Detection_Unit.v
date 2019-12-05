`include "Defines.v"

module Hazard_Detection_Unit (
    input have_two_src, ignore_hazard, 
    input ignore_from_forwarding,
    input EXE_mem_read_en,
    input [`REG_ADDRESS_LEN - 1:0] src1_address, src2_address,
    input [`REG_ADDRESS_LEN - 1:0] exe_wb_dest, mem_wb_dest,
    input exe_wb_en, mem_wb_en,

    output hazard_detected
);
    wire internal_hazard;

    assign internal_hazard = (ignore_hazard == 1'b1) ? 1'b0
            : ((src1_address == exe_wb_dest) && (exe_wb_en == 1'b1)) ? 1'b1
            : ((src1_address == mem_wb_dest) && (mem_wb_en == 1'b1)) ? 1'b1
            : ((src2_address == exe_wb_dest) && (exe_wb_en == 1'b1) && (have_two_src == 1'b1)) ? 1'b1
            : ((src2_address == mem_wb_dest) && (mem_wb_en == 1'b1) && (have_two_src == 1'b1)) ? 1'b1
            : 1'b0;
    
    assign hazard_detected = internal_hazard & (ignore_from_forwarding | EXE_mem_read_en);
endmodule
