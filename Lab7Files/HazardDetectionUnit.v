`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Simplified Hazard Detection Unit for Load-Use Hazards
////////////////////////////////////////////////////////////////////////////////

module HazardDetectionUnit(
    input        ID_EX_MemRead,
    input  [4:0] ID_EX_RegisterRt,
    input  [4:0] IF_ID_RegisterRs,
    input  [4:0] IF_ID_RegisterRt,
    output       PCWrite,
    output       IF_ID_Write,
    output       ControlHazard
);

    // Detect a load-use hazard:
    // If the current instruction in ID/EX is a load (ID_EX_MemRead == 1)
    // and the following instruction in IF/ID needs the loaded register (check Rs or Rt),
    // then we must stall.
    wire load_use_hazard;
    assign load_use_hazard = ID_EX_MemRead && 
                             ((ID_EX_RegisterRt == IF_ID_RegisterRs) ||
                              (ID_EX_RegisterRt == IF_ID_RegisterRt));

    assign PCWrite       = ~load_use_hazard;
    assign IF_ID_Write   = ~load_use_hazard;
    assign ControlHazard = load_use_hazard;

endmodule
