module reg_file(
    input clk,
    input we,
    input [4:0] raddr1,
    input [4:0] raddr2,
    input [4:0] waddr,
    input [31:0] wdata,
    output [31:0] rdata1,
    output [31:0] rdata2
);

    reg [31:0] registers [31:0];

    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] = 32'b0;
    end

    always @(posedge clk) begin
        if (we && waddr != 5'b0)
            registers[waddr] <= wdata;
    end

    assign rdata1 = registers[raddr1];
    assign rdata2 = registers[raddr2];

endmodule