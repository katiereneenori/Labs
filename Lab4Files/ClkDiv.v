`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// Module - ClkDiv.v
// Description - Clock devider to toggle clock signal at slower rate 
// ECE369A - Computer Architecture
// Laboratory 1
////////////////////////////////////////////////////////////////////////////////

module ClkDiv(Clk, Reset, ClkOut);
   input Clk, Reset;
   output reg ClkOut;
   parameter DivVal = 50000000; //do 1 for simulation from 50000000
   reg [25:0] DivCnt;
   reg ClkInt;

   always @(posedge Clk or posedge Reset) begin
      if (Reset) begin
         DivCnt <= 0;
         ClkOut <= 0;
         ClkInt <= 0;
      end
      else if (DivCnt == DivVal) begin
            ClkOut <= ~ClkInt;
            ClkInt <= ~ClkInt;
         DivCnt <= 0;
      end
      else begin
            ClkOut <= ClkInt;
            ClkInt <= ClkInt;
         DivCnt <= DivCnt + 1;
      end
   end
endmodule
