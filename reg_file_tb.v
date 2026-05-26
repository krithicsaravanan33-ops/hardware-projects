module reg_file_tb;

    reg clk;
    reg we;
    reg [4:0] raddr1;
    reg [4:0] raddr2;
    reg [4:0] waddr;
    reg [31:0] wdata;
    wire [31:0] rdata1;
    wire [31:0] rdata2;

    reg_file uut (
        .clk(clk),
        .we(we),
        .raddr1(raddr1),
        .raddr2(raddr2),
        .waddr(waddr),
        .wdata(wdata),
        .rdata1(rdata1),
        .rdata2(rdata2)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("reg_file_tb.vcd");
        $dumpvars(0, reg_file_tb);

        we = 0;
        raddr1 = 0; raddr2 = 0;
        waddr = 0; wdata = 0;
        #10;

        we = 1;
        waddr = 5'd1;
        wdata = 32'd42;
        #10;

        we = 1;
        waddr = 5'd2;
        wdata = 32'd100;
        #10;

        we = 1;
        waddr = 5'd3;
        wdata = 32'd255;
        #10;

        we = 0;
        raddr1 = 5'd1;
        raddr2 = 5'd2;
        #10;
        $display("Register 1 = %d (expected 42)", rdata1);
        $display("Register 2 = %d (expected 100)", rdata2);

        raddr1 = 5'd3;
        raddr2 = 5'd0;
        #10;
        $display("Register 3 = %d (expected 255)", rdata1);
        $display("Register 0 = %d (expected 0)", rdata2);

        we = 1;
        waddr = 5'd0;
        wdata = 32'd999;
        #10;

        we = 0;
        raddr1 = 5'd0;
        #10;
        $display("Register 0 after write attempt = %d (expected 0)", rdata1);

        $finish;
    end

endmodule