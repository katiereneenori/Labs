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

module Mux32Bit3To1(
    input [31:0] inA,
    input [31:0] inB,
    input [31:0] inC,
    input [1:0] sel,
    output reg [31:0] out
);
    always @(*) begin
        case(sel)
            2'b00: out = inA;
            2'b01: out = inB;
            2'b10: out = inC;
            default: out = 32'b0;
        endcase
    end
endmodule
