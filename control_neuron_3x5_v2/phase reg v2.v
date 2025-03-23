//phase reg v3
`timescale 1ns / 1ps
module phase_reg(
    input full_tick, re, ren, sclk,drop,state_cheak,
    input [3:0] ini_phase,
    input [3:0] phase,
    output reg [3:0] phi_out,
    output  reg state_changed
);
    reg c;
    reg [3:0] prev_phase;

    wire phase_en,ini_en;
    wire [3:0]ini_w,phase_w;

    assign phase_en=(state_cheak & state_changed);
    assign ini_en=ren&drop;
    
    always@(posedge sclk)
    begin
        if (re == 1) begin
                  phi_out=8;
                  end
        else    begin
                if(ini_en==1)
                begin
                prev_phase<=ini_phase;
                phi_out<=ini_phase;
                end
                if(phase_en==1)
                phi_out<=phase;
                end
      end
      
      always@(state_cheak)
        if(state_cheak==1)
            if(prev_phase!=phase)begin
                state_changed=1;
                prev_phase=phase;end
            else
                state_changed<=0;
       
       
      
endmodule
