`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//
//
// Student(s) Name and Last Name: Tanner Shartel and Katie Dionne (50%/50%)
//
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, Reset, ReadData1, ReadData2);

	input [4:0]  ReadRegister1;
	input [4:0]  ReadRegister2;
	input [4:0]  WriteRegister;
	input [31:0] WriteData;

	output reg [31:0] ReadData1;
	output reg [31:0] ReadData2;
	
	input RegWrite;
	input Clk, Reset;
	
	reg [31:0] registers [31:0]; // initialize 32 32-bit registers

	integer i;
	initial begin 
		for (i = 0; i < 32; i = i + 1) begin
			registers[i] = 32'b0;
		end
		
		//temp 
		//registers[8] = 32'd5;
		//registers[9] = 32'd9;
		//initialize all registers to 0
	end
	
    //combinational read logic
    always @(posedge Clk) begin // reads registers on falling edge of clock, so pipeline regfile has values to write
    ReadData1 = registers[ReadRegister1];
    ReadData2 = registers[ReadRegister2];
    end
    
    always @(posedge Clk) begin
        if (RegWrite && WriteRegister != 5'd0) begin
            $display("Time %0t: Writing %h to Register %d", $time, WriteData, WriteRegister);
        end
    end


    // sequential write logic
    always @(posedge Clk) begin // writes to registers on rising edge of the clock
        if (RegWrite && WriteRegister != 5'd0) begin
            registers[WriteRegister] <= WriteData;
        end
    end
endmodule