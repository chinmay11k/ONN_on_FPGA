//neuron v4
`timescale 1ns/1ps
module neuron(
    input wire sclk,          // System clock
    input wire re,re_n,         // Reset signal
    input wire nin,           // Neuron input oscillation
    input wire full_tick,drop,state_cheak,     // Synchronization signal
    input [3:0]ini_phase,  // Serial input for initialization
    output wire nout,         // Neuron output oscillation
    output  [3:0] phi_out ,// Neuron phase output
    output wire state_changed );
  
    wire [3:0]phase;
    wire ren=re^re_n;
        
    diff_phase_fsm phase_diff(sclk,nin,nout,re_n,phi_out,phase);
    
    pco pco(sclk,ren,phi_out,nout);
      
    phase_reg phase_reg(full_tick,re,ren,sclk,drop,state_cheak,ini_phase,phase,phi_out,state_changed);
    
    endmodule