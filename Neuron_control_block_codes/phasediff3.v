`timescale 1ns/1ps

module phasediff3(
    input wire clk,         // System clock
    input wire reset,       // Reset signal
    input wire nin,         // Input oscillating signal
    input wire nout,        // Output oscillating signal
    output reg signed [15:0] phi_out,
    output reg [3:0] phase_count// Output phase
);

    reg prev_nin, prev_nout; // Previous states for edge detection
    reg nin_rise, nout_rise; // Rising edge flags
    reg [15:0] phase_diff;   // Phase difference counter
       // 4-bit counter for 16 phase states

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            prev_nin  <= 0;
            prev_nout <= 0;
            nin_rise  <= 0;
            nout_rise <= 0;
            phase_diff <= 0;
            phi_out <= 0;
            phase_count <= 0;
        end else begin
            // Detect rising edge of nin
            nin_rise <= (nin & ~prev_nin);
            // Detect rising edge of nout
            nout_rise <= (nout & ~prev_nout);

            // Store previous states
            prev_nin  <= nin;
            prev_nout <= nout;
        end
    end

    // FSM for phase difference calculation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            phase_diff <= 0;
            phase_count <= 0;
        end else if (nin_rise) begin
            // If nin rises first, adjust phase difference
            if (phase_count < 15) begin
                phase_diff <= phase_diff + 1;
                phase_count <= phase_count + 1;
            end else begin
                phase_count <= 0;
            end
            phi_out <= phi_out + phase_diff;
        end else if (nout_rise) begin
            // If nout rises first, adjust phase difference
            if (phase_count > 0) begin
                phase_diff <= phase_diff - 1;
                phase_count <= phase_count - 1;
            end else begin
                phase_count <= 15;
            end
            phi_out <= phi_out - phase_diff;
        end
    end

endmodule
