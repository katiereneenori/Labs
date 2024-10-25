`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2024 02:20:29 PM
// Design Name: 
// Module Name: TopDatapath_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// Testbench for TopDatapath Module
// Simulates clock generation, reset application, memory initialization,
// and monitors key outputs for verification.
//////////////////////////////////////////////////////////////////////////////////


module TopDatapath_tb;

    // Inputs
    reg Clk;
    reg Reset;

    // Outputs
    wire [31:0] out;             // PC Result
    wire [31:0] alu_result;      // ALU Output
    wire [31:0] mem_read_data;   // Data read from memory

    // Instantiate the TopDatapath
    TopDatapath uut (
        .Clk(Clk),
        .Reset(Reset),
        .out(out),
        .alu_result(alu_result),
        .mem_read_data(mem_read_data)
    );

    // Clock Generation: 100 MHz => 10 ns period
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; // Toggle every 5 ns
    end

    // Apply Reset: Assert reset at time 0, deassert after 20 ns
    initial begin
        Reset = 1;
        #20;
        Reset = 0;
    end

    // Initialize Instruction Memory
    initial begin
        $readmemh("C:\\Users\\tjwil\\Desktop\\ECE369A\\LabsRepo\\Labs\\Lab4Files\\out.mem", uut.IM.memory);
    end

    // Initialize Data Memory (Optional)
    initial begin
        // If DataMemory requires initialization, uncomment and modify as necessary
        // $readmemh("data_memory.mem", uut.datamem.memory);
    end

    // Monitor Key Signals
    initial begin
        $monitor("Time=%0dns | PC=%h | ALU=%h | MemReadData=%h",
                 $time, out, alu_result, mem_read_data);
    end

    // Simulation Duration and Termination
    initial begin
        #1000; // Run simulation for 1000 ns
        $finish;
    end

endmodule