`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2024 07:55:48 PM
// Design Name: 
// Module Name: Control_tb
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
// 
//////////////////////////////////////////////////////////////////////////////////

module Control_tb;

    reg [31:0] Instruction;

    wire [4:0] ALUOp;
    wire [1:0] PCSrc, RegDst, MemToReg;
    wire ToBranch, ALUSrc, RegWrite, MemWrite, MemRead, ShiftA, MemByte, MemHalf, JorBranch;

    // instantiate the Control Unit
    Control uut (
        .Instruction(Instruction),
        .ALUOp(ALUOp),
        .PCSrc(PCSrc),
        .ToBranch(ToBranch),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemToReg(MemToReg),
        .ShiftA(ShiftA),
        .MemByte(MemByte),
        .MemHalf(MemHalf),
        .JorBranch(JorBranch)
    );

    // task to display control signals
    task display_control_signals;
        begin
            $display("Time: %0t", $time);
            $display("Instruction: %b", Instruction);
            $display("ALUOp: %b", ALUOp);
            $display("PCSrc: %b, ToBranch: %b", PCSrc, ToBranch);
            $display("RegDst: %b, ALUSrc: %b, RegWrite: %b", RegDst, ALUSrc, RegWrite);
            $display("MemWrite: %b, MemRead: %b, MemToReg: %b", MemWrite, MemRead, MemToReg);
            $display("ShiftA: %b, MemByte: %b, MemHalf: %b, JorBranch: %b", ShiftA, MemByte, MemHalf, JorBranch);
            $display("-----------------------------------------------------");
        end
    endtask

    // Test vectors
    initial begin
        // Test R-type instruction: add $t1, $t2, $t3
        // Opcode: 000000, rs: $t2 (01010), rt: $t3 (01011), rd: $t1 (01001), shamt: 00000, funct: 100000 (add)
        Instruction = 32'b000000_01010_01011_01001_00000_100000;
        #10;
        display_control_signals();

        // Test R-type instruction: sub $t1, $t2, $t3
        // funct: 100010
        Instruction = 32'b000000_01010_01011_01001_00000_100010;
        #10;
        display_control_signals();

        // Test R-type instruction: mul $t1, $t2, $t3
        // funct: 011000
        Instruction = 32'b000000_01010_01011_01001_00000_011000;
        #10;
        display_control_signals();

        // Test R-type instruction: jr $t1
        // Opcode: 000000, funct: 001000
        Instruction = 32'b000000_01001_00000_00000_00000_001000;
        #10;
        display_control_signals();

        // Test I-type instruction: addi $t1, $t2, 16
        // Opcode: 001000 (addi)
        Instruction = 32'b001000_01010_01001_0000000000010000;
        #10;
        display_control_signals();

        // Test I-type instruction: lw $t1, 0($t2)
        // Opcode: 100011 (lw)
        Instruction = 32'b100011_01010_01001_0000000000000000;
        #10;
        display_control_signals();

        // Test I-type instruction: sw $t1, 0($t2)
        // Opcode: 101011 (sw)
        Instruction = 32'b101011_01010_01001_0000000000000000;
        #10;
        display_control_signals();

        // Test I-type instruction: beq $t1, $t2, offset
        // Opcode: 000100 (beq)
        Instruction = 32'b000100_01001_01010_0000000000000100; // offset = 4
        #10;
        display_control_signals();

        // Test J-type instruction: j target
        // Opcode: 000010 (j)
        Instruction = 32'b000010_00000000000000000000010000; // address = 16
        #10;
        display_control_signals();

        // Test J-type instruction: jal target
        // Opcode: 000011 (jal)
        Instruction = 32'b000011_00000000000000000000010000; // address = 16
        #10;
        display_control_signals();

        // Test I-type instruction: andi $t1, $t2, 0xFFFF
        // Opcode: 001100 (andi)
        Instruction = 32'b001100_01010_01001_1111111111111111;
        #10;
        display_control_signals();

        // Test I-type instruction: ori $t1, $t2, 0x1234
        // Opcode: 001101 (ori)
        Instruction = 32'b001101_01010_01001_0001001000110100;
        #10;
        display_control_signals();

        // Test I-type instruction: xori $t1, $t2, 0xFFFF
        // Opcode: 001110 (xori)
        Instruction = 32'b001110_01010_01001_1111111111111111;
        #10;
        display_control_signals();

        // Test I-type instruction: slti $t1, $t2, 10
        // Opcode: 001010 (slti)
        Instruction = 32'b001010_01010_01001_0000000000001010;
        #10;
        display_control_signals();

        // Test R-type instruction: sll $t1, $t2, 4
        // Opcode: 000000, funct: 000000, shamt: 00100
        Instruction = 32'b000000_00000_01010_01001_00100_000000;
        #10;
        display_control_signals();

        // Test R-type instruction: srl $t1, $t2, 4
        // Opcode: 000000, funct: 000010, shamt: 00100
        Instruction = 32'b000000_00000_01010_01001_00100_000010;
        #10;
        display_control_signals();

        // Test R-type instruction: slt $t1, $t2, $t3
        // Opcode: 000000, funct: 101010
        Instruction = 32'b000000_01010_01011_01001_00000_101010;
        #10;
        display_control_signals();

        // Finish simulation
        $finish;
    end

endmodule
