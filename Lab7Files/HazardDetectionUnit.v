`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// HazardDetectionUnit
// Flushes only IF/ID when a control hazard (branch or jump) occurs in ID.
////////////////////////////////////////////////////////////////////////////////

module HazardDetectionUnit(
    input        ID_EX_MemRead,
    input [4:0]  ID_EX_RegisterRt,
    input [4:0]  IF_ID_RegisterRs,
    input [4:0]  IF_ID_RegisterRt,
    input        BranchTaken,
    input        JumpTaken,
    output       PCWrite,
    output       IF_ID_Write,
    output       Flush1
);

    wire load_use_hazard = ID_EX_MemRead &&
                           ((ID_EX_RegisterRt == IF_ID_RegisterRs) ||
                            (ID_EX_RegisterRt == IF_ID_RegisterRt));

    wire control_hazard = BranchTaken || JumpTaken;

    // If a control hazard (branch/jump) occurs, we flush the IF/ID register and update PC.
    assign PCWrite = ~load_use_hazard || control_hazard;
    assign IF_ID_Write = ~load_use_hazard && ~control_hazard;
    assign Flush1 = control_hazard;

endmodule
