`timescale 1ns / 1ps
module phasecon(
input [3:0]phase,
output reg [15:0]lb,
output reg load);

always @(phase) begin
load=1;
        case (phase)
            4'h0: lb = 16'b1111111100000000;
            4'h1: lb = 16'b0111111110000000;
            4'h2: lb = 16'b0011111111000000;
            4'h3: lb = 16'b0001111111100000;
            4'h4: lb = 16'b0000111111110000;
            4'h5: lb = 16'b0000011111111000;
            4'h6: lb = 16'b0000001111111100;
            4'h7: lb = 16'b0000000111111110;
            4'h8: lb = 16'b0000000011111111;
            
            default: lb = 16'hff00;
        endcase
        #5 load=0;
      end

endmodule
