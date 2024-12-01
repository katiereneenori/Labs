`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// ECE369A - Computer Architecture
// Module - ShiftLeft2.v
// Description - Shifts bits left 2
// 
// INPUTS:-
// toShift: 32-Bit input word
// 
// OUTPUTS:-
// shiftedResult: 32-Bit output port.
//
// FUNCTIONALITY:-
// Shifts input word by 2 bits (multiply by 4 for byte addressing)
////////////////////////////////////////////////////////////////////////////////

module ShiftLeft2(toShift, shiftedResult);

    input [31:0] toShift;

    output [31:0] shiftedResult;
    
    assign shiftedResult = toShift << 2;

endmodule

