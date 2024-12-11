`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Simplified Hazard Detection Unit for Load-Use Hazards
////////////////////////////////////////////////////////////////////////////////

module HazardDetectionUnit(
    input        ID_EX_MemRead,
    input [4:0]  ID_EX_RegisterRt,
    input [4:0]  IF_ID_RegisterRs,
    input [4:0]  IF_ID_RegisterRt,
    // New inputs:
    input        BranchTaken,   // From EX stage: indicates a taken branch
    input        JumpTaken,     // From ID stage: indicates a jump instruction
    output       PCWrite,
    output       IF_ID_Write,
    output       Flush1
);

    // Existing load-use hazard detection
    wire load_use_hazard = ID_EX_MemRead &&
                           ((ID_EX_RegisterRt == IF_ID_RegisterRs) ||
                            (ID_EX_RegisterRt == IF_ID_RegisterRt));

    // New control hazard detection:
    wire control_hazard = BranchTaken || JumpTaken;

    assign PCWrite = ~load_use_hazard || control_hazard;
    assign IF_ID_Write = ~load_use_hazard && ~control_hazard;
    assign Flush1      = control_hazard;   // Flush when branch/jump taken
    

endmodule
