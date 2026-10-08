`timescale 1ns / 1ps

module TB1_tb();
reg clk;
reg bit;
wire [0:59] phi_out;
wire num;


control_to_neuron uut(.clk(clk),.bit(),.phi_out(phi_out),.num(num));
initial begin 
clk=0;
forever #5 clk=~clk;
end
initial begin
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10; 
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10;
bit = 1;#10;bit = 1;#10;bit = 1;#10;bit = 1;#10; 
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10;
bit = 0;#10;bit = 0;#10;bit = 0;#10;bit = 0;#10;

$finish;

end



endmodule

