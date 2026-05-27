module vending(
    input  clk,
    input  rst,
    input  coin5,
    input  coin10,
    output reg dispense,
    output reg change
);

    parameter IDLE     = 3'd0;
    parameter S5       = 3'd1;
    parameter S10      = 3'd2;
    parameter S15      = 3'd3;
    parameter DISP     = 3'd4;
    parameter DISP_CHG = 3'd5;

    reg [2:0] current_state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always @(*) begin
        next_state = current_state;
        dispense   = 0;
        change     = 0;

        case (current_state)
            IDLE: begin
                if (coin5)       next_state = S5;
                else if (coin10) next_state = S10;
            end
            S5: begin
                if (coin5)       next_state = S10;
                else if (coin10) next_state = S15;
            end
            S10: begin
                if (coin5)       next_state = S15;
                else if (coin10) next_state = DISP;
            end
            S15: begin
                if (coin5)       next_state = DISP;
                else if (coin10) next_state = DISP_CHG;
            end
            DISP: begin
                dispense   = 1;
                next_state = IDLE;
            end
            DISP_CHG: begin
                dispense   = 1;
                change     = 1;
                next_state = IDLE;
            end
        endcase
    end

endmodule