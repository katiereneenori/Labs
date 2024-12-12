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
    output       Flush1,
    output       Flush_ID_EX
);

    wire control_hazard = BranchTaken || JumpTaken;
    wire load_use_hazard = ID_EX_MemRead &&
                           ((ID_EX_RegisterRt == IF_ID_RegisterRs) ||
                            (ID_EX_RegisterRt == IF_ID_RegisterRt));

    // Control Hazard (branch/jump taken in ID):
    // - Flush IF/ID to remove the instruction after branch
    // - PCWrite = 1 so that we move to branch target now
    // - IF_ID_Write = 0 to prevent writing a new incorrect instruction in this cycle
    //
    // Load-Use Hazard:
    // - Stall by disabling PCWrite and IF_ID_Write (both 0)
    // - Do not flush. Just wait one cycle.

    assign Flush1 = control_hazard;     // Flush IF/ID only on control hazard
    assign Flush_ID_EX = 1'b0;          // Do not flush ID/EX on control hazards now

    assign PCWrite = control_hazard ? 1'b1 : ~load_use_hazard;
    assign IF_ID_Write = control_hazard ? 1'b0 : ~load_use_hazard;

endmodule

