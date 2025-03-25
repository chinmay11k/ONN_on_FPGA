//phase reg v4

`timescale 1ns / 1ps
module phase_reg(
    input re, ren,drop,state_cheak,
    input [3:0] ini_phase,
    input [3:0] phase,
    output reg [3:0] phi_out,
    output  reg state_changed
);
    always@(posedge state_cheak or posedge drop or posedge re)
    begin
        if (re == 1) begin
                  phi_out<=8;
                  state_changed<=0;
                  end
        else    begin
                if(drop==1)
                begin
                phi_out<=ini_phase;
                end
                if(state_cheak==1)
                       begin
                       if(phi_out!=phase)begin
                            state_changed<=1;
                            phi_out<=phase;end
                        else
                        begin
                            state_changed<=0;
                            phi_out<=phase;end

                            end
       end
       end
       
      
endmodule
