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

module IF_ID(
    input        Clk,
    input        Reset,
    input        IF_ID_Write,     // Added control signal for stalling
    input [31:0] inWire2,
    input [31:0] inWire3,
    input [31:0] inWire4,
    input        Flush1, Flush2,
    output reg [31:0] outWire2,
    output reg [31:0] outWire3,
    output reg [31:0] outWire4
);
    
    always @(posedge Clk or posedge Reset) begin
        if (Reset || Flush1) begin
            outWire2 <= 32'd0;
            outWire3 <= 32'd0;
            outWire4 <= 32'd0;
        end else if (IF_ID_Write) begin
            // Update outputs when IF_ID_Write is asserted
            outWire2 <= inWire2;
            outWire3 <= inWire3;
            outWire4 <= inWire4;
        end else begin
            // Hold current values (stall) when IF_ID_Write is deasserted
            outWire2 <= outWire2;
            outWire3 <= outWire3;
            outWire4 <= outWire4;
        end
    end

endmodule