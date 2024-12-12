`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: [Your Name]
//
// Create Date:    11:00 AM 12/01/2024
// Module Name:    TopDatapath_tb
// Project Name:   MIPS Datapath
// Target Devices:
// Tool Versions:
// Description:
//    Enhanced Testbench for the TopDatapath module. This version monitors:
//    - PC and Instruction memory
//    - WriteData and register writes
//    - $v0 and $v1 register values
//    - Hazard detection signals
//    - Forwarding signals
//    - Pipeline register outputs
//
// Dependencies:
//
// Revision:
// Revision 0.10 - Enhanced testbench with comprehensive monitoring
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

    // Clock Generation: 10 ns period
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk;
    end

    // Reset Signal Generation
    initial begin
        Reset = 1;
        #20;          // Hold reset high for 20 ns
        Reset = 0;
    end

    // Waveform Dump for GTKWave or similar
    initial begin
        $dumpfile("TopDatapath_tb.vcd");
        $dumpvars(0, TopDatapath_tb);
    end

    // Monitor Changes in PC, Instruction, WriteData, v0, v1 every cycle
    always @(posedge Clk) begin
        $display("---------------------------------------------------------");
        $display("Time: %0dns", $time);
        $display("PC: %0d (0x%08h)", wire2, wire2);
        $display("Instruction: 0x%08h", uut.IM.Instruction);
        $display("WriteData (wire13): %0d", $signed(wire13));
        $display("v0: %0d, v1: %0d", $signed(v0), $signed(v1));
        
        // Hazard Signals
        $display("HDU: PCWrite=%b, IF_ID_Write=%b, Flush1=%b", 
                 uut.HDU_PCWrite, uut.HDU_IF_ID_Write, uut.HDU_Flush1);
        
        // Forwarding signals
        $display("Forwarding: ForwardA=%b, ForwardB=%b", uut.ForwardA, uut.ForwardB);
        
        // Pipeline control signals of interest at each stage
        // IF/ID outputs:
        $display("IF/ID: outWire2(PC)=%0d, outWire4(Instruction)=0x%08h", uut.IF_IDRegFile.outWire2, uut.IF_IDRegFile.outWire4);
        
        // ID/EX outputs:
        $display("ID/EX: ALUOp=%b, RegWrite=%b, MemWrite=%b, MemRead=%b, MemToReg=%b, RegDst=%b, JalSel=%b",
                 uut.ID_EXRegFile.outALUOp, 
                 uut.ID_EXRegFile.outRegWrite, uut.ID_EXRegFile.outMemWrite, uut.ID_EXRegFile.outMemRead,
                 uut.ID_EXRegFile.outMemToReg, uut.ID_EXRegFile.outRegDst, uut.ID_EXRegFile.outJalSel);
        $display("       Rs=%d, Rt=%d, Rd=%d (ID/EX), A=%0d, B=%0d, SignExtImm=%0d", 
                 uut.ID_EX_RegisterRs, uut.ID_EXRegFile.outWire27, uut.ID_EXRegFile.outWire28, 
                 $signed(uut.ID_EXRegFile.outWire14), $signed(uut.ID_EXRegFile.outWire15), $signed(uut.ID_EXRegFile.outWire18));
        
        // EX/MEM outputs:
        $display("EX/MEM: RegWrite=%b, MemWrite=%b, MemRead=%b, MemToReg=%b, JalSel=%b, ALUResult=%0d, WriteReg=%d",
                 uut.EX_MEMRegFile.outRegWrite, uut.EX_MEMRegFile.outMemWrite, uut.EX_MEMRegFile.outMemRead,
                 uut.EX_MEMRegFile.outMemToReg, uut.EX_MEMRegFile.outJalSel, 
                 $signed(uut.EX_MEMRegFile.outWire34), uut.EX_MEMRegFile.outWire33);
        
        // MEM/WB outputs:
        $display("MEM/WB: RegWrite=%b, JalSel=%b, MemToReg=%b, WriteData(MEM/WB)=%0d, WriteReg=%d",
                 uut.MEM_WBRegFile.outRegWrite, uut.MEM_WBRegFile.outJalSel, uut.MEM_WBRegFile.outMemToReg,
                 $signed(uut.wire13), uut.MEM_WBRegFile.outWire41);
                 
        // If register writes occur:
        if (uut.Registers.RegWrite) begin
            $display("Register[%0d] <= %0d (signed)", 
                     uut.Registers.WriteRegister, 
                     $signed(uut.Registers.registers[uut.Registers.WriteRegister]));
        end

        $display("---------------------------------------------------------\n");
    end

    // End Simulation after a certain time if needed
    initial begin
        #50000; // Run simulation for 50,000 ns or until you decide it's enough
        $finish;
    end

endmodule
