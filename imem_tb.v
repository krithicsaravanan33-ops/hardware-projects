module imem_tb;
    reg [31:0] addr;
    wire [31:0] instr;

    imem uut(
        .addr(addr),
        .instr(instr)

    );

    initial begin 
        $dumpfile("imem_tb.vcd");
        $dumpvars(0, imem_tb);

        addr = 32'd0;
        #10;
        $display("Instr 0 = %h (expected 00500093)", instr);

        addr = 32'd4;
        #10;
        $display("Instr 1 = %h (expected 00300113)", instr);

        addr = 32'd8;
        #10;
        $display("Instr 2 = %h (expected 002081b3)", instr);

        $finish;
    end
endmodule

