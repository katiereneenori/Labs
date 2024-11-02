`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
// 
// ECE369A - Computer Architecture
// Laboratory 4
// Create Date: 10/23/2024 04:20:01 AM
// Design Name: 
// Module Name: TopDatapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module TopDatapath(Clk, Reset, wire2, wire13);// //ReadDataOut1, ReadDataOut2

input Clk;
input Reset;

// wire [15:0] Num;
output [31:0] wire2, wire13;

// output [6:0] out7; //seg a, b, ... g
// output [3:0] en_out;
//  wire dp;

// wire ClkOut;

// ClkDiv m1(Clk, Reset, ClkOut);

// Mux2x1 m4(wire2[15:0], wire13[15:0], Num, ClkOut);

// Mux2x1 m5(0, 1, dp, ClkOut);

// One4DigitDisplay m2(Clk, Num, out7, en_out);

// wire [31:0] PCOut; // output program counter
// wire [31:0] WriteDataOut; // output WriteData to register file (WriteDataOut)
//output [31:0] ReadDataOut1;  // Output ReadData1 from register file
//output [31:0] ReadDataOut2;   // Output ReadData2 from register file

// Internal Wires
// 32-bit wires
wire [31:0] wire1, wire3, wire4, wire5, wire6, wire7, wire8, wire9, wire10, wire11, wire14, wire15, wire16,
            wire17, wire18, wire21, wire22, wire23, wire24, wire25, wire26, wire29,
            wire30, wire31, wire32, wire34, wire36, wire37, wire39, wire40, wire42,
            wire43, wire44, wire46, wire47, wire48; // Added wire46, wire47, wire48 for PC+4 propagation
                
// 1-bit wires
wire wire35, wire38;

// 5-bit wires
wire [4:0] wire12, wire27, wire28, wire33, wire41, wire45;
wire [4:0] ALUOpWire, ALUOpWire1;

// 2-bit wires
wire [1:0] ALUSrcAWire, ALUSrcBWire, MemToRegWire, ALUSrcAWire1, ALUSrcBWire1, MemToRegWire1, MemToRegWire2, MemToRegWire3;

// 1-bit control signals
wire ToBranchWire, RegWriteWire, MemWriteWire, MemReadWire, MemByteWire, MemHalfWire, RegDstWire, JalSelWire, PCSrcWire, JorBranchWire;
wire ToBranchWire1, RegWriteWire1, MemWriteWire1, MemReadWire1, MemByteWire1, MemHalfWire1, RegDstWire1, JalSelWire1, JorBranchWire1;
wire ToBranchWire2, RegWriteWire2, MemWriteWire2, MemReadWire2, MemByteWire2, MemHalfWire2, RegDstWire2, JalSelWire2, JorBranchWire2;

wire JalSelWire3, RegWriteWire3;

reg [4:0] returnAddr = 5'b11111;

// Assign outputs
//assign PCOut = wire2; // Connecting PCOut to wire2
//assign WriteDataOut = wire13; // Connecting wire13 to WriteDataOut
//assign ReadDataOut1 = wire14;
//assign ReadDataOut2 = wire15;

//always @(wire2, wire13) 
//    begin
//        PCOutReg <= wire2;
//        WriteDataOutReg <= wire13;
//    end    

// ------------------------Instruction Fetch Stage------------------------

    Mux32Bit2To1 JorBranchMux(
        .inA(wire6),
        .inB(wire7),
        .out(wire5),
        .sel(JorBranchWire2)
        );
    
    Mux32Bit2To1 PCSrcMux( // 2x1 mux -- PCSrc control signal
        .inA(wire3),
        .inB(wire5),
        .out(wire1),
        .sel(PCSrcWire)
        );
    
    ProgramCounter PC(
        .Address(wire1), 
        .PCResult(wire2), 
        .Reset(Reset), 
        .Clk(Clk)
        );
        
    PCAdder PCAdd( // provides PC + 4
        .PCResult(wire2),
        .PCAddResult(wire3)
        );
        
    InstructionMemory IM(
        .Address(wire2), 
        .Instruction(wire4)
        );
        
    IF_ID IF_IDRegFile(
        .Clk(Clk),
        .Reset(Reset),
        .inWire2(wire2),
        .inWire3(wire3),
        .inWire4(wire4),
        .outWire2(wire9),
        .outWire3(wire10),
        .outWire4(wire11)
    );
    
// ------------------------Instruction Decode Stage------------------------ 

    Control Controller(
        .Instruction(wire11), 
        .ALUOp(ALUOpWire), 
        .ToBranch(ToBranchWire), 
        .RegDst(RegDstWire), 
        .ALUSrcA(ALUSrcAWire), 
        .ALUSrcB(ALUSrcBWire), 
        .RegWrite(RegWriteWire), 
        .MemWrite(MemWriteWire), 
        .MemRead(MemReadWire), 
        .MemToReg(MemToRegWire), 
        .MemByte(MemByteWire), 
        .MemHalf(MemHalfWire), 
        .JorBranch(JorBranchWire), 
        .JalSel(JalSelWire)
    );
    
    RegisterFile Registers(
        .ReadRegister1(wire11[25:21]), 
        .ReadRegister2(wire11[20:16]), 
        .WriteRegister(wire12), 
        .WriteData(wire13), 
        .RegWrite(RegWriteWire3), 
        .Clk(Clk),
        .Reset(Reset), 
        .ReadData1(wire14), 
        .ReadData2(wire15)
    );
    
    FiveBitExtender FiveExtend(
        .in(wire11[10:6]),
        .out(wire16)
    );
    
    ShiftLeft2 Shift1(
        //.toShift(wire18),
        .toShift(wire11),   // ?
        .shiftedResult(wire17)
    );
    
    SignExtension SE(
        .in(wire11[15:0]),
        .out(wire18)
    );
    
    // Modified to pass full PC+4 (wire10) through the pipeline
    ID_EX ID_EXRegFile(
        .Clk(Clk),
        .Reset(Reset),
        // Control signals
        .inALUOp(ALUOpWire), 
        .inToBranch(ToBranchWire), 
        .inRegWrite(RegWriteWire), 
        .inMemWrite(MemWriteWire), 
        .inMemRead(MemReadWire), 
        .inMemByte(MemByteWire),
        .inMemHalf(MemHalfWire),  
        .inRegDst(RegDstWire), 
        .inJalSel(JalSelWire), 
        .inALUSrcA(ALUSrcAWire), 
        .inALUSrcB(ALUSrcBWire), 
        .inJorBranch(JorBranchWire), 
        .inMemToReg(MemToRegWire), 
        // Data signals
        .inWire16(wire16), 
        .inWire14(wire14), 
        .inWire9(wire9), 
        .inWire15(wire15), 
        .inWire17(wire17), 
        .inWire18(wire18), 
        .inWire10(wire10),  // Pass the full PC+4
    .inWire27(wire11[20:16]),  // rt
    .inWire28(wire11[15:11]),  // rd
        // Outputs
        .outALUOp(ALUOpWire1), 
        .outToBranch(ToBranchWire1), 
        .outRegWrite(RegWriteWire1),
        .outMemWrite(MemWriteWire1), 
        .outMemRead(MemReadWire1), 
        .outMemByte(MemByteWire1), 
        .outMemHalf(MemHalfWire1),  
        .outRegDst(RegDstWire1), 
        .outJalSel(JalSelWire1),
        .outALUSrcA(ALUSrcAWire1), 
        .outALUSrcB(ALUSrcBWire1), 
        .outJorBranch(JorBranchWire1), 
        .outMemToReg(MemToRegWire1), 
        .outWire10(wire46),  // New wire carrying PC+4
        .outWire16(wire21), 
        .outWire14(wire22), 
        .outWire9(wire23), 
        .outWire15(wire24), 
        .outWire17(wire25), 
        .outWire18(wire26),
    .outWire27(wire27),        // rt
    .outWire28(wire28)         // rd
    );
    
// ------------------------Execution Stage------------------------
    
    ShiftLeft2 Shift2(
        .toShift(wire26),
        .shiftedResult(wire29)
    );
    
    Adder offsetAdder(
        .inA(wire46), // Use full PC+4 from ID_EX
        .inB(wire29),
        .AddResult(wire30)
    );
    
    Mux32Bit3To1 ALUSrcAMux(
        .inA(wire22),
        .inB(wire21),
        .inC(wire23),
        .sel(ALUSrcAWire1),
        .out(wire31)
    );
    
    Mux32Bit3To1 ALUSrcBMux(
        .inA(wire24),
        .inB(wire26),
        .inC(wire25),
        .sel(ALUSrcBWire1),
        .out(wire32)
    );
    
    Mux5Bit2To1 RegDstMux(
        .inA(wire27),
        .inB(wire28),
        .sel(RegDstWire1),
        .out(wire33)
    );
    
    ALU32Bit ALU(
        .ALUControl(ALUOpWire1),
        .A(wire31),
        .B(wire32),
        .ALUResult(wire34),
        .Zero(wire35)
    );
    
    // Modified to pass PC+4 (wire46) to EX_MEM
    EX_MEM EX_MEMRegFile(
         .Clk(Clk), .Reset(Reset), 
         .inToBranch(ToBranchWire1), .inRegWrite(RegWriteWire1), .inMemWrite(MemWriteWire1), .inMemRead(MemReadWire1), .inMemByte(MemByteWire1),
         .inMemHalf(MemHalfWire1), .inJalSel(JalSelWire1), .inJorBranch(JorBranchWire1), .inMemToReg(MemToRegWire1), 
         .inWire46(wire46), // PC+4
         .inWire30(wire30), .inWire35(wire35), .inWire34(wire34), .inWire24(wire24), .inWire33(wire33), 
         .outToBranch(ToBranchWire2), .outRegWrite(RegWriteWire2),
         .outMemWrite(MemWriteWire2), .outMemRead(MemReadWire2), .outMemByte(MemByteWire2), .outMemHalf(MemHalfWire2), 
         .outJalSel(JalSelWire2), .outJorBranch(JorBranchWire2), .outMemToReg(MemToRegWire2), 
         .outWire46(wire47), // PC+4 passed to EX_MEM
         .outWire30(wire6), .outWire35(wire38), .outWire34(wire7), .outWire24(wire40), .outWire33(wire41)
        );  
    
// ------------------------Memory Access Stage------------------------
    
    DataMemory datamem(
        .Address(wire7), 
        .WriteData(wire40), 
        .Clk(Clk), 
        .MemWrite(MemWriteWire2), 
        .MemRead(MemReadWire2), 
        .ReadData(wire8),
        .byte(MemByteWire2), 
        .half(MemHalfWire2)
    );
    
    AND_Gate andgate(
        .inA(ToBranchWire2),
        .inB(wire38),
        .out(PCSrcWire)
    );
    
// ------------------------Write Back Stage------------------------

    // Modified to pass PC+4 (wire47) to MEM_WB
    // Assuming wire41 and wire45 are 5-bit wires
    MEM_WB MEM_WBRegFile(
        .Clk(Clk),
        .Reset(Reset),
        .inRegWrite(RegWriteWire2), 
        .inJalSel(JalSelWire2), 
        .inMemToReg(MemToRegWire2),  
        .outRegWrite(RegWriteWire3), 
        .outJalSel(JalSelWire3), 
        .outMemToReg(MemToRegWire3), 
        .inWire46(wire47), // PC+4 from EX_MEM
        .inWire8(wire8), 
        .inWire7(wire7), 
        .inWire41(wire41),     // 5-bit input
        .outWire46(wire48),    // PC+4 passed to MEM_WB
        .outWire8(wire43), 
        .outWire7(wire44),
        .outWire41(wire45)     // 5-bit output
    );

    
    // Updated MemToRegMux to use full PC+4 (wire48)
    Mux32Bit3To1 MemToRegMux(
        .inA(wire43),    // Data from memory (lw)
        .inB(wire44),    // ALU result
        .inC(wire48),    // PC+4 for jal
        .out(wire13),    // WriteData
        .sel(MemToRegWire3)
    );
    
    Mux5Bit2To1 JalSelMux(
        .inA(wire45),
        .inB(returnAddr),
        .sel(JalSelWire3),
        .out(wire12)
    );
    
endmodule
