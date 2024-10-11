`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2022 01:31:02 PM
// Design Name: 
// Module Name: InstructionFetchUnit
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


module InstructionFetchUnit(Clk, Rst, Instruction, PCResult);

input Clk, Rst;
output [31:0] Instruction;

output wire [31:0] PCResult;
wire [31:0] PCAddResult;

PCAdder u0(PCResult, PCAddResult);

ProgramCounter u1(Clk, Rst, PCAddResult, PCResult);

InstructionMemory u2(PCResult, Instruction);

endmodule
