`include "Defines.v"

module ALU(
		input [`REGISTER_LEN - 1:0] alu_in1, alu_in2,
        input [`EXECUTE_COMMAND_LEN - 1:0] alu_command,
        input cin,

        output wire [`REGISTER_LEN - 1:0] alu_out,
        output wire [3:0] statusRegister
		);
    
    wire z, n;
    reg v, cout;
    assign statusRegister = {z, cout, n, v};

    assign z = (alu_out == 8'b0 ? 1 : 0);
    assign n = alu_out[`REGISTER_LEN - 1];

    reg [`REGISTER_LEN - 1:0] alu_out_temp;
    assign alu_out = alu_out_temp;
	
	reg temp_tmep_temp;
	
	always @(*) begin
	    cout = 1'b0;
        v = 1'b0;
		temp_tmep_temp = 1'b0;
	
		case(alu_command)
            `MOV_EXE:
                alu_out_temp = alu_in2;
            `MOVN_EXE:
                alu_out_temp = ~alu_in2; 
			`ADD_EXE:
                begin
                    {cout, alu_out_temp} = alu_in1 + alu_in2;
                    v = ((alu_in1[`REGISTER_LEN - 1] == alu_in2[`REGISTER_LEN - 1])
                            & (alu_out_temp[`REGISTER_LEN - 1] != alu_in1[`REGISTER_LEN - 1]));
                end

			`ADC_EXE:
                begin
                    {cout, alu_out_temp} = alu_in1 + alu_in2 + cin;
                    v = ((alu_in1[`REGISTER_LEN - 1] == alu_in2[`REGISTER_LEN - 1])
                            & (alu_out_temp[`REGISTER_LEN - 1] != alu_in1[`REGISTER_LEN - 1]));
                end
			`SUB_EXE:
                begin
                    {cout, alu_out_temp} = {alu_in1[31], alu_in1} - {alu_in2[31], alu_in2};
                    v = ((alu_in1[`REGISTER_LEN - 1] == alu_in2[`REGISTER_LEN - 1])
                            & (alu_out_temp[`REGISTER_LEN - 1] != alu_in1[`REGISTER_LEN - 1]));
                end

			`SBC_EXE:
                begin
                    {cout, alu_out_temp} = {alu_in1[31], alu_in1} - {alu_in2[31], alu_in2} - 33'd1;
                    v = ((alu_in1[`REGISTER_LEN - 1] == alu_in2[`REGISTER_LEN - 1])
                            & (alu_out_temp[`REGISTER_LEN - 1] != alu_in1[`REGISTER_LEN - 1]));
                end
                
			`AND_EXE:
                alu_out_temp	 = 	alu_in1 & alu_in2;
			`ORR_EXE:
                alu_out_temp	 = 	alu_in1 | alu_in2;
			`EOR_EXE:
                alu_out_temp	 = 	alu_in1 ^ alu_in2;
			`CMP_EXE: begin
					{cout, alu_out_temp} = {alu_in1[31], alu_in1} - {alu_in2[31], alu_in2};
					temp_tmep_temp = 1'b1;
				end
			`TST_EXE:
                alu_out_temp	 = 	alu_in1 & alu_in2;
			`LDR_EXE:
                alu_out_temp	 = 	alu_in1 + alu_in2;
			`STR_EXE:
                alu_out_temp	 = 	alu_in1 + alu_in2;
		endcase
	end

	
endmodule
