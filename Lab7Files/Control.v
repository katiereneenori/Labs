`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// Module - Control.v
// Description - Control module for the datapath.
//
// INPUTS:-
// Instruction: 32-bit instruction.
//
// OUTPUTS:-
// ALUOp: Determines the operation of the ALU.
// ToBranch: Control signal for branching.
// RegDst: Determines the destination register for writes.
// ALUSrcA: Selects the ALU A input source.
// ALUSrcB: Selects the ALU B input source.
// RegWrite: Enables/disables register write.
// MemWrite: Enables/disables memory write.
// MemRead: Enables/disables memory read.
// MemToReg: Selects the data source for writing to the register file.
// MemByte: Determines if memory access is byte-wide.
// MemHalf: Determines if memory access is half-word-wide.
// JorBranch: Selects the source for the next PC value.
// JalSel: Selects the destination register for JAL instruction.
//
// FUNCTIONALITY:-
// Given an instruction, the module sets the control signals required by the datapath
// to correctly execute the instruction.
////////////////////////////////////////////////////////////////////////////////

module Control(
    input [31:0] Instruction,
    input ControlHazard,
    output reg [4:0] ALUOp,
    output reg ToBranch,
    output reg RegDst,
    output reg [1:0] ALUSrcA,
    output reg [1:0] ALUSrcB,
    output reg RegWrite,
    output reg MemWrite,
    output reg MemRead,
    output reg [1:0] MemToReg,
    output reg MemByte,
    output reg MemHalf,
    output reg JorBranch,
    output reg JalSel
);

    always @(*) begin
        // Default values to prevent latches and unintended operations
        ALUOp = 5'b00000;
        ToBranch = 1'b0;
        RegDst = 1'b0;
        ALUSrcA = 2'b00;
        ALUSrcB = 2'b00;
        RegWrite = 1'b0;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        MemToReg = 2'b01;  // Default to ALU result
        MemByte = 1'b0;
        MemHalf = 1'b0;
        JorBranch = 1'b0;
        JalSel = 1'b0;
        
    if (ControlHazard) begin
        // Hazard detected: Insert a bubble by setting control signals to zero
        ALUOp = 5'b00000;
        ToBranch = 1'b0;
        RegDst = 1'b0;
        ALUSrcA = 2'b00;
        ALUSrcB = 2'b00;
        RegWrite = 1'b0;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        MemToReg = 2'b01;
        MemByte = 1'b0;
        MemHalf = 1'b0;
        JorBranch = 1'b0;
        JalSel = 1'b0;  // Explicitly reset JalSel
    end else if (Instruction == 32'b0) begin
            // NOP detected; ensure no operation occurs
            // All control signals remain at their default safe values
            // RegWrite, MemWrite, MemRead are deasserted
        end else if (Instruction[31:26] == 6'b000000) begin
            // R-type instructions
            case (Instruction[5:0])
                // ADD
                6'b100000: begin
                    ALUOp = 5'b00000;
                    RegDst = 1'b1;
                    ALUSrcA = 2'b00;  // rs
                    ALUSrcB = 2'b00;  // rt
                    RegWrite = 1'b1;
                end
                // SUB
                6'b100010: begin
                    ALUOp = 5'b00001;
                    RegDst = 1'b1;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b00;
                    RegWrite = 1'b1;
                end
                // MUL
                6'b011000: begin
                    ALUOp = 5'b00010;
                    RegDst = 1'b1;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b00;
                    RegWrite = 1'b1;
                end
                // AND
                6'b100100: begin
                    ALUOp = 5'b00011;
                    RegDst = 1'b1;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b00;
                    RegWrite = 1'b1;
                end
                // OR
                6'b100101: begin
                    ALUOp = 5'b00100;
                    RegDst = 1'b1;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b00;
                    RegWrite = 1'b1;
                end
                // NOR
                6'b100111: begin
                    ALUOp = 5'b00101;
                    RegDst = 1'b1;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b00;
                    RegWrite = 1'b1;
                end
                // XOR
                6'b100110: begin
                    ALUOp = 5'b00110;
                    RegDst = 1'b1;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b00;
                    RegWrite = 1'b1;
                end
                // SLL
                6'b000000: begin
                    ALUOp = 5'b00111;
                    RegDst = 1'b1;
                    ALUSrcA = 2'b01;  // rt
                    ALUSrcB = 2'b10;  // shamt
                    RegWrite = 1'b1;
                end
                // SRL
                6'b000010: begin
                    ALUOp = 5'b01000;
                    RegDst = 1'b1;
                    ALUSrcA = 2'b01;  // rt
                    ALUSrcB = 2'b10;  // shamt
                    RegWrite = 1'b1;
                end
                // SLT
                6'b101010: begin
                    ALUOp = 5'b01001;
                    RegDst = 1'b1;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b00;
                    RegWrite = 1'b1;
                end
                // JR
                6'b001000: begin
                    ALUOp = 5'b10000;
                    ToBranch = 1'b1;
                    ALUSrcA = 2'b00;  // rs
                    JorBranch = 1'b1;
                end
                default: begin
                    // Unsupported R-type instruction
                    // All control signals remain at default values
                end
            endcase
        end else begin
            // I-type and J-type instructions
            case (Instruction[31:26])
                // ADDI
                6'b001000: begin
                    ALUOp = 5'b00000;
                    RegDst = 1'b0;  // rt
                    ALUSrcA = 2'b00;  // rs
                    ALUSrcB = 2'b01;  // immediate
                    RegWrite = 1'b1;
                end
                // ANDI
                6'b001100: begin
                    ALUOp = 5'b00011;
                    RegDst = 1'b0;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                end
                // ORI
                6'b001101: begin
                    ALUOp = 5'b00100;
                    RegDst = 1'b0;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                // XORI
                6'b001110: begin
                    ALUOp = 5'b00110;
                    RegDst = 1'b0;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                end
                // SLTI
                6'b001010: begin
                    ALUOp = 5'b01001;
                    RegDst = 1'b0;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                end
                // LW
                6'b100011: begin
                    ALUOp = 5'b00000;  // ADD
                    RegDst = 1'b0;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                    MemRead = 1'b1;
                    MemToReg = 2'b00;  // Memory data
                end
                // SW
                6'b101011: begin
                    ALUOp = 5'b00000;  // ADD
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b01;
                    MemWrite = 1'b1;
                end
                // LB
                6'b100000: begin
                    ALUOp = 5'b00000;  // ADD
                    RegDst = 1'b0;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                    MemRead = 1'b1;
                    MemToReg = 2'b00;  // Memory data
                    MemByte = 1'b1;
                end
                // SB
                6'b101000: begin
                    ALUOp = 5'b00000;  // ADD
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b01;
                    MemWrite = 1'b1;
                    MemByte = 1'b1;
                end
                // LH
                6'b100001: begin
                    ALUOp = 5'b00000;  // ADD
                    RegDst = 1'b0;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                    MemRead = 1'b1;
                    MemToReg = 2'b00;
                    MemHalf = 1'b1;
                end
                // SH
                6'b101001: begin
                    ALUOp = 5'b00000;  // ADD
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b01;
                    MemWrite = 1'b1;
                    MemHalf = 1'b1;
                end
                // BEQ
                6'b000100: begin
                    ALUOp = 5'b00001;  // SUBTRACT
                    ToBranch = 1'b1;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b00;
                end
                // BNE
                6'b000101: begin
                    ALUOp = 5'b00001;  // SUBTRACT
                    ToBranch = 1'b1;
                    ALUSrcA = 2'b00;
                    ALUSrcB = 2'b00;
                end
                // BGTZ
                6'b000111: begin
                    ALUOp = 5'b10010;  // BGTZ operation code
                    ToBranch = 1'b1;
                    ALUSrcA = 2'b00;    // rs
                    ALUSrcB = 2'b11;    // Zero
                end
                // BLEZ
                6'b000110: begin
                    ALUOp = 5'b10001;  // BLEZ operation code
                    ToBranch = 1'b1;
                    ALUSrcA = 2'b00;    // rs
                    ALUSrcB = 2'b11;    // Zero
                end
                // BLTZ and BGEZ (opcode 6'b000001)
                6'b000001: begin
                    ToBranch = 1'b1;
                    ALUSrcA = 2'b00;  // rs
                    ALUSrcB = 2'b11;  // Zero
                    if (Instruction[20:16] == 5'b00000) begin
                        // BLTZ
                        ALUOp = 5'b01110;  // BLTZ operation code
                    end else if (Instruction[20:16] == 5'b00001) begin
                        // BGEZ
                        ALUOp = 5'b10011;  // BGEZ operation code
                    end else begin
                        // Unsupported branch type
                    end
                end
                // J
                6'b000010: begin
                    ALUOp = 5'b10100;
                    ToBranch = 1'b1;
                    ALUSrcA = 2'b10;  // PC
                    ALUSrcB = 2'b10;  // jump address
                    JorBranch = 1'b1;
                end
                // JAL
                6'b000011: begin
                    ALUOp = 5'b10100;
                    ToBranch = 1'b1;
                    ALUSrcA = 2'b10;
                    ALUSrcB = 2'b11;
                    RegWrite = 1'b1;
                    MemToReg = 2'b10;  // PC+4
                    JalSel = 1'b1;      // Write to $ra
                    JorBranch = 1'b1;
                end
                default: begin
                    // Unsupported I-type or J-type instruction
                    // All control signals remain at default values
                end
            endcase
        end
    end

endmodule