`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
// 
// Laboratory 4
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.   
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData, byte, half); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 
    input byte, half;       // Control signal for half/byte memory access instructions

    output reg[31:0] ReadData; // Contents of memory location at Address

	reg [31:0] memory [0:1023]; // 1K memory declaration
	
	integer i;
	
	// initialize all to 0
	initial begin
	   for(i = 0; i < 1024; i = i + 1) begin
	       memory[i] = 32'b0;
	   end
//	   $readmemh("out.mem", memory);
	end
	
// memory write 
    always @(posedge Clk) begin
        if (MemWrite) begin
            if ((!byte) && (!half)) begin
                // store the full 32-bit word
                memory[Address[11:2]] <= WriteData;
            end
            
            else if (half && !byte) begin
                // store the lower or upper 16 bits (store half)
                if (Address[1] == 1'b0) begin
                    // store half in lower 16 bits of the word
                    memory[Address[11:2]] <= {memory[Address[11:2]][31:16], WriteData[15:0]};
                end else begin
                    // store half in upper 16 bits of the word
                    memory[Address[11:2]] <= {WriteData[15:0], memory[Address[11:2]][15:0]};
                end
            end
            
            else if (byte && !half) begin
                // store only a single byte
                case (Address[1:0]) // select which byte to store
                    2'b00: memory[Address[11:2]] <= {memory[Address[11:2]][31:8], WriteData[7:0]};
                    2'b01: memory[Address[11:2]] <= {memory[Address[11:2]][31:16], WriteData[7:0], memory[Address[11:2]][7:0]};
                    2'b10: memory[Address[11:2]] <= {memory[Address[11:2]][31:24], WriteData[7:0], memory[Address[11:2]][15:0]};
                    2'b11: memory[Address[11:2]] <= {WriteData[7:0], memory[Address[11:2]][23:0]};
                endcase
            end
        end
    end

    // memory read
    always @(*) begin
        if (MemRead) begin
            if ((!byte) && (!half)) begin
                // load the full 32-bit word
                ReadData = memory[Address[11:2]];
            end
            
            else if (half && !byte) begin
                // load the halfword and sign extend
                if (Address[1] == 1'b0) begin
                    // load lower 16 bits and sign extend
                    ReadData = {{16{memory[Address[11:2]][15]}}, memory[Address[11:2]][15:0]};
                end else begin
                    // load upper 16 bits and sign extend
                    ReadData = {{16{memory[Address[11:2]][31]}}, memory[Address[11:2]][31:16]};
                end
            end
            
            else if (byte && !half) begin
                // Load the byte and sign extend
                case (Address[1:0])
                    2'b00: ReadData = {{24{memory[Address[11:2]][7]}}, memory[Address[11:2]][7:0]};
                    2'b01: ReadData = {{24{memory[Address[11:2]][15]}}, memory[Address[11:2]][15:8]};
                    2'b10: ReadData = {{24{memory[Address[11:2]][23]}}, memory[Address[11:2]][23:16]};
                    2'b11: ReadData = {{24{memory[Address[11:2]][31]}}, memory[Address[11:2]][31:24]};
                endcase
            end
        end else begin
            ReadData = 32'b0;    // Output 0 if MemRead is disabled
        end
    end

endmodule