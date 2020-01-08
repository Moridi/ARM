module RegisterShiftController(
    input [1:0] mode, 
    input immediate, rs_identifier, rm_identifier,

    output wire have_three_source
);

    assign have_three_source = (mode == 2'b0) & (immediate == 1'b0)
            & (rs_identifier == 1'b0) & (rm_identifier == 1'b1);

endmodule