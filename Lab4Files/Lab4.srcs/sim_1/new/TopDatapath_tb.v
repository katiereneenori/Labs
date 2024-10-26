`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2024 10:00:00 AM
// Design Name: 
// Module Name: TopDatapath_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//      Testbench for the TopDatapath module. This testbench generates a clock,
//      applies a reset, and monitors internal signals to verify correct
//      datapath functionality.
// 
// Dependencies: 
//      TopDatapath.v
// 
// Revision:
//      Revision 0.01 - File Created
// 
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TopDatapath_tb;

    // ------------------------Inputs------------------------
    reg Clk;
    reg Reset;

    // ------------------------Outputs-----------------------
    // No top-level outputs as per design adjustments

    // ------------------------Internal Wires for Monitoring-----------------------
    // Assuming wire2 is PCOut and wire13 is WriteDataOut
    wire [31:0] PCOut;
    wire [31:0] WriteDataOut;

    // Instantiate the Unit Under Test (UUT)
    TopDatapath uut (
        .Clk(Clk), 
        .Reset(Reset),
        .PCOut(PCOut),
        .WriteDataOut(WriteDataOut)
    );

    // ------------------------Clock Generation------------------------
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; // Toggle clock every 5 ns for 100 MHz
    end

    // ------------------------Reset Signal------------------------
    initial begin
        Reset = 1;
        #10;             // Hold reset for 10 ns
        Reset = 0;
    end

    // ------------------------Monitoring Signals------------------------
    initial begin
        // Wait for reset to be deasserted
        #15;
        // Display header
        $display("Time\tPCOut\t\tInstruction\t\tWriteDataOut");
        // Monitor signals
        $monitor("%0t\t%h\t%h\t%h", $time, PCOut, uut.wire11, WriteDataOut);
    end



    // ------------------------Simulation Control------------------------
    initial begin
        #1000;           // Run simulation for 1000 ns
        $stop;           // Stop simulation
    end

endmodule
