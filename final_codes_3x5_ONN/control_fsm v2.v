//control_fsm v2
`timescale 1ns / 1ps
module control_fsm(
input sclk,load,re,
input [14:0]state_changed,
output reg re_n,phi_to_no,drop,state_cheak);

reg [2:0]state;
reg[7:0]s1_c=0;
reg en_s2;
reg[4:0]s3_c=0;
parameter s0=0,s1=1,s2=2,s3=3,s4=4,si=5,sc=6;
reg en_s3;
always@(posedge sclk)
begin
if(re==1)
begin
s1_c=0;
en_s2=0;
en_s3=0;
phi_to_no=0;
s3_c=0;
state=s0;
re_n=0;
drop=0;
state_cheak=0;
end
else
begin
    case(state)
    s0:begin
        if(load==1)
            state=s1;
       else
        state=s0;
       end
    s1:begin
         if(s1_c>59)
         state=si;
         else
         state=s1;
         end
    s2:begin
        if(en_s3==1)
        state=s3;
        else
        state=s2;
        end
    s3:begin
        if(s3_c>16)
         begin
            state=sc;
        end
        else
            state=s3;
        end
     sc:begin
            if(state_changed>0)
                state=s2;
            else
                state=s4;
        end
     si:if(en_s2==1)
            state=s2;
    endcase  
 end       
//end

//always@(posedge sclk)       
//begin
case(state)        
s1:begin
    s1_c=s1_c+1;
    state_cheak=0;
   end
s2:begin
    re_n=1;
    drop=0;
    state_cheak=0;
    en_s3=1;
    en_s2=0;
   end
s3:begin
    re_n=0;
    en_s3=0;
    s3_c=s3_c+1;
    end
s4:begin
    phi_to_no=1;
        state_cheak=0;
end
si:begin
    en_s2=1;
    re_n=0;
    drop=1;
    end
sc:begin
    state_cheak=1;
    s3_c=0;
   end
endcase
end

endmodule
