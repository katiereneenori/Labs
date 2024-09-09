`timescale 1ns / 1ps

module ClkDiv(Clk, Reset, ClkOut);
   input Clk, Reset;
   output reg ClkOut;
   parameter DivVal = 50000000;
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
         DivCnt <= DivCnt + 1;
      end
   end
endmodule
