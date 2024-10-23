`timescale 1ns / 1ps

//AND Gate

module AND_Gate (inA, inB, out);

input inA, inB;

output reg out;

    always @(*) begin
	   if(inA && inB) begin
		  out = 1'b1;
	   end
	   else begin
		  out = 1'b0;
	   end
	
	end
endmodule