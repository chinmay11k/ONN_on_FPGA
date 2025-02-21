`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2025 10:25:56
// Design Name: 
// Module Name: state_changes
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


module state_changes(
input clk,[3:0]phase,
output reg state_changed );
reg [3:0]prev_phase;
always@(posedge clk)
begin
if(prev_phase!=phase)
begin
state_changed<=1'b1;
prev_phase<=phase;
end
else
state_changed<=1'b0;
end
endmodule
