`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
//Temporary placeholder for the register file pipeline
//for now, this just transfers the data from one side to the other
//in the hopes of testing out single instructions 
////////////////////////////////////////////////////////////////////////////////

module IF_ID(inWire2, inWire3, inWire4, outWire2, outWire3, outWire4, Clk, Reset);

    input [31:0] inWire2, inWire3, inWire4;
    
    input Clk, Reset;
    
    output reg [31:0] outWire2, outWire3, outWire4;
    
    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            outWire2 <= 32'b0;
            outWire3 <= 32'b0;
            outWire4 <= 32'b0;
        end else begin
            outWire2 <= inWire2;
            outWire3 <= inWire3;
            outWire4 <= inWire4;
        end
    end
    
endmodule









