`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
//////////////////////////////////////////////////////////////////////////////////

module TopDatapath_Board(
    input Clk, Reset,
    output [6:0] out7,
    output [3:0] en_out,
    output dp
);

    wire [31:0] v0, v1;
    wire [7:0] NumA, NumB;
    wire ClkOut;

    ClkDiv #(10000) m1(Clk, Reset, ClkOut); // Adjust as needed for a comfortable speed

    assign NumA = v0[7:0]; // Just the lower byte, must be 0-99
    assign NumB = v1[7:0]; // Also must be 0-99 for proper display

    two2DigitDisplay m2(
        .Clk(Clk),       // Using system clock for display refresh
        .NumberA(NumA),
        .NumberB(NumB),
        .out7(out7),
        .en_out(en_out),
        .dp(dp)
    );

    TopDatapath m3(
        .Clk(ClkOut),
        .Reset(Reset),
        .wire2(), .wire13(),
        .v0(v0),
        .v1(v1)
    );
endmodule
