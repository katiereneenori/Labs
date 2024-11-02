`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
//Temporary placeholder for the register file pipeline
//for now, this just transfers the data from one side to the other
//in the hopes of testing out single instructions 
////////////////////////////////////////////////////////////////////////////////

module MEM_WB (
    input Clk,
    input Reset,
    input inRegWrite,
    input inJalSel,
    input [1:0] inMemToReg,
    input [31:0] inWire46, inWire8, inWire7,
    input [4:0] inWire41,
    output reg outRegWrite,
    output reg outJalSel,
    output reg [1:0] outMemToReg,
    output reg [31:0] outWire46, outWire8, outWire7,
    output reg [4:0] outWire41
);

    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            // Reset outputs
            outRegWrite <= 1'b0;
            outJalSel   <= 1'b0;
            outMemToReg <= 2'b00;
            outWire46   <= 32'b0;
            outWire8    <= 32'b0;
            outWire7    <= 32'b0;
            outWire41   <= 5'b0;
        end else begin
            // Register inputs
            outRegWrite <= inRegWrite;
            outJalSel   <= inJalSel;
            outMemToReg <= inMemToReg;
            outWire46   <= inWire46;
            outWire8    <= inWire8;
            outWire7    <= inWire7;
            outWire41   <= inWire41;
        end
    end

endmodule
