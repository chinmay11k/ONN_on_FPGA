//phase calculator v2
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2025 13:50:47
// Design Name: 
// Module Name: phasecalc
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


module phasecalc(
input nf,ns,clk,
output reg [3:0]phase_diff);

reg [3:0]c=0;
reg [3:0]diffreg=0;
reg [3:0]prediffreg=0;
reg enpd=1;
always@(negedge clk)
begin
if(c==0 && ns==1)
enpd=0;
else if(c>0)
enpd=1;
end
      
always@(posedge clk )//or posedge nin or posedge nout)
    begin
    if (nf==1 && ns==0)
        c<=c+1;
    else if(ns==1)begin
           diffreg<=c;
           c<=0;
        end
        end
always@*
begin
if(enpd==1)
begin
if(prediffreg!=diffreg)
begin
phase_diff<=diffreg;
prediffreg<=diffreg;
end
end
end
endmodule
