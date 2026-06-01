module imem(
    input [31:0] addr,
    output [31:0] instr
);

    reg [31:0] mem [0:63];

    initial begin
        // addi x1, x0, 5  →  x1 = 5
        mem[0] = 32'h00500093;
        // addi x2, x0, 3  →  x2 = 3
        mem[1] = 32'h00300113;
        // add x3, x1, x2  →  x3 = 8
        mem[2] = 32'h002081B3;
        // fill rest with zeros
        mem[3] = 32'h00000000;
    end
    assign instr =mem[addr[31:2]];
endmodule