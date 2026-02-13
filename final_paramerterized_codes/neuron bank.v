//neuron bank 5x3 v2
//////////////////////////////////////////////////////////////////////////////////
// Company: iit gn 
// Engineer: chinmay kulkarni
// 
// Create Date: 17.02.2025 20:58:13
//////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module neuron_bank_3x5#(parameter n=210)
(
    input sclk,
    input re,re_n,
    input drop,state_cheak,
    input  [0:n-1] nin,
    input  [0:4*n-1]state,
    output [0:n-1] nout,
    output [0:n-1] state_changed,
    output [0:4*n-1] phi_out
);
genvar i;
generate
    for (i = 0; i < n; i = i + 1) begin : neuron_block
        neuron N (
            .sclk(sclk), 
            .re(re),
            .re_n(re_n), 
            .nin(nin[i]),
            .drop(drop),
            .state_cheak(state_cheak),
            .ini_phase(state[(4*i) +: 4]),
            .nout(nout[i]), 
            .phi_out(phi_out[(4*i) +: 4]),
            .state_changed(state_changed[i])
        );
    end
endgenerate

endmodule