//phase reg v2
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2025 11:18:49
// Design Name: 
// Module Name: phase_reg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module phase_reg(
    input full_tick, re, clk,
    input [3:0] ini_phase, phase,
    output reg [3:0] phi_out,
    output reg state_changed
);

reg [3:0] prev_phase; // Register to store the previous phase value

always @(posedge clk) begin
    if (re == 1)
        phi_out <= 0;
    else if (full_tick == 0)
        phi_out <= ini_phase;
    else 
    phi_out<=0;
        
    
    
    if (phase != prev_phase) // Check if phase has changed
        begin
        phi_out <= phase;
        state_changed<=1'b1;
        end  
        else
        state_changed<=1'b0;
         
    prev_phase <= phase; // Update previous phase value
end

endmodule

