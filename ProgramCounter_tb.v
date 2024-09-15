`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// Module - ProgramCounter_tb.v
// Description - test functionality of ProgramCounter
//
// ECE369A - Computer Architecture
// Laboratory 1
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter_tb(); 

	reg [31:0] Address;
	reg Reset, Clk;

	wire [31:0] PCResult;

    ProgramCounter u0(
        .Address(Address), 
        .PCResult(PCResult), 
        .Reset(Reset), 
        .Clk(Clk)
    );

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	
    Address = 32'h00000000;
        Reset = 1'b1;

        #20 Reset = 1'b0; //reset after 20 ns

        #20 Address = 32'h00000010;
        #20 Address = 32'h00000020;
        #20 Address = 32'h00000030;
        #20 Reset   = 1'b1;
        
        #20 $finish;
	
	end

endmodule

