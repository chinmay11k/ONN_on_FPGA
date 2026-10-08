`timescale 1ns / 1ps
module test_bench_onn_60( );
reg sclk, re, start;
reg[3:0]img_no;
wire [3:0]num;

top_module uut(sclk,re,start,img_no,num);

initial
begin
sclk=0;
forever #1 sclk=~sclk;
end

initial
begin
re=1;
img_no=0;//change this as per imag_load module used to sent state directly 
#4 re=0;
start=1;
#1200

$finish;
end
endmodule

