`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Control.v
// Description - Control module for datapath
//
// INPUTS:-
// 32-bit instruction
//
// OUTPUTS:-
// PCSrc - Fed into mux to determine source for PC
// ToBranch - Fed into and gate called branch
// RegDst - fed into mux to determine write register source
// ALUOp - determines the operation of the ALU
// ALUSrc - fed into mux to determine source register for ALU
// RegWrite - enable/disable register write
// MemWrite - enable/disable memory write
// MemRead - enable/disable memory read
// MemToReg - write data register file source (load word from mem, or just take alu output)
// ShiftA - When the shift functions are called, takes the imm field as ALU a input
// MemByte - sent to memory and determines if the memory accesses a byte or whole word
// MemHalf - sent to memory and determines if half or whole word
// JorBranch - for jr instruction, chooses value of register as PC input
//
// FUNCTIONALITY:-
// Given an instruction, determine the control signals that the datapath
// needs to set so the instruction and data is handled as needed
////////////////////////////////////////////////////////////////////////////////

module Control(Instruction, ALUOp, PCSrc, ToBranch, RegDst, ALUSrc, RegWrite, MemWrite, MemRead, MemToReg, ShiftA, MemByte, MemHalf, JorBranch);

input [31:0] Instruction;

output reg [4:0] ALUOp;
output reg ToBranch, ALUSrc, RegWrite, MemWrite, MemRead, ShiftA, MemByte, MemHalf, JorBranch;
output reg [1:0] PCSrc, RegDst, MemToReg;

always @(*) begin	

       // default values to prevent latches
        ALUOp = 5'b00000;
        PCSrc = 2'b00;
        ToBranch = 1'b0;
        RegDst = 2'b00;
        ALUSrc = 1'b0;
        RegWrite = 1'b0;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        MemToReg = 2'b00;
        ShiftA = 1'b0;
        MemByte = 1'b0;
        MemHalf = 1'b0;
        JorBranch = 1'b0;
	
if (Instruction[31:26] == 6'b000000) begin

            // r-type instructions
            case (Instruction[5:0])
            
                // add
                6'b100000: begin
                    ALUOp = 5'b00000;       // alu operation: add
                    PCSrc = 2'b00;          // next pc is pc + 4 (sequential execution)
                    ToBranch = 1'b0;        // not a branch instruction
                    RegDst = 2'b01;         // write to rd (r-type instruction)
                    ALUSrc = 1'b0;          // alu input b comes from register rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift operation
                    MemByte = 1'b0;         // not a byte operation
                    MemHalf = 1'b0;         // not a half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // sub
                6'b100010: begin
                    ALUOp = 5'b00001;       // alu operation: subtract
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b01;         // write to rd
                    ALUSrc = 1'b0;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // mul
                6'b011000: begin
                    ALUOp = 5'b00010;       // alu operation: multiply
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b01;         // write to rd
                    ALUSrc = 1'b0;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
                end

                // jr
                6'b001000: begin
                    ALUOp = 5'b10000;       // alu passes rs if needed
                    PCSrc = 2'b11;          // pc comes from register rs
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // don't care
                    ALUSrc = 1'b0;          // don't care
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b1;       // use register value for pc
                end
                
                // and
                6'b100100: begin
                    ALUOp = 5'b00011;       // alu operation: and
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b01;         // write to rd
                    ALUSrc = 1'b0;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // or
                6'b100101: begin
                    ALUOp = 5'b00100;       // alu operation: or
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b01;         // write to rd
                    ALUSrc = 1'b0;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // nor
                6'b100111: begin
                    ALUOp = 5'b00101;       // alu operation: nor
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b01;         // write to rd
                    ALUSrc = 1'b0;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // xor
                6'b100110: begin
                    ALUOp = 5'b00110;       // alu operation: xor
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b01;         // write to rd
                    ALUSrc = 1'b0;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // sll
                6'b000000: begin
                    ALUOp = 5'b00111;       // alu operation: shift left logical
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b01;         // write to rd
                    ALUSrc = 1'b0;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b1;          // shift amount comes from shamt field
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // srl
                6'b000010: begin
                    ALUOp = 5'b01000;       // alu operation: shift right logical
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b01;         // write to rd
                    ALUSrc = 1'b0;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b1;          // shift amount comes from shamt field
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // slt
                6'b101010: begin
                    ALUOp = 5'b01001;       // alu operation: set less than
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b01;         // write to rd
                    ALUSrc = 1'b0;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                default: begin
                // set control signals to default values or handle errors
                end
                
            endcase
        end else begin
        
            // i-type and j-type instructions
            case (Instruction[31:26])
                
                // addi
                6'b001000: begin
                    ALUOp = 5'b00000;       // alu operation: add
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // write to rt
                    ALUSrc = 1'b1;          // alu input b comes from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // lw
                6'b100011: begin
                    ALUOp = 5'b00000;       // alu operation: add (for address calculation)
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // write to rt
                    ALUSrc = 1'b1;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b1;         // enable memory read
                    MemToReg = 2'b01;       // write memory data to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // access full word
                    MemHalf = 1'b0;         // access full word
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // sw
                6'b101011: begin
                    ALUOp = 5'b00000;       // alu operation: add (for address calculation)
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // don't care
                    ALUSrc = 1'b1;          // alu input b from immediate
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b1;        // enable memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // write full word
                    MemHalf = 1'b0;         // write full word
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // lb
                6'b100000: begin
                    ALUOp = 5'b00000;       // alu operation: add (for address calculation)
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // write to rt
                    ALUSrc = 1'b1;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b1;         // enable memory read
                    MemToReg = 2'b01;       // write memory data to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b1;         // access byte
                    MemHalf = 1'b0;         // not half-word
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // sb
                6'b101000: begin
                    ALUOp = 5'b00000;       // alu operation: add (for address calculation)
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // don't care
                    ALUSrc = 1'b1;          // alu input b from immediate
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b1;        // enable memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b1;         // write byte
                    MemHalf = 1'b0;         // not half-word
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // lh
                6'b100001: begin
                    ALUOp = 5'b00000;       // alu operation: add (for address calculation)
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // write to rt
                    ALUSrc = 1'b1;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b1;         // enable memory read
                    MemToReg = 2'b01;       // write memory data to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not byte
                    MemHalf = 1'b1;         // access half-word
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // sh
                6'b101001: begin
                    ALUOp = 5'b00000;       // alu operation: add (for address calculation)
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // don't care
                    ALUSrc = 1'b1;          // alu input b from immediate
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b1;        // enable memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not byte
                    MemHalf = 1'b1;         // write half-word
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // beq
                6'b000100: begin
                    ALUOp = 5'b01011;       // alu operation: subtract for comparison
                    PCSrc = 2'b01;          // pc may change to branch address
                    ToBranch = 1'b1;        // branch instruction
                    RegDst = 2'b00;         // don't care
                    ALUSrc = 1'b0;          // alu input b from register rt
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump register
                end
                
                // bne
                6'b000101: begin
                    ALUOp = 5'b01111;       // alu operation: compare not equal
                    PCSrc = 2'b01;          // pc may change to branch address
                    ToBranch = 1'b1;        // branch instruction
                    RegDst = 2'b00;         // don't care
                    ALUSrc = 1'b0;          // alu input b from register rt
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump register
                end
                
                // blez
                6'b000110: begin
                    ALUOp = 5'b01101;       // alu operation: branch if less than or equal to zero
                    PCSrc = 2'b01;          // pc may change to branch address
                    ToBranch = 1'b1;        // branch instruction
                    RegDst = 2'b00;         // don't care
                    ALUSrc = 1'b0;          // alu input b from register rt
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump register
                end
                
                // bgtz
                6'b000111: begin
                    ALUOp = 5'b01010;       // alu operation: branch if greater than zero
                    PCSrc = 2'b01;          // pc may change to branch address
                    ToBranch = 1'b1;        // branch instruction
                    RegDst = 2'b00;         // don't care
                    ALUSrc = 1'b0;          // alu input b from register rt
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump register
                end
                
                // bltz and bgez
                6'b000001: begin
                    if (Instruction[20:16] == 5'b00000) begin
                        // bltz
                        ALUOp = 5'b01100;   // alu operation: branch if less than zero
                        PCSrc = 2'b01;      // pc may change to branch address
                        ToBranch = 1'b1;    // branch instruction
                    end else if (Instruction[20:16] == 5'b00001) begin
                        // bgez
                        ALUOp = 5'b01101;   // alu operation: branch if greater than or equal to zero
                        PCSrc = 2'b01;      // pc may change to branch address
                        ToBranch = 1'b1;    // branch instruction
                    end
                    RegDst = 2'b00;         // don't care
                    ALUSrc = 1'b0;          // alu input b from register rt
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump register
                end
                
                // andi
                6'b001100: begin
                    ALUOp = 5'b00011;       // alu operation: and immediate
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // write to rt
                    ALUSrc = 1'b1;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // ori
                6'b001101: begin
                    ALUOp = 5'b00100;       // alu operation: or immediate
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // write to rt
                    ALUSrc = 1'b1;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // xori
                6'b001110: begin
                    ALUOp = 5'b00110;       // alu operation: xor immediate
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // write to rt
                    ALUSrc = 1'b1;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // slti
                6'b001010: begin
                    ALUOp = 5'b01001;       // alu operation: set less than immediate
                    PCSrc = 2'b00;          // sequential execution
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // write to rt
                    ALUSrc = 1'b1;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // write alu result to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump or branch
                end
                
                // j
                6'b000010: begin
                    ALUOp = 5'b00000;       // irrelevant for jump
                    PCSrc = 2'b10;          // pc comes from jump address
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b00;         // don't care
                    ALUSrc = 1'b0;          // irrelevant
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump register
                end
                
                // jal
                6'b000011: begin
                    ALUOp = 5'b00000;       // irrelevant for jal
                    PCSrc = 2'b10;          // pc comes from jump address
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 2'b10;         // write to $ra (register 31)
                    ALUSrc = 1'b0;          // irrelevant
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b10;       // write pc + 4 to register
                    ShiftA = 1'b0;          // no shift
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump register
                end
                
                default: begin
                // set control signals to default values or handle errors
                end
                
            endcase
        end

    end

endmodule