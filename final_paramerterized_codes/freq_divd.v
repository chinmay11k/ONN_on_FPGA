`timescale 1ns / 1ps
module freqdivider(
    input clk,
    output  out
);
    reg [6:0] c = 0; // 7 bits sufficient for counting to 50

    always @(posedge clk) begin
     c=c+1;
     end
     
     assign out=c[5];
endmodule
