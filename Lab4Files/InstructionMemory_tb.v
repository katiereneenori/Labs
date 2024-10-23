`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// Module - InstructionMemory_tb.v
// Description - test functionality of InstructionMemory
//
// ECE369A - Computer Architecture
// Laboratory 1
////////////////////////////////////////////////////////////////////////////////

module InstructionMemory_tb(); 

    wire [31:0] Instruction;

    reg [31:0] Address;

	InstructionMemory u0(
		.Address(Address),
        .Instruction(Instruction)
	);

	initial begin
	
        //address = 0
        Address = 32'd0;
        #10;
        $display("Address = %d, Instruction = %h", Address, Instruction);

        //address = 4
        Address = 32'd4;
        #10;
        $display("Address = %d, Instruction = %h", Address, Instruction);

        //address = 8
        Address = 32'd8;
        #10;
        $display("Address = %d, Instruction = %h", Address, Instruction);

        //address = 12
        Address = 32'd12;
        #10;
        $display("Address = %d, Instruction = %h", Address, Instruction);

        $stop;
	
	end

endmodule

