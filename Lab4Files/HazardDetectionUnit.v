`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
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
    input       ID_EX_MemRead, EX_MEM_MemRead,
    input [4:0] ID_EX_RegisterRt,
    input [4:0] IF_ID_RegisterRs,
    input [4:0] IF_ID_RegisterRt,
    input [4:0] EX_MEM_RegisterRt,
    output      PCWrite,
    output      IF_ID_Write,
    output      ControlHazard
);

assign ControlHazard = (ID_EX_MemRead || EX_MEM_MemRead) && 
                       ((ID_EX_RegisterRt == IF_ID_RegisterRs) || 
                        (ID_EX_RegisterRt == IF_ID_RegisterRt) || 
                        (EX_MEM_RegisterRt == IF_ID_RegisterRs)|| 
                        (EX_MEM_RegisterRt == IF_ID_RegisterRt));

assign PCWrite = ~ControlHazard;
assign IF_ID_Write = ~ControlHazard;

endmodule