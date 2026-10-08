`timescale 1ns / 1ps
module uart_out#(parameter n=210)(
    input clk,
    input reset,
    input transmit,
    input [0:4*n-1] phi_out,
    output reg TxD
);

// Internal image data storage: 15 registers (for 3x5 image)

// Internal variables
//reg [3:0] address = 0; 
reg [7:0]address ;       // 4 bits: address range 0-14
reg [3:0] bitcounter;
reg [13:0] counter;
reg state, nextstate;
reg [9:0] rightshiftreg;
reg shift;
reg load;
reg clear;
reg inc_addr;
wire [7:0]gray_scale;
wire [3:0]phi;
assign phi=phi_out[(4*address) +: 4];
assign gray_scale=(phi*32>255)?255:phi*32;
// UART logic
always @(posedge clk) begin 
    if (reset) begin
        state <= 0;
        counter <= 0;
        bitcounter <= 0;
        address <= 0;
    end else begin
        counter <= counter + 1;
        if (counter >= 10415) begin
            state <= nextstate;
            counter <= 0;
            if (load) rightshiftreg <= {1'b1,gray_scale, 1'b0}; // start + data + stop
            if (clear) bitcounter <= 0;
            if (inc_addr) address <= address + 1;
            if (shift) begin
                rightshiftreg <= rightshiftreg >> 1;
                bitcounter <= bitcounter + 1;
            end
        end
    end
end

// FSM
always @(posedge clk) begin
    load <= 0;
    shift <= 0;
    clear <= 0;
    TxD <= 1;
    inc_addr <= 0;

    case (state)
        0: begin
            if (transmit) begin
                nextstate <= 1;
                load <= 1;
            end else begin
                nextstate <= 0;
            end
        end
        1: begin
            if (bitcounter >= 10) begin
                nextstate <= 0;
                if (address <n) inc_addr <= 1; // 15 values: 0-14
                clear <= 1;
            end else begin
                nextstate <= 1;
                TxD <= rightshiftreg[0];
                shift <= 1;
            end
        end
        default: nextstate <= 0;
    endcase
end 

endmodule
