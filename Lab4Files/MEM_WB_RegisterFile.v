`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Register file pipeline modified to match format of EX_MEM module
// Transfers data from one side to the other to test single instructions
////////////////////////////////////////////////////////////////////////////////

module MEM_WB (
    input Clk,
    input Reset,
    input inRegWrite,
    input inJalSel,
    input [1:0] inMemToReg,
    input [31:0] inWire46, inWire8, inWire7,
    input [31:0] inWriteData,
    input [4:0] inWire41,
    input [4:0] inWriteRegister,
    output reg outRegWrite,
    output reg outJalSel,
    output reg [1:0] outMemToReg,
    output reg [31:0] outWire46, outWire8, outWire7,
    output reg [31:0] outWriteData,
    output reg [4:0] outWire41,
    output reg [4:0] outWriteRegister
);

    reg OneBitRegs [1:0];           // 2 1-bit intermediate registers
    reg [1:0] TwoBitRegs;           // 1 2-bit intermediate register
    reg [31:0] ThirtyTwoBitRegs [4:0]; // 5 32-bit intermediate registers
    reg [4:0] FiveBitRegs [1:0];    // 2 5-bit intermediate registers

    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin // Set all intermediate registers to zero on reset
            OneBitRegs[0] <= 1'b0;
            OneBitRegs[1] <= 1'b0;
            TwoBitRegs <= 2'b00;
            ThirtyTwoBitRegs[0] <= 32'b0;
            ThirtyTwoBitRegs[1] <= 32'b0;
            ThirtyTwoBitRegs[2] <= 32'b0;
            ThirtyTwoBitRegs[3] <= 32'b0;
            ThirtyTwoBitRegs[4] <= 32'b0;
            FiveBitRegs[0] <= 5'b0;
            FiveBitRegs[1] <= 5'b0;
        end else begin
            OneBitRegs[0] <= inRegWrite;
            OneBitRegs[1] <= inJalSel;
            TwoBitRegs <= inMemToReg;
            ThirtyTwoBitRegs[0] <= inWire46;
            ThirtyTwoBitRegs[1] <= inWire8;
            ThirtyTwoBitRegs[2] <= inWire7;
            ThirtyTwoBitRegs[3] <= inWriteData;
            ThirtyTwoBitRegs[4] <= inWriteRegister;
            FiveBitRegs[0] <= inWire41;
            FiveBitRegs[1] <= inWriteRegister;
        end
    end

    always @(negedge Clk) begin
        outRegWrite <= OneBitRegs[0];
        outJalSel <= OneBitRegs[1];
        outMemToReg <= TwoBitRegs;
        outWire46 <= ThirtyTwoBitRegs[0];
        outWire8 <= ThirtyTwoBitRegs[1];
        outWire7 <= ThirtyTwoBitRegs[2];
        outWriteData <= ThirtyTwoBitRegs[3];
        outWire41 <= FiveBitRegs[0];
        outWriteRegister <= FiveBitRegs[1];
    end

endmodule