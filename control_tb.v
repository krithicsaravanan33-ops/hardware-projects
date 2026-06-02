module control_tb;

    reg  [6:0] opcode;
    wire       reg_write;
    wire       alu_src;
    wire       mem_read;
    wire       mem_write;
    wire       mem_to_reg;
    wire       branch;
    wire [1:0] alu_op;

    control uut (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .alu_op(alu_op)
    );

    initial begin
        $display("Testing R-type (add/sub/and/or):");
        opcode = 7'b0110011;
        #10;
        $display("reg_write=%b alu_src=%b mem_read=%b mem_write=%b branch=%b alu_op=%b",
                  reg_write, alu_src, mem_read, mem_write, branch, alu_op);
        $display("expected:  1        0        0         0         0      10");

        $display("Testing I-type (addi):");
        opcode = 7'b0010011;
        #10;
        $display("reg_write=%b alu_src=%b mem_read=%b mem_write=%b branch=%b alu_op=%b",
                  reg_write, alu_src, mem_read, mem_write, branch, alu_op);
        $display("expected:  1        1        0         0         0      10");

        $display("Testing Load:");
        opcode = 7'b0000011;
        #10;
        $display("reg_write=%b alu_src=%b mem_read=%b mem_write=%b branch=%b alu_op=%b",
                  reg_write, alu_src, mem_read, mem_write, branch, alu_op);
        $display("expected:  1        1        1         0         0      00");

        $display("Testing Store:");
        opcode = 7'b0100011;
        #10;
        $display("reg_write=%b alu_src=%b mem_read=%b mem_write=%b branch=%b alu_op=%b",
                  reg_write, alu_src, mem_read, mem_write, branch, alu_op);
        $display("expected:  0        1        0         1         0      00");

        $display("Testing Branch:");
        opcode = 7'b1100011;
        #10;
        $display("reg_write=%b alu_src=%b mem_read=%b mem_write=%b branch=%b alu_op=%b",
                  reg_write, alu_src, mem_read, mem_write, branch, alu_op);
        $display("expected:  0        0        0         0         1      01");

        $finish;
    end

endmodule