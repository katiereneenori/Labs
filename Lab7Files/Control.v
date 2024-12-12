`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Control.v - Control module for the datapath.
//
// Make sure this file contains NO extra logic after the endmodule line.
//
// Changes made:
// - Removed duplicated logic after the endmodule.
// - Confirmed signals are only set for appropriate instructions.
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
    output reg JalSel,
    output reg JSrc,
    output reg JRSelect
);

    always @(*) begin
        // Default values
        ALUOp = 5'b00000;
        ToBranch = 1'b0;
        RegDst = 1'b0;
        ALUSrcA = 2'b00;
        ALUSrcB = 2'b00;
        RegWrite = 1'b0;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        MemByte = 1'b0;
        MemHalf = 1'b0;
        JorBranch = 1'b0;
        JalSel = 1'b0;
        JSrc = 1'b0;
        JRSelect = 1'b0;
        MemToReg = 2'b01; // Default: ALU result to register (for R-type, etc.)

        if (Instruction == 32'b0) begin
            // NOP: do nothing
        end else if (Instruction[31:26] == 6'b000000) begin
            // R-type
            case (Instruction[5:0])
                6'b100000: begin // ADD
                    ALUOp = 5'b00000;
                    RegDst = 1'b1;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b100010: begin // SUB
                    ALUOp = 5'b00001;
                    RegDst = 1'b1;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b011000: begin // MUL
                    ALUOp = 5'b00010;
                    RegDst = 1'b1;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b100100: begin // AND
                    ALUOp = 5'b00011;
                    RegDst = 1'b1;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b100101: begin // OR
                    ALUOp = 5'b00100;
                    RegDst = 1'b1;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b100111: begin // NOR
                    ALUOp = 5'b00101;
                    RegDst = 1'b1;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b100110: begin // XOR
                    ALUOp = 5'b00110;
                    RegDst = 1'b1;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b000000: begin // SLL
                    ALUOp = 5'b00111;
                    RegDst = 1'b1;
                    ALUSrcA = 2'b01;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b000010: begin // SRL
                    ALUOp = 5'b01000;
                    RegDst = 1'b1;
                    ALUSrcA = 2'b01;
                    ALUSrcB = 2'b10;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b101010: begin // SLT
                    ALUOp = 5'b01001;
                    RegDst = 1'b1;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b001000: begin // JR
                    ALUOp = 5'b10000;
                    JorBranch = 1'b1;
                    JSrc = 1'b1;
                    JRSelect = 1'b1;
                end
                default: begin
                    // Unsupported R-type instruction
                end
            endcase
        end else begin
            // I-type / J-type
            case (Instruction[31:26])
                6'b001000: begin // ADDI
                    ALUOp = 5'b00000;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b001100: begin // ANDI
                    ALUOp = 5'b00011;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b001101: begin // ORI
                    ALUOp = 5'b00100;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b001110: begin // XORI
                    ALUOp = 5'b00110;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b001010: begin // SLTI
                    ALUOp = 5'b01001;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                    MemToReg = 2'b01;
                end
                6'b100011: begin // LW
                    ALUOp = 5'b00000;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                    MemRead = 1'b1;
                    MemToReg = 2'b00;
                end
                6'b101011: begin // SW
                    ALUOp = 5'b00000;
                    ALUSrcB = 2'b01;
                    MemWrite = 1'b1;
                end
                6'b100000: begin // LB
                    ALUOp = 5'b00000;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                    MemRead = 1'b1;
                    MemByte = 1'b1;
                    MemToReg = 2'b00;
                end
                6'b101000: begin // SB
                    ALUOp = 5'b00000;
                    ALUSrcB = 2'b01;
                    MemWrite = 1'b1;
                    MemByte = 1'b1;
                end
                6'b100001: begin // LH
                    ALUOp = 5'b00000;
                    ALUSrcB = 2'b01;
                    RegWrite = 1'b1;
                    MemRead = 1'b1;
                    MemHalf = 1'b1;
                    MemToReg = 2'b00;
                end
                6'b101001: begin // SH
                    ALUOp = 5'b00000;
                    ALUSrcB = 2'b01;
                    MemWrite = 1'b1;
                    MemHalf = 1'b1;
                end
                6'b000100: begin // BEQ
                    ALUOp = 5'b00001;
                    ToBranch = 1'b1;
                end
                6'b000101: begin // BNE
                    ALUOp = 5'b01111;
                    ToBranch = 1'b1;
                end
                6'b000111: begin // BGTZ
                    ALUOp = 5'b10010;
                    ToBranch = 1'b1;
                    ALUSrcB = 2'b11;
                end
                6'b000110: begin // BLEZ
                    ALUOp = 5'b10001;
                    ToBranch = 1'b1;
                    ALUSrcB = 2'b11;
                end
                6'b000001: begin // BLTZ/BGEZ
                    ToBranch = 1'b1;
                    ALUSrcB = 2'b11;
                    if (Instruction[20:16] == 5'b00000) begin
                        // BLTZ
                        ALUOp = 5'b01110;
                    end else if (Instruction[20:16] == 5'b00001) begin
                        // BGEZ
                        ALUOp = 5'b10011;
                    end
                end
                6'b000010: begin // J
                    ALUOp = 5'b10100;
                    ALUSrcA = 2'b10;
                    ALUSrcB = 2'b10;
                    JorBranch = 1'b1;
                    JSrc = 1'b1;
                end
                6'b000011: begin // JAL
                    ALUOp = 5'b10100;
                    ALUSrcA = 2'b10;
                    ALUSrcB = 2'b10;
                    RegWrite = 1'b1;
                    MemToReg = 2'b10;
                    JalSel = 1'b1;
                    JorBranch = 1'b1;
                    JSrc = 1'b1;
                end
                // Custom branches
                6'b110000: begin // BGE
                    ALUOp = 5'b10101;
                    ToBranch = 1'b1;
                end
                6'b110001: begin // BLE
                    ALUOp = 5'b10110;
                    ToBranch = 1'b1;
                end
                6'b110011: begin // BLT
                    ALUOp = 5'b10111;
                    ToBranch = 1'b1;
                end
                6'b110100: begin // BGT
                    ALUOp = 5'b11000;
                    ToBranch = 1'b1;
                end
                default: begin
                    // Unsupported I/J instruction
                end
            endcase
        end
    end
endmodule
