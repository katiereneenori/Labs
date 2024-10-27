`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
//Temporary placeholder for the register file pipeline
//for now, this just transfers the data from one side to the other
//in the hopes of testing out single instructions 
////////////////////////////////////////////////////////////////////////////////

module ID_EX(
    input [4:0] inALUOp, inWire27, inWire28,
    input inToBranch, inRegWrite, inMemWrite, inMemRead, inMemByte, inMemHalf, inRegDst, inJalSel, inJorBranch,
    input [1:0] inALUSrcA, inALUSrcB, inMemToReg,
    input [31:0] inWire10, inWire14, inWire9, inWire15, inWire16, inWire17, inWire18,
    input Clk, Reset,
    output reg [4:0] outALUOp, outWire27, outWire28,
    output reg outToBranch, outRegWrite, outMemWrite, outMemRead, outMemByte, outMemHalf, outRegDst, outJalSel, outJorBranch,
    output reg [1:0] outALUSrcA, outALUSrcB, outMemToReg,
    output reg [31:0] outWire10, outWire14, outWire9, outWire15, outWire16, outWire17, outWire18
);

    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            // Reset all outputs to zero
            outALUOp      <= 5'd0;
            outWire27     <= 5'd0;
            outWire28     <= 5'd0;
            outToBranch   <= 1'b0;
            outRegWrite   <= 1'b0;
            outMemWrite   <= 1'b0;
            outMemRead    <= 1'b0;
            outMemByte    <= 1'b0;
            outMemHalf    <= 1'b0;
            outRegDst     <= 1'b0;
            outJalSel     <= 1'b0;
            outJorBranch  <= 1'b0;
            outALUSrcA    <= 2'd0;
            outALUSrcB    <= 2'd0;
            outMemToReg   <= 2'd0;
            outWire10     <= 32'd0;
            outWire14     <= 32'd0;
            outWire9      <= 32'd0;
            outWire15     <= 32'd0;
            outWire16     <= 32'd0;
            outWire17     <= 32'd0;
            outWire18     <= 32'd0;
        end else begin
            // Register inputs
            outALUOp      <= inALUOp;
            outWire27     <= inWire27;
            outWire28     <= inWire28;
            outToBranch   <= inToBranch;
            outRegWrite   <= inRegWrite;
            outMemWrite   <= inMemWrite;
            outMemRead    <= inMemRead;
            outMemByte    <= inMemByte;
            outMemHalf    <= inMemHalf;
            outRegDst     <= inRegDst;
            outJalSel     <= inJalSel;
            outJorBranch  <= inJorBranch;
            outALUSrcA    <= inALUSrcA;
            outALUSrcB    <= inALUSrcB;
            outMemToReg   <= inMemToReg;
            outWire10     <= inWire10;
            outWire14     <= inWire14;
            outWire9      <= inWire9;
            outWire15     <= inWire15;
            outWire16     <= inWire16;
            outWire17     <= inWire17;
            outWire18     <= inWire18;
        end
    end

endmodule
