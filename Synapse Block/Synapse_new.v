`timescale 1ns/1ps

module synapse_block_n #(
    parameter NUM_NEURONS  = 15,
    parameter PHASE_BITS   = 4,
    parameter WEIGHT_WIDTH = 5,
    parameter WEIGHT_FILE  = "weights.hex"
)(
    input  wire clk,
    input  wire rst_n,
    input  wire [NUM_NEURONS-1:0] nout,
    output wire [NUM_NEURONS-1:0] nin
);



//initial begin
//    $readmemh("weights.hex", weights); // Load Hebbian weights for digit '0'
//end
////-----------------------------
//// Synaptic Computation
////-----------------------------
//integer i,j;
//integer sum = 0;
//always @(posedge clk) begin
//    if (rst_n) begin
//        nin = 15'h0000; // Reset output to 0
//    end else begin
//        for ( i = 0; i < 15; i = i + 1) begin

//            for ( j = 0; j < 15; j = j + 1) begin
//                if (i != j) begin
//                    sum = sum + (nout[j] ? $signed(weights[i*15 + j]) : -$signed(weights[i*15 + j]));
//                end
//            end
//            nin[i]=sum;
//            //nin[i] = (sum > 0) ? 1'b1 : 1'b0;
//        end
//    end
//end

//endmodule

reg signed [4:0] w [0:14][0:14];

    // Initialize weights from a hex file (for simulation only)
    initial begin
        $readmemh("weights.hex", w);
    end

    // Generate block for parallel computation of each output n_in[i]
    genvar i, j;
    generate
        for (i = 0; i < 15; i = i + 1) begin : synapse_i
            // Array to hold individual terms: w[i][j] * n_out[j]
            wire signed [10:0] term [0:14];
            
            // Compute each term based on n_out[j]
            for (j = 0; j < 15; j = j + 1) begin : term_j
                assign term[j] = nout[j] ? w[i][j] : -w[i][j];
            end
            
            // Sum all terms combinatorially
            wire signed [10:0] sum = term[0] + term[1] + term[2] + term[3] + term[4] +
                                    term[5] + term[6] + term[7] + term[8] + term[9] +
                                    term[10] + term[11] + term[12] + term[13] + term[14];
            
            // Assign n_in[i] based on the sign of the sum
            
            assign nin[i] = (sum > 0) ? 1'b1 : 1'b0;
        end
    endgenerate

endmodule
