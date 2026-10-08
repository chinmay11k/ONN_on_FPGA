//control_to_neuron_v2
`timescale 1ns / 1ps
module control_to_neuron#(parameter n=210)(
input sclk,re,data_in,load,
input[0:n-1]nin,
output [0:4*n-1] phi_out,
output [n-1:0]nout,
output phi_to_no
    );
//wire sclk; 
wire [0:4*n-1]state;
wire [n-1:0]state_changed;
wire re_n;
//freqdivider m1(clk,sclk);
wire drop;
wire state_cheak;
wire [7:0]s1_c_out;  


control_fsm controller(sclk,load,re,state_changed,re_n,phi_to_no,drop,state_cheak,s1_c_out);    


neuron_bank N_bank(
        sclk,
        re,re_n,
        drop,
        state_cheak,
        nin,
        state,
        nout,
        state_changed,
        phi_out       
    ); 

serial2state s2s(data_in,load, re, sclk,state);
endmodule
