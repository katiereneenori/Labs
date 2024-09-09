`timescale 1ns / 1ps

module TopModule_tb;

    // Inputs to the TopModule
    reg Clk;
    reg Reset;

    // Outputs from the TopModule
    wire [6:0] out7;      // 7-segment display outputs
    wire [3:0] en_out;    // Enable outputs for 7-segment digits
    wire dp;              // Decimal point output

    // Instantiate the TopModule
    TopModule uut (
        .Clk(Clk),
        .Reset(Reset),
        .out7(out7),
        .en_out(en_out),
        .dp(dp)
    );

    // Clock Generation: 100 MHz clock (10 ns period)
    always begin
        #5 Clk = ~Clk;  // Toggle clock every 5 ns to create a 10 ns period
    end

    // Initialize Inputs and apply test sequences
    initial begin
        // Initialize the clock and reset signals
        Clk = 0;
        Reset = 1;
        
        // Apply reset
        #20;            // Wait for 20 ns
        Reset = 0;      // Deassert reset
        
        // Simulation run for a few clock cycles to observe the behavior
        #200;           // Run simulation for 200 ns to allow instruction fetch and display
        
        // Apply reset again to observe reset behavior
        Reset = 1;
        #20;            // Wait for 20 ns
        Reset = 0;      // Deassert reset

        // Run simulation for additional time to see more cycles
        #500;           // Continue simulation to observe more instructions
        
        // Finish simulation
        $finish;
    end

    // Monitor output changes
    initial begin
        $monitor("Time=%0d ns, Reset=%b, Clk=%b, out7=%b, en_out=%b, dp=%b", 
                 $time, Reset, Clk, out7, en_out, dp);
    end

endmodule
