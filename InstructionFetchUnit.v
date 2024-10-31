`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
// 
// ECE369A - Computer Architecture
// Laboratory 1
// Module - InstructionFetchUnit.v
// Description - Fetches the instruction from the instruction memory based on 
//               the program counter (PC) value.
// INPUTS:-
// Reset: 1-Bit input signal. 
// Clk: Input clock signal.
//
// OUTPUTS:-
// Instruction: 32-Bit output instruction from the instruction memory. 
//              Decimal value diplayed 
//
// FUNCTIONALITY:-
// Please connect up the following implemented modules to create this
// 'InstructionFetchUnit':-
//   (a) ProgramCounter.v
//   (b) PCAdder.v
//   (c) InstructionMemory.v
// Connect the modules together in a testbench so that the instruction memory
// outputs the contents of the next instruction indicated by the memory location
// in the PC at every clock cycle. Please initialize the instruction memory with
// some preliminary values for debugging purposes.
//
// @@ The 'Reset' input control signal is connected to the program counter (PC) 
// register which initializes the unit to output the first instruction in 
// instruction memory.
// @@ The 'Instruction' output port holds the output value from the instruction
// memory module.
// @@ The 'Clk' input signal is connected to the program counter (PC) register 
// which generates a continuous clock pulse into the module.
////////////////////////////////////////////////////////////////////////////////

module InstructionFetchUnit(Instruction, Reset, Clk, PCResultWire);

    input Reset, Clk;

    output [31:0] Instruction;
    
    output wire [31:0] PCResultWire;    //ProgramCounter output
    wire [31:0] PCAddResultWire; //PCAdder output
    
    PCAdder Adder(
        .PCResult(PCResultWire),
        .PCAddResult(PCAddResultWire)
    );
    
    ProgramCounter PC (
        .Clk(Clk),                 //clock signal
        .Reset(Reset),             //reset signal
        .Address(PCAddResultWire), //Adder output wired to PC input
        .PCResult(PCResultWire)    //PC Result wire
    );
    
    InstructionMemory IM (
        .Address(PCResultWire),   //PC output 
        .Instruction(Instruction) //InstructionFetchUnit output
    );

endmodule

