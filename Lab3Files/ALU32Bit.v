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

	input [4:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
				//
				// for ISA: need:
				// add, sub, set less than (compare), and, or, nor, xor, shift left, shift right, multiply
	input [31:0] A, B;	    // inputs

	output [31:0] ALUResult;	// answer
	output Zero;	    // Zero=1 if ALUResult == 0

    always @(*) begin
	case (ALUControl)
		5'b00000: ALUResult = A + B; 	// Add
		
		5'b00001: ALUResult = A - B;		// Subtract
		
		5'b00010: ALUResult = A * B;		// Multiply

		5'b00011: ALUResult = A & B;		// AND
		
		5'b00100: ALUResult = A | B;		// OR
		
		5'b00101: ALUResult = ~(A | B);	// NOR
		
		5'b00110: ALUResult = A ^ B;		// XOR 
		
		5'b00111: ALUResult = B << A;	// Shif left (B Shifted left by A bits)
		
		5'b01000: ALUResult = B >> A;	// Shift right (B shifted A bits right)
		
		5'b01001: begin					// Set less than AND blez
				if (A < B) begin
					ALUResult = 32'b1;
					Zero = 1;
				end
				else begin
					ALUResult = 32'b0;
					Zero = 0;
				end
			 end

		5'b01010: begin					// set greater than AND bgtz
					if (A > B) begin
						ALUResult = 32'b1;
						Zero = 1;
					end
					else begin
						ALUResult = 32'b0;
						Zero = 0;
					end
				end

		5'b01011: begin					// ALUResult is 0 if equal 1 if not equal
					if (A == B) begin
						ALUResult = 32'b0;
					end
					else begin
						ALUResult = 32'b1
					end
				end

		5'b01100: begin					// A greater than or equal to B
					if (A >= B) begin
						ALUResult = 32'b0;
					end
					else begin
						ALUResult = 32'b1;
					end
				end

		5'b01101: begin					// A less than or equal to B
					if (A <= B) begin
						ALUResult = 32'b1;
						Zero = 1;
					end
					else begin
						ALUResult = 32'b0;
						Zero = 0;
					end
				end

		5'b01110: begin
					if (A >= 0) begin
						ALUResult = 0;  // bgez raises zero flag
					end

					else begin
						ALUResult = 1;  
					end
				end

		5'b01111: begin
					if (A != B) begin
						ALUResult = 1'b0;
					end

					else begin
						ALUResult = 1'b1;
					end
				end

		5'b10000: begin // just push through A input to output
					ALUResult = A;
					Zero = 1;
				end

		default: ALUResult = 32'b0;		// default case 

		// a beq instruction can be done with subtract, and determine if output is 0, and branch if yes

	endcase

	if (ALUResult == 32'b0) begin
		Zero = 1'b1;
	end
	
	else begin
		Zero = 1'b0;
	end

    end

endmodule

