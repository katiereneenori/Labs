`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module with store/load word, halfword,
//               and byte functionality.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    // Inputs
    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;
    reg             byte;
    reg             half;

    // Output
    wire [31:0] ReadData;

    // Instantiate the DataMemory module
    DataMemory datamem(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .byte(byte), 
        .half(half),
        .ReadData(ReadData)
    ); 

    // Clock generation
    initial begin
        Clk <= 1'b0;
        forever #10 Clk <= ~Clk;
    end

    // Test procedure
    initial begin
        // Initialize inputs
        MemWrite <= 0;
        MemRead <= 0;
        Address <= 32'd0;
        WriteData <= 32'd0;
        byte <= 0;
        half <= 0;

        // Wait for reset
        #20;

        // Write full word to address 0x00000010
        MemWrite <= 1;
        Address <= 32'h00000010;
        WriteData <= 32'hDEADBEEF;  // Full word write
        byte <= 0;
        half <= 0;
        #20;

        // Disable write
        MemWrite <= 0;

        // Read full word from address 0x00000010
        MemRead <= 1;
        Address <= 32'h00000010;
        #20;

        // Disable read
        MemRead <= 0;

        // Write halfword to address 0x00000020
        MemWrite <= 1;
        Address <= 32'h00000020;
        WriteData <= 32'h12341234;  // Halfword write (lower half)
        byte <= 0;
        half <= 1;
        #20;

        // Disable write
        MemWrite <= 0;
        half <= 0;

        // Read halfword from address 0x00000020
        MemRead <= 1;
        Address <= 32'h00000020;
        #20;

        // Disable read
        MemRead <= 0;

        // Write byte to address 0x00000024
        MemWrite <= 1;
        Address <= 32'h00000024;
        WriteData <= 32'h000000FF;  // Byte write
        byte <= 1;
        half <= 0;
        #20;

        // Disable write
        MemWrite <= 0;

        // Read byte from address 0x00000024
        MemRead <= 1;
        Address <= 32'h00000024;
        #20;

        // Disable read
        MemRead <= 0;

        // Write halfword to upper half of address 0x00000020
        MemWrite <= 1;
        Address <= 32'h00000022;  // Write to upper halfword
        WriteData <= 32'h00005678;  // Halfword to be written to upper half
        byte <= 0;
        half <= 1;
        #20;

        // Disable write
        MemWrite <= 0;

        // Read full word from address 0x00000020 (should be a combination of two halfword writes)
        MemRead <= 1;
        Address <= 32'h00000020;
        #20;

        // Disable read
        MemRead <= 0;

        $finish;
    end

endmodule