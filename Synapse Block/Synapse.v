`timescale 1ns/1ps

module synapse_block #(
    parameter NUM_NEURONS  = 15,
    parameter PHASE_BITS   = 4,
    parameter WEIGHT_WIDTH = 5,
    parameter WEIGHT_FILE  = "weights.hex"
)(
    input  wire clk,
    input  wire rst_n,
    input  wire [NUM_NEURONS-1:0] nin,
    output wire [NUM_NEURONS-1:0] nout
);

    // Global phase counter (0-15)
    reg [PHASE_BITS-1:0] global_phase;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) 
            global_phase <= 0;
        else 
            global_phase <= (global_phase == 15) ? 0 : global_phase + 1;
    end

    // Neuron phase tracking (rising edge detection)
    reg [PHASE_BITS-1:0] neuron_phases [0:NUM_NEURONS-1];
    generate
        genvar i;
        for (i = 0; i < NUM_NEURONS; i = i + 1) begin : phase_track
            reg [1:0] edge_detect;
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    edge_detect     <= 2'b00;
                    neuron_phases[i] <= 0;
                end else begin
                    edge_detect <= {edge_detect[0], nin[i]};
                    if (edge_detect == 2'b01)
                        neuron_phases[i] <= global_phase;
                end
            end
        end
    endgenerate

    // Weight memory
    reg signed [WEIGHT_WIDTH-1:0] weight_rom [0:NUM_NEURONS*NUM_NEURONS-1];
    initial begin 
        $readmemh(WEIGHT_FILE, weight_rom);
    end

    // Phase interaction and output generation
    // Minimal changes: instead of a fully parallel inner loop,
    // we use a sequential accumulator inside each neuron's block.
    generate
        genvar k;
        for (k = 0; k < NUM_NEURONS; k = k + 1) begin : neuron_core
            // Sequential accumulator registers
            reg signed [WEIGHT_WIDTH+8:0] phase_sum;
            reg [PHASE_BITS-1:0] phase_offset;
            reg [PHASE_BITS-1:0] pdiff;
            reg [3:0] j_counter;   // Will count from 0 to NUM_NEURONS
            reg state;             // 0 = accumulating, 1 = done
            // Shift register for square-wave output (16-bit cyclic pattern)
            reg [15:0] shift_reg;
            
            // Shift register rotation 
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n)
                    shift_reg <= 16'b1111111100000000;
                else
                    shift_reg <= {shift_reg[14:0], shift_reg[15]};
            end

            // Sequential accumulation: compute phase_sum over NUM_NEURONS cycles
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    phase_sum  <= 0;
                    j_counter  <= 0;
                    state      <= 0;
                    phase_offset <= 0;
                end else begin
                    if (state == 0) begin
                        // Accumulation phase: process one j per clock
                        if (j_counter < NUM_NEURONS) begin
                            if (j_counter != k) begin
                                // Calculate circular phase difference:
                                if (neuron_phases[k] >= neuron_phases[j_counter])
                                    pdiff <= neuron_phases[k] - neuron_phases[j_counter];
                                else
                                    pdiff <= 16 + neuron_phases[k] - neuron_phases[j_counter];
                                phase_sum <= phase_sum + weight_rom[k*NUM_NEURONS + j_counter] * SIN_LUT(pdiff);
                            end
                            j_counter <= j_counter + 1;
                        end else begin
                            // After accumulating over all j, compute phase offset.
                            phase_offset <= (neuron_phases[k] + (phase_sum >>> 8)) % 16;
                            state <= 1;
                        end
                    end else begin
                        // Stay in state=1 for one cycle to update output, then reset accumulator.
                        j_counter <= 0;
                        phase_sum <= 0;
                        state <= 0;
                    end
                end
            end

            // Use the computed phase_offset to sample the shift register for output.
            assign nout[k] = shift_reg[phase_offset];
        end
    endgenerate

    // Sine LUT for phase modulation (unchanged)
    function signed [7:0] SIN_LUT(input [3:0] pdiff);
        case(pdiff)
            4'd0:  SIN_LUT = 8'h00;
            4'd1:  SIN_LUT = 8'h30;
            4'd2:  SIN_LUT = 8'h5A;
            4'd3:  SIN_LUT = 8'h76;
            4'd4:  SIN_LUT = 8'h7F;
            4'd5:  SIN_LUT = 8'h76;
            4'd6:  SIN_LUT = 8'h5A;
            4'd7:  SIN_LUT = 8'h30;
            4'd8:  SIN_LUT = 8'h00;
            4'd9:  SIN_LUT = 8'hD0;
            4'd10: SIN_LUT = 8'hA6;
            4'd11: SIN_LUT = 8'h8A;
            4'd12: SIN_LUT = 8'h81;
            4'd13: SIN_LUT = 8'h8A;
            4'd14: SIN_LUT = 8'hA6;
            4'd15: SIN_LUT = 8'hD0;
            default: SIN_LUT = 8'h00;
        endcase
    endfunction

endmodule
