`timescale 1ns / 1ps

module TopModule(
    input Clk,             // System clock
    input Reset,           // Reset signal
    output [6:0] out7,     // Segment outputs for the 7-segment display
    output [3:0] en_out,   // Enable outputs for each of the 4 digits
    output dp              // Decimal point (always off)
);

    // Intermediate signals
    wire [31:0] PCResultWire;       // ProgramCounter output
    wire [31:0] PCAddResultWire;    // PCAdder output
    wire [31:0] Instruction;        // Instruction from InstructionMemory
    wire SlowClk;                   // Slow clock signal for 7-segment display

    // Clock Divider to generate a slower clock for the 7-segment display
    ClkDiv clk_div (
        .Clk(Clk),
        .Reset(Reset),
        .ClkOut(SlowClk)
    );

    // Program Counter module
    ProgramCounter PC (
        .Clk(Clk),                // Clock signal
        .Reset(Reset),            // Reset signal
        .Address(PCAddResultWire),// Address from PCAdder
        .PCResult(PCResultWire)   // Output to InstructionMemory
    );

    // PC Adder module
    PCAdder Adder (
        .PCResult(PCResultWire),   // Input from ProgramCounter
        .PCAddResult(PCAddResultWire)  // Output to ProgramCounter
    );

    // Instruction Memory module
    InstructionMemory IM (
        .Address(PCResultWire),   // Input from ProgramCounter
        .Instruction(Instruction) // Output to One4DigitDisplay
    );

    // Display the least significant 16 bits of the instruction on the 7-segment display
    One4DigitDisplay display (
        .Clk(SlowClk),             // Slower clock signal
        .NumberA(Instruction[15:0]),// Lower 16 bits of the instruction
        .out7(out7),               // Segment outputs for the 7-segment display
        .en_out(en_out),           // Enable outputs for each of the 4 digits
        .dp(dp)                    // Decimal point (always off)
    );

endmodule
