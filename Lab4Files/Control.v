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
//
// FUNCTIONALITY:-
// Given an instruction, determine the control signals that the datapath
// needs to set so the instruction and data is handled as needed
////////////////////////////////////////////////////////////////////////////////

module Control(Instruction, ALUOp, PCSrc, ToBranch, RegDst, ALUSrc, RegWrite, MemWrite, MemRead, MemToReg);

input [31:0] Instruction;

output [3:0] ALUOp;
output PCSrc, ToBranch, RegDst, ALUSrc, RegWrite, MemWrite, MemRead, MemToReg;

always @(*) begin	
	
// R-type instructions
	if (Instruction[31:26] == 6'b000000) begin
		
		case (Instruction[5:0])
		
		// add --
		6'b100000: begin 
			ALUOp = 4'b0000;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
		end

		// sub
		6'b100010: begin
			ALUOp = 4'b0000;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
		end

		// jr
		6'b001000: begin
			ALUOp = 4'b0000;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
		end

		//and
		6'100100: begin
			ALUOp = 4'b0000;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
		end

		6'b100101: begin
			ALUOp = 4'b0000;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
		end

		//nor
		6'b100111: begin
			ALUOp = 4'b0000;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
		end

		//xor
		6'b100110: begin
			ALUOp = 4'b0000;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
		end

		// sll
		6'b000000: begin
			ALUOp = 4'b0000;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
		end

		// srl
		6'b000010: begin
			ALUOp = 4'b0000;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
		end

		// slt
		6'b101010: begin
			ALUOp = 4'b0000;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
		end

	endcase

// I-Type and J-Type instructions
	else begin

		case (Instruction[31:26]) begin
		
			// addi
			6'b001000: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// lw
			6'b100011 begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// sw
			6'b101011: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// sb
			6'b101000: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// lb
			6'b100000: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// lh
			6'b100001: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end
		
			// sh
			6'b101001: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// bgez
			6'b000001: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// beq
			6'b000100: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// bne
			6'b000101: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// bgtz
			6'b000111: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// blez
			6'b000110: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// bltz
			6'b000001: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// andi
			6'b001100: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// ori
			6'b001101: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// xori
			6'b001110: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// slti
			6'b001010: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// j
			6'b000010: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

			// jal
			6'b000011: begin
				ALUOp = 4'b0000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
			end

		endcase
	end



endmodule







