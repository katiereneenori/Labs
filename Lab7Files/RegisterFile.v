`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Team Members: Tanner Shartel and Katie Dionne (50%/50%)
//
// Module - RegisterFile.v
// Description - Implements a register file with 32 32-bit wide registers.
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
    output reg [31:0] ReadData2,
    output wire [31:0] v0_reg,
    output wire [31:0] v1_reg
);

    reg [31:0] registers [31:0]; // 32 registers, each 32 bits wide
    
    assign v0_reg = registers[2];  // $v0 is register 2
    assign v1_reg = registers[3];  // $v1 is register 3

    integer i;

    // Combinational read logic
    always @(*) begin
        ReadData1 = registers[ReadRegister1];
        ReadData2 = registers[ReadRegister2];
    end

    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            // Initialize all registers to zero, except $sp (register 29)
            for (i = 0; i < 32; i = i + 1) begin
                if (i == 29)
                    registers[i] <= 8191 * 4; // Initialize $sp to top of 8K word memory
                else
                    registers[i] <= 32'b0;
            end
        end else if (RegWrite) begin
            // Write to register if it's not $zero
            if (WriteRegister != 5'd0) begin
                registers[WriteRegister] <= WriteData;
            end
        end
    end

endmodule
