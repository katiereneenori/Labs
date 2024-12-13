`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// Updated for Decimal Display:
// This module now takes two 8-bit numbers (NumberA, NumberB), converts each
// to decimal (tens and ones place), and displays them on a 4-digit 7-seg display.
// The display order will be: 
// Digit0: ones place of NumberA
// Digit1: tens place of NumberA
// Digit2: ones place of NumberB
// Digit3: tens place of NumberB
//////////////////////////////////////////////////////////////////////////////////

module two2DigitDisplay(
    input Clk,
    input [7:0] NumberA,   // 0-99 assumed
    input [7:0] NumberB,   // 0-99 assumed
    output [6:0] out7,
    output reg [3:0] en_out,
    output dp
);

    wire [3:0] A_tens, A_ones;
    wire [3:0] B_tens, B_ones;

    // Convert binary to two BCD digits for each number
    BinaryToBCD2Digit convA(
        .bin(NumberA),
        .tens(A_tens),
        .ones(A_ones)
    );

    BinaryToBCD2Digit convB(
        .bin(NumberB),
        .tens(B_tens),
        .ones(B_ones)
    );

    // We now have A_tens, A_ones, B_tens, B_ones each 4-bit BCD
    // Mapping to digits:
    // Digit3 (leftmost): A_tens
    // Digit2: A_ones
    // Digit1: B_tens
    // Digit0 (rightmost): B_ones

    reg [3:0] in4;
    assign dp = 1'b1; // no decimal point

    SevenSegment segdecoder(in4, out7);

    reg [19:0] cnt = 0;
    always @(posedge Clk) begin
        cnt <= cnt + 1;
    end

    always @(*) begin
        case(cnt[17:16])
            2'b00: begin 
                en_out = 4'b0111; // Leftmost digit
                in4 = A_tens;
            end
            2'b01: begin 
                en_out = 4'b1011; 
                in4 = A_ones;
            end
            2'b10: begin 
                en_out = 4'b1101; 
                in4 = B_tens;
            end
            2'b11: begin 
                en_out = 4'b1110; 
                in4 = B_ones;
            end
        endcase
    end
endmodule
