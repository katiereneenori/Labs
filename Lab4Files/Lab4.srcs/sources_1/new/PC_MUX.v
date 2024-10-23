`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2024 07:16:38 PM
// Design Name: 
// Module Name: PC_MUX
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

module PC_MUX(
    input [31:0] PC_Plus4,          // input 0
    input [31:0] Branch_Target,     // input 1
    input [31:0] Jump_Address,      // input 2
    input [31:0] Register_Address,  // input 3
    input [1:0] PCSrc,              // control signal
    output reg [31:0] PC_Next       // output to PC
);

    always @(*) begin
        case (PCSrc)
            2'b00: PC_Next = PC_Plus4;
            2'b01: PC_Next = Branch_Target;
            2'b10: PC_Next = Jump_Address;
            2'b11: PC_Next = Register_Address;
            default: PC_Next = PC_Plus4; //default to sequential execution
        endcase
    end

endmodule