`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
// 
// ECE369A - Computer Architecture
// Laboratory 4
// Module - Mux32Bit3To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit3To1(out, inA, inB, inC, sel);
    output reg [31:0] out;
    input [31:0] inA, inB, inC;
    input [1:0] sel;

    always @(*) begin
        if (sel == 2'b00)
            out = inA;
        else if (sel == 2'b01)
            out = inB;
        else if (sel == 2'b10)
            out = inC;
        else
            out = inA; // default to inA
    end
endmodule
