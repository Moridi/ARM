`include "Defines.v"

module ConditionalCheck (
    input [`COND_LEN - 1:0] cond,
    input [3:0] statusRegister,
    output wire condState
    );

    wire z, c, n, v;
    // TODO: order of status registers must be checked.
    assign {z, c, n, v} = statusRegister;

	reg tempCondition;
	
	assign condState = tempCondition;

    always @(*) begin

        case(cond)
            `COND_EQ : begin
                tempCondition <= z;
            end

            `COND_NE : begin
                tempCondition <= ~z;
            end

            `COND_CS_HS : begin
                tempCondition <= c;
            end

            `COND_CC_LO : begin
                tempCondition <= ~c;
            end

            `COND_MI : begin
                tempCondition <= n;
            end

            `COND_PL : begin
                tempCondition <= ~n;
            end

            `COND_VS : begin
                tempCondition <= v;
            end

            `COND_VC : begin
                tempCondition <= ~v;
            end

            `COND_HI : begin
                tempCondition <= c & ~z;
            end

            `COND_LS : begin
                tempCondition <= ~c & z;
            end

            `COND_GE : begin
                tempCondition <= (n & v) | (~n & ~v);
            end
            `COND_LT : begin
                tempCondition <= (n & ~v) | (~n & v);
            end

            `COND_GT : begin
                tempCondition <= ~z & ((n & v) | (~n & ~v));
            end

            `COND_LE : begin
                tempCondition <= z & ((n & ~v) | (~n & v));
            end

            `COND_AL : begin
                tempCondition <= 1'b1;
            end
        endcase
    end
endmodule