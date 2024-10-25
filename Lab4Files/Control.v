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
// ALUSrcA - When 0, take rs as A input to ALU, when 1, take imm field as A input to ALU
// ALUSrcB - determine if b source is imm or rt field
// RegWrite - enable/disable register write
// MemWrite - enable/disable memory write
// MemRead - enable/disable memory read
// MemToReg - write data register file source (load word from mem, or just take alu output)
// MemByte - sent to memory and determines if the memory accesses a byte or whole word
// MemHalf - sent to memory and determines if half or whole word
// JorBranch - for jr instruction, chooses value of register as PC input
//
// FUNCTIONALITY:-
// Given an instruction, determine the control signals that the datapath
// needs to set so the instruction and data is handled as needed
////////////////////////////////////////////////////////////////////////////////

module Control(Instruction, ALUOp, ToBranch, RegDst, ALUSrcA, ALUSrcB, RegWrite, MemWrite, MemRead, MemToReg, MemByte, MemHalf, JorBranch, JalSel);

input [31:0] Instruction;

output reg [4:0] ALUOp;
output reg ToBranch, RegWrite, MemWrite, MemRead, MemByte, MemHalf,  RegDst, JalSel, JorBranch;
output reg [1:0] ALUSrcA, ALUSrcB, MemToReg;

always @(*) begin	

       // default values to prevent latches
        ALUOp = 5'b00000;
        ToBranch = 1'b0;
        RegDst = 1'b0;
        ALUSrcA = 2'b00;
        ALUSrcB = 2'b00;
        RegWrite = 1'b0;
        MemWrite = 1'b0;
        MemRead = 1'b0;
        MemToReg = 2'b00;
        MemByte = 1'b0;
        MemHalf = 1'b0;
        JorBranch = 1'b0;
	    JalSel = 1'b0;
	
if (Instruction[31:26] == 6'b000000) begin

            // r-type instructions
            case (Instruction[5:0])
            
                // add --
                6'b100000: begin
                    ALUOp = 5'b00000;       // alu operation: add
                    ToBranch = 1'b0;        // not a branch instruction (PCSrc remains zero)
                    RegDst = 1'b1;         // write to rd (r-type instruction)
		    ALUSrcA = 2'b00;          // destination register not Instruction[10:6]
                    ALUSrcB = 2'b00;          // alu input b comes from register rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // alu output bypasses memory
                    MemByte = 1'b0;         // not a byte operation
                    MemHalf = 1'b0;         // not a half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;	    // zero UNLESS jal
                end
                
                // sub --
                6'b100010: begin
                    ALUOp = 5'b00001;       // alu operation: subtract
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b1;         // write to rd
                    ALUSrcA = 2'b00;          // destination register not Instruction[10:6]
                    ALUSrcB = 2'b00;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // write alu result to register
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // mul --
                6'b011000: begin
                    ALUOp = 5'b00010;       // alu operation: multiply
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b1;         // write to rd
                    ALUSrcA = 2'b00;          // destination register not Instruction[10:6]
                    ALUSrcB = 2'b00;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // bypass memory
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end

                // jr --
                6'b001000: begin
                    ALUOp = 5'b10000;       // alu passes rs
                    ToBranch = 1'b1;        // ToBranch is high so PC accepts input other than PC+4
                    RegDst = 1'b0;         // don't care
                    ALUSrcA = 2'b00;          // alu a input is rs
                    ALUSrcB = 2'b00;          // don't care
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b1;       // use rs from alu output for PC input
		    JalSel = 1'b0;
                end
                
                // and --
                6'b100100: begin
                    ALUOp = 5'b00011;       // alu operation: and
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b1;         // write to rd
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b00;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // bypass memory read
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // or --
                6'b100101: begin
                    ALUOp = 5'b00100;       // alu operation: or
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b1;         // write to rd
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b00;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // write alu result to register
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // nor --
                6'b100111: begin
                    ALUOp = 5'b00101;       // alu operation: nor
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b1;         // write to rd
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b00;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // write alu result to register
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // xor --
                6'b100110: begin
                    ALUOp = 5'b00110;       // alu operation: xor
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b1;         // write to rd
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b00;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // write alu result to register
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // sll --
                6'b000000: begin
                    ALUOp = 5'b00111;       // alu operation: shift left logical
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b1;         // write to rd
                    ALUSrcA = 2'b01;          // ALU A input is [10:6] sign extended
                    ALUSrcB = 2'b00;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // write alu result to register
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // srl --
                6'b000010: begin
                    ALUOp = 5'b01000;       // alu operation: shift right logical
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b1;         // write to rd
                    ALUSrcA = 2'b01;          // shift amount comes from shamt field
                    ALUSrcB = 2'b00;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // write alu result to register
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // slt --
                6'b101010: begin
                    ALUOp = 5'b01001;       // alu operation: set less than
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b1;         // write to rd
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b00;          // alu input b from rt
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // write alu result to register
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                default: begin
                // set control signals to default values or handle errors
                end
                
            endcase
        end else begin
        
            // i-type and j-type instructions
            case (Instruction[31:26])
                
                // addi --
                6'b001000: begin
                    ALUOp = 5'b00000;       // alu operation: add
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b0;         // write to rt
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b01;          // alu input b comes from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // write alu result to register
                    MemByte = 1'b0;         // not byte operation
                    MemHalf = 1'b0;         // not half-word operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // lw --
                6'b100011: begin
                    ALUOp = 5'b00000;       // alu operation: add (for address calculation)
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b0;         // write to rt
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b01;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b1;         // enable memory read
                    MemToReg = 2'b00;       // 0 = memory output goes to register file input
                    MemByte = 1'b0;         // access full word
                    MemHalf = 1'b0;         // access full word
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // sw --
                6'b101011: begin
                    ALUOp = 5'b00000;       // alu operation: add (for address calculation)
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b0;         // don't care
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b01;          // alu input b from immediate
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b1;        // enable memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    MemByte = 1'b0;         // write full word
                    MemHalf = 1'b0;         // write full word
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // lb --
                6'b100000: begin
                    ALUOp = 5'b00000;       // alu operation: add (for address calculation)
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b0;         // write to rt
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b01;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b1;         // enable memory read
                    MemToReg = 2'b00;       // write memory data to register
                    MemByte = 1'b1;         // access last byte only
                    MemHalf = 1'b0;         // not half-word
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // sb --
                6'b101000: begin
                    ALUOp = 5'b00000;       // alu operation: add (for address calculation)
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b0;         // don't care
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b01;          // alu input b from immediate
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b1;        // enable memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    MemByte = 1'b1;         // write byte
                    MemHalf = 1'b0;         // not half-word
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // lh --
                6'b100001: begin
                    ALUOp = 5'b00000;       // alu operation: add (for address calculation)
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b0;         // write to rt
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b01;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b1;         // enable memory read
                    MemToReg = 2'b00;       // write data = memory output
                    MemByte = 1'b0;         // not byte
                    MemHalf = 1'b1;         // access half-word
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // sh --
                6'b101001: begin
                    ALUOp = 5'b00000;       // alu operation: add (for address calculation)
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b0;         // don't care
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b01;          // alu input b from immediate
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b1;        // enable memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    MemByte = 1'b0;         // not byte
                    MemHalf = 1'b1;         // write half-word
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // beq --
                6'b000100: begin
                    ALUOp = 5'b01011;       // alu operation: subtract for comparison
                    ToBranch = 1'b1;        // branch instruction
                    RegDst = 1'b0;         // don't care
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b00;          // alu input b from register rt
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump, so PC+4 + (offset << 2) input to PC
		    JalSel = 1'b0;
                end
                
                // bne --
                6'b000101: begin
                    ALUOp = 5'b01111;       // alu operation: compare not equal
                    ToBranch = 1'b1;        // branch instruction
                    RegDst = 1'b0;         // don't care
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b00;          // alu input b from register rt
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump register
		    JalSel = 1'b0;
                end
                
                // blez --
                6'b000110: begin
                    ALUOp = 5'b10001;       // alu operation: BLEZ (unique to this instruction)
                    ToBranch = 1'b1;        // branch instruction
                    RegDst = 1'b0;         // don't care
                    ALUSrcA = 2'b00;         // A input is rs
                    ALUSrcB = 2'b00;         // don't care
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // choose branch, if condition met, pcsrc = 1 and branches, otherwise pc input is pc + 4
		    JalSel = 1'b0;
                end
                
                // bgtz --
                6'b000111: begin
                    ALUOp = 5'b10010;       // alu operation: BGTZ
                    ToBranch = 1'b1;        // branch instruction
                    RegDst = 1'b0;         // don't care
                    ALUSrcA = 2'b00;         // Source A is rs
                    ALUSrcB = 2'b00;         // don't care
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump register
		    JalSel = 1'b0;
                end
                
                // bltz and bgez --
                6'b000001: begin
                    if (Instruction[20:16] == 5'b00000) begin
                        // bltz
                        ALUOp = 5'b01110;   // alu operation: BLTZ
                        ToBranch = 1'b1;    // branch instruction
                    end else if (Instruction[20:16] == 5'b00001) begin
                        // bgez
                        ALUOp = 5'b10011;   // alu operation: branch if greater than or equal to zero
                        ToBranch = 1'b1;    // branch instruction
                    end
                    RegDst = 1'b0;         // don't care
                    ALUSrcA = 2'b00;         // A source is rs register
                    ALUSrcB = 2'b00;         // don't care
                    RegWrite = 1'b0;        // no register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b00;       // don't care
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump register
		    JalSel = 1'b0;
                end
                
                // andi --
                6'b001100: begin
                    ALUOp = 5'b00011;       // alu operation: and
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b0;         // write to rt
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b01;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // write alu result to register
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // ori --
                6'b001101: begin
                    ALUOp = 5'b00100;       // alu operation: or
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b0;         // write to rt
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b01;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // write alu result to register
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // xori --
                6'b001110: begin
                    ALUOp = 5'b00110;       // alu operation: xor immediate
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b0;         // write to rt
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b01;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // write alu result to register
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // slti --
                6'b001010: begin
                    ALUOp = 5'b01001;       // alu operation: set less than
                    ToBranch = 1'b0;        // not a branch
                    RegDst = 1'b0;         // write to rt
                    ALUSrcA = 2'b00;          // no shift
                    ALUSrcB = 2'b01;          // alu input b from immediate
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b01;       // write alu result to register
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b0;       // not a jump or branch
		    JalSel = 1'b0;
                end
                
                // j --
                6'b000010: begin
                    ALUOp = 5'b10100;       // calculate the jump address
                    ToBranch = 1'b1;        // PCSrc = 1
                    RegDst = 1'b0;         // don't care
                    ALUSrcA = 2'b10;          // Source A is PC output
                    ALUSrcB = 2'b10;          // Source B is instruction left shifted twice
                    RegWrite = 1'b0;        // don't care
                    MemWrite = 1'b0;        // don't care
                    MemRead = 1'b0;         // don't care
                    MemToReg = 2'b00;       // don't care
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b1;       // take ALU output as PC input
		    JalSel = 1'b0;
                end
                
                // jal --
                6'b000011: begin
                    ALUOp = 5'b10100;       // calculate the jump address
                    ToBranch = 1'b1;        // PCSrc = 1
                    RegDst = 1'b0;         // don't care
                    ALUSrcA = 2'b10;          // Source A is PC output
                    ALUSrcB = 2'b10;          // Source B is instruction left shifted twice
                    RegWrite = 1'b1;        // enable register write
                    MemWrite = 1'b0;        // no memory write
                    MemRead = 1'b0;         // no memory read
                    MemToReg = 2'b10;       // only time this is 2, passes PC + 4 to WriteData on Registers
                    MemByte = 1'b0;         // not memory operation
                    MemHalf = 1'b0;         // not memory operation
                    JorBranch = 1'b1;       // use alu output as pc input
		    JalSel = 1'b1;		// only instruction to have this as 1
                end
                
                default: begin
                // set control signals to default values or handle errors        ALUOp = 5'b00000;
        		ToBranch = 1'b0;
        		RegDst = 1'b0;
        		ALUSrcA = 2'b00;
        		ALUSrcB = 2'b00;
        		RegWrite = 1'b0;
        		MemWrite = 1'b0;
        		MemRead = 1'b0;
        		MemToReg = 2'b00;
        		MemByte = 1'b0;
        		MemHalf = 1'b0;
        		JorBranch = 1'b0;
			JalSel = 1'b0;
                end
                
            endcase
        end

    end

endmodule