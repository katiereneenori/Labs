`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// ECE369A - Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 3 (memory[i] = i * 3;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will indexa into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;           // Input Address 
    output reg [31:0] Instruction;  // Instruction read from memory

    reg [31:0] memory [0:8191];    // 8K memory declaration

    integer i;
    
    // Assign all bits of Address[31:0] to a wire to utilize them
    wire [31:0] Address_used = Address;
    assign Address_used = Address_used;
    
    // Initialize memory
    initial begin
        for (i = 0; i < 8191; i = i + 1) begin
            memory[i] = 32'b0;
        end
        
//        $readmemh("private_instruction_memory.mem", memory);       
        $readmemh("Instruction_Memory.mem", memory);
        
    end

    // Instruction read
    always @(*) begin
        Instruction = memory[Address[14:2]];
    end

endmodule

