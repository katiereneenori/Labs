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
// Revision 0.08 - Enhanced with even more internal signals, flush, JSrc, JRSelect, etc.
//
// Additional Comments:
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

    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; 
    end

    initial begin
        Reset = 1;
        #20;
        Reset = 0;
    end

    initial begin
        $dumpfile("TopDatapath_waveform.vcd");
        $dumpvars(0, TopDatapath_tb);
    end

    integer cycle_count = 0;

    always @(posedge Clk) begin
        if (!Reset) begin
            cycle_count <= cycle_count + 1;

            // Print a header every 20 cycles for readability
            if (cycle_count % 20 == 1) begin
                $display("\n=== Cycle    PC      Instruction       v0      v1     RegWrite  WriteReg  WriteData  JalSel  MemToReg  PCSrcWire ===");
            end

            $display("C=%0d | PC=%0d | Inst=0x%08h | v0=%0d | v1=%0d | RegWrite=%b | WReg=%0d | WData=%0d | JalSel=%b | M2R=%b | PCSrcWire=%b",
                     cycle_count,
                     wire2,
                     uut.IM.Instruction, 
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

    always @(negedge Clk) begin
        if (!Reset) begin
            $display("    [IF/ID]: PC+4=%0d, Instruction=0x%08h",
                     uut.wire10,
                     uut.wire11);

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

            $display("    Hazard/Forward Info: HDU_PCWrite=%b, HDU_IF_ID_Write=%b, HDU_Flush1=%b, ForwardA=%b, ForwardB=%b",
                     uut.HDU_PCWrite,
                     uut.HDU_IF_ID_Write,
                     uut.HDU_Flush1,
                     uut.ForwardA,
                     uut.ForwardB);

            $display("    Additional Signals: JSrc=%b, JRSelect=%b, Flush1=%b",
                     uut.JSrcWire,
                     uut.JRSelectWire,
                     uut.HDU_Flush1);
        end
    end

    initial begin
        #25000;
        $finish;
    end

endmodule
