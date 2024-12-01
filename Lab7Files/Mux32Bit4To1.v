`timescale 1ns / 1ps

module Mux32Bit4To1(
    input [31:0] inA,   // Input 0
    input [31:0] inB,   // Input 1
    input [31:0] inC,   // Input 2
    input [31:0] inD,   // Input 3
    input [1:0] sel,
    output reg [31:0] out
);
    always @(*) begin
        case(sel)
            2'b00: out = inA;
            2'b01: out = inB;
            2'b10: out = inC;
            2'b11: out = inD;
            default: out = 32'b0;
        endcase
    end
endmodule
