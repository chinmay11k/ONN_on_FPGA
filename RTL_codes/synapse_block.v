`timescale 1ns/1ps

module synapse_block_n #(
    parameter n = 210
)(
    input  wire [0:n-1] nout,
    output wire [0:n-1] nin
);

    // Flattened weight memory: n*n weights, 5-bit signed
    reg signed [4:0] w [0:n*n-1];

    initial begin
        $readmemh("weights_iitgn_30_hex.hex", w);
    end

    genvar i, j;
    generate
        for (i = 0; i < n; i = i + 1) begin : synapse_i

            wire signed [10:0] term [0:n-1];

            for (j = 0; j < n; j = j + 1) begin : term_j

                assign term[j] =
                    nout[j] ? w[i*n+j] : -w[i*n+j];

            end

            wire signed [20:0] sum =
                    term[0] + term[1] + term[2] + term[3] + term[4] +
                    term[5] + term[6] + term[7] + term[8] + term[9] +
                    term[10] + term[11] + term[12] + term[13] + term[14] +
                    term[15] + term[16] + term[17] + term[18] + term[19] +
                    term[20] + term[21] + term[22] + term[23] + term[24] +
                    term[25] + term[26] + term[27] + term[28] + term[29] +
                    term[30] + term[31] + term[32] + term[33] + term[34] +
                    term[35] + term[36] + term[37] + term[38] + term[39] +
                    term[40] + term[41] + term[42] + term[43] + term[44] +
                    term[45] + term[46] + term[47] + term[48] + term[49] +
                    term[50] + term[51] + term[52] + term[53] + term[54] +
                    term[55] + term[56] + term[57] + term[58] + term[59] +
                    term[60] + term[61] + term[62] + term[63] + term[64] +
                    term[65] + term[66] + term[67] + term[68] + term[69] +
                    term[70] + term[71] + term[72] + term[73] + term[74] +
                    term[75] + term[76] + term[77] + term[78] + term[79] +
                    term[80] + term[81] + term[82] + term[83] + term[84] +
                    term[85] + term[86] + term[87] + term[88] + term[89] +
                    term[90] + term[91] + term[92] + term[93] + term[94] +
                    term[95] + term[96] + term[97] + term[98] + term[99] +
                    term[100] + term[101] + term[102] + term[103] + term[104] +
                    term[105] + term[106] + term[107] + term[108] + term[109] +
                    term[110] + term[111] + term[112] + term[113] + term[114] +
                    term[115] + term[116] + term[117] + term[118] + term[119] +
                    term[120] + term[121] + term[122] + term[123] + term[124] +
                    term[125] + term[126] + term[127] + term[128] + term[129] +
                    term[130] + term[131] + term[132] + term[133] + term[134] +
                    term[135] + term[136] + term[137] + term[138] + term[139] +
                    term[140] + term[141] + term[142] + term[143] + term[144] +
                    term[145] + term[146] + term[147] + term[148] + term[149] +
                    term[150] + term[151] + term[152] + term[153] + term[154] +
                    term[155] + term[156] + term[157] + term[158] + term[159] +
                    term[160] + term[161] + term[162] + term[163] + term[164] +
                    term[165] + term[166] + term[167] + term[168] + term[169] +
                    term[170] + term[171] + term[172] + term[173] + term[174] +
                    term[175] + term[176] + term[177] + term[178] + term[179] +
                    term[180] + term[181] + term[182] + term[183] + term[184] +
                    term[185] + term[186] + term[187] + term[188] + term[189] +
                    term[190] + term[191] + term[192] + term[193] + term[194] +
                    term[195] + term[196] + term[197] + term[198] + term[199] +
                    term[200] + term[201] + term[202] + term[203] + term[204] +
                    term[205] + term[206] + term[207] + term[208] + term[209];

            assign nin[i] = (sum > 0) ? 1'b1 : 1'b0;

        end
    endgenerate

endmodule