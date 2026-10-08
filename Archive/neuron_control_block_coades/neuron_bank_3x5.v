//neuron bank 5x3 v1
//////////////////////////////////////////////////////////////////////////////////
// Company: iit gn 
// Engineer: chinmay kulkarni
// 
// Create Date: 17.02.2025 20:58:13
//////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module neuron_bank_3x5(
    input clk,sclk,
    input re,
    input full_tick,
    input  [14:0] nin,
    input  ser_state_in,  // Declare as 2D array inside the module
    output [14:0] nout,
    output [14:0] state_changed,
output [0:59] phi_out
);
//reg [3:0] ser_state_out;
wire ser_state_out[14:0];
 neuron N0(
                       .clk(clk),
                       .sclk(sclk),
                       .re(re),
                       .nin(nin[0]),
                       .full_tick(full_tick),
                       .ser_state_in(ser_state_in),
                       .nout(nout[0]),
                       .ser_state_out(ser_state_out[0]),
                       .phi_out(phi_out[0:3]),
                       .state_changed(state_changed[0])
                   );
genvar n;
generate 
    for(n=1;n<15;n=n+1)
       begin:pixcel_no
       
        neuron N(
                        .clk(clk),
                        .sclk(sclk),
                        .re(re),
                        .nin(nin[n]),
                        .full_tick(full_tick),
                        .ser_state_in(ser_state_out[n-1]),
                        .nout(nout[n]),
                        .ser_state_out(ser_state_out[n]),
                        .phi_out(phi_out[4*n:4*n+3]),
                        .state_changed(state_changed[n])
                    );
                  end 
endgenerate




endmodule