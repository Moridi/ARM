`include "Defines.v"

module Val2Generator(
		input [`REGISTER_LEN - 1:0] Rm,
        input [11:0] shift_operand,
        input immd, is_mem_command,

        output wire [`REGISTER_LEN - 1:0] val2_out
		);

    reg [`REGISTER_LEN - 1:0] val2_out_temp;
    assign val2_out = val2_out_temp;

    integer i;
    always @(*) begin
        val2_out_temp = {20'b0, shift_operand};

        if (is_mem_command == `DISABLE) begin

            if (immd == 1'b0) begin
                for (i = 0; i < shift_operand[11:8]; i = i + 1) begin
                    val2_out_temp = {val2_out[1], val2_out[0], val2_out[31:2]}; 
                end

            end else if(immd == 1'b0 && shift_operand[4] == 0) begin
                case(shift_operand[6:5])
                    `LSL_SHIFT_STATE : 
                        val2_out_temp = val2_out << shift_operand[11:7];

                    `LSR_SHIFT_STATE :
                        val2_out_temp = val2_out >> shift_operand[11:7];
                    
                    `ASR_SHIFT_STATE :
                        val2_out_temp = val2_out >>> shift_operand[11:7];

                    `ROR_SHIFT_STATE : begin
                        for (i = 0; i < shift_operand[11:7]; i = i + 1) begin
                            val2_out_temp = {val2_out[0], val2_out[31:1]}; 
                        end
                    end
                endcase
            end
        end 

        
    end
endmodule