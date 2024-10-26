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
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction);

    input [31:0] Address;        // Input Address 

    output reg [31:0] Instruction;    // Instruction at memory location Address
    
    reg [31:0] memory[0:1023]; //store instructions
    
    integer i;
    
    initial begin
        // Initialize all memory locations to zero
        for (i = 0; i < 1024; i = i + 1) begin
            memory[i] = 32'b0;
        end
        
        // Hard-coded instructions for testing
        memory[0] = 32'h20080005; // addi $t0, $zero, 5       // $t0 = 5
        memory[1] = 32'h2009000A; // addi $t1, $zero, 10      // $t1 = 10
        memory[2] = 32'h01095020; // add $t2, $t0, $t1        // $t2 = $t0 + $t1
        memory[3] = 32'hAC0A0000; // sw $t2, 0($zero)         // Memory[0] = $t2
        memory[4] = 32'h8C0B0000; // lw $t3, 0($zero)         // $t3 = Memory[0]
        memory[5] = 32'h016A5822; // sub $t3, $t3, $t2        // $t3 = $t3 - $t2
        memory[6] = 32'h110B0002; // beq $t0, $t3, label      // Branch if $t0 == $t3
        memory[7] = 32'h08000006; // j end                    // Jump to end
        memory[8] = 32'h200C0001; // label: addi $t4, $zero, 1 // $t4 = 1
        memory[9] = 32'hAC0C0004; // sw $t4, 4($zero)          // Memory[1] = $t4
        
        // Load instructions from file
        //$readmemh("C:/Users/tjwil/Desktop/ECE369A/LabsRepo/Labs/Lab4Files/out.mem", memory);
    end
    
    
    
    always @(*) begin
        Instruction = memory[Address[11:2]];
    end

    
endmodule
