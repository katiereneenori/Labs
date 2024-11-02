`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2024 10:48:53 AM
// Design Name: 
// Module Name: TopDatapath_Board
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2024 07:24:48 PM
// Design Name: 
// Module Name: TopDatapath_Board
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