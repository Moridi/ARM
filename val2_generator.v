`include "Defines.v"

module Val2Generator(
		input [`REGISTER_LEN - 1:0] Rm,
        input [11:0] shift_operand,
        input immd, is_mem_command,

        output wire [`REGISTER_LEN - 1:0] val2_out
		);

    reg [`REGISTER_LEN - 1:0] imd_shifted;
    reg [`REGISTER_LEN - 1:0] rm_rotate;
    integer i;
    integer j;

    assign val2_out = (is_mem_command == `DISABLE) ? 
        (
            // (immd == 1'b1) ? {24'b0, shift_operand[7:0]} // need for loop here.
            (immd == 1'b1) ? imd_shifted
            : (shift_operand[6:5] == `LSL_SHIFT_STATE) ? Rm << {1'b0, shift_operand[11:7]}
            : (shift_operand[6:5] == `LSR_SHIFT_STATE) ? Rm >> {1'b0, shift_operand[11:7]}
            : (shift_operand[6:5] == `ASR_SHIFT_STATE) ? Rm >>> {1'b0, shift_operand[11:7]}
            : rm_rotate
        )
        : {20'b0, shift_operand};
    
    
    always @(*) begin
        rm_rotate = Rm;
        for (i = 0; i < {1'b0, shift_operand[11:7]}; i = i + 1) begin
            rm_rotate = {rm_rotate[0], rm_rotate[31:1]}; 
        end
    end


    always @(*) begin
        imd_shifted = {24'b0, shift_operand[7:0]};
        for (j = 0; j < {1'b0, shift_operand[11:8]}; j = j + 1) begin
            imd_shifted = {imd_shifted[1], imd_shifted[0], imd_shifted[31:2]}; 
        end
    end


    
    // assign val2_out = val2_out_temp;

    // integer i;
    // always @(*) begin

    //     if (is_mem_command == `DISABLE) begin

    //         if (immd == 1'b1) begin
	// 			val2_out_temp = {24'b0, shift_operand[7:0]};
                
	// 			for (i = 0; i < {1'b0, shift_operand[11:8]}; i = i + 1) begin
    //                 val2_out_temp = {val2_out_temp[1], val2_out_temp[0], val2_out_temp[31:2]}; 
    //             end

    //         end else if(immd == 1'b0 && shift_operand[4] == 0) begin
	// 			val2_out_temp = Rm;
				
    //             case(shift_operand[6:5])
    //                 `LSL_SHIFT_STATE : 
    //                     val2_out_temp = val2_out_temp << {1'b0, shift_operand[11:7]};

    //                 `LSR_SHIFT_STATE :
    //                     val2_out_temp = val2_out_temp >> {1'b0, shift_operand[11:7]};
                    
    //                 `ASR_SHIFT_STATE :
    //                     val2_out_temp = val2_out_temp >>> {1'b0, shift_operand[11:7]};

    //                 `ROR_SHIFT_STATE : begin
    //                     for (i = 0; i < {1'b0, shift_operand[11:7]}; i = i + 1) begin
    //                         val2_out_temp = {val2_out_temp[0], val2_out_temp[31:1]}; 
    //                     end
    //                 end
    //             endcase
    //         end
    //     end else
	// 		val2_out_temp = {20'b0, shift_operand};
        
    // end
endmodule