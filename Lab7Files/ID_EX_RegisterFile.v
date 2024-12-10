`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
// 
// ECE369A - Computer Architecture
// Laboratory 4
//Temporary placeholder for the register file pipeline
//for now, this just transfers the data from one side to the other
//in the hopes of testing out single instructions 
////////////////////////////////////////////////////////////////////////////////

module ID_EX(
    input [4:0] inALUOp, inWire27, inWire28, inWireRs,
    input inToBranch, inRegWrite, inMemWrite, inMemRead, inMemByte, inMemHalf, inRegDst, inJalSel, inJorBranch,
    input [1:0] inALUSrcA, inALUSrcB, inMemToReg,
    input [31:0] inWire10, inWire14, inWire9, inWire15, inWire16, inWire17, inWire18,
    input Clk, Reset, Flush, JSrc1,
    output reg [4:0] outALUOp, outWireRs,
    output reg outToBranch, outRegWrite, outMemWrite, outMemRead, outMemByte, outMemHalf, outRegDst, outJalSel, outJorBranch, outJSrc1,
    output reg [1:0] outALUSrcA, outALUSrcB, outMemToReg,
    output reg [31:0] outWire10, outWire14, outWire9, outWire15, outWire16, outWire17, outWire18,
    output reg [4:0] outWire27, outWire28
);

    always @(posedge Clk or posedge Reset) begin
        if (Reset || Flush) begin
            outALUOp     <= 5'd0;
            outWire27    <= 5'd0;
            outWire28    <= 5'd0;
            outWireRs    <= 5'd0;
            outToBranch  <= 1'b0;
            outRegWrite  <= 1'b0;
            outMemWrite  <= 1'b0;
            outMemRead   <= 1'b0;
            outMemByte   <= 1'b0;
            outMemHalf   <= 1'b0;
            outRegDst    <= 1'b0;
            outJalSel    <= 1'b0;
            outJorBranch <= 1'b0;
            outALUSrcA   <= 2'b00;
            outALUSrcB   <= 2'b00;
            outMemToReg  <= 2'b00;
            outWire10    <= 32'd0;
            outWire14    <= 32'd0;
            outWire9     <= 32'd0;
            outWire15    <= 32'd0;
            outWire16    <= 32'd0;
            outWire17    <= 32'd0;
            outWire18    <= 32'd0;
            outJSrc1     <= 1'b0;
        end else begin
            outALUOp     <= inALUOp;
            outWire27    <= inWire27;
            outWire28    <= inWire28;
            outWireRs    <= inWireRs;
            outToBranch  <= inToBranch;
            outRegWrite  <= inRegWrite;
            outMemWrite  <= inMemWrite;
            outMemRead   <= inMemRead;
            outMemByte   <= inMemByte;
            outMemHalf   <= inMemHalf;
            outRegDst    <= inRegDst;
            outJalSel    <= inJalSel;
            outJorBranch <= inJorBranch;
            outALUSrcA   <= inALUSrcA;
            outALUSrcB   <= inALUSrcB;
            outMemToReg  <= inMemToReg;
            outWire10    <= inWire10;
            outWire14    <= inWire14;
            outWire9     <= inWire9;
            outWire15    <= inWire15;
            outWire16    <= inWire16;
            outWire17    <= inWire17;
            outWire18    <= inWire18;
            outJSrc1     <= JSrc1;
        end
    end
    
//    reg [4:0] FiveBitRegs [2:0]; //3 5-bit intermediate registers
//    reg OneBitRegs [8:0]; //9 1-bit intermediate registers
//    reg [1:0] TwoBitRegs [2:0]; // 3 2-bit intermediate registers
//    reg [31:0] ThirtyTwoBitRegs [6:0]; //7 32-bit intermediate registers
//    // registers are stored in the order they are declared abov
    
//    reg [1:0] i; // 2-bit counter for flushing 3 instructions

//    always @(posedge Clk or posedge Reset) begin
//        if (Reset) begin
//            // Reset outputs and counter
//            outALUOp     <= 5'd0;
//            outWire27    <= 5'd0;
//            outWire28    <= 5'd0;
//            outToBranch  <= 1'b0;
//            outRegWrite  <= 1'b0;
//            outMemWrite  <= 1'b0;
//            outMemRead   <= 1'b0;
//            outMemByte   <= 1'b0;
//            outMemHalf   <= 1'b0;
//            outRegDst    <= 1'b0;
//            outJalSel    <= 1'b0;
//            outJorBranch <= 1'b0;
//            outALUSrcA   <= 2'b00;
//            outALUSrcB   <= 2'b00;
//            outMemToReg  <= 2'b00;
//            outWire10    <= 32'd0;
//            outWire14    <= 32'd0;
//            outWire9     <= 32'd0;
//            outWire15    <= 32'd0;
//            outWire16    <= 32'd0;
//            outWire17    <= 32'd0;
//            outWire18    <= 32'd0;
//            i <= 2'd0;
//        end else if (Flush || i != 0) begin
//            // Flush logic
//            outALUOp     <= 5'd0;
//            outWire27    <= 5'd0;
//            outWire28    <= 5'd0;

//            outToBranch  <= 1'b0;
//            outRegWrite  <= 1'b0;
//            outMemWrite  <= 1'b0;
//            outMemRead   <= 1'b0;
//            outMemByte   <= 1'b0;
//            outMemHalf   <= 1'b0;
//            outRegDst    <= 1'b0;
//            outJalSel    <= 1'b0;
//            outJorBranch <= 1'b0;
//            outALUSrcA   <= 2'b00;
//            outALUSrcB   <= 2'b00;
//            outMemToReg  <= 2'b00;
//            outWire10    <= 32'd0;
//            outWire14    <= 32'd0;
//            outWire9     <= 32'd0;
//            outWire15    <= 32'd0;
//            outWire16    <= 32'd0;
//            outWire17    <= 32'd0;
//            outWire18    <= 32'd0;

//            // Increment or reset the flush counter
//            if (i < 1)
//                i <= i + 1;
//            else
//                i <= 0;
//        end else if (inWire17[31:26] == 6'b000011 || // jal
//                     inWire17[31:26] == 6'b000010 || // j
//                     (inWire17[31:26] == 6'b000000 && inWire17[5:0] == 6'b001000)) begin // jr
//            // Detect jal, j, or jr: Pass through the instruction and set the flush counter
//            outALUOp     <= inALUOp;
//            outWire27    <= inWire27;
//            outWire28    <= inWire28;
//            outToBranch  <= inToBranch;
//            outRegWrite  <= inRegWrite;
//            outMemWrite  <= inMemWrite;
//            outMemRead   <= inMemRead;
//            outMemByte   <= inMemByte;
//            outMemHalf   <= inMemHalf;
//            outRegDst    <= inRegDst;
//            outJalSel    <= inJalSel;
//            outJorBranch <= inJorBranch;
//            outALUSrcA   <= inALUSrcA;
//            outALUSrcB   <= inALUSrcB;
//            outMemToReg  <= inMemToReg;
//            outWire10    <= inWire10;
//            outWire14    <= inWire14;
//            outWire9     <= inWire9;
//            outWire15    <= inWire15;
//            outWire16    <= inWire16;
//            outWire17    <= inWire17;
//            outWire18    <= inWire18;

//            i <= 1; // Start flushing next cycle
//        end else begin
//            // Normal operation: Pass through inputs to outputs
//            outALUOp     <= inALUOp;
//            outWire27    <= inWire27;
//            outWire28    <= inWire28;

//            outToBranch  <= inToBranch;
//            outRegWrite  <= inRegWrite;
//            outMemWrite  <= inMemWrite;
//            outMemRead   <= inMemRead;
//            outMemByte   <= inMemByte;
//            outMemHalf   <= inMemHalf;
//            outRegDst    <= inRegDst;
//            outJalSel    <= inJalSel;
//            outJorBranch <= inJorBranch;
//            outALUSrcA   <= inALUSrcA;
//            outALUSrcB   <= inALUSrcB;
//            outMemToReg  <= inMemToReg;
//            outWire10    <= inWire10;
//            outWire14    <= inWire14;
//            outWire9     <= inWire9;
//            outWire15    <= inWire15;
//            outWire16    <= inWire16;
//            outWire17    <= inWire17;
//            outWire18    <= inWire18;

//        end
//    end

endmodule
