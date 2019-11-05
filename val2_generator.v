`include "Defines.v"

module val2_generator(
		input [`REGISTER_LEN - 1:0] Rm
        input [11:0] shift_operand,
        input immd, is_mem_command,

        output wire [`REGISTER_LEN - 1:0] val2_out,
		);

    always @(cond) begin
        integer i;
        val2_out = {12'b0, shift_operand};

        if (is_mem_command == `DISABLE) begin

            if (immd == `ENABLE) begin
                for (i = 0; i < shift_operand[11:8]; i = i + 1) begin
                    val2_out = {val2_out[1], val2_out[0], val2_out[31:2]}; 
                end

            end else if(immd == `DISABLE && shift_operand[4] == 0) begin
                case(shift_operand[6:5])
                    `LSL_SHIFT_STATE : begin
                    end
                    `LSR_SHIFT_STATE : begin
                    end
                    `ASR_SHIFT_STATE : begin
                    end
                    `ROR_SHIFT_STATE : begin
                    end
                endcase
            end
        end 

        
    end
endmodule