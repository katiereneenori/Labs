`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - 5BitExtender.v
// Description - Word extension module.
////////////////////////////////////////////////////////////////////////////////
module FiveBitExtender(in, out);

    // A 5-Bit input word 
    input [4:0] in;
    
    // A 32-Bit output word 
    output reg [31:0] out;
    always @(*) begin
        out = {27'b000000000000000000000000000, in};
    end

endmodule
