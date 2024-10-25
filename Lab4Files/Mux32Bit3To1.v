`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux32Bit3To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit3To1(out, inA, inB, inC, sel, Clk, Reset);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
    input [31:0] inC;
    input [1:0] sel;
    
    input Clk, Reset;
    
    reg [31:0] mux_out;

    //using combinational logic to select the input
    always @(*) begin
            case (sel)
                2'b00: mux_out = inA;
                2'b01: mux_out = inB;
                2'b10: mux_out = inC;
                default: mux_out = inA; //default to inA if undefined sel
            endcase
        end
        
        //using sequential logic to register the output
            always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            out <= 32'b0;
        end 
        else begin
            out <= mux_out;
        end
    end

endmodule
