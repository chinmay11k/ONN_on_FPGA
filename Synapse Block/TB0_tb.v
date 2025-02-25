`timescale 1ns / 1ps

module TB_tb();
reg clk;
reg bit;
wire [0:59] phi_out;
wire num;

 reg [3:0] matrix [0:4][0:2]; // 5x3 matrix storing 4-bit values
    integer i, j, k;
    reg [3:0] temp;

 control_to_neuron uut(.clk(clk),.bit(),.phi_out(phi_out),.num(num));
initial begin 
clk=0;
forever #5 clk=~clk;
end
initial begin
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;


k = 0;
        for (i = 0; i < 5; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin
                temp = 0;
                temp[3] = bit; #10;
                temp[2] = bit; #10;
                temp[1] = bit; #10;
                temp[0] = bit; #10;
                matrix[i][j] = temp;
            end
        end

        // Display the matrix
        $display("5x3 Matrix Representation:");
        for (i = 0; i < 5; i = i + 1) begin
            for (j = 0; j < 3; j = j + 1) begin
                $write("%b ", matrix[i][j]); // Print 4-bit binary values
            end
            $write("\n");
         end
$finish;

end



endmodule

