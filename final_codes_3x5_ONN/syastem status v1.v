//syastem stetus v1

`timescale 1ns / 1ps
module system_status(
input sclk,full_tick,[14:0]state_changed,
output reg steady_cheak,inconsistant_cheak);
//state change =1 when change happen and 0 all other time
reg [6:0]cs;
reg [20:0]ci;
always@(posedge sclk )
begin
if(full_tick==0)
    begin
    if(state_changed>0)
        begin
        cs<=0;
        steady_cheak<=0;
        end
    else
        begin
        if(cs[6]!=1)
        cs<=cs+1;
        else
            begin
            steady_cheak<=1;
            cs<=0;
        end
    end
end
end

always@(posedge sclk )
begin
    if(full_tick==0)
        begin
        if(state_changed>0)
            begin
            ci<=0;
            inconsistant_cheak<=0;
            end
        else
        begin
            if(ci!=10000)
            ci<=ci+1;
            else
            begin
            inconsistant_cheak<=1;
            ci<=0;
            end
            end
        end
    end
endmodule