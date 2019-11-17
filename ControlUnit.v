`include "Defines.v"

module ControlUnit(
		mode, opcode, s, immediate_in,
		execute_command, mem_read, mem_write,
		wb_enable, immediate,
		branch_taken, status_write_enable
		);

	input[`MODE_LEN - 1 : 0] mode;
	input[`OPCODE_LEN - 1 : 0] opcode;
	input s, immediate_in;
	output wire[`EXECUTE_COMMAND_LEN - 1 : 0] execute_command;
	output wire mem_read, mem_write, immediate,
			wb_enable, branch_taken, status_write_enable;
			
	reg mem_read_reg, mem_write_reg,
			wb_enable_reg, branch_taken_reg, status_write_enable_reg;
		
	reg [`EXECUTE_COMMAND_LEN - 1 : 0] execute_command_reg;
		
		
	// @TODO: What shoult I do
	assign immediate = immediate_in;
	assign status_write_enable = s;
	
	assign execute_command = execute_command_reg;
	assign mem_read = mem_read_reg;
	assign mem_write = mem_write_reg;
	assign wb_enable = wb_enable_reg;
	assign branch_taken = branch_taken_reg;
	
	always @(mode, opcode, s) begin

		mem_write_reg = `DISABLE;
		mem_read_reg = `DISABLE;
		wb_enable_reg = `DISABLE;
		branch_taken_reg = `DISABLE;
		
			case (mode)
				`ARITHMETHIC_TYPE : begin
				
					case(opcode)
						`MOV : begin
							wb_enable_reg = `ENABLE;
							execute_command_reg = `MOV_EXE;
						end

						`MOVN : begin 
							wb_enable_reg = `ENABLE;
							execute_command_reg = `MOVN_EXE;
						end

						`ADD : begin 
							wb_enable_reg = `ENABLE;
							execute_command_reg = `ADD_EXE;
						end

						`ADC : begin 
							wb_enable_reg = `ENABLE;
							execute_command_reg = `ADC_EXE;
						end

						`SUB : begin
							wb_enable_reg = `ENABLE;
							execute_command_reg = `SUB_EXE;
						end

						`SBC : begin 
							wb_enable_reg = `ENABLE;
							execute_command_reg = `SBC_EXE;
						end

						`AND : begin 
							wb_enable_reg = `ENABLE;
							execute_command_reg = `AND_EXE;
						end

						`ORR : begin 
							wb_enable_reg = `ENABLE;
							execute_command_reg = `ORR_EXE;
						end

						`EOR : begin 
							wb_enable_reg = `ENABLE;
							execute_command_reg = `EOR_EXE;
						end

						`CMP :
							execute_command_reg = `CMP_EXE;

						`TST :
							execute_command_reg = `TST_EXE;

						`LDR : begin 
							wb_enable_reg = `ENABLE;
							execute_command_reg = `LDR_EXE;
						end

						`STR :
							execute_command_reg = `STR_EXE;
				endcase
			end

			`MEMORY_TYPE : begin		
				case (s)
					`S_ONE : begin
						mem_read_reg = `ENABLE;
						wb_enable_reg = `ENABLE;
					end
					`S_ZERO : begin
						mem_write_reg = `ENABLE;
					end
				endcase
			end
			
			`BRANCH_TYPE :
				branch_taken_reg = `ENABLE;
		endcase
		
	end
endmodule