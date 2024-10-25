`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
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


module TopDatapath(Clk, Reset, PC_out, ALU_result_out, MemReadData_out);

input Clk;
input Reset;

output [31:0] PC_out, ALU_result_out, MemReadData_out;

wire [31:0] wire1, wire2, wire3, wire4, wire5, wire6, wire7, wire8, wire9, wire10, wire11, wire14, wire15, wire16,
            wire17, wire18, wire19, wire20, wire21, wire22, wire23, wire24, wire25, wire26, wire27, wire28, wire29,
            wire30, wire31, wire32, wire33, wire34, wire36, wire37, wire39, wire40, wire41, wire42,
            wire43, wire44, wire45;
wire [4:0] ALUOpWire, wire12, wire13, ALUOpWire1;
wire [1:0] ALUSrcAWire, ALUSrcBWire, MemToRegWire, ALUSrcAWire1, ALUSrcBWire1, MemToRegWire1;
wire ToBranchWire, RegWriteWire, MemWriteWire, MemReadWire, MemByteWire, MemHalfWire, RegDstWire, JalSelWire, PCSrcWire, JorBranchWire;
wire ToBranchWire1, RegWriteWire1, MemWriteWire1, MemReadWire1, MemByteWire1, MemHalfWire1, RegDstWire1, JalSelWire1, wire35, wire38, JorBranchWire1;
wire ToBranchWire2, RegWriteWire2, MemWriteWire2, MemReadWire2, MemByteWire2, MemHalfWire2, RegDstWire2, JalSelWire2, JorBranchWire2;
wire MemToRegWire3, JalSelWire3, RegWriteWire3;
reg returnAddr = 5'b11111;

// ------------------------Instruction Fetch Stage------------------------

    Mux32Bit2To1 JorBranchMux(
        .inA(wire6),
        .inB(wire7),
        .out(wire5),
        .sel(JorBranchWire)
        );
    
    Mux32Bit2To1 PCSrcMux( // 2x1 mux -- PCSrc control signal
        .inA(wire3),
        .inB(wire5),
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
    
// ------------------------Execution Stage------------------------ 
   
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
        .RegWrite(RegWriteWire), 
        .Clk(Clk), 
        .ReadData1(wire14), 
        .ReadData2(wire15)
    );
    
    FiveBitExtender FiveExtend(
        .in(wire11[10:6]),
        .out(wire16)
    );
    
    ShiftLeft2 Shift1(
        .toShift(wire11),
        .shiftedResult(wire17)
    );
    
    SignExtension SE(
        .in(wire11[15:0]),
        .out(wire18)
    );
    
    ID_EX ID_EXRegFile(
        .Clk(Clk),
        .Reset(Reset),
        .inALUOp(ALUOpWire), .inToBranch(ToBranchWire), .inRegWrite(RegWriteWire), 
        .inMemWrite(MemWriteWire), .inMemRead(MemReadWire), .inMemByte(MemByteWire),
        .inMemHalf(MemHalfWire),  .inRegDst(RegDstWire), .inJalSel(JalSelWire), 
        .inALUSrcA(ALUSrcAWire), .inALUSrcB(ALUSrcBWire), .inJorBranch(JorBranch), 
        .inMemToReg(MemToRegWire), .inWire10(wire10), .inWire16(wire16), 
        .inWire14(wire14), .inWire9(wire9), .inWire15(wire15), .inWire17(wire17), 
        .inWire18(wire18), .inWire11Upper(wire11[20:16]), .inWire11Lower(wire11[15:11]), 
        .outALUOp(ALUOpWire1), .outToBranch(ToBranchWire1), .outRegWrite(RegWriteWire1),
        .outMemWrite(MemWriteWire1), .outMemRead(MemReadWire1), .outMemByte(MemByteWire1), 
        .outMemHalf(MemHalfWire1),  .outRegDst(RegDstWire1), .outJalSel(JalSelWire1),
        .outALUSrcA(ALUSrcAWire1), .outALUSrcB(ALUSrcBWire1), .outJorBranch(JorBranch1), 
        .outMemToReg(MemToRegWire1), .outWire10Upper(wire19), .outWire10Lower(wire20), .outWire16(wire21), 
        .outWire14(wire22), .outWire9(wire23), .outWire15(wire24), .outWire17(wire25), 
        .outWire18(wire26), .outWire11Upper(wire27), .outWire11Lower(wire28)
    );
    
    ShiftLeft2 Shift2(
        .toShift(wire26),
        .shiftedResult(wire29)
    );
    
    Adder offsetAdder(
        .inA(wire20),
        .inB(wire29),
        .AddResult(wire30)
    );
    
    Mux32Bit3To1 ALUSrcAMux(
        .inA(wire22),
        .inB(wire21),
        .inC(wire23),
        .sel(ALUSrcA1),
        .out(wire31)
    );
    
    Mux32Bit3To1 ALUSrcBMux(
        .inA(wire24),
        .inB(wire26),
        .inC(wire25),
        .sel(ALUSrcB1),
        .out(wire32)
    );
    
    Mux32Bit2To1 RegDstMux(
        .inA(wire27),
        .inB(wire28),
        .sel(RegDst1),
        .out(wire33)
    );
    
    ALU32Bit ALU(
        .ALUControl(ALUOpWire1),
        .A(wire31),
        .B(wire32),
        .ALUResult(wire34),
        .Zero(wire35)
    );
    
    EX_MEM EX_MEMRegFile(
         .Clk(Clk), .Reset(Reset),.inToBranch(ToBranchWire1), .inRegWrite(RegWriteWire1), .inMemWrite(MemWriteWire1), .inMemRead(MemReadWire1), .inMemByte(MemByteWire1),
         .inMemHalf(MemHalfWire1), .inJalSel(JalSelWire1), .inJorBranch(JorBranchWire1), .inMemToReg(MemToRegWire1), .inWire19(wire19), 
         .inWire30(wire30), .inWire35(wire35), .inWire34(wire34), .inWire24(wire24), .inWire33(wire33), .outToBranch(ToBranchWire2), .outRegWrite(RegWriteWire2),
         .outMemWrite(MemWriteWire2), .outMemRead(MemReadWire2), .outMemByte(MemByteWire2), .outMemHalf(MemHalfWire2), .outJalSel(JalSelWire2),
         .outJorBranch(JorBranchWire2), .outMemToReg(MemToRegWire2), .outWire19(wire36), .outWire30(wire6), .outWire35(wire38), .outWire34(wire7), .outWire24(wire40), .outWire33(wire41)
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
        .out(PCSrc)
    );
    
            // ------------------------Write Back Stage------------------------
    MEM_WB(
        .Clk(Clk), .Reset(Reset),
        .inRegWrite(RegWriteWire2), 
        .inJalSel(JalSelWire2), 
        .inMemToReg(MemToRegWire2),  
        .outRegWrite(RegWriteWire3), 
        .outJalSel(JalSelWire3), 
        .outMemToReg(MemToRegWire3), 
        .inWire36(wire36), 
        .inWire8(wire8), 
        .inWire7(wire7), 
        .inWire41(wire41),
        .outWire36(wire42), 
        .outWire8(wire43), 
        .outWire7(wire44),
        .outWire41(wire45)
    );
    
    Mux32Bit3To1 MemToRegMux(
        .inA(wire43),
        .inB(wire44),
        .inC(wire42),
        .out(wire13),
        .sel(MemToRegWire3)
    );
    
    Mux32Bit2To1 JalSelMux(
        .inA(wire45),
        .inB(returnAddr),
        .sel(JalSelWire3)
    );
endmodule
