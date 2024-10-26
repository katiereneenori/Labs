`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux32Bit3To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit3To1(out, inA, inB, inC, sel);
    output [31:0] out;
    input [31:0] inA, inB, inC;
    input [1:0] sel;

    assign out = (sel == 2'b00) ? inA :
                 (sel == 2'b01) ? inB :
                 (sel == 2'b10) ? inC : inA; // default to inA
endmodule
