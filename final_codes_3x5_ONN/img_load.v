`timescale 1ns / 1ps
module img_load(
    input [2:0] img_no,
    input start,
    input re,
    input sclk,
    output reg data_in,
    output reg load
);

reg [0:59] state;
reg [5:0] c=0;

always @(posedge sclk) begin
    if (re == 1) begin
        load <= 0;
        c <= 0;
        case (img_no)
            3'd0: state <= 60'h000080080080000;
            3'd1: state <= 60'h880880880880880;
            3'd2: state <= 60'h000880000088000;
            3'd3: state <= 60'h010080080080100;
            3'd4: state <= 60'h880880780880881;
            3'd5: state <= 60'h000780000088100;
            3'd6: state <= 60'h100080081080000;
            3'd7: state <= 60'h780880880880881;
            default: state <= 60'h000000000000000;
        endcase
    end
    else if (start == 1) begin
        if (c <60) begin
            load <= 1;
            data_in <= state[59];         // Send MSB first
            state <= state >> 1;          // Left shift by 1
            c <= c + 1;
        end
        else begin
            load <= 0;
        end
    end
    else begin
        load <= 0;
    end
end

endmodule

