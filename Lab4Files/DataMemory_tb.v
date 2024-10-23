`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
        // Initialize inputs
        MemWrite <= 0;
        MemRead <= 0;
        Address <= 32'd0;
        WriteData <= 32'd0;

        // Wait for reset
        #20;

        // Test case 1: Write data to address 0x00000010
        MemWrite <= 1;
        Address <= 32'h00000010;
        WriteData <= 32'hDEADBEEF;
        #20;

        // Disable write
        MemWrite <= 0;

        // Test case 2: Read data from address 0x00000010
        MemRead <= 1;
        Address <= 32'h00000010;
        #20;

        // Disable read
        MemRead <= 0;

        // Test case 3: Write data to address 0x00000020
        MemWrite <= 1;
        Address <= 32'h00000020;
        WriteData <= 32'h12345678;
        #20;

        // Disable write
        MemWrite <= 0;

        // Test case 4: Read data from address 0x00000020
        MemRead <= 1;
        Address <= 32'h00000020;
        #20;

        // Disable read
        MemRead <= 0;

        $finish;
	end

endmodule

