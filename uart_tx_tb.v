module uart_tx_tb;

    parameter CLK_FREQ  = 50000000;
    parameter BAUD_RATE = 9600;
    parameter CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

    reg        clk;
    reg        rst;
    reg        start;
    reg  [7:0] data;
    wire       tx;
    wire       busy;

    uart_tx #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .data(data),
        .tx(tx),
        .busy(busy)
    );

    initial clk = 0;
    always #1 clk = ~clk;

    integer i;

    initial begin
        $dumpfile("uart_tx_tb.vcd");
        $dumpvars(0, uart_tx_tb);

        rst = 1; start = 0; data = 0;
        #10;
        rst = 0;
        #10;

        data  = 8'b10110001;
        start = 1;
        #2;
        start = 0;

        @(negedge tx);
        $display("Start bit detected");

        for (i = 0; i < 8; i = i + 1) begin
            #(CLKS_PER_BIT * 2);
            $display("Bit %0d = %b", i, tx);
        end

        #(CLKS_PER_BIT * 2);
        $display("Stop bit = %b (expected 1)", tx);
        $display("Transmission complete");

        $finish;
    end

endmodule