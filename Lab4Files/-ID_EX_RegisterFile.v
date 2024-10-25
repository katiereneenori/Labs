`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
//Temporary placeholder for the register file pipeline
//for now, this just transfers the data from one side to the other
//in the hopes of testing out single instructions 
////////////////////////////////////////////////////////////////////////////////

module ID_EX(inALUOp, inToBranch, inRegWrite, inMemWrite, inMemRead, inMemByte,
             inMemHalf,  inRegDst, inJalSel, inALUSrcA, inALUSrcB, inJorBranch, 
             inMemToReg, inWire10Upper, inWire10Lower, inWire16, inWire14, inWire9, inWire15, inWire17, 
             inWire18, inWire11Upper, inWire11Lower, outALUOp, outToBranch, outRegWrite,
             outMemWrite, outMemRead, outMemByte, outMemHalf,  outRegDst, outJalSel,
             outALUSrcA, outALUSrcB, outJorBranch, outMemToReg, outWire10Upper, outWire10Lower, outWire16, 
             outWire14, outWire9, outWire15, outWire17, outWire18, outWire11Upper, outWire11Lower, Clk, Reset
);

input [4:0] inALUOp;
input inToBranch, inRegWrite, inMemWrite, inMemRead, inMemByte, inMemHalf,  inRegDst, inJalSel, inJorBranch;
input [1:0] inALUSrcA, inALUSrcB, inMemToReg;
input [31:0] inWire10Upper, inWire10Lower, inWire16, inWire14, inWire9, inWire15, inWire17, inWire18, inWire11Upper, inWire11Lower;

input Clk, Reset;

output reg [4:0] outALUOp;
output reg outToBranch, outRegWrite, outMemWrite, outMemRead, outMemByte, outMemHalf,  outRegDst, outJalSel, outJorBranch;
output reg [1:0] outALUSrcA, outALUSrcB, outMemToReg;
output reg [31:0] outWire10Upper, outWire10Lower, outWire16, outWire14, outWire9, outWire15, outWire17, outWire18, outWire11Upper, outWire11Lower;
    
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
            outWire10Upper <= 32'b0;
            outWire10Lower <= 32'b0;
            outWire16 <= 32'b0;
            outWire14 <= 32'b0;
            outWire9 <= 32'b0;
            outWire15 <= 32'b0;
            outWire17 <= 32'b0;
            outWire18 <= 32'b0;
            outWire11Upper <= 5'b0;
            outWire11Lower <= 5'b0;
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
            outWire10Upper <= inWire10Upper;
            outWire10Lower <= inWire10Lower;
            outWire16 <= inWire16;
            outWire14 <= inWire14;
            outWire9 <= inWire9;
            outWire15 <= inWire15;
            outWire17 <= inWire17;
            outWire18 <= inWire18;
            outWire11Upper <= inWire11Upper;
            outWire11Lower <= inWire11Lower;
        end
    end

endmodule