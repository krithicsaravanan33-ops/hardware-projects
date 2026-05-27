module uart_tx #(
    parameter CLK_FREQ  = 50000000,
    parameter BAUD_RATE = 9600
)(
    input        clk,
    input        rst,
    input        start,
    input  [7:0] data,
    output reg   tx,
    output reg   busy
);

    localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

    parameter IDLE  = 2'd0;
    parameter START = 2'd1;
    parameter DATA  = 2'd2;
    parameter STOP  = 2'd3;

    reg [1:0]  state;
    reg [31:0] clk_count;
    reg [2:0]  bit_index;
    reg [7:0]  tx_data;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state     <= IDLE;
            tx        <= 1;
            busy      <= 0;
            clk_count <= 0;
            bit_index <= 0;
        end else begin
            case (state)
                IDLE: begin
                    tx   <= 1;
                    busy <= 0;
                    if (start) begin
                        tx_data   <= data;
                        state     <= START;
                        clk_count <= 0;
                        busy      <= 1;
                    end
                end

                START: begin
                    tx <= 0;
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        bit_index <= 0;
                        state     <= DATA;
                    end
                end

                DATA: begin
                    tx <= tx_data[bit_index];
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1;
                        end else begin
                            state <= STOP;
                        end
                    end
                end

                STOP: begin
                    tx <= 1;
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        state     <= IDLE;
                        busy      <= 0;
                    end
                end
            endcase
        end
    end

endmodule