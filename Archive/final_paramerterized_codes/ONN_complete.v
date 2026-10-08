`timescale 1ns / 1ps

module ONN_complete#(parameter n=210)(
input sclk,re,data_in,load,
output [0:4*n-1]phi_out,
output  phi_to_no
);
   
wire[0:n-1]nin;   
//wire [0:59]phi_out;
//wire steady_cheak,inconsistant_cheak;
wire[0:n-1]nout;
//wire phi_to_no;

control_to_neuron cn(
sclk,re,data_in,load,
nin,
phi_out,
nout,
phi_to_no
    );
    
synapse_block_n syn(
        nout,
        nin
    );
    
  endmodule