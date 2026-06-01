module pc_tb;
    reg     clk;
    reg     rst;
    reg  [31:0] pc_next;
    wire [31:0] pc_out;

    pc uut (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc_out(pc_out)
    );
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("pc_tb.vcd");
        $dumpvars(0, pc_tb);

        rst = 1; pc_next = 0;
        #10;
        rst = 0;

        pc_next = 32'd4;
        #10;
        $display("PC = %0d (expected 4)",pc_out);

        pc_next = 32'd8;
        #10;
        $display ( "PC = %0d (expected 8)", pc_out);

        pc_next = 32'd12;
        #10;
        $display("PC = %0d (expected 12)", pc_out);

        rst=1;
        #10;
        $display("PC = %0d (expected 0)", pc_out);

        $finish;
    end
endmodule