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
//      Enhanced Testbench for the TopDatapath module. This version monitors the PC,
//      current instruction, WriteData, and registers (registers[31:0]) in signed decimal.
//
// Dependencies: 
//
// Revision: 
// Revision 0.05 - Changed register output format to signed decimal
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

        // Enhanced Monitoring for PC, Instruction, and WriteData
        $monitor(
            "Time: %0dns | PC: %0d | Instruction: 0x%08h | WriteData: %0d", 
            $time, wire2, uut.IM.Instruction, $signed(wire13)
        );
        
        // End Simulation after a fixed time
        #25000;        // Run simulation for 25,000 ns
        $finish;
    end

    always @(posedge Clk) begin
        // Check if a register write is occurring
        if (uut.Registers.RegWrite) begin
            // Display the register number and its new signed value
            $display("Time: %0dns | Register[%0d] <= %0d", 
                     $time, 
                     uut.Registers.WriteRegister, 
                     $signed(uut.Registers.registers[uut.Registers.WriteRegister]));
        end
    end

    // Control Signal Monitoring
    always @(posedge Clk) begin
        $display("Time: %0dns | ALUOp: %b | PCWrite: %b | IF_ID_Write: %b", 
                 $time, uut.ID_EXRegFile.outALUOp, uut.HDU_PCWrite, uut.HDU_IF_ID_Write);
    end

endmodule
