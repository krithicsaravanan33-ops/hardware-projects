module imm_gen(
    input  [31:0] instr,
    output reg [31:0] imm
);

    wire [6:0] opcode = instr[6:0];

    always @(*) begin
        case(opcode)
            7'b0010011: // I-type (addi)
                imm = {{20{instr[31]}}, instr[31:20]};

            7'b0000011: // I-type (load)
                imm = {{20{instr[31]}}, instr[31:20]};

            7'b0100011: // S-type (store)
                imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};

            7'b1100011: // B-type (branch)
                imm = {{19{instr[31]}}, instr[31], instr[7],
                        instr[30:25], instr[11:8], 1'b0};

            7'b1101111: // J-type (jal)
                imm = {{11{instr[31]}}, instr[31], instr[19:12],
                        instr[20], instr[30:21], 1'b0};

            default:
                imm = 32'b0;
        endcase
    end

endmodule