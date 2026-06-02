module alu32_tb;

    reg  [31:0] a;
    reg  [31:0] b;
    reg  [3:0]  alu_ctrl;
    wire [31:0] result;
    wire        zero;

    alu32 uut (
        .a(a),
        .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .zero(zero)
    );

    initial begin
        a = 32'd10; b = 32'd3; alu_ctrl = 4'b0000;
        #10;
        $display("10 + 3 = %0d (expected 13)", result);

        a = 32'd10; b = 32'd3; alu_ctrl = 4'b0001;
        #10;
        $display("10 - 3 = %0d (expected 7)", result);

        a = 32'd12; b = 32'd10; alu_ctrl = 4'b0010;
        #10;
        $display("12 AND 10 = %0d (expected 8)", result);

        a = 32'd12; b = 32'd10; alu_ctrl = 4'b0011;
        #10;
        $display("12 OR 10 = %0d (expected 14)", result);

        a = 32'd5; b = 32'd5; alu_ctrl = 4'b0001;
        #10;
        $display("5 - 5 = %0d zero = %b (expected 0, zero=1)", result, zero);

        a = 32'd3; b = 32'd5; alu_ctrl = 4'b0111;
        #10;
        $display("3 < 5 = %0d (expected 1)", result);

        $finish;
    end

endmodule