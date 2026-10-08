`timescale 1ns / 1ps

module test_bench_onn_emnist();

reg sclk;
reg re;
reg start;
reg digit;
reg [2:0] img_no;

wire [3:0] num;

top_module #(
    .n(100)
) uut (
    .sclk(sclk),
    .re(re),
    .start(start),
    .digit(digit),
    .img_no(img_no),
    .num(num)
);

initial begin
    sclk = 0;
    forever #1 sclk = ~sclk;
end


initial begin

    re    = 1;
    start = 0;
    digit = 0;
    img_no = 0;

    #4;
    re = 0;
    start = 1;

    #1200;

    $finish;

end

endmodule