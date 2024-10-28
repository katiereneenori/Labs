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
                memory[0] = 32'h20080005; // addi $t0, $zero, 5        // $t0 = 5
        memory[1] = 32'h00000000; // nop
        memory[2] = 32'h00000000; // nop
        memory[3] = 32'h00000000; // nop
        memory[4] = 32'h00000000; // nop
        memory[5] = 32'h00000000; // nop

        memory[6] = 32'h2009000A; // addi $t1, $zero, 10       // $t1 = 10
        memory[7] = 32'h00000000; // nop
        memory[8] = 32'h00000000; // nop
        memory[9] = 32'h00000000; // nop
        memory[10] = 32'h00000000; // nop
        memory[11] = 32'h00000000; // nop

        memory[12] = 32'h01095020; // add $t2, $t0, $t1         // $t2 = $t0 + $t1 = 15
        memory[13] = 32'h00000000; // nop
        memory[14] = 32'h00000000; // nop
        memory[15] = 32'h00000000; // nop
        memory[16] = 32'h00000000; // nop
        memory[17] = 32'h00000000; // nop

        memory[18] = 32'h01495818; // mul $t3, $t2, $t1
        memory[19] = 32'h00000000; // nop
        memory[20] = 32'h00000000; // nop
        memory[21] = 32'h00000000; // nop
        memory[22] = 32'h00000000; // nop
        memory[23] = 32'h00000000; // nop

        memory[23] = 32'h01285022; // sub $t2, $t1, $t0         
        memory[25] = 32'h00000000; // nop
        memory[26] = 32'h00000000; // nop
        memory[27] = 32'h00000000; // nop
        memory[28] = 32'h00000000; // nop
        memory[29] = 32'h00000000; // nop

        memory[30] = 32'h016B5818; // mul $t3, $t3, $t3
        memory[31] = 32'h00000000; // nop
        memory[32] = 32'h00000000; // nop
        memory[33] = 32'h00000000; // nop
        memory[34] = 32'h00000000; // nop
        memory[35] = 32'h00000000; // nop

        memory[36] = 32'hAC0B0004; // sw $t3, 4($zero)          // Memory[1] = $t3
        memory[37] = 32'h00000000; // nop
        memory[38] = 32'h00000000; // nop
        memory[39] = 32'h00000000; // nop
        memory[40] = 32'h00000000; // nop
        memory[41] = 32'h00000000; // nop

        memory[42] = 32'hA00B0008; // sb $t2, 8($zero)          // Store byte from $t2 at Memory[2]
        memory[43] = 32'h00000000; // nop
        memory[44] = 32'h00000000; // nop
        memory[45] = 32'h00000000; // nop
        memory[46] = 32'h00000000; // nop
        memory[47] = 32'h00000000; // nop

        memory[48] = 32'h840C0004; // lh $t4, 4($zero) 
        memory[49] = 32'h00000000; // nop
        memory[50] = 32'h00000000; // nop
        memory[51] = 32'h00000000; // nop
        memory[52] = 32'h00000000; // nop
        memory[53] = 32'h00000000; // nop

        memory[54] = 32'h800D0004; // lb $t5, 4($zero)
        memory[55] = 32'h00000000; // nop
        memory[56] = 32'h00000000; // nop
        memory[57] = 32'h00000000; // nop
        memory[58] = 32'h00000000; // nop
        memory[59] = 32'h00000000; // nop

        memory[60] = 32'hA40C000C; // sh $t4, 12($zero) 
        memory[61] = 32'h00000000; // nop
        memory[62] = 32'h00000000; // nop
        memory[63] = 32'h00000000; // nop
        memory[64] = 32'h00000000; // nop
        memory[65] = 32'h00000000; // nop

        memory[66] = 32'h0501000B; // bgez $t0, label1            // Branch if $t0 >= 0
        memory[67] = 32'h00000000; // nop
        memory[68] = 32'h00000000; // nop
        memory[69] = 32'h00000000; // nop
        memory[70] = 32'h00000000; // nop
        memory[71] = 32'h00000000; // nop

        memory[72] = 32'h08000018; // j label2
        memory[73] = 32'h00000000; // nop
        memory[74] = 32'h00000000; // nop
        memory[75] = 32'h00000000; // nop
        memory[76] = 32'h00000000; // nop
        memory[77] = 32'h00000000; // nop

        memory[78] = 32'h200D0001; // label1: addi $t5, $zero, 1
        memory[79] = 32'h00000000; // nop
        memory[80] = 32'h00000000; // nop
        memory[81] = 32'h00000000; // nop
        memory[82] = 32'h00000000; // nop
        memory[83] = 32'h00000000; // nop

        memory[84] = 32'h110A0002; // beq $t0, $t2, label2      // Branch if $t0 == $t2
        memory[85] = 32'h00000000; // nop
        memory[86] = 32'h00000000; // nop
        memory[87] = 32'h00000000; // nop
        memory[88] = 32'h00000000; // nop
        memory[89] = 32'h00000000; // nop

        memory[90] = 32'h0800001C; // j label3
        memory[91] = 32'h00000000; // nop
        memory[92] = 32'h00000000; // nop
        memory[93] = 32'h00000000; // nop
        memory[94] = 32'h00000000; // nop
        memory[95] = 32'h00000000; // nop

        memory[96] = 32'h150A0002; // bne $t0, $t2, label3      // Branch if $t0 != $t2
        memory[97] = 32'h00000000; // nop
        memory[98] = 32'h00000000; // nop
        memory[99] = 32'h00000000; // nop
        memory[100] = 32'h00000000; // nop
        memory[101] = 32'h00000000; // nop

        memory[102] = 32'h1C0A0002; // bgtz $t0, label4         // Branch if $t0 > 0
        memory[103] = 32'h00000000; // nop
        memory[104] = 32'h00000000; // nop
        memory[105] = 32'h00000000; // nop
        memory[106] = 32'h00000000; // nop
        memory[107] = 32'h00000000; // nop

        memory[108] = 32'h180A0002; // blez $t0, label5         // Branch if $t0 <= 0
        memory[109] = 32'h00000000; // nop
        memory[110] = 32'h00000000; // nop
        memory[111] = 32'h00000000; // nop
        memory[112] = 32'h00000000; // nop
        memory[113] = 32'h00000000; // nop

        memory[114] = 32'h040A0002; // bltz $t0, label6         // Branch if $t0 < 0
        memory[115] = 32'h00000000; // nop
        memory[116] = 32'h00000000; // nop
        memory[117] = 32'h00000000; // nop
        memory[118] = 32'h00000000; // nop
        memory[119] = 32'h00000000; // nop

        memory[120] = 32'h0800002B; // j 43
        memory[121] = 32'h00000000; // nop
        memory[122] = 32'h00000000; // nop
        memory[123] = 32'h00000000; // nop
        memory[124] = 32'h00000000; // nop
        memory[125] = 32'h00000000; // nop

        memory[126] = 32'h03E00008; // jr $ra                   // Jump to return address
        memory[127] = 32'h00000000; // nop
        memory[128] = 32'h00000000; // nop
        memory[129] = 32'h00000000; // nop
        memory[130] = 32'h00000000; // nop
        memory[131] = 32'h00000000; // nop

        memory[132] = 32'h0C000032; // jal func                 // Jump and link to function
        memory[133] = 32'h00000000; // nop
        memory[134] = 32'h00000000; // nop
        memory[135] = 32'h00000000; // nop
        memory[136] = 32'h00000000; // nop
        memory[137] = 32'h00000000; // nop

        memory[138] = 32'h01495024; // and $t2, $t0, $t1        // $t2 = $t0 & $t1
        memory[139] = 32'h00000000; // nop
        memory[140] = 32'h00000000; // nop
        memory[141] = 32'h00000000; // nop
        memory[142] = 32'h00000000; // nop
        memory[143] = 32'h00000000; // nop

        memory[144] = 32'h3149000F; // andi $t1, $t0, 15        // $t1 = $t0 & 0xF
        memory[145] = 32'h00000000; // nop
        memory[146] = 32'h00000000; // nop
        memory[147] = 32'h00000000; // nop
        memory[148] = 32'h00000000; // nop
        memory[149] = 32'h00000000; // nop

        memory[150] = 32'h01495025; // or $t2, $t0, $t1         // $t2 = $t0 | $t1
        memory[151] = 32'h00000000; // nop
        memory[152] = 32'h00000000; // nop
        memory[153] = 32'h00000000; // nop
        memory[154] = 32'h00000000; // nop
        memory[155] = 32'h00000000; // nop

        memory[156] = 32'h01495027; // nor $t2, $t0, $t1        // $t2 = ~($t0 | $t1)
        memory[157] = 32'h00000000; // nop
        memory[158] = 32'h00000000; // nop
        memory[159] = 32'h00000000; // nop
        memory[160] = 32'h00000000; // nop
        memory[161] = 32'h00000000; // nop

        memory[162] = 32'h01495026; // xor $t2, $t0, $t1        // $t2 = $t0 ^ $t1
        memory[163] = 32'h00000000; // nop
        memory[164] = 32'h00000000; // nop
        memory[165] = 32'h00000000; // nop
        memory[166] = 32'h00000000; // nop
        memory[167] = 32'h00000000; // nop

        memory[168] = 32'h354A000F; // ori $t2, $t2, 15         // $t2 = $t2 | 0xF
        memory[169] = 32'h00000000; // nop
        memory[170] = 32'h00000000; // nop
        memory[171] = 32'h00000000; // nop
        memory[172] = 32'h00000000; // nop
        memory[173] = 32'h00000000; // nop

        memory[174] = 32'h394A000F; // xori $t2, $t2, 15        // $t2 = $t2 ^ 0xF
        memory[175] = 32'h00000000; // nop
        memory[176] = 32'h00000000; // nop
        memory[177] = 32'h00000000; // nop
        memory[178] = 32'h00000000; // nop
        memory[179] = 32'h00000000; // nop

        memory[180] = 32'h00095000; // sll $t2, $t1, 0          // Shift $t1 left by 0 bits (no-op)
        memory[181] = 32'h00000000; // nop
        memory[182] = 32'h00000000; // nop
        memory[183] = 32'h00000000; // nop
        memory[184] = 32'h00000000; // nop
        memory[185] = 32'h00000000; // nop

        memory[186] = 32'h00095002; // srl $t2, $t1, 2          // Shift $t1 right by 2 bits
        memory[187] = 32'h00000000; // nop
        memory[188] = 32'h00000000; // nop
        memory[189] = 32'h00000000; // nop
        memory[190] = 32'h00000000; // nop
        memory[191] = 32'h00000000; // nop

        memory[192] = 32'h014A502A; // slt $t2, $t2, $t1        // $t2 = ($t2 < $t1) ? 1 : 0
        memory[193] = 32'h00000000; // nop
        memory[194] = 32'h00000000; // nop
        memory[195] = 32'h00000000; // nop
        memory[196] = 32'h00000000; // nop
        memory[197] = 32'h00000000; // nop

        memory[198] = 32'h294A0005; // slti $t2, $t2, 5         // $t2 = ($t2 < 5) ? 1 : 0
        memory[199] = 32'h00000000; // nop
        memory[200] = 32'h00000000; // nop
        memory[201] = 32'h00000000; // nop
        memory[202] = 32'h00000000; // nop
        memory[203] = 32'h00000000; // nop

        memory[204] = 32'h08000000; // j to beginning
        memory[205] = 32'h00000000; // nop
        memory[206] = 32'h00000000; // nop
        memory[207] = 32'h00000000; // nop
        memory[208] = 32'h00000000; // nop
        memory[209] = 32'h00000000; // nop

        memory[210] = 32'h200F0001; // label2: addi $t7, $zero, 1
        memory[211] = 32'h00000000; // nop
        memory[212] = 32'h00000000; // nop
        memory[213] = 32'h00000000; // nop
        memory[214] = 32'h00000000; // nop
        memory[215] = 32'h00000000; // nop

        memory[216] = 32'h200E0002; // label3: addi $t6, $zero, 2
        memory[217] = 32'h00000000; // nop
        memory[218] = 32'h00000000; // nop
        memory[219] = 32'h00000000; // nop
        memory[220] = 32'h00000000; // nop
        memory[221] = 32'h00000000; // nop

        memory[222] = 32'h200D0003; // label4: addi $t5, $zero, 3
        memory[223] = 32'h00000000; // nop
        memory[224] = 32'h00000000; // nop
        memory[225] = 32'h00000000; // nop
        memory[226] = 32'h00000000; // nop
        memory[227] = 32'h00000000; // nop

        memory[228] = 32'h200C0004; // label5: addi $t4, $zero, 4
        memory[229] = 32'h00000000; // nop
        memory[230] = 32'h00000000; // nop
        memory[231] = 32'h00000000; // nop
        memory[232] = 32'h00000000; // nop
        memory[233] = 32'h00000000; // nop

        memory[234] = 32'h200B0005; // label6: addi $t3, $zero, 5
        memory[235] = 32'h00000000; // nop
        memory[236] = 32'h00000000; // nop
        memory[237] = 32'h00000000; // nop
        memory[238] = 32'h00000000; // nop
        memory[239] = 32'h00000000; // nop

        memory[240] = 32'h200A0006; // func: addi $t2, $zero, 6
        memory[241] = 32'h00000000; // nop
        memory[242] = 32'h00000000; // nop
        memory[243] = 32'h00000000; // nop
        memory[244] = 32'h00000000; // nop
        memory[245] = 32'h00000000; // nop

        memory[246] = 32'h03E00008; // jr $ra                   // Return from function
        memory[247] = 32'h00000000; // nop
        memory[248] = 32'h00000000; // nop
        memory[249] = 32'h00000000; // nop
        memory[250] = 32'h00000000; // nop
        memory[251] = 32'h00000000; // nop

        memory[252] = 32'h00000000; // nop (end of program)
        
        /*memory[0] = 32'h20080005; // addi $t0, $zero, 5       // $t0 = 5
        memory[1] = 32'h00000000; // nop
        memory[2] = 32'h00000000; // nop
        memory[3] = 32'h00000000; // nop
        memory[4] = 32'h00000000; // nop
        memory[5] = 32'h00000000; // nop
        
        memory[6] = 32'h2009000A; // addi $t1, $zero, 10      // $t1 = 10
        memory[7] = 32'h00000000; // nop
        memory[8] = 32'h00000000; // nop
        memory[9] = 32'h00000000; // nop
        memory[10] = 32'h00000000; // nop
        memory[11] = 32'h00000000; // nop
        
        memory[12] = 32'h01095020; // add $t2, $t0, $t1        // $t2 = $t0 + $t1
        memory[13] = 32'h00000000; // nop
        memory[14] = 32'h00000000; // nop
        memory[15] = 32'h00000000; // nop
        memory[16] = 32'h00000000; // nop
        memory[17] = 32'h00000000; // nop
        
        memory[18] = 32'hAC0A0000; // sw $t2, 0($zero)         // Memory[0] = $t2
        memory[19] = 32'h00000000; // nop
        memory[20] = 32'h00000000; // nop
        memory[21] = 32'h00000000; // nop
        memory[22] = 32'h00000000; // nop
        memory[23] = 32'h00000000; // nop
        
        memory[24] = 32'h8C0B0000; // lw $t3, 0($zero)         // $t3 = Memory[0]
        memory[25] = 32'h00000000; // nop
        memory[26] = 32'h00000000; // nop
        memory[27] = 32'h00000000; // nop
        memory[28] = 32'h00000000; // nop
        memory[29] = 32'h00000000; // nop
        
        memory[30] = 32'h016A5822; // sub $t3, $t3, $t2        // $t3 = $t3 - $t2
        memory[31] = 32'h00000000; // nop
        memory[32] = 32'h00000000; // nop
        memory[33] = 32'h00000000; // nop
        memory[34] = 32'h00000000; // nop
        memory[35] = 32'h00000000; // nop
        
        memory[36] = 32'h110B0002; // beq $t0, $t3, label      // Branch if $t0 == $t3
        memory[37] = 32'h00000000; // nop
        memory[38] = 32'h00000000; // nop
        memory[39] = 32'h00000000; // nop
        memory[40] = 32'h00000000; // nop
        memory[41] = 32'h00000000; // nop
        
        memory[42] = 32'h0800003B; // j 59                   // Jump to end
        memory[43] = 32'h00000000; // nop
        memory[44] = 32'h00000000; // nop
        memory[45] = 32'h00000000; // nop
        memory[46] = 32'h00000000; // nop
        memory[47] = 32'h00000000; // nop
        
        memory[48] = 32'h200C0001; // label: addi $t4, $zero, 1 // $t4 = 1
        memory[49] = 32'h00000000; // nop
        memory[50] = 32'h00000000; // nop
        memory[51] = 32'h00000000; // nop
        memory[52] = 32'h00000000; // nop
        memory[53] = 32'h00000000; // nop
        
        memory[54] = 32'hAC0C0004; // sw $t4, 4($zero)          // Memory[1] = $t4
        memory[55] = 32'h00000000; // nop
        memory[56] = 32'h00000000; // nop
        memory[57] = 32'h00000000; // nop
        memory[58] = 32'h00000000; // nop
        memory[59] = 32'h00000000; // nop   
        
        memory[60] = 32'h08000000; // j to beginning  
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
        memory[9] = 32'hAC0C0004; // sw $t4, 4($zero)          // Memory[1] = $t4*/
        
        // Load instructions from file
        //$readmemh("C:/Users/tjwil/Desktop/ECE369A/LabsRepo/Labs/Lab4Files/out.mem", memory);
    end
    
    always @(*) begin
        Instruction = memory[Address[11:2]];
    end

    
endmodule
