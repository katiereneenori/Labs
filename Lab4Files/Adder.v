`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// ECE369A - Computer Architecture
// Module - Adder.v
// Description - 32-Bit adder.
// 
// INPUTS:-
// inA
// inB
// 
// OUTPUTS:-
// AddResult: 32-Bit output port.
//
// FUNCTIONALITY:-
// Adds two inputs and outputs solution
////////////////////////////////////////////////////////////////////////////////

module Adder(inA, inB, AddResult);

    input [31:0] inA, inB;

    output [31:0] AddResult;
    
    assign AddResult = inA + inB; 

endmodule

