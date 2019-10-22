`include "Defines.v"
`include "ISA.v"

module ConditionalCheck (
    input [`COND_LEN - 1:0] cond,
    input [3:0] statusRegister,
    output condState
    );

    wire z, c, n, v;
    // TODO: order of status registers must be checked.
    assign {z, c, n, v} = statusRegister;

    always @(cond) begin

        case(cond)
            `COND_EQ : begin
                condState <= z;
            end

            `COND_NE : begin
                condState <= ~z;
            end

            `COND_CS_HS : begin
                condState <= c;
            end

            `COND_CC_LO : begin
                condState <= ~c;
            end

            `COND_MI : begin
                condState <= n;
            end

            `COND_PL : begin
                condState <= ~n;
            end

            `COND_VS : begin
                condState <= v;
            end

            `COND_VC : begin
                condState <= ~v;
            end

            `COND_HI : begin
                condState <= c & ~z;
            end

            `COND_LS : begin
                condState <= ~c & z;
            end

            `COND_GE : begin
                condState <= (n & v) | (~n & ~v);
            end

            `COND_LT : begin
                condState <= (n & ~v) | (~n & v);
            end

            `COND_GT : begin
                condState <= ~z & ((n & v) | (~n & ~v));
            end

            `COND_LE : begin
                condState <= z & ((n & ~v) | (~n & v));
            end

            `COND_LE : begin
                condState <= 1`b1;
            end
        endcase
    end
endmodule