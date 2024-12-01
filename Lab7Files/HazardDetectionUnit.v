`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
// 
// ECE369A - Computer Architecture
// Create Date: 11/10/2024 10:17:12 AM
// Design Name: 
// Module Name: HazardDetectionUnit
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


module HazardDetectionUnit(
    input       ID_EX_MemRead,
    input [4:0] ID_EX_RegisterRt,
    input [4:0] IF_ID_RegisterRs,
    input [4:0] IF_ID_RegisterRt,
    output      PCWrite,
    output      IF_ID_Write,
    output      ControlHazard
);

assign ControlHazard = ID_EX_MemRead && 
                       ((ID_EX_RegisterRt == IF_ID_RegisterRs) || 
                        (ID_EX_RegisterRt == IF_ID_RegisterRt));

assign PCWrite = ~ControlHazard;
assign IF_ID_Write = ~ControlHazard;

endmodule