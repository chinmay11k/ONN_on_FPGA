//edge detector
`timescale 1ns / 1ps
module edge_detect(
input clk,n,
output o);
reg q;
always@(posedge clk)
begin
q<=n;
end
assign o=~q&n;
endmodule
