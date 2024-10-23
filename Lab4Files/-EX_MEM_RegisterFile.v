`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
//Temporary placeholder for the register file pipeline
//for now, this just transfers the data from one side to the other
//in the hopes of testing out single instructions 
////////////////////////////////////////////////////////////////////////////////

module EX_MEM(inToBranch, inRegWrite, inMemWrite, inMemRead, inMemByte,
             inMemHalf, inJalSel, inJorBranch, inMemToReg, inWire19, 
             inWire30, inWire35, inWire34, inWire24, inWire33, outToBranch, outRegWrite,
             outMemWrite, outMemRead, outMemByte, outMemHalf, outJalSel,
             outJorBranch, outMemToReg, outWire19, outWire30, outWire35, outWire34, outWire24, outWire33
);

input inToBranch, inRegWrite, inMemWrite, inMemRead, inMemByte, inMemHalf, inJalSel, inJorBranch;
input [1:0] inMemToReg;
input [31:0] inWire19, inWire30, inWire35, inWire34, inWire24, inWire33;

output reg outToBranch, outRegWrite, outMemWrite, outMemRead, outMemByte, outMemHalf, outJalSel, outJorBranch;
output reg [1:0] outMemToReg;
output reg [31:0] outWire19, outWire30, outWire35, outWire34, outWire24, outWire33;
    
    always @(*) begin
        outToBranch = inToBranch;
        outRegWrite = inRegWrite; 
        outMemWrite = inMemWrite; 
        outMemRead = inMemRead; 
        outMemByte = inMemByte; 
        outMemHalf = inMemHalf; 
        outJalSel = inJalSel;
        outJorBranch = inJorBranch; 
        outMemToReg = inMemToReg;
        outWire19 = inWire19; 
        outWire30 = inWire30; 
        outWire35 = inWire35; 
        outWire34 = inWire34; 
        outWire24 = inWire24; 
        outWire33 = inWire33;
    end
    
endmodule