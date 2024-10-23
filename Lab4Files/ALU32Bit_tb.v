`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [4:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs

	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	
    // Test Add
        ALUControl = 5'b00000; A = 32'd10; B = 32'd15;
        #10;
        // Expected ALUResult = 25, Zero = 0

        // Test Subtract
        ALUControl = 5'b00001; A = 32'd20; B = 32'd5;
        #10;
        // Expected ALUResult = 15, Zero = 0

        // Test Multiply
        ALUControl = 5'b00010; A = 32'd3; B = 32'd4;
        #10;
        // Expected ALUResult = 12, Zero = 0

        // Test AND
        ALUControl = 5'b00011; A = 32'hFF00FF00; B = 32'h0F0F0F0F;
        #10;
        // Expected ALUResult = 0x0F000F00, Zero = 0

        // Test OR
        ALUControl = 5'b00100; A = 32'hFF00FF00; B = 32'h0F0F0F0F;
        #10;
        // Expected ALUResult = 0xFF0FFF0F, Zero = 0

        // Test NOR
        ALUControl = 5'b00101; A = 32'h00000000; B = 32'hFFFFFFFF;
        #10;
        // Expected ALUResult = 0x00000000, Zero = 1

        // Test XOR
        ALUControl = 5'b00110; A = 32'hAAAA5555; B = 32'h5555AAAA;
        #10;
        // Expected ALUResult = 0xFFFFFFFF, Zero = 0

        // Test Shift Left Logical
        ALUControl = 5'b00111; A = 32'd2; B = 32'd5;
        #10;
        // Expected ALUResult = 20, Zero = 0

        // Test Shift Right Logical
        ALUControl = 5'b01000; A = 32'd2; B = 32'd20;
        #10;
        // Expected ALUResult = 5, Zero = 0

        // Test Set Less Than
        ALUControl = 5'b01001; A = 32'd5; B = 32'd10;
        #10;
        // Expected ALUResult = 1, Zero = 0

        // Test Zero Flag when result is zero
        ALUControl = 5'b00001; A = 32'd5; B = 32'd5;
        #10;
        // Expected ALUResult = 0, Zero = 1

        // Finish simulation
        $finish;
	
	end

endmodule

