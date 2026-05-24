module alu_tb;
    reg [3:0] a;
    reg [2:0] b;
    reg [2:0] op;
    wire [3:0] result;

    alu uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

        a=4'd5; b = 4'd3; op = 3'b000; // Addition
        #10;
        $display("5 + 3 = %d", result);

        a=4'd9; b=4'd4; op = 3'b001; // Subtraction
        #10;
        $display("9-4=%d", result);

        a=4'd6; b = 4'd3; op = 3'b010; // Bitwise AND
        #10;
        $display("6 AND 3 = %d", result);

        a=4'd6; b = 4'd3; op = 3'b011; // Bitwise OR
        #10;
        $display("6 OR 3 = %d", result);

        a=4'd6; b = 4'd3; op = 3'b100; // Bitwise XOR
        #10;
        $display("6 XOR 3 = %d", result);
      

        $finish;
    end
endmodule