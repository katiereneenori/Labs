`timescale 1ns / 1ps

module TopDatapath_tb;

    // Inputs to the TopDatapath
    reg Clk;
    reg Reset;
    
    
    // Outputs from the TopDatapath
 //   wire [31:0] v0;     // This will capture the v0 register output
 //   wire [31:0] v1;     // This will capture the v1 register output


    // Outputs from the TopDatapath
    wire [31:0] wire2;     // This will capture the PC output
    wire [31:0] wire13;    // This will capture the WriteData output

    // Instantiate the TopDatapath
    TopDatapath uut (
        .Clk(Clk),
        .Reset(Reset),
//        .v0(v0),
//        .v1(v1),
        .wire2(wire2),
        .wire13(wire13)
    );

    // Clock Generation
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; // Toggle clock every 5 ns (100 MHz clock)
    end

    // Reset Signal Generation
    initial begin
        Reset = 1;
        #5;          // Hold reset high for 10 ns
        Reset = 0;
    end

    // Simulation Control
    initial begin
        // Monitor the outputs
        
        // Monitor the outputs
  //      $monitor("Time: %0dns, PC: %h, WriteData: %h, v0: %h, v1: %h",
  //               $time, wire2, wire13, v0, v1);
        
       // $monitor("Time: %0dns, v0: 0x%08h, v1: 0x%08h", $time, v0, v1);
       $monitor("Time: %0dns, wire2 (PCOut): 0x%08h, wire13 (WriteDataOut): %0d", $time, wire2, wire13);

        // Run the simulation for a specified time
        #500000;        // Adjust the simulation time as needed
        $finish;
    end

endmodule
