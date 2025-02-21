`timescale 1ns / 1ps
module freqdivider(
input clk,
output out);
reg[27:0]c=0;
reg clko=0;
always @(posedge clk)
begin 
c<=c+1;
end

assign out=c[4];
endmodule

