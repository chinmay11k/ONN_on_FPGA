//state reg  v1

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2025 10:09:14
// Design Name: 
// Module Name: state_register
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


module state_in(
input full_tick,clk,
input ser_state_in,
output reg ser_state_out,reg [3:0]ini_phase);
always@(posedge clk)
begin
if(full_tick==1)
begin
ini_phase[0]<=ser_state_in;
ini_phase[3:1]<=ini_phase[2:0];
ser_state_out<=ini_phase[3];
end
end
endmodule
