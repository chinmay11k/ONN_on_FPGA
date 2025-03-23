//tb0

`timescale 1ns / 1ps

module tb0();
reg sclk,re,load;
reg bit;
reg [14:0]nin;
wire [0:59] phi_out;
//wire [1:0]num;
wire steady_cheak;
wire [14:0]nout;
wire inconsistant_cheak;
integer i;
wire phi_to_no;
control_to_neuron uut (
sclk,re,bit,load,//in
nin,//in
phi_out,//0
steady_cheak,inconsistant_cheak,//o
nout,
phi_to_no//o
    );

initial begin 
sclk=0;
forever #5 sclk=~sclk;
end

initial begin
load=1;re=1;#10;re=0;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 0;#10;bit = 1;#10;bit = 0;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 0;#10;bit = 1;#10;bit = 0;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
load=0;

#2000;
$finish;
end
reg[14:0]nop,nop2;
always@(posedge sclk)
begin
if(control_to_neuron.controller.re_n==0)
#1; nin=nop2;
nop2=nop;
nop=nout;
end
endmodule
