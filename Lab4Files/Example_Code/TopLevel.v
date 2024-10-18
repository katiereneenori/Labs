`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2022 05:55:58 PM
// Design Name: 
// Module Name: TopLevel
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


module TopLevel(Clk, Reset, out7, en_out, dp);

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

InstructionFetchUnit m3(ClkOut, Reset, Address, PCVal);


endmodule
