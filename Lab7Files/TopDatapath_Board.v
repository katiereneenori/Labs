`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
//////////////////////////////////////////////////////////////////////////////////


module TopDatapath_Board(Clk, Reset, out7, en_out, dp);

input Clk, Reset;
wire [15:0] Address, PCVal, Num;

wire [7:0] NumA, NumB;
wire [31:0] v0, v1; // Outputs from TopDatapath

output [6:0] out7; //seg a, b, ... g
output [3:0] en_out;
output wire dp;

wire ClkOut;

ClkDiv m1(Clk, Reset, ClkOut);

assign NumA = v0[7:0]; // Display the least significant byte of v0
assign NumB = v1[7:0]; // Display the least significant byte of v1

//Mux2x1 m4(PCVal, Address, Num, ClkOut);

//Mux2x1 m5(0, 1, dp, ClkOut);

//One4DigitDisplay m2(Clk, Num, out7, en_out);

// Instantiate the two-digit display module
two2DigitDisplay m2(
    .Clk(Clk), 
    .NumberA(NumA), 
    .NumberB(NumB), 
    .out7(out7), 
    .en_out(en_out), 
    .dp(dp)
);

TopDatapath m3(ClkOut, Reset, PCVal, Address, v0, v1);

// Instantiate the TopDatapath module
//TopDatapath m3(
//    .Clk(ClkOut), 
//    .Reset(Reset), 
 //   .v0(v0), 
 //   .v1(v1)
//);

endmodule