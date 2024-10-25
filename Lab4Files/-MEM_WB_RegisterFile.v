`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
//Temporary placeholder for the register file pipeline
//for now, this just transfers the data from one side to the other
//in the hopes of testing out single instructions 
////////////////////////////////////////////////////////////////////////////////

module MEM_WB(inRegWrite, inJalSel, inMemToReg,  
              outRegWrite, outJalSel, outMemToReg, 
	          inWire36, inWire8, inWire7, inWire41, outWire36, 
              outWire8, outWire7, outWire41, Clk, Reset
);

input inRegWrite, inJalSel;
input [1:0] inMemToReg;
input [31:0] inWire36, inWire8, inWire7, inWire41;

input Clk, Reset;

output reg outRegWrite, outJalSel;
output reg [1:0] outMemToReg;
output reg [31:0] outWire36, outWire8, outWire7, outWire41;
    
    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            // zero on Reset
            outRegWrite   <= 1'b0;
            outJalSel     <= 1'b0;
            outMemToReg   <= 2'b00;
            outWire36     <= 32'b0;
            outWire8      <= 32'b0;
            outWire7      <= 32'b0;
            outWire41     <= 32'b0;
        end 
        else begin
        
            // capture input values on rising edge of Clk
            outRegWrite   <= inRegWrite; 
            outJalSel     <= inJalSel;
            outMemToReg   <= inMemToReg;
            outWire36     <= inWire36; 
            outWire8      <= inWire8; 
            outWire7      <= inWire7; 
            outWire41     <= inWire41;
        end
    end
    
endmodule