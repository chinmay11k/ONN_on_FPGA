`timescale 1ns / 1ps
module first_wave(
input nin,nout,clk,re,
output reg flag );
reg prev_nin, prev_nout; // Previous states for edge detection
reg o1,o2;
reg en;
always@(posedge clk)
 begin
           // Detect rising edge of nin
           o1 <= (nin & ~prev_nin);
           // Detect rising edge of nout
           o2 <= (nout & ~prev_nout);

           // Store previous states
           prev_nin  <= nin;
           prev_nout <= nout;
       end
always@(posedge clk)
     begin
     if(re)begin
     en=1;
     flag=0;
     end
     else
     begin
     if(en==1)
     begin 
     case({o1,o2})
     2'b10:
                begin
                flag=1;
                en=0;
                end
     2'b11:     begin
                flag=1;
                en=0;
                end
     2'b01:
               begin
               flag=0;
               en=0;
               end
               endcase
end
end
end
endmodule
