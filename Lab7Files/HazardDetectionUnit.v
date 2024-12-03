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
    input       ID_EX_RegWrite,
    input [4:0] ID_EX_RegisterRd,
    input       EX_MEM_RegWrite,
    input [4:0] EX_MEM_RegisterRd,
    input       MEM_WB_RegWrite,
    input [4:0] MEM_WB_RegisterRd,
    input [4:0] IF_ID_RegisterRs,
    input [4:0] IF_ID_RegisterRt,
    output      PCWrite,
    output      IF_ID_Write,
    output      ControlHazard
);

    wire hazard_ID_EX;
    wire hazard_EX_MEM;
    wire hazard_MEM_WB;

    assign hazard_ID_EX = ID_EX_RegWrite && (ID_EX_RegisterRd != 0) &&
                          ((ID_EX_RegisterRd == IF_ID_RegisterRs) ||
                           (ID_EX_RegisterRd == IF_ID_RegisterRt));

    assign hazard_EX_MEM = EX_MEM_RegWrite && (EX_MEM_RegisterRd != 0) &&
                           ((EX_MEM_RegisterRd == IF_ID_RegisterRs) ||
                            (EX_MEM_RegisterRd == IF_ID_RegisterRt));

    assign hazard_MEM_WB = MEM_WB_RegWrite && (MEM_WB_RegisterRd != 0) &&
                           ((MEM_WB_RegisterRd == IF_ID_RegisterRs) ||
                            (MEM_WB_RegisterRd == IF_ID_RegisterRt));

    assign ControlHazard = hazard_ID_EX || hazard_EX_MEM || hazard_MEM_WB;

    assign PCWrite = ~ControlHazard;
    assign IF_ID_Write = ~ControlHazard;

endmodule
