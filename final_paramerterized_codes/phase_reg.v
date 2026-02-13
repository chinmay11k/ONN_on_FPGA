`timescale 1ns / 1ps
module phase_reg(
    input clk,                  // System clock
    input re,                   // Reset trigger
    input drop,                 // Drop trigger
    input state_cheak,          // Phase check trigger
    input [3:0] ini_phase,      // Initial phase value
    input [3:0] phase,          // Input phase to compare
    output reg [3:0] phi_out,   // Output phase value
    output reg state_changed    // Output: state changed flag
);

// Internal flags to remember last states (for edge detection)
reg re_d, drop_d, check_d;

always @(posedge clk) begin
    // Edge detection
    re_d     <= re;
    drop_d   <= drop;
    check_d  <= state_cheak;

    // --------------------
    // RESET logic (posedge re)
    if (re && !re_d) begin
        phi_out <= 4'd15;
        state_changed <= 0;
    end

    // --------------------
    // DROP logic (posedge drop)
    else if (drop && !drop_d) begin
        phi_out <= ini_phase;
        state_changed <=1;
    end

    // --------------------
    // PHASE CHECK logic (posedge state_cheak)
    else if (state_cheak && !check_d) begin
        if (phi_out != phase) begin
            phi_out <= phase;
            state_changed <= 1;
        end else begin
            state_changed <= 0;
        end
    end
end

endmodule
//phase reg v4
 
//`timescale 1ns / 1ps
//module phase_reg(
//    input re,drop,state_cheak,
//    input [3:0] ini_phase,
//    input [3:0] phase,
//    output reg [3:0] phi_out,
//    output  reg state_changed
//);
////    reg drop2;
////    reg[3:0]ini_phase2;
//    always@(posedge state_cheak or posedge drop or posedge re)
//    begin
//        if (re == 1) begin
//                  phi_out<=8;
//                  state_changed<=0;
//                  end
//        else    begin
//                if(drop==1)
//                begin
//                phi_out<=ini_phase;
//                end
//                if(state_cheak==1)
//                       begin
//                       if(phi_out!=phase)begin
//                            state_changed<=1;
//                            phi_out<=phase;end
//                        else
//                        begin
//                            state_changed<=0;
//                            phi_out<=phase;end

//                            end
//       end
//       end      
//endmodule

