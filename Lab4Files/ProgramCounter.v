`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// ECE369A - Computer Architecture
// Laboratory 1
// Module - pc_register.v
// Description - 32-Bit program counter (PC) register.
//
// INPUTS:-
// Address: 32-Bit address input port.
// Reset: 1-Bit input control signal.
// Clk: 1-Bit input clock signal.
//
// OUTPUTS:-
// PCResult: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design a program counter register that holds the current address of the 
// instruction memory.  This module should be updated at the positive edge of 
// the clock. The contents of a register default to unknown values or 'X' upon 
// instantiation in your module.  
// You need to enable global reset of your datapath to point 
// to the first instruction in your instruction memory (i.e., the first address 
// location, 0x00000000H).
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter(Address, PCResult, Reset, Clk, PCWrite);
    input [31:0] Address;
    input Reset, Clk, PCWrite;
    output reg [31:0] PCResult;

    reg [1:0] stall_counter; // Counter to track stall cycles

    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            PCResult <= 32'b0;
            stall_counter <= 2'b00;
        end else if (stall_counter > 0) begin
            stall_counter <= stall_counter - 1;
            PCResult <= PCResult; // Hold the value (stall)
        end else if (~PCWrite) begin
            stall_counter <= 2'b10; // Initiate 2-cycle stall
            PCResult <= PCResult;   // Hold the value (stall)
        end else begin
            PCResult <= Address;    // Normal operation
        end
    end
endmodule