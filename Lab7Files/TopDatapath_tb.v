`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tanner Shartel and Katie Dionne
// 
// Create Date:    11:00 AM 12/01/2024 
// Design Name: 
// Module Name:    TopDatapath_tb 
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//      Testbench for the TopDatapath module. This testbench monitors the PC,
//      current instruction, WriteData, and all registers (registers[31:0]).
//      It generates a clock, applies a reset, and observes the behavior over time.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
////////////////////////////////////////////////////////////////////////////////

module TopDatapath_tb;

    // Inputs to the TopDatapath
    reg Clk;
    reg Reset;
    
    // Outputs from the TopDatapath
    wire [31:0] v0;     // Register $v0
    wire [31:0] v1;     // Register $v1

    // Additional Outputs from the TopDatapath
    wire [31:0] wire2;     // PC output
    wire [31:0] wire13;    // WriteData output

    // Instantiate the TopDatapath
    TopDatapath uut (
        .Clk(Clk),
        .Reset(Reset),
        .v0(v0),
        .v1(v1),
        .wire2(wire2),
        .wire13(wire13)
    );

    // Clock Generation
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; // 100 MHz clock (period = 10 ns)
    end

    // Reset Signal Generation
    initial begin
        Reset = 1;
        #20;          // Hold reset high for 20 ns
        Reset = 0;
    end

    // Simulation Control and Monitoring
    initial begin
        // Initialize waveform dump
        $dumpfile("TopDatapath_tb.vcd"); // Name of the dump file
        $dumpvars(0, TopDatapath_tb);    // Dump all variables in the testbench hierarchy

        // Monitor specific signals using hierarchical references
        // Monitor PC, Instruction, WriteData, v0, v1, and $ra (registers[31])
        $monitor("Time: %0dns | PC: 0x%08h | Instruction: 0x%08h | WriteData: 0x%08h | v0: 0x%08h | v1: 0x%08h | $ra: 0x%08h",
                 $time, wire2, uut.IM.Instruction, wire13, v0, v1, uut.Registers.registers[31]);

        // Optional: Display all registers at every positive clock edge
        /*
        integer i;
        always @(posedge Clk) begin
            for (i = 0; i < 32; i = i + 1) begin
                $display("Time: %0dns | Register[%0d]: 0x%08h", $time, i, uut.Registers.registers[i]);
            end
        end
        */

        // Run the simulation for a specified duration
        #5000;        // Run simulation for 500,000 ns (500 us)
        $finish;
    end

endmodule
