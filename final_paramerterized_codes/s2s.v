//s2s_v3
`timescale 1ns / 1ps

module serial2state#(parameter n=210) (
    input wire data_in, // Single 8-bit input
    input wire load, re, sclk,
    output reg[0:4*n-1]state  );

always@(posedge sclk)
begin
if(re==1)
    state=0;
    else
    begin
        if(load==1)
        state<={data_in,state[0:4*n-2]};
    end
    end
endmodule
