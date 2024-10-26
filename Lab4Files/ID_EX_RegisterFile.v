`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
//Temporary placeholder for the register file pipeline
//for now, this just transfers the data from one side to the other
//in the hopes of testing out single instructions 
////////////////////////////////////////////////////////////////////////////////

module ID_EX(
    input [4:0] inALUOp,
    input inToBranch, inRegWrite, inMemWrite, inMemRead, inMemByte, inMemHalf, inRegDst, inJalSel, inJorBranch,
    input [1:0] inALUSrcA, inALUSrcB, inMemToReg,
    input [31:0] inWire10, inWire14, inWire9, inWire15, inWire16, inWire17, inWire18,
    input [4:0] inWire27, inWire28,
    input Clk, Reset,
    output reg [4:0] outALUOp,
    output reg outToBranch, outRegWrite, outMemWrite, outMemRead, outMemByte, outMemHalf, outRegDst, outJalSel, outJorBranch,
    output reg [1:0] outALUSrcA, outALUSrcB, outMemToReg,
    output reg [31:0] outWire10, outWire14, outWire9, outWire15, outWire16, outWire17, outWire18,
    output reg [4:0] outWire27, outWire28
);

    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            outALUOp <= 5'b0;
            outToBranch <= 1'b0;
            outRegWrite <= 1'b0;
            outMemWrite <= 1'b0;
            outMemRead <= 1'b0;
            outMemByte <= 1'b0;
            outMemHalf <= 1'b0;
            outRegDst <= 1'b0;
            outJalSel <= 1'b0;
            outALUSrcA <= 2'b00;
            outALUSrcB <= 2'b00;
            outJorBranch <= 1'b0;
            outMemToReg <= 2'b00;
            outWire10 <= 32'b0;
            outWire14 <= 32'b0;
            outWire9 <= 32'b0;
            outWire15 <= 32'b0;
            outWire16 <= 32'b0;
            outWire17 <= 32'b0;
            outWire18 <= 32'b0;
            outWire27 <= 5'b0;
            outWire28 <= 5'b0;
        end else begin
            outALUOp <= inALUOp;
            outToBranch <= inToBranch;
            outRegWrite <= inRegWrite;
            outMemWrite <= inMemWrite;
            outMemRead <= inMemRead;
            outMemByte <= inMemByte;
            outMemHalf <= inMemHalf;
            outRegDst <= inRegDst;
            outJalSel <= inJalSel;
            outALUSrcA <= inALUSrcA;
            outALUSrcB <= inALUSrcB;
            outJorBranch <= inJorBranch;
            outMemToReg <= inMemToReg;
            outWire10 <= inWire10;
            outWire14 <= inWire14;
            outWire9 <= inWire9;
            outWire15 <= inWire15;
            outWire16 <= inWire16;
            outWire17 <= inWire17;
            outWire18 <= inWire18;
            outWire27 <= inWire27;
            outWire28 <= inWire28;
        end
    end

endmodule
