`include "Defines.v"

module ControlUnit(
		mode, opcode, s,
		execute_command, mem_read, mem_write,
		wb_enable, immediate,
		branch_taken, status_write_enable
		);

	input[`MODE_LEN - 1 : 0] mode;
	input[`OPCODE_LEN - 1 : 0] opcode;
	input s;
	output wire[`EXECUTE_COMMAND_LEN - 1 : 0] execute_command;
	output wire mem_read, mem_write,
			wb_enable, immediate,
			branch_taken, status_write_enable;
		
	always @(mode, opcode, s) begin
		execute_command = 0; mem_read = 0;
		mem_write = 0; wb_enable = 0;
		immediate = 0; branch_taken = 0;
		status_write_enable = 0;
		
		
		case (mode)
			`ARITHMETHIC_TYPE : begin
				`MOV : begin
					
				end

				`MOVN : begin
					
				end

				`ADD : begin
					
				end

				`ADC : begin
					
				end

				`SUB : begin
					
				end

				`SBC : begin
					
				end

				`AND : begin
					
				end

				`ORR : begin
					
				end

				`EOR : begin
					
				end

				`CMP : begin
					
				end

				`TST : begin
					
				end

				`LDR : begin
					
				end

				`STR : begin
					
				end

			end

			`MEMORY_TYPE : begin
				
			end

			`BRANCH_TYPE : begin
				
			end		
		end
		
endmodule