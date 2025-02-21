//neuron v3
`timescale 1ns/1ps
module neuron(
    input wire clk,sclk,          // System clock
    input wire re,         // Reset signal
    input wire nin,           // Neuron input oscillation
    input wire full_tick,     // Synchronization signal
    input wire ser_state_in,  // Serial input for initialization
    output wire nout,         // Neuron output oscillation
    output wire ser_state_out,// Serial output for scan-path
    output wire [3:0] phi_out ,// Neuron phase output
    output wire state_changed );
    wire [3:0]ini_phase;
    wire [3:0]phase;
         
    phasediff m2(nin,nout,clk,sclk,re,phi_out,phase);
    
    pco m3(sclk,re,phi_out,nout);
    
    state_in m4(full_tick,clk,ser_state_in,ser_state_out,ini_phase);
    
    state_changes m5(clk,phi_out,state_changed);
    
    phase_reg m6(full_tick,re,sclk,ini_phase,phase,phi_out);
    
    endmodule