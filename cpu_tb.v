module cpu_tb;

    reg clk;
    reg rst;
    integer errors;

    cpu uut (
        .clk(clk),
        .rst(rst)
    );

    // 10ns clock period
    initial clk = 0;
    always #5 clk = ~clk;

    // Compare one register against its expected value and print PASS/FAIL.
    // === is used (not ==) so an X or Z value counts as a failure.
    task check;
        input [4:0]  r;
        input [31:0] actual;
        input [31:0] expected;
        begin
            if (actual === expected)
                $display("PASS  x%0d = %0d", r, $signed(actual));
            else begin
                $display("FAIL  x%0d = %0d (expected %0d)", r, $signed(actual), $signed(expected));
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);

        errors = 0;
        rst = 1;
        #20;
        rst = 0;

        // Let the program run (20 cycles is more than enough)
        #200;

        $display("---- Register checks ----");
        check(5'd0, uut.RF.registers[0], 32'd0);     // x0 hardwired to zero
        check(5'd1, uut.RF.registers[1], 32'd5);     // addi x1, x0, 5
        check(5'd2, uut.RF.registers[2], 32'd3);     // addi x2, x0, 3
        check(5'd3, uut.RF.registers[3], 32'd8);     // add  x3, x1, x2
        check(5'd4, uut.RF.registers[4], 32'd0);     // never written
        check(5'd5, uut.RF.registers[5], 32'd12);    // addi x5, x0, 12
        check(5'd6, uut.RF.registers[6], 32'd12);    // add  x6, x4, x5
        check(5'd7, uut.RF.registers[7], 32'd7);     // sub  x7, x6, x1
        check(5'd8, uut.RF.registers[8], 32'd1024);  // addi x8, x0, 1024 (funct7 regression test)

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("%0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
