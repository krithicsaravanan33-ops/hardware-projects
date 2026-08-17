module cpu_tb;

    reg clk;
    reg rst;

    cpu uut (
        .clk(clk),
        .rst(rst)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);

        rst = 1;
        #20;
        rst = 0;

        #200

        $display("Register x1 = %0d (expected 5)",  uut.RF.registers[1]);
        $display("Register x2 = %0d (expected 3)",  uut.RF.registers[2]);
        $display("Register x3 = %0d (expected 8)",  uut.RF.registers[3]);
        $display("Register x5 = %0d (expected 12)", uut.RF.registers[5]);
        $display("Register x6 = %0d (expected 12)", uut.RF.registers[6]);
        $display("Register x7 = %0d (expected 7)", uut.RF.registers[7]);
        $finish;
    end

endmodule