`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux32Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit2To1(out, inA, inB, sel, Clk, Reset);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
    input sel;
    
    input Clk, Reset;
    
    reg [31:0] mux_out;

    // combinational logic to select the input
    always @(*) begin
        if (sel) begin
            mux_out = inB; // select inB when sel is 1
        end
        else begin
            mux_out = inA; // select inA when sel is 0
        end
    end

    //sequential logic to register the output
    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            out <= 32'b0; // initialize output to 0 on Reset
        end 
        else begin
            out <= mux_out; // register the selected input on rising edge of Clk
        end
    end

endmodule
