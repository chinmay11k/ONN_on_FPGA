`timescale 1ns / 1ps

module ONN_complete(
input sclk,re,data_in,load,
output[1:0] num
);
   
wire[0:14]nin;   
wire [0:59]phi_out;
wire steady_cheak,inconsistant_cheak;
wire[0:14]nout;
wire phi_to_no;

control_to_neuron cn(
sclk,re,data_in,load,
nin,
phi_out,
steady_cheak,inconsistant_cheak,
nout,
phi_to_no
    );
    
synapse_block_n syn(
        nout,
        nin
    );
        
phase_to_number ptn(phi_to_no,phi_out,num);
    
  endmodule