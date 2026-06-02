module imm_gen_tb;

    reg  [31:0] instr;
    wire [31:0] imm;

    imm_gen uut (
        .instr(instr),
        .imm(imm)
    );

    initial begin
        // addi x1, x0, 5 — immediate should be 5
        instr = 32'h00500093;
        #10;
        $display("addi imm = %0d (expected 5)", imm);

        // addi x2, x0, 3 — immediate should be 3
        instr = 32'h00300113;
        #10;
        $display("addi imm = %0d (expected 3)", imm);

        // addi x1, x0, -1 — immediate should be -1
        instr = 32'hFFF00093;
        #10;
        $display("addi imm = %0d (expected -1)", $signed(imm));

        $finish;
    end

endmodule