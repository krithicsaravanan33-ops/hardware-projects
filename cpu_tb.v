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

        $finish;
    end

endmodule