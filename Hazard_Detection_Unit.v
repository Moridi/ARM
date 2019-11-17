`include "Defines.v"

module Hazard_Detection_Unit (
    input have_two_src,
    input [`REG_ADDRESS_LEN - 1:0] src1_address, src2_address,
    input [`REG_ADDRESS_LEN - 1:0] exe_wb_dest, mem_wb_dest,
    input exe_wb_en, mem_wb_en,

    output hazard_detected
);

    assign hazard_detected = 1'b0;
endmodule