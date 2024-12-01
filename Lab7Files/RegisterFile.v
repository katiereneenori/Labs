`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Team Members: Tanner Shartel and Katie Dionne (50%/50%)
//
// Module - RegisterFile.v
// Description - Implements a register file with 32 32-bit wide registers.
//
// INPUTS:-
// ReadRegister1: 5-bit address for the first register to read.
// ReadRegister2: 5-bit address for the second register to read.
// WriteRegister: 5-bit address for the register to write.
// WriteData: 32-bit data to write into the register file.
// RegWrite: Control signal to enable writing to the register file.
// Clk: Clock signal.
// Reset: Reset signal.
//
// OUTPUTS:-
// ReadData1: 32-bit data read from the first register.
// ReadData2: 32-bit data read from the second register.
//
// FUNCTIONALITY:-
// Allows reading from two registers and writing to one register simultaneously.
// Ensures that writes to register $zero (register 0) are ignored.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(
    input [4:0]  ReadRegister1,
    input [4:0]  ReadRegister2,
    input [4:0]  WriteRegister,
    input [31:0] WriteData,
    input RegWrite,
    input Clk,
    input Reset,
    output reg [31:0] ReadData1,
    output reg [31:0] ReadData2
);

    reg [31:0] registers [31:0]; // 32 registers, each 32 bits wide

    integer i;
    initial begin
        // Initialize all registers to zero
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
    end

    // Combinational read logic
    always @(*) begin
        ReadData1 = registers[ReadRegister1];
        ReadData2 = registers[ReadRegister2];
    end

    // Sequential write logic
    always @(posedge Clk) begin
        if (RegWrite) begin
            if (WriteRegister != 5'd0) begin
                // Write to register if it's not $zero
                registers[WriteRegister] <= WriteData;
            end else begin
                // Attempted write to $zero is ignored
            end
        end
    end

endmodule
