`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
// 
// ECE369A - Computer Architecture
// Laboratory 4
// Create Date: 10/25/2024 04:55:09 PM
// Design Name: 
// Module Name: Mux5Bit2To1
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

module Mux5Bit2To1(out, inA, inB, sel);
    output reg [4:0] out;
    input [4:0] inA, inB;
    input sel;

    always @(*) begin
        if (sel) 
            out = inB;
        else 
            out = inA;
    end
endmodule
