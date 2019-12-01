`include "Defines.v"

module Val2Generator(
		input [`REGISTER_LEN - 1:0] Rm,
        input [11:0] shift_operand,
        input immd, is_mem_command,

        output wire [`REGISTER_LEN - 1:0] val2_out
		);

    reg [`REGISTER_LEN - 1:0] val2_out_temp;
    assign val2_out = val2_out_temp;

    integer i = 0;
    always @(*) begin

        if (is_mem_command == `DISABLE) begin

            if (immd == 1'b1) begin
				val2_out_temp = {24'b0, shift_operand[7:0]};
                
				for (i = 0; i < {1'b0, shift_operand[11:8]}; i = i + 1) begin
                    val2_out_temp = {val2_out_temp[1], val2_out_temp[0], val2_out_temp[31:2]}; 
                end

            end else if(immd == 1'b0 && shift_operand[4] == 0) begin
				val2_out_temp = Rm;
				
                case(shift_operand[6:5])
                    `LSL_SHIFT_STATE : 
                        val2_out_temp = val2_out_temp << {1'b0, shift_operand[11:7]};

                    `LSR_SHIFT_STATE :
                        val2_out_temp = val2_out_temp >> {1'b0, shift_operand[11:7]};
                    
                    `ASR_SHIFT_STATE :
                        val2_out_temp = val2_out_temp >>> {1'b0, shift_operand[11:7]};

                    `ROR_SHIFT_STATE : begin
                        for (i = 0; i < {1'b0, shift_operand[11:7]}; i = i + 1) begin
                            val2_out_temp = {val2_out_temp[0], val2_out_temp[31:1]}; 
                        end
                    end
                endcase
            end
        end else
			val2_out_temp = {20'b0, shift_operand};
        
    end
endmodule