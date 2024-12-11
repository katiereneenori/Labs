`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Tanner Shartel and Katie Dionne
// 
// Create Date:    11:00 AM 12/01/2024 
// Module Name:    TopDatapath_tb
// Description:
//   Enhanced Testbench for the TopDatapath module with additional instrumentation.
//
// Observes internal pipeline state, register file content ($v0, $v1, $a3, $t8, $t0, $t1),
// instructions in pipeline stages, and control signals. Step through the simulation
// cycle-by-cycle to understand when and why $v0 and $v1 update.
//
// Notes:
// - Single-step by looking at the output each cycle.
// - Ensure hierarchical references match your actual module and signal names.
////////////////////////////////////////////////////////////////////////////////

module TopDatapath_tb;

    reg Clk;
    reg Reset;
    
    wire [31:0] v0;
    wire [31:0] v1;
    wire [31:0] wire2;
    wire [31:0] wire13;

    TopDatapath uut (
        .Clk(Clk),
        .Reset(Reset),
        .v0(v0),
        .v1(v1),
        .wire2(wire2),
        .wire13(wire13)
    );

    // Clock generation
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; 
    end

    // Reset sequence
    initial begin
        Reset = 1;
        #20;
        Reset = 0;
    end

    // Dump waveforms
    initial begin
        $dumpfile("TopDatapath_waveform.vcd");
        $dumpvars(0, TopDatapath_tb);
    end

    integer cycle_count = 0;

    // Display pipeline status on positive edge of clock
    always @(posedge Clk) begin
        if (!Reset) begin
            cycle_count <= cycle_count + 1;

            // Print a header every 20 cycles for readability
            if (cycle_count % 20 == 1) begin
                $display("\n=== Cycle    PC      IF_Inst       ID_Inst       EX_Inst       v0      v1     RegWrite(MEMWB)  WriteReg(MEMWB)  WriteData(MEMWB)  JalSel(MEMWB)  MemToReg(MEMWB)  PCSrcWire ===");
            end

            // Attempt to show instructions at each stage:
            // IF stage instruction: uut.IM.Instruction
            // ID stage instruction: IF/ID out is uut.wire11
            // EX stage instruction: ID/EX outWire17 is uut.wire25 (assuming outWire17 holds the instruction)
            // If outWire17 does not actually hold the full instruction, this might show partial or zero.
            // Adjust as needed if you have a separate pipeline register for the full instruction.
            
            $display("C=%0d | PC=%0d | IF=0x%08h | ID=0x%08h | EX=0x%08h | v0=%0d | v1=%0d | RegW=%b | WReg=%0d | WData=%0d | JalSel=%b | M2R=%b | PCSrcWire=%b",
                     cycle_count,
                     wire2,
                     uut.IM.Instruction, 
                     uut.wire11,           // ID stage instruction from IF_ID register
                     uut.wire25,           // EX stage instruction from ID_EX register (if stored)
                     $signed(v0),
                     $signed(v1),
                     uut.RegWriteWire3,
                     uut.wire49,
                     $signed(wire13),
                     uut.JalSelWire3,
                     uut.MemToRegWire3,
                     uut.PCSrcWire
                     );
        end
    end

    // Display detailed information on negative edge for better readability
    always @(negedge Clk) begin
        if (!Reset) begin
            // Print pipeline stage details
            $display("    [IF/ID]: PC+4=%0d, Instruction(ID)=%0h", uut.wire10, uut.wire11);

            $display("    [ID/EX]: RD1=%0d, RD2=%0d, ALUOp=%b, RegDst=%b, ALUSrcA=%b, ALUSrcB=%b, ToBranch=%b, JalSel=%b, JorBranch=%b, JSrc=%b, JRSelect=%b",
                     $signed(uut.wire14), 
                     $signed(uut.wire15),
                     uut.ALUOpWire1,
                     uut.RegDstWire1,
                     uut.ALUSrcAWire1,
                     uut.ALUSrcBWire1,
                     uut.ToBranchWire1,
                     uut.JalSelWire1,
                     uut.JorBranchWire1,
                     uut.JSrcWire1,
                     uut.JRSelectWire
                     );

            $display("    [EX/MEM]: ALUResult=%0d, MemWrite=%b, MemRead=%b, RegWrite=%b, JalSel=%b, JorBranch=%b, ToBranch=%b",
                     $signed(uut.wire7),
                     uut.MemWriteWire2,
                     uut.MemReadWire2,
                     uut.RegWriteWire2,
                     uut.JalSelWire2,
                     uut.JorBranchWire2,
                     uut.ToBranchWire2
                     );

            $display("    [MEM/WB]: RegWrite=%b, JalSel=%b, MemToReg=%b, WriteData(final)=%0d, WriteReg=%0d",
                     uut.RegWriteWire3,
                     uut.JalSelWire3,
                     uut.MemToRegWire3,
                     $signed(wire13),
                     uut.wire49);

            // Print hazard and forwarding info
            $display("    Hazard/Forward Info: HDU_PCWrite=%b, HDU_IF_ID_Write=%b, HDU_Flush1=%b, ForwardA=%b, ForwardB=%b",
                     uut.HDU_PCWrite,
                     uut.HDU_IF_ID_Write,
                     uut.HDU_Flush1,
                     uut.ForwardA,
                     uut.ForwardB);

            $display("    Additional Signals: JSrc=%b, JRSelect=%b, BranchTaken=%b, JumpTaken=%b",
                     uut.JSrcWire,
                     uut.JRSelectWire,
                     (uut.ToBranchWire2 & uut.wire38),
                     (uut.JorBranchWire & uut.JSrcWire));

            // Print out key registers: $a3(7), $t8(24), $t0(8), $t1(9)
            // Requires hierarchical access to RegisterFile internals:
            $display("    Registers: $a3=%0d, $t8=%0d, $t0=%0d, $t1=%0d",
                     $signed(uut.Registers.registers[7]),
                     $signed(uut.Registers.registers[24]),
                     $signed(uut.Registers.registers[8]),
                     $signed(uut.Registers.registers[9]));

            $display("--------------------------------------------------------------------------------");
        end
    end

    initial begin
        // Run the simulation for enough cycles to observe changes
        #25000;
        $finish;
    end

endmodule
