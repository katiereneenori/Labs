`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////

module TopDatapath(Clk, Reset, wire2, wire13, v0, v1);

    input Clk;
    input Reset;

    output [31:0] wire2, wire13;
    output [31:0] v0, v1;

    // Wires for Hazard Detection Unit
    wire HDU_PCWrite;
    wire HDU_IF_ID_Write;
    wire HDU_ControlHazard;

    // Internal Wires
    // 32-bit wires
    wire [31:0] wire1, wire3, wire4, wire5, wire6, wire7, wire8, wire9, wire10, wire11, wire14, wire15, wire16,
                wire17, wire18, wire21, wire22, wire23, wire24, wire25, wire26, wire29,
                wire30, wire31, wire32, wire34, wire36, wire37, wire39, wire40, wire42,
                wire43, wire44, wire46, wire47, wire48, JAddressWire; // Added wire46, wire47, wire48 for PC+4 propagation

    wire [31:0] AddressMasked;

    // 1-bit wires
    wire wire35, wire38, toFlush;

    // 5-bit wires
    wire [4:0] wire12, wire27, wire28, wire33, wire41, wire45, wire49;
    wire [4:0] ALUOpWire, ALUOpWire1;

    // 2-bit wires
    wire [1:0] ALUSrcAWire, ALUSrcBWire, MemToRegWire, ALUSrcAWire1, ALUSrcBWire1, MemToRegWire1, MemToRegWire2, MemToRegWire3;

    // 1-bit control signals
    wire ToBranchWire, RegWriteWire, MemWriteWire, MemReadWire, MemByteWire, MemHalfWire, RegDstWire, JalSelWire, PCSrcWire, JorBranchWire, JSrcWire, JRSelectWire;
    wire ToBranchWire1, RegWriteWire1, MemWriteWire1, MemReadWire1, MemByteWire1, MemHalfWire1, RegDstWire1, JalSelWire1, JorBranchWire1, JSrcWire1;
    wire ToBranchWire2, RegWriteWire2, MemWriteWire2, MemReadWire2, MemByteWire2, MemHalfWire2, RegDstWire2, JalSelWire2, JorBranchWire2;

    wire JalSelWire3, RegWriteWire3;

    reg [4:0] returnAddr = 5'b11111;

    // From IF_ID pipeline register
    wire [4:0] IF_ID_RegisterRs = wire11[25:21]; // Rs field of instruction in IF_ID
    wire [4:0] IF_ID_RegisterRt = wire11[20:16]; // Rt field of instruction in IF_ID

    // From ID_EX pipeline register
    wire [4:0] ID_EX_RegisterRt = wire27;        // Rt field from ID_EX
    wire [4:0] ID_EX_RegisterRd;                 // Destination register in ID_EX
    wire ID_EX_RegWrite = RegWriteWire1;         // RegWrite signal from ID_EX

    // From EX_MEM pipeline register
    wire [4:0] EX_MEM_RegisterRd = wire41;       // Destination register from EX_MEM
    wire EX_MEM_RegWrite = RegWriteWire2;        // RegWrite signal from EX_MEM

    // From MEM_WB pipeline register
    wire [4:0] MEM_WB_RegisterRd = wire45;       // Destination register from MEM_WB
    wire MEM_WB_RegWrite = RegWriteWire3;        // RegWrite signal from MEM_WB
    
    //wire [5:0] OpCode = wire11[31:26];

    // Hazard Detection Unit instantiation
    HazardDetectionUnit HDU (
        .ID_EX_RegWrite(ID_EX_RegWrite),
        .ID_EX_RegisterRd(ID_EX_RegisterRd),
        .EX_MEM_RegWrite(EX_MEM_RegWrite),
        .EX_MEM_RegisterRd(EX_MEM_RegisterRd),
        .MEM_WB_RegWrite(MEM_WB_RegWrite),
        .MEM_WB_RegisterRd(MEM_WB_RegisterRd),
        .IF_ID_RegisterRs(IF_ID_RegisterRs),
        .IF_ID_RegisterRt(IF_ID_RegisterRt),
        .PCWrite(HDU_PCWrite),
        .IF_ID_Write(HDU_IF_ID_Write),
        .ControlHazard(HDU_ControlHazard)
        //.OpCode(OpCode)
    );

    // ------------------------Instruction Fetch Stage------------------------

    /*Mux32Bit2To1 JorBranchMux(
        .inA(wire6),
        .inB(wire7),
        .out(wire5),
        .sel(JorBranchWire2)
    );*/

    Mux3To1PCSrc PCSrcMux( // 3x1 mux -- PCSrc and JSrc control signal
        .inA(wire3),
        .inB(wire6),
        .inC(JAddressWire),
        .out(wire1),
        .sel1(PCSrcWire),
        .sel2(JSrcWire)
    );

    ProgramCounter PC(
        .Address(wire1),
        .PCResult(wire2),
        .Reset(Reset),
        .Clk(Clk),
        .PCWrite(HDU_PCWrite) // Modified to include PCWrite signal from HDU
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
        .IF_ID_Write(HDU_IF_ID_Write), // Modified to include IF_ID_Write from HDU
        .inWire2(wire2),
        .inWire3(wire3),
        .inWire4(wire4),
        .outWire2(wire9),
        .outWire3(wire10),
        .outWire4(wire11),
        .Flush1(JSrcWire),
        .Flush2(JSrcWire1)
    );

    // ------------------------Instruction Decode Stage------------------------

    Control Controller(
        .Instruction(wire11),
        .ControlHazard(HDU_ControlHazard),
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
        .JalSel(JalSelWire),
        .JSrc(JSrcWire),
        .JRSelect(JRSelectWire)
    );

    // Wires for control signals after hazard Muxes
    wire [4:0] ALUOpMuxed;
    wire ToBranchMuxed;
    wire RegDstMuxed;
    wire [1:0] ALUSrcAMuxed;
    wire [1:0] ALUSrcBMuxed;
    wire RegWriteMuxed;
    wire MemWriteMuxed;
    wire MemReadMuxed;
    wire [1:0] MemToRegMuxed;
    wire MemByteMuxed;
    wire MemHalfMuxed;
    wire JorBranchMuxed;
    wire JalSelMuxed;

    // Mux control signals based on ControlHazard
    assign ALUOpMuxed     = HDU_ControlHazard ? 5'b00000 : ALUOpWire;
    assign ToBranchMuxed  = HDU_ControlHazard ? 1'b0     : ToBranchWire;
    assign RegDstMuxed    = HDU_ControlHazard ? 1'b0     : RegDstWire;
    assign ALUSrcAMuxed   = HDU_ControlHazard ? 2'b00    : ALUSrcAWire;
    assign ALUSrcBMuxed   = HDU_ControlHazard ? 2'b00    : ALUSrcBWire;
    assign RegWriteMuxed  = HDU_ControlHazard ? 1'b0     : RegWriteWire;
    assign MemWriteMuxed  = HDU_ControlHazard ? 1'b0     : MemWriteWire;
    assign MemReadMuxed   = HDU_ControlHazard ? 1'b0     : MemReadWire;
    assign MemToRegMuxed  = HDU_ControlHazard ? 2'b00    : MemToRegWire;
    assign MemByteMuxed   = HDU_ControlHazard ? 1'b0     : MemByteWire;
    assign MemHalfMuxed   = HDU_ControlHazard ? 1'b0     : MemHalfWire;
    assign JorBranchMuxed = HDU_ControlHazard ? 1'b0     : JorBranchWire;
    assign JalSelMuxed    = HDU_ControlHazard ? 1'b0     : JalSelWire;
    
    // branch hazard flush
    assign toFlush = (wire35 && ToBranchWire1);

    RegisterFile Registers(
        .ReadRegister1(wire11[25:21]),
        .ReadRegister2(wire11[20:16]),
        .WriteRegister(wire49),
        .WriteData(wire13),
        .RegWrite(RegWriteWire3),
        .Clk(Clk),
        .Reset(Reset),
        .ReadData1(wire14),
        .ReadData2(wire15),
        .v0_reg(v0),
        .v1_reg(v1)
    );

    FiveBitExtender FiveExtend(
        .in(wire11[10:6]),
        .out(wire16)
    );
    
    SignExtension SE(
        .in(wire11[15:0]),
        .out(wire18)
    );

    ShiftLeft2 Shift1(
        .toShift(wire11),
        .shiftedResult(wire17)
    );
    
    PrependPC PrependPC(
        .LeftShiftedAddress(wire17),
        .PC4Sig(wire10),
        .out(JAddressWire),
        .sel(JRSelectWire),
        .RegAddress(wire14)
        //.AddressToAdd(wire2)
    );

    // Modified to compute ID_EX_RegisterRd for HDU
    Mux5Bit2To1 ID_EX_RegisterRdMux(
        .inA(wire27),       // rt from ID_EX (for I-type instructions)
        .inB(wire28),       // rd from ID_EX (for R-type instructions)
        .sel(RegDstWire1),  // RegDst control signal from ID_EX
        .out(ID_EX_RegisterRd)
    );

    // Modified to pass control signals with hazard handling
    ID_EX ID_EXRegFile(
        .Clk(Clk),
        .Reset(Reset),
        // Control signals
        .inALUOp(ALUOpMuxed),
        .inToBranch(ToBranchMuxed),
        .inRegWrite(RegWriteMuxed),
        .inMemWrite(MemWriteMuxed),
        .inMemRead(MemReadMuxed),
        .inMemByte(MemByteMuxed),
        .inMemHalf(MemHalfMuxed),
        .inRegDst(RegDstMuxed),
        .inJalSel(JalSelMuxed),
        .inALUSrcA(ALUSrcAMuxed),
        .inALUSrcB(ALUSrcBMuxed),
        .inJorBranch(JorBranchMuxed),
        .inMemToReg(MemToRegMuxed),
        // Data signals
        .inWire16(wire16),
        .inWire14(wire14),
        .inWire9(wire9),
        .inWire15(wire15),
        .inWire17(wire11),
        //.inWire17(wire18),
        .inWire18(wire18),
        .inWire10(wire10),          // Pass the full PC+4
        .inWire27(wire11[20:16]),   // rt
        .inWire28(wire11[15:11]),   // rd
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
        .outWire28(wire28),         // rd
        .Flush(toFlush),     // flush subsequent instruction when branching dependency
        .JSrc1(JSrcWire),
        .outJSrc1(JSrcWire1)
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

//    Mux32Bit3To1 ALUSrcAMux(
//        .inA(wire22),
//        .inB(wire24),
//        .inC(wire21),
//        .sel(ALUSrcAWire1),
//        .out(wire31)
//    );

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

    EX_MEM EX_MEMRegFile(
        .Clk(Clk),
        .Reset(Reset),
        .inToBranch(ToBranchWire1),
        .inRegWrite(RegWriteWire1),
        .inMemWrite(MemWriteWire1),
        .inMemRead(MemReadWire1),
        .inMemByte(MemByteWire1),
        .inMemHalf(MemHalfWire1),
        .inJalSel(JalSelWire1),
        .inJorBranch(JorBranchWire1),
        .inMemToReg(MemToRegWire1),
        .inWire46(wire46), // PC+4
        .inWire30(wire30),
        .inWire35(wire35),
        .inWire34(wire34),
        .inWire24(wire24),
        .inWire33(wire33),
        .outToBranch(ToBranchWire2),
        .outRegWrite(RegWriteWire2),
        .outMemWrite(MemWriteWire2),
        .outMemRead(MemReadWire2),
        .outMemByte(MemByteWire2),
        .outMemHalf(MemHalfWire2),
        .outJalSel(JalSelWire2),
        .outJorBranch(JorBranchWire2),
        .outMemToReg(MemToRegWire2),
        .outWire46(wire47), // PC+4 passed to EX_MEM
        .outWire30(wire6),
        .outWire35(wire38),
        .outWire34(wire7),
        .outWire24(wire40),
        .outWire33(wire41)
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
        .inWire41(wire41),
        .outWire46(wire48),    // PC+4 passed to MEM_WB
        .outWire8(wire43),
        .outWire7(wire44),
        .outWire41(wire45)
    );

    // Correct WriteRegMux using wire45 from MEM_WB stage
    Mux5Bit2To1 WriteRegMux (
        .inA(wire45),            // Write register from MEM_WB pipeline register
        .inB(returnAddr),        // $ra (register 31) for jal instruction
        .sel(JalSelWire3),       // JalSel control signal from MEM_WB stage
        .out(wire49)             // Output to RegisterFile.WriteRegister
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
