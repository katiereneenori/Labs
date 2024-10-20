`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [3:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
				//
				// for ISA: need:
				// add, sub, set less than (compare), and, or, nor, xor, shift left, shift right, multiply
	input [31:0] A, B;	    // inputs

	output [31:0] ALUResult;	// answer
	output Zero;	    // Zero=1 if ALUResult == 0

    always @(*) begin
	case (ALUControl)
		4'b0000: ALUResult = A + B; 	// Add
		
		4'b0001: ALUResult = A - B;		// Subtract
		
		4'b0010: ALUResult = A * B;		// Multiply

		4'b0011: ALUResult = A & B;		// AND
		
		4'b0100: ALUResult = A | B;		// OR
		
		4'b0101: ALUResult = ~(A | B);	// NOR
		
		4'b0110: ALUResult = A ^ B;		// XOR 
		
		4'b0111: ALUResult = B << A;	// Shif left (B Shifted left by A bits)
		
		4'b1000: ALUResult = B >> A;	// Shift right (B shifted A bits right)
		
		4'b1001: begin					// Set less than
				if (A < B) begin
					ALUResult = 32'b1;
				end
				else begin
					ALUResult = 32'b0;
				end
			 end

		4'b1010: begin					// set greater than
					if (A > B) begin
						ALUResult = 32'b1;
					end
					else begin
						ALUResult = 32'b0;
					end
				end

		4'b1011: begin					// ALUResult is 1 if equal 0 if not equal
					if (A == B) begin
						ALUResult = 32'b1;
					end
					else begin
						ALUResult = 32'b0;
					end
				end

		4'b1100: begin					// A greater than or equal to B
					if (A >= B) begin
						ALUResult = 32'b1;
					end
					else begin
						ALUResult = 32'b0;
					end
				end

		4'b1101: begin					// A less than or equal to B
					if (A <= B) begin
						ALUResult = 32'b1;
					end
					else begin
						ALUResult = 32'b0;
					end
				end

		default: ALUResult = 32'b0;		// default case 

	endcase

	if (ALUResult == 32'b0) begin
		Zero = 1'b1;
	end
	
	else begin
		Zero = 1'b0;
	end

    end

endmodule

