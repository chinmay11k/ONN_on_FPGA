`timescale 1ns/1ps

module Weights #(
    parameter NUM_NEURONS    = 15,     // 5x3 ONN → 15 neurons
    parameter WEIGHT_WIDTH   = 5,      // 5-bit signed weights
    parameter WEIGHT_FILE    = "D:/Vivado practice/ONN_SynapseBlock/ONN_SynapseBlock.srcs/sources_1/new/weights.hex"
)(
    input wire [3:0] addr_row,         // 4-bit address (0-14)
    input wire [3:0] addr_col,
    output reg signed [WEIGHT_WIDTH-1:0] weight
);
integer i;
// 15x15 weight matrix
reg signed [WEIGHT_WIDTH-1:0] mem [0:NUM_NEURONS-1][0:NUM_NEURONS-1];

initial begin
    // Load weights and zero self-connections
    $readmemh(WEIGHT_FILE, mem);
    for ( i = 0; i < NUM_NEURONS; i=i+1) mem[i][i] = 0;
end

// Combinational read
always @(*) begin
    weight = mem[addr_row][addr_col];
end

endmodule
