`timescale 1ns / 1ps

module phase_to_number(clk,steady_cheak,num,phi_out);
output reg [1:0] num;
input [0:59] phi_out;
input steady_cheak,clk;
always@(posedge clk) begin
if(steady_cheak==1) begin
if(phi_out == 60'b111111111111111100001111111100001111111100001111111111111111) begin
    num=2'b00;
end
else if(phi_out == 60'b000000001111000000001111000000001111000000001111000000001111) begin
    num=2'b01;
end
else if(phi_out == 60'b111111111111000000001111111111111111111100000000111111111111) begin
    num=2'b10;
end
else num=2'b11;
end
else num=2'bxx;

end

endmodule
