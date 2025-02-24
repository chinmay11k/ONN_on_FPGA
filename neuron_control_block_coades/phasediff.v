//phasediff v4
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:iitgn 
// Engineer: chinmay kulkarni
//////////////////////////////////////////////////////////////////


module phasediff(
input nin,nout,clk,sclk,re,
input [3:0]phi_out,
output reg [3:0]phase);
wire [3:0]phase_diff;
reg nf,ns;
wire flag;
reg sign;
initial
begin
nf=nin;
ns=nout;
sign=1;
//phase=ini_phase;
end
first_wave i2(nin,nout,clk,re,flag);

always@(posedge sclk)//(re)
begin
case(flag)
1:
    begin
    nf<=nin;
    ns<=nout;
    sign=0;//- phasediff
    end
0:
    begin
    nf<=nout;
    ns<=nin;
    sign=1;//+phasediff
    end
endcase
end
phase_diff_calculator i1(nf,ns,sclk,phase_diff);
always@(phase_diff)
begin
case(sign)
1:phase<=phi_out-phase_diff;
0:phase<=phi_out+phase_diff;
endcase
end
endmodule
