`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2024 12:33:04 PM
// Design Name: 
// Module Name: Mux32Bit2To1JorBranch
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


module Mux32Bit2To1JorBranch(out, inA, inB, sel, Clk);
    output reg [31:0] out;
    input [31:0] inA, inB;
    input sel;
    input Clk;

    always @(posedge Clk) begin
        if (sel) 
            out <= inB;
        else 
            out <= inA;
    end
endmodule