module vending_tb;

    reg clk;
    reg rst;
    reg coin5;
    reg coin10;
    wire dispense;
    wire change;

    vending uut (
        .clk(clk),
        .rst(rst),
        .coin5(coin5),
        .coin10(coin10),
        .dispense(dispense),
        .change(change)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    integer dispensed;

    initial begin
        $dumpfile("vending_tb.vcd");
        $dumpvars(0, vending_tb);

        rst = 1; coin5 = 0; coin10 = 0;
        #20;
        rst = 0;
        #20;

        dispensed = 0;

        $display("Test 1: Four 5-cent coins");
        coin5 = 1; #10; coin5 = 0; #10;
        coin5 = 1; #10; coin5 = 0; #10;
        coin5 = 1; #10; coin5 = 0; #10;
        coin5 = 1; #10; coin5 = 0;
        @(posedge dispense);
        $display("Dispense triggered - PASS");

        rst = 1; #20; rst = 0; #20;

        $display("Test 2: Two 10-cent coins");
        coin10 = 1; #10; coin10 = 0; #10;
        coin10 = 1; #10; coin10 = 0;
        @(posedge dispense);
        $display("Dispense triggered - PASS");

        rst = 1; #20; rst = 0; #20;

        $display("Test 3: 10 + 5 + 10 cents with change");
        coin10 = 1; #10; coin10 = 0; #10;
        coin5  = 1; #10; coin5  = 0; #10;
        coin10 = 1; #10; coin10 = 0;
        @(posedge dispense);
        $display("Dispense triggered - PASS");
        if (change)
            $display("Change triggered - PASS");
        else
            $display("Change NOT triggered - FAIL");

        #20;
        $finish;
    end

endmodule