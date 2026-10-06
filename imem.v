module imem(
    input  [31:0] addr,
    output [31:0] instr
);

    reg [31:0] mem [0:63];
    integer i;

    initial begin
        // Fill all 64 words with NOP (addi x0, x0, 0) so unused memory
        // is defined instead of X. Keeps the waveform clean after the program ends.
        for (i = 0; i < 64; i = i + 1)
            mem[i] = 32'h00000013;

        // Test program (hand-encoded RISC-V machine code)
        mem[0] = 32'h00500093; // addi x1, x0, 5     -> x1 = 5
        mem[1] = 32'h00300113; // addi x2, x0, 3     -> x2 = 3
        mem[2] = 32'h002081B3; // add  x3, x1, x2    -> x3 = 8
        mem[3] = 32'h00C00293; // addi x5, x0, 12    -> x5 = 12
        mem[4] = 32'h00520333; // add  x6, x4, x5    -> x6 = 0 + 12 = 12
        mem[5] = 32'h401303B3; // sub  x7, x6, x1    -> x7 = 12 - 5 = 7
        mem[6] = 32'h40000413; // addi x8, x0, 1024  -> x8 = 1024 (regression test: bit 30 is set)

        // OPTIONAL (only after adding dmem.v): load/store test
        // mem[7] = 32'h00302023; // sw x3, 0(x0)    -> data memory[0] = 8
        // mem[8] = 32'h00002483; // lw x9, 0(x0)    -> x9 = 8
    end

    assign instr = mem[addr[31:2]];

endmodule
