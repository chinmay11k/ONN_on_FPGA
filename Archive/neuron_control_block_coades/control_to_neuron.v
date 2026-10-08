`timescale 1ns / 1ps
module control_to_neuron(
input clk,re,data_in,load,
input[14:0]nin,
output [0:59] phi_out,
output steady_cheak,inconsistant_cheak,
output [14:0]nout
    );
wire sclk; 
wire ser_state_out;
 wire full_tick;
wire [14:0]state_changed;

freqdivider m1(clk,sclk);   
    
neuron_bank_3x5 m2(
        clk,sclk,
        re,
        full_tick,
        nin,
        ser_state_out,  // Declare as 2D array inside the module
        nout,
        phi_out,
        state_changed
    ); 

   
system_status m3(clk,sclk,full_tick,state_changed,steady_cheak,inconsistant_cheak);   
   
serial2state m4 (data_in,load, re, clk,ser_state_out,full_tick);
endmodule
