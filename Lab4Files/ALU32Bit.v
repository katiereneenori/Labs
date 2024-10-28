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

	input [4:0] ALUControl;         // control bits for ALU operation
	
	input signed [31:0] A, B;	            // inputs to ALU

	output reg signed [31:0] ALUResult;	// Result
	output reg Zero;	            // Zero = 1 if ALUResult == 0

    always @(*) begin
    Zero = 0;
	case (ALUControl)
		5'b00000: ALUResult = A + B; 	// Add
		
		5'b00001: ALUResult = A - B;	// Subtract
		
		5'b00010: ALUResult = A * B;	// Multiply

		5'b00011: ALUResult = A & B;	// AND
		
		5'b00100: ALUResult = A | B;	// OR
		
		5'b00101: ALUResult = ~(A | B);	// NOR
		
		5'b00110: ALUResult = A ^ B;	// XOR 
		
		5'b00111: ALUResult = B << A;	// Shift left (B Shifted left by A bits)
		
		5'b01000: ALUResult = B >> A;	// Shift right (B shifted A bits right)
		
		5'b01001: begin			        // Set less than (slt & slti) ONLY
				if (A < B) begin
					ALUResult = 32'b1;
				end
				else begin
					ALUResult = 32'b0;
				end
			 end

		5'b01011: begin		            // beq
					if (A == B) begin
						ALUResult = 32'b0;
					end
					else begin
						ALUResult = 32'b1;
					end
				end

		5'b01110: begin 	            //bltz
					if (A < 0) begin
						ALUResult = 1'b0; // raises zero flag, allowing branch 
					end

					else begin
						ALUResult = 1'b1;  
					end
				end

		5'b01111: begin 	            //bne
					if (A != B) begin
						ALUResult = 1'b0;
					end

					else begin
						ALUResult = 1'b1;
					end
				end

		5'b10000: begin //pass A and raise zero flag, used in jr instruction
					ALUResult = A;
					Zero = 1'b1;
			end
		
		5'b10001: begin		            //blez
				if (A <= 0) begin
					ALUResult = 1'b0; //raise zero flag allowing branch
				end
				else begin
					ALUResult = 1'b1; //do not raise zero flag
				end
			end
		
		5'b10010: begin		            //bgtz
				if (A > 0) begin
					ALUResult = 1'b0; //raise zero flag allowing branch
				end
				else begin
					ALUResult = 1'b1; //do not raise zero flag
				end
			end

		5'b10011: begin		            //bgez
				if (A >= 0) begin
					ALUResult = 1'b0; //raise zero flag allowing branch
				end
				else begin
					ALUResult = 1'b1; //do not raise zero flag
				end
			end

		5'b10100: begin               // jump address calculation
                                      // A input = 32 bit PC output for the jump instruction (need most significant 4 bits)
				                      // B input = 32 bit jump instruction LEFT SHIFTED twice (only care about least
				                      // significant 26 bits of instruction)
				
				ALUResult = {A[31:28], B[27:0]};
				Zero = 1'b1; // need PCSrc to accept ALUResult without equaling zero
				
			end
			
		5'b10101: begin       // for jump, pass least 26 bits shifted left 2
		        ALUResult = {4'b0000, B[27:0]};
		        Zero = 1'b1;  // allow PCSrc to accept new branch
		end
		
		default: ALUResult = 32'b0;		// default case 

	endcase

	if ((ALUResult == 32'b0)) begin // zero flag indicates zero output for all except jump instructions
		Zero = 1'b1;
	end
	
	else if ((ALUControl != 5'b10100) && (ALUControl != 5'b10000) &&(ALUControl != 5'b10101)) begin
		Zero = 1'b0;
	end
	
    end

endmodule

