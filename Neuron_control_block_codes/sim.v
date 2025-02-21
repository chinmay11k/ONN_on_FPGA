`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2025 12:08:18
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2025 11:38:05
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb;
reg n,re,clk;
wire out;

pef uut(clk,re,n,out);
always
#0.2 clk=~clk;

initial
begin 
clk=1;
re=1;
#3;
re=0;

#3 n=0;
#3 n=1;
#3 n=1;
#3 n=0;
#3 n=0;
#3 n=0;
#3 n=1;
#3 n=1;
#3 n=1;
#3 n=0;
#3 n=1;
#3 n=0;
#3 n=1;
#3 n=0;
#3 n=0;
#3 n=0;
#3 n=0;
#3 n=0;
#3 n=1;
#3 n=0;
#3 n=0;
#3 n=1;
#3 n=0;
#3 n=1;
#3 n=1;
#3 n=1;
#3 n=1;
#3 n=1;
#3 n=0;
#3 n=1;
#3 n=1;
#3 n=0;
#3 n=1;
#3 n=0;
#3 n=1;



end




endmodule
