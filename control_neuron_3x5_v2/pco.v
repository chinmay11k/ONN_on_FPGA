// pco
`timescale 1ns/1ps
module pco (
    input wire clk,         // System clock
    input wire re_pco,       // Reset signal
    input wire [3:0] phase, // 4-bit phase selector
    output nout);
    reg [0:15] shift_reg = 16'b1000000001111111;
    // 16-stage shift register representing a full oscillation cycle
    
always @(posedge clk or posedge re_pco) begin
            if (re_pco) begin
                shift_reg <= 16'b1000000001111111; // Reset to initial waveform
            end else begin
                shift_reg <= {shift_reg[15],shift_reg[0:14]}; // Circular shift
            end
        end
    
        assign nout=shift_reg[phase];

endmodule