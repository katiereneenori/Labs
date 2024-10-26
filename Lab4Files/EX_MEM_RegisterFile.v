`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
//Temporary placeholder for the register file pipeline
//for now, this just transfers the data from one side to the other
//in the hopes of testing out single instructions 
////////////////////////////////////////////////////////////////////////////////

module EX_MEM(
    input inToBranch, inRegWrite, inMemWrite, inMemRead, inMemByte, inMemHalf, inJalSel, inJorBranch,
    input [1:0] inMemToReg,
    input [31:0] inWire46, inWire30, inWire35, inWire34, inWire24, inWire33,
    input Clk, Reset,
    output reg outToBranch, outRegWrite, outMemWrite, outMemRead, outMemByte, outMemHalf, outJalSel, outJorBranch,
    output reg [1:0] outMemToReg,
    output reg [31:0] outWire46, outWire30, outWire35, outWire34, outWire24, outWire33
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
            outMemToReg   <= 2'b00;
            outWire46     <= 32'b0;
            outWire30     <= 32'b0;
            outWire35     <= 32'b0;
            outWire34     <= 32'b0;
            outWire24     <= 32'b0;
            outWire33     <= 32'b0;
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
