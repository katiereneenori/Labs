`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - RegisterFile.v
// Description - Test the register_file
// Suggested test case - First write arbitrary values into 
// the saved and temporary registers (i.e., register 8 through 25). Then, 2-by-2, 
// read values from these registers.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile_tb();

	reg [4:0] ReadRegister1;
	reg [4:0] ReadRegister2;
	reg	[4:0] WriteRegister;
	reg [31:0] WriteData;
	reg RegWrite;
	reg Clk;

	wire [31:0] ReadData1;
	wire [31:0] ReadData2;

	RegisterFile u0(
		.ReadRegister1(ReadRegister1), 
		.ReadRegister2(ReadRegister2), 
		.WriteRegister(WriteRegister), 
		.WriteData(WriteData), 
		.RegWrite(RegWrite), 
		.Clk(Clk), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2)
	);

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
		// Test case 1: Write to register 5
		RegWrite <= 1'b1;
		WriteRegister <= 5'b00101;
		WriteData <= 32'hAAAA_BBBB;
		#20;  // Wait for a clock cycle

		// Test case 2: Read from register 5
		RegWrite <= 1'b0;
		ReadRegister1 <= 5'b00101;
		ReadRegister2 <= 5'b00101;
		#20;  // Wait for a clock cycle

		// Test case 3: Write to register 10
		RegWrite <= 1'b1;
		WriteRegister <= 5'b01010;
		WriteData <= 32'h1234_5678;
		#20;  // Wait for a clock cycle

		// Test case 4: Read from register 10 and register 5
		RegWrite <= 1'b0;
		ReadRegister1 <= 5'b01010;
		ReadRegister2 <= 5'b00101;
		#20;  // Wait for a clock cycle

		// Test case 5: Write to register 31
		RegWrite <= 1'b1;
		WriteRegister <= 5'b11111;
		WriteData <= 32'hDEAD_BEEF;
		#20;  // Wait for a clock cycle

		// Test case 6: Read from register 31
		RegWrite <= 1'b0;
		ReadRegister1 <= 5'b11111;
		ReadRegister2 <= 5'b11111;
		#20;  // Wait for a clock cycle

		$finish;
	end

endmodule