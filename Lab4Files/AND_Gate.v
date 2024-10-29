`timescale 1ns / 1ps

// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
// 
// ECE369A - Computer Architecture
// Laboratory 4

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