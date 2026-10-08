`timescale 1ns/1ps   
module ONN_emnist_tb(); 
reg sclk,re,start;
reg [2:0]img_no;
wire phi_to_no;
reg [1:0]letter;
wire [1:0]letter_no;
 
top_module uut(sclk, re, start, img_no, letter, phi_to_no,letter_no);

parameter I=0,T=1,G=2,N=3;

initial 
begin
sclk=0;
forever #5 sclk=~sclk;
end 
initial
begin 
re=1;
letter=T;
img_no=0;
//start=1;
#100;
re=0;
#100;
start=1;
end
initial begin
    #10000;
        $display("# non-converging \n");
        $display("phi_out = \"%h\"", uut.onn.cn.phi_out);  
        $display("#LETTER = \"%h\"", letter_no ); 

    $finish;
end

// Trigger condition: phi_to_no becomes 1
initial begin
    wait (phi_to_no == 1);
    #20;
    $display("phi_out = \"%h\"", uut.onn.cn.phi_out);
    $display("#LETTER = \"%h\"", letter_no ); 
    $display("# converging \n");
    $finish;
end

initial begin
    wait (uut.onn.cn.controller.drop == 1);
    #20;
    $display("state = \"%h\"", uut.onn.cn.s2s.state );  
end
endmodule
