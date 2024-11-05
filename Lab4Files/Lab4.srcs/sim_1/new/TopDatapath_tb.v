`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// 
////////////////////////////////////////////////////////////////////////////////

module TopDatapath_tb;

    // ------------------------Inputs------------------------
    reg Clk;
    reg Reset;

    // ------------------------Outputs-----------------------
    wire [31:0] wire2;
    wire [31:0] wire13;

 //   wire [31:0] ReadDataOut1;
 //   wire [31:0] ReadDataOut2;

    // Instantiate the Unit Under Test (UUT)
    TopDatapath uut (
        .Clk(Clk), 
        .Reset(Reset),
        .wire2(wire2),
        .wire13(wire13)
//        .ReadDataOut1(ReadDataOut1),
//        .ReadDataOut2(ReadDataOut2)
    );
// Clock Generation
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; // Toggle clock every 5 ns (100 MHz clock)
    end

    // Reset Signal Generation
    initial begin
        Reset = 1;
        #10;          // Hold reset high for 10 ns
        Reset = 0;
    end

    // Simulation Control
    initial begin
        // Monitor the outputs
        $monitor("Time: %0dns, wire2 (PCOut): 0x%08h, wire13 (WriteDataOut): %0d", $time, wire2, wire13);

        // Run the simulation for a specified time
        #1000;        // Adjust the simulation time as needed
        $finish;
    end

endmodule