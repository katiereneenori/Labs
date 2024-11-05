`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
//////////////////////////////////////////////////////////////////////////////////


module TopDatapath_Board(Clk, Reset, out7, en_out, dp);

input Clk, Reset;
wire [15:0] Address, PCVal, Num;

output [6:0] out7; //seg a, b, ... g
output [3:0] en_out;
output wire dp;

wire ClkOut;

ClkDiv m1(Clk, Reset, ClkOut);

Mux2x1 m4(PCVal, Address, Num, ClkOut);

Mux2x1 m5(0, 1, dp, ClkOut);

One4DigitDisplay m2(Clk, Num, out7, en_out);

TopDatapath m3(ClkOut, Reset, PCVal, Address);

endmodule