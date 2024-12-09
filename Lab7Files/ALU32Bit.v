`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// ECE369A - Computer Architecture
// Laboratory 4
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

module ALU32Bit(
    input [4:0] ALUControl,       // Control bits for ALU operation
    input signed [31:0] A,        // ALU input A
    input signed [31:0] B,        // ALU input B
    output reg signed [31:0] ALUResult,  // ALU result output
    output reg Zero               // Zero flag
);

    always @(*) begin
        Zero = 1'b0;
        case (ALUControl)
            5'b00000: ALUResult = A + B;    // Add

            5'b00001: ALUResult = A - B;    // Subtract

            5'b00010: ALUResult = A * B;    // Multiply

            5'b00011: ALUResult = A & B;    // AND

            5'b00100: ALUResult = A | B;    // OR

            5'b00101: ALUResult = ~(A | B); // NOR

            5'b00110: ALUResult = A ^ B;    // XOR

            5'b00111: ALUResult = B << A[4:0]; // Shift Left Logical

            5'b01000: ALUResult = A >> B[4:0]; // Shift Right Logical

            5'b01001: ALUResult = (A < B) ? 32'b1 : 32'b0; // Set Less Than

            // Branch operations
            5'b01110: ALUResult = (A < 0) ? 32'b0 : 32'b1; // BLTZ

            5'b01111: ALUResult = (A != B) ? 32'b0 : 32'b1; // BNE

            5'b10000: begin  // JR
                ALUResult = A;
                Zero = 1'b1;
            end

            5'b10001: ALUResult = (A <= 0) ? 32'b0 : 32'b1; // BLEZ

            5'b10010: ALUResult = (A > 0) ? 32'b0 : 32'b1;  // BGTZ

            5'b10011: ALUResult = (A >= 0) ? 32'b0 : 32'b1; // BGEZ

            5'b10100: begin  // Jump Address Calculation
                ALUResult = {A[31:28], B[25:0], 2'b00};
                Zero = 1'b1;
            end
                        
            5'b10101: begin // bge (Branch if Greater or Equal)
                ALUResult = (A >= B) ? 32'b0 : 32'b1;
            end
            
            5'b10110: begin // ble (Branch if Less or Equal)
                ALUResult = (A <= B) ? 32'b0 : 32'b1;
            end
            
            5'b10111: begin // blt (Branch if Less Than)
                ALUResult = (A < B) ? 32'b0 : 32'b1;
            end
            
            5'b11000: begin // bgt (Branch if Greater Than)
                ALUResult = (A > B) ? 32'b0 : 32'b1;
            end    
                        
            default: ALUResult = 32'b0;
        endcase

        // Set Zero flag if ALUResult is zero
        if (ALUResult == 32'b0) begin
            Zero = 1'b1;
        end else begin
            Zero = 1'b0;
        end
    end

endmodule
