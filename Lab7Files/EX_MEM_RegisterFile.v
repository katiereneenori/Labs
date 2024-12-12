`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// EX_MEM pipeline register
////////////////////////////////////////////////////////////////////////////////

module EX_MEM (
    input inToBranch, inRegWrite, inMemWrite, inMemRead, inMemByte, inMemHalf, inJalSel, inJorBranch,
    input [1:0] inMemToReg,
    input [31:0] inWire46, inWire30, inWire34, inWire24,
    input [4:0] inWire33,
    input inWire35,
    input Clk, Reset,
    output reg outToBranch, outRegWrite, outMemWrite, outMemRead, outMemByte, outMemHalf, outJalSel, outJorBranch, outWire35,
    output reg [1:0] outMemToReg,
    output reg [4:0] outWire33,
    output reg [31:0] outWire46, outWire30, outWire34, outWire24
);

    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            outToBranch   <= 1'b0;
            outRegWrite   <= 1'b0;
            outMemWrite   <= 1'b0;
            outMemRead    <= 1'b0;
            outMemByte    <= 1'b0;
            outMemHalf    <= 1'b0;
            outJalSel     <= 1'b0;
            outJorBranch  <= 1'b0;
            outMemToReg   <= 2'd0;
            outWire46     <= 32'd0;
            outWire30     <= 32'd0;
            outWire35     <= 1'b0;
            outWire34     <= 32'd0;
            outWire24     <= 32'd0;
            outWire33     <= 5'd0;
        end else begin
            outToBranch   <= inToBranch;
            outRegWrite   <= inRegWrite;
            outMemWrite   <= inMemWrite;
            outMemRead    <= inMemRead;
            outMemByte    <= inMemByte;
            outMemHalf    <= inMemHalf;
            outJalSel     <= inJalSel;
            outJorBranch  <= inJorBranch;
            outMemToReg   <= inMemToReg;
            outWire46     <= inWire46;
            outWire30     <= inWire30;
            outWire35     <= inWire35;
            outWire34     <= inWire34;
            outWire24     <= inWire24;
            outWire33     <= inWire33;
        end
    end

endmodule
