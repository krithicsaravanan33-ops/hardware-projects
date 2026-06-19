module cpu(
    input clk,
    input rst
);

    // ─── Internal wires ───
    wire [31:0] pc_out;
    wire [31:0] pc_next;
    wire [31:0] instr;
    wire [31:0] reg_rdata1;
    wire [31:0] reg_rdata2;
    wire [31:0] imm;
    wire [31:0] alu_b;
    wire [31:0] alu_result;
    wire        alu_zero;
    wire [31:0] reg_wdata;

    // Control signals
    wire        reg_write;
    wire        alu_src;
    wire        mem_read;
    wire        mem_write;
    wire        mem_to_reg;
    wire        branch;
    wire [1:0]  alu_op;
    wire [3:0]  alu_ctrl_out;

    // ─── PC next logic ───
    wire branch_taken;
    wire [31:0] pc_plus4;
    wire [31:0] branch_target;

    assign pc_plus4      = pc_out + 32'd4;
    assign branch_target = pc_out + imm;
    assign branch_taken  = branch & alu_zero;
    assign pc_next       = branch_taken ? branch_target : pc_plus4;

    // ─── Module instantiations ───

    pc PC (
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc_out(pc_out)
    );

    imem IMEM (
        .addr(pc_out),
        .instr(instr)
    );

    control CTRL (
        .opcode(instr[6:0]),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .alu_op(alu_op)
    );

    reg_file RF (
        .clk(clk),
        .we(reg_write),
        .raddr1(instr[19:15]),
        .raddr2(instr[24:20]),
        .waddr(instr[11:7]),
        .wdata(reg_wdata),
        .rdata1(reg_rdata1),
        .rdata2(reg_rdata2)
    );

    imm_gen IMMGEN (
        .instr(instr),
        .imm(imm)
    );

    alu_ctrl ALUCTRL (
        .alu_op(alu_op),
        .funct3(instr[14:12]),
        .funct7(instr[30]),
        .alu_ctrl(alu_ctrl_out)
    );

    assign alu_b = alu_src ? imm : reg_rdata2;

    alu32 ALU (
        .a(reg_rdata1),
        .b(alu_b),
        .alu_ctrl(alu_ctrl_out),
        .result(alu_result),
        .zero(alu_zero)
    );

    assign reg_wdata = alu_result;

endmodule