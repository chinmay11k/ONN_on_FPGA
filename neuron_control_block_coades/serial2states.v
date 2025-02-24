`timescale 1ns / 1ps

module serial2state (
    input wire data_in, // Single 8-bit input
    input wire load, re, clk,
    output reg ser_state_out,
    output reg full_tick
);
reg[7:0]fc;

always@(posedge clk)
begin
if(load==1)
   begin
    fc<=fc+1;
    ser_state_out<=data_in;
    full_tick<=1;
   end
if(fc==60)
begin
full_tick<=0;
fc<=0;
end  
  end
endmodule
