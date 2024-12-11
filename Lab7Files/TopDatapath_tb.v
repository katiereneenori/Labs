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
//   Enhanced Testbench for the TopDatapath module with more signals monitored
//   including internal pipeline registers, register write signals, flush logic,
//   hazard signals, and register file content (focusing on $v0, $v1, and the
//   write register and data).
//
// Dependencies: 
//
// Revision: 
// Revision 0.07 - Enhanced monitoring of flush signals, hazard signals, and 
//                 pipeline internal logic.
//
// Additional Comments: 
////////////////////////////////////////////////////////////////////////////////

module TopDatapath_tb;

    // Inputs to the TopDatapath
    reg Clk;
    reg Reset;
    
    // Outputs from the TopDatapath
    wire [31:0] v0;     // Register $v0
    wire [31:0] v1;     // Register $v1

    // Additional Outputs from the TopDatapath
    wire [31:0] wire2;  // PC output
    wire [31:0] wire13; // WriteData output (final data written to register file)

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

    // VCD Dump for waveform analysis
    initial begin
        $dumpfile("TopDatapath_waveform.vcd");
        $dumpvars(0, TopDatapath_tb);
    end

    integer cycle_count = 0;

    // Display a large amount of internal signals to diagnose flush issues
    // and hazard conditions. This includes the flush logic from the uut.
    always @(posedge Clk) begin
        if (!Reset) begin
            cycle_count <= cycle_count + 1;

            // Print a header every 20 cycles for readability
            if (cycle_count % 20 == 1) begin
                $display("\n=== Cycle    PC      Instruction       v0      v1   RegWrite WriteReg WriteData JalSel MemToReg FlushPulse PCSrc lastPCSrc ===");
            end

            $display("C=%0d | PC=%0d | Inst=0x%08h | v0=%0d | v1=%0d | RegWrite=%b | WReg=%0d | WData=%0d | JalSel=%b | M2R=%b | FlushPulse=%b | PCSrcWire=%b | lastPCSrc=%b",
                     cycle_count,
                     wire2,
                     uut.IM.Instruction, 
                     $signed(v0),
                     $signed(v1),
                     uut.RegWriteWire3,       // final RegWrite in MEM_WB
                     uut.wire49,              // final write register in MEM_WB
                     $signed(wire13),         // final write data in MEM_WB
                     uut.JalSelWire3,         // final JalSel in MEM_WB
                     uut.MemToRegWire3,       // final MemToReg in MEM_WB
                     uut.FlushPulse,          // FlushPulse signal from the datapath
                     uut.PCSrcWire,           // PCSrc signal
                     uut.lastPCSrc            // lastPCSrc register from datapath
                     );
        end
    end

    // Additional Monitor of selected internal signals at the negedge of clock
    // to see pipeline states after updates
    always @(negedge Clk) begin
        if (!Reset) begin
            // Show IF/ID pipeline registers
            $display("    [IF/ID]: PC+4=%0d, Instruction=0x%08h",
                     uut.wire10,
                     uut.wire11);

            // Show ID/EX signals including read registers:
            $display("    [ID/EX]: RD1=%0d, RD2=%0d, ALUOp=%b, RegDst=%b, ALUSrcA=%b, ALUSrcB=%b, ToBranch=%b",
                     $signed(uut.wire14), 
                     $signed(uut.wire15),
                     uut.ALUOpWire1,
                     uut.RegDstWire1,
                     uut.ALUSrcAWire1,
                     uut.ALUSrcBWire1,
                     uut.ToBranchWire1);

            // Show EX/MEM signals including ALU result and memory controls:
            $display("    [EX/MEM]: ALUResult=%0d, MemWrite=%b, MemRead=%b, RegWrite=%b, JalSel=%b, JorBranch=%b",
                     $signed(uut.wire7),
                     uut.MemWriteWire2,
                     uut.MemReadWire2,
                     uut.RegWriteWire2,
                     uut.JalSelWire2,
                     uut.JorBranchWire2);
            
            // Show MEM/WB signals including final chosen MemToReg:
            $display("    [MEM/WB]: RegWrite=%b, JalSel=%b, MemToReg=%b, WriteData(final)=%0d, WriteReg=%0d",
                     uut.RegWriteWire3,
                     uut.JalSelWire3,
                     uut.MemToRegWire3,
                     $signed(wire13),
                     uut.wire49);

            // Show hazard detection and forwarding info
            $display("    Hazard/Forward Info: HDU_PCWrite=%b, HDU_IF_ID_Write=%b, HDU_ControlHazard=%b, ForwardA=%b, ForwardB=%b",
                     uut.HDU_PCWrite,
                     uut.HDU_IF_ID_Write,
                     uut.HDU_ControlHazard,
                     uut.ForwardA,
                     uut.ForwardB);

            // Show flush conditions:
            $display("    Flush Conditions: toFlush=%b (should flush when branch taken), FlushPulse=%b (one-cycle pulse)",
                     uut.toFlush,
                     uut.FlushPulse);
        end
    end

    // Continuous monitor whenever any of these changes (might be verbose)
    // Shows critical signals including PC, instruction, v0, v1 continuously.
    // You may comment this out if too noisy.
    initial begin
        $monitor("Time: %0dns | PC=%0d | Inst=0x%08h | v0=%0d | v1=%0d | RegWrite=%b | WReg=%0d | WData=%0d",
                 $time, wire2, uut.IM.Instruction, $signed(v0), $signed(v1), uut.RegWriteWire3, uut.wire49, $signed(wire13));
    end

    // Simulation runtime
    initial begin
        #25000;        // Run simulation for 25,000 ns
        $finish;
    end

endmodule
