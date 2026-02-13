`timescale 1ns / 1ps

module top_module#(parameter n=210)(
input clk,re,start,
input [1:0]letter,
input [2:0]img_no,
output TxD,phi_to_no
    );
wire sclk;
freqdivider fd (clk,sclk);
    
wire [0:4*n-1]phi_out;
wire load;
wire data_in;

letter_load il(img_no,start,re,sclk,letter,data_in,load);

ONN_complete onn(sclk,re,data_in,load,phi_out,phi_to_no);

wire phi_e;

edge_detect p(clk,phi_to_no,phi_e); 
   
uart_out out(
         clk,
         phi_e,
         phi_to_no,
         phi_out,
         TxD);
endmodule
