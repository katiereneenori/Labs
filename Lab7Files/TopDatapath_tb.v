`timescale 1ns / 1ps

module TopDatapath_tb;

    // Inputs
    reg Clk;
    reg Reset;

    // Outputs
    wire [31:0] v0;       // $v0 register
    wire [31:0] v1;       // $v1 register
    wire [31:0] wire2;    // PC
    wire [31:0] wire13;   // WriteData to RegisterFile

    // Instantiate the Unit Under Test (UUT)
    TopDatapath uut (
        .Clk(Clk),
        .Reset(Reset),
        .v0(v0),
        .v1(v1),
        .wire2(wire2),
        .wire13(wire13)
    );

    // Generate clock
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk;
    end

    // Apply reset
    initial begin
        Reset = 1;
        #20;
        Reset = 0;
    end

    // Setup waveform dumping
    initial begin
<<<<<<< HEAD
        $dumpfile("TopDatapath_tb.vcd");
        $dumpvars(0, TopDatapath_tb);
=======
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
>>>>>>> parent of 3ca3e89 (dsfsadgasghdrhtrsegh edf)
    end

    // Main monitor: prints PC, Instruction, WriteData, v0, and v1
    // Use $signed for signed decimal formatting
    always @(posedge Clk) begin
        $display("Time: %0dns | PC: %h | Instr: %h | WriteData(wire13): %d | v0: %d | v1: %d",
                 $time, wire2, uut.IM.Instruction, $signed(wire13), $signed(v0), $signed(v1));
    end

    // Display whenever a register is written in the RegisterFile
    always @(posedge Clk) begin
        if (uut.Registers.RegWrite) begin
            $display("Time: %0dns | Register[%0d] <= %d",
                     $time,
                     uut.Registers.WriteRegister,
                     $signed(uut.Registers.registers[uut.Registers.WriteRegister]));
        end
    end

    // Monitor Hazard Detection signals
    always @(posedge Clk) begin
        $display("Time: %0dns | HDU: PCWrite=%b, IF_ID_Write=%b, Flush1=%b",
                 $time, uut.HDU_PCWrite, uut.HDU_IF_ID_Write, uut.HDU_Flush1);
    end

    // Monitor Forwarding signals
    always @(posedge Clk) begin
        $display("Time: %0dns | Forwarding: A=%b, B=%b",
                 $time, uut.ForwardA, uut.ForwardB);
    end

    // Monitor ID/EX pipeline outputs for debugging
    always @(posedge Clk) begin
        $display("Time: %0dns | ID/EX: ALUOp=%b, RegWrite=%b, MemWrite=%b, MemRead=%b, MemToReg=%b, RegDst=%b, JSrc=%b",
                 $time,
                 uut.ID_EXRegFile.outALUOp,
                 uut.ID_EXRegFile.outRegWrite,
                 uut.ID_EXRegFile.outMemWrite,
                 uut.ID_EXRegFile.outMemRead,
                 uut.ID_EXRegFile.outMemToReg,
                 uut.ID_EXRegFile.outRegDst,
                 uut.ID_EXRegFile.outJSrc1);
    end

    // Run simulation for a set amount of time
    initial begin
        #10000;
    end

endmodule
