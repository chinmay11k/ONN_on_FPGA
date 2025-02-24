`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2025 11:51:41
// Design Name: 
// Module Name: system_status
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


module system_status(
input clk,sclk,full_tick,[14:0]state_changed,
output reg steady_cheak,inconsistant_cheak);
//state change =1 when change happen and 0 all other time
reg [6:0]cs;
reg [20:0]ci;
always@(posedge sclk )
begin
if(full_tick==0)
begin
if(|state_changed==1)
begin
cs<=0;
steady_cheak<=0;
end
else
cs<=cs+1;
end
if(cs[6]==1)
begin
steady_cheak<=1;
cs<=0;
end
end

always@(posedge clk )
begin
if(full_tick==0)
begin
if(|state_changed==1)
begin
ci<=0;
inconsistant_cheak<=0;
end
else
ci<=ci+1;
end
if(ci==10000)
begin
inconsistant_cheak<=1;
cs<=0;
end
end
endmodule