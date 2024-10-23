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
output reg PCSrc, ToBranch, RegDst, ALUSrc, RegWrite, MemWrite, MemRead, MemToReg, ShiftA, MemByte, MemHalf, JorBranch;

always @(*) begin	
	
// R-type instructions
	if (Instruction[31:26] == 6'b000000) begin
		
		case (Instruction[5:0])
		
		// add --
		6'b100000: begin 
			ALUOp = 5'b00000;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
			ShiftA = 1'b0;
			MemByte = 1'b0;
			MemHalf = 1'b0;
			JorBranch = 1'b0;
		end

		// sub --
		6'b100010: begin
			ALUOp = 5'b00001;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
			ShiftA = 1'b0;
			MemByte = 1'b0;
			MemHalf = 1'b0;	
			JorBranch = 1'b0;		
		end

		// jr : possibly need to adjust datapath
		6'b001000: begin
			ALUOp = 5'b10000; // rs goes through alu
			ToBranch = 1'b1;
			RegDst = 1'b0; 
			ALUSrc = 1'b0;
			RegWrite = 1'b0;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			ShiftA = 1'b0;
			MemByte = 1'b0;
			MemHalf = 1'b0;
			JorBranch = 1'b1;
		end

		// and --
		6'b100100: begin
			ALUOp = 5'b00011;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
			ShiftA = 1'b0;
			MemByte = 1'b0;
			MemHalf = 1'b0;
			JorBranch = 1'b0;
		end

		// or --
		6'b100101: begin
			ALUOp = 5'b00100;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
			ShiftA = 1'b0;
			MemByte = 1'b0;
			MemHalf = 1'b0;
			JorBranch = 1'b0;
		end

		// nor --
		6'b100111: begin
			ALUOp = 5'b00101;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
			ShiftA = 1'b0;
			MemByte = 1'b0;
			MemHalf = 1'b0;
			JorBranch = 1'b0;
		end

		//xor --
		6'b100110: begin
			ALUOp = 5'b00110;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
			ShiftA = 1'b0;
			MemByte = 1'b0;
			MemHalf = 1'b0;
			JorBranch = 1'b0;
		end

		// sll -- mux and sign extend added to datapath
		6'b000000: begin
			ALUOp = 5'b00111;
			ToBranch = 1'b0;
			RegDst = 1'b0; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
			ShiftA = 1'b1;
			MemByte = 1'b0;
			MemHalf = 1'b0;
			JorBranch = 1'b0;
		end

		// srl --
		6'b000010: begin
			ALUOp = 5'b01000;
			ToBranch = 1'b0;
			RegDst = 1'b0; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
			ShiftA = 1'b1;
			MemByte = 1'b0;
			MemHalf = 1'b0;
			JorBranch = 1'b0;
		end

		// slt --
		6'b101010: begin
			ALUOp = 5'b01001;
			ToBranch = 1'b0;
			RegDst = 1'b1; 
			ALUSrc = 1'b0;
			RegWrite = 1'b1;
			MemWrite = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b1;
			ShiftA = 1'b0;
			MemByte = 1'b0;
			MemHalf = 1'b0;
			JorBranch = 1'b0;
		end

	endcase
end

// I-Type and J-Type instructions
	else begin

		case (Instruction[31:26])
		
			// addi --
			6'b001000: begin
				ALUOp = 5'b00000;
				ToBranch = 1'b0;
				RegDst = 1'b0; //rt is destination
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// lw --
			6'b100011: begin
				ALUOp = 5'b00000; // add 0
				ToBranch = 1'b0;
				RegDst = 1'b0; 
				ALUSrc = 1'b1; // add offset to base
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b1;
				MemToReg = 1'b0;
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// sw --
			6'b101011: begin
				ALUOp = 5'b00000;
				ToBranch = 1'b0;
				RegDst = 1'b0; 
				ALUSrc = 1'b1;
				RegWrite = 1'b0;
				MemWrite = 1'b1;
				MemRead = 1'b0;
				MemToReg = 1'b1; //don't care
				ShiftA = 1'b0; 
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// sb --
			6'b101000: begin
				ALUOp = 5'b00000;
				ToBranch = 1'b0;
				RegDst = 1'b1; // don't care
				ALUSrc = 1'b1;
				RegWrite = 1'b0;
				MemWrite = 1'b1;
				MemRead = 1'b0;
				MemToReg = 1'b1; // don't care
				ShiftA = 1'b0;
				MemByte = 1'b1;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// lb --
			6'b100000: begin
				ALUOp = 5'b00000;
				ToBranch = 1'b0;
				RegDst = 1'b0; 
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b1;
				MemToReg = 1'b0;
				ShiftA = 1'b0;
				MemByte = 1'b1;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// lh 
			6'b100001: begin
				ALUOp = 5'b00000;
				ToBranch = 1'b0;
				RegDst = 1'b0; 
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b1;
				MemToReg = 1'b0;
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b1;
				JorBranch = 1'b0;
			end
		
			// sh --
			6'b101001: begin
				ALUOp = 5'b00000;
				ToBranch = 1'b0;
				RegDst = 1'b1; //don't care
				ALUSrc = 1'b1;
				RegWrite = 1'b0;
				MemWrite = 1'b1;
				MemRead = 1'b0;
				MemToReg = 1'b1; // don't care
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b1;
				JorBranch = 1'b0;
			end

			// bgez --
			6'b000001: begin
				ALUOp = 5'b01110;
				ToBranch = 1'b1;
				RegDst = 1'b0;  // don't care
				ALUSrc = 1'b0;  // don't care
				RegWrite = 1'b0; 
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1; // don't care
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// beq --
			6'b000100: begin
				ALUOp = 5'b01011;
				ToBranch = 1'b1;
				RegDst = 1'b1; 	 // don't care
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1; // don't care
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// bne --
			6'b000101: begin
				ALUOp = 5'b01111;
				ToBranch = 1'b1;
				RegDst = 1'b1; //don't care
				ALUSrc = 1'b0; 
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1; // don't care
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// bgtz --
			6'b000111: begin
				ALUOp = 5'b01010;
				ToBranch = 1'b1;
				RegDst = 1'b1;   // don't care
				ALUSrc = 1'b0;	
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1; // don't care
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// blez --
			6'b000110: begin
				ALUOp = 5'b01101;
				ToBranch = 1'b1;
				RegDst = 1'b1;	// don't care 
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1; // don't care
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// bltz --
			6'b000001: begin
				ALUOp = 5'b01001;
				ToBranch = 1'b1;
				RegDst = 1'b0; //don't care 
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1; //don't care
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// andi --
			6'b001100: begin
				ALUOp = 5'b00011;
				ToBranch = 1'b0;
				RegDst = 1'b0; 
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// ori --
			6'b001101: begin
				ALUOp = 5'b00100;
				ToBranch = 1'b0;
				RegDst = 1'b0; 
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// xori --
			6'b001110: begin
				ALUOp = 5'b00110;
				ToBranch = 1'b0;
				RegDst = 1'b0; 
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// slti --
			6'b001010: begin
				ALUOp = 5'b01001;
				ToBranch = 1'b0;
				RegDst = 1'b0; 
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// j
			6'b000010: begin
				ALUOp = 5'b00000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

			// jal
			6'b000011: begin
				ALUOp = 5'b00000;
				ToBranch = 1'b0;
				RegDst = 1'b1; 
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				MemWrite = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
				ShiftA = 1'b0;
				MemByte = 1'b0;
				MemHalf = 1'b0;
				JorBranch = 1'b0;
			end

		endcase
	end
end


endmodule







