module alu_ctrl_tb;
    reg[1:0] alu_op;
    reg[2:0] funct3;
    reg funct7;
    wire[3:0] alu_ctrl;

    alu_ctrl uut (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7(funct7),
        .alu_ctrl(alu_ctrl)
    );

    initial begin
        alu_op = 2'b00; funct3 = 3'b000; funct7 = 0;
        #10;
        $display("Load/Store = %b (expected 0000)", alu_ctrl);

        alu_op = 2'b01; funct3 = 3'b000; funct7 = 0;
        #10;
        $display("Branch = %b (expected 0001)", alu_ctrl);

        alu_op = 2'b10; funct3 = 3'b000; funct7 = 0;
        #10;
        $display("ADD = %b (expected 0000)", alu_ctrl);

        alu_op = 2'b10; funct3 = 3'b000; funct7 = 1;
        #10;
        $display("SUB = %b (expected 0001)", alu_ctrl);

        alu_op = 2'b10; funct3 = 3'b111; funct7 = 0;
        #10;
        $display("AND = %b (expected 0010)", alu_ctrl);

        alu_op = 2'b10; funct3 = 3'b110; funct7 = 0;
        #10;
        $display("OR = %b (expected 0011)", alu_ctrl);

        $finish;
    end

endmodule