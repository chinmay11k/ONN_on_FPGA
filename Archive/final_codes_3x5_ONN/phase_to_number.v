`timescale 1ns / 1ps

module phase_to_number(phi_to_no,phi_out,num);
output reg [1:0] num;
input [0:59] phi_out;
input phi_to_no;

always@(phi_to_no) begin

if(phi_to_no==1) begin
    if(phi_out == 60'b000000000000000010000000000010000000000010000000000000000000) begin
        num=2'b00;
    end
    else if(phi_out == 60'b100010000000100010000000100010000000100010000000100010000000) begin
        num=2'b01;
    end
    else if(phi_out == 60'b000000000000100010000000000000000000000010001000000000000000) begin
        num=2'b10;
    end
    else num=2'b11;
    end
else num=2'bxx;

end

endmodule
