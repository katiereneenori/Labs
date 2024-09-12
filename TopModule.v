`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// Module - TopModule.v
// Description - integrates clkdiv, IFU(programcounter, pcadder, instructionmemory),
// and one4digitdisplay submodules to control operation and design
//
// ECE369A - Computer Architecture
// Laboratory 1
////////////////////////////////////////////////////////////////////////////////

module TopModule(Clk, Reset, en_out, out7, dp);

    input Clk;
    input Reset;
    output [3:0] en_out;
    output [6:0] out7;
    output dp;
    
    (* mark_debug = "true" *) wire ClkOut;
    (* mark_debug = "true" *) wire [15:0] InstructionWire;
    
    ClkDiv Clock(
        .Clk(Clk), //clock input from board
        .Reset(Reset),
        .ClkOut(ClkOut)    //clock output to Clk
    );
    
    InstructionFetchUnit IFU (
        .Reset(Reset),    
        .Clk(ClkOut),      //clock input to IFU from ClkDiv
        .Instruction(InstructionWire)   //Instruction output
    );
    
    One4DigitDisplay display (
        .Clk(Clk),
        .NumberA(InstructionWire),
        .out7(out7),
        .en_out(en_out),
        .dp(dp)
    );
    
endmodule
