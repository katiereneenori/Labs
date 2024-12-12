`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// ECE369A - Computer Architecture
// Laboratory 4
// Updated to move branch decision to ID stage and flush only IF stage.
////////////////////////////////////////////////////////////////////////////////

module TopDatapath(Clk, Reset, wire2, wire13, v0, v1);

    input Clk;
    input Reset;

    output [31:0] wire2, wire13;
    output [31:0] v0, v1;

    // Hazard Detection signals
    wire HDU_PCWrite;
    wire HDU_IF_ID_Write;
    wire HDU_Flush1;

    wire [1:0] ForwardA, ForwardB;
    wire [31:0] ForwardedA, ForwardedB;


    // Internal wires
    wire [31:0] wire1, wire3, wire4, wire6, wire7, wire8, wire9, wire10, wire11,
                 wire14, wire15, wire16, wire17, wire18, wire21, wire22, wire23,
                 wire24, wire25, wire26, wire29, wire30, wire31, wire32, wire34,
                 wire40, wire43, wire44, wire46, wire47, wire48, JAddressWire;

    wire wire35, wire38;

    wire [4:0] wire12, wire27, wire28, wire33, wire41, wire45, wire49;
    wire [4:0] ALUOpWire, ALUOpWire1;

    wire [1:0] ALUSrcAWire, ALUSrcBWire, MemToRegWire, ALUSrcAWire1, ALUSrcBWire1,
                MemToRegWire1, MemToRegWire2, MemToRegWire3;

    wire ToBranchWire, RegWriteWire, MemWriteWire, MemReadWire, MemByteWire,
         MemHalfWire, RegDstWire, JalSelWire, PCSrcWire, JorBranchWire, JSrcWire, JRSelectWire;
    wire ToBranchWire1, RegWriteWire1, MemWriteWire1, MemReadWire1, MemByteWire1,
         MemHalfWire1, RegDstWire1, JalSelWire1, JorBranchWire1, JSrcWire1;
    wire ToBranchWire2, RegWriteWire2, MemWriteWire2, MemReadWire2, MemByteWire2,
         MemHalfWire2, RegDstWire2, JalSelWire2, JorBranchWire2;

    wire JalSelWire3, RegWriteWire3;

    reg [4:0] returnAddr = 5'b11111;

    // IF/ID register fields for Register Rs and Rt
    wire [4:0] IF_ID_RegisterRs = wire11[25:21];
    wire [4:0] IF_ID_RegisterRt = wire11[20:16];

    // For forwarding unit:
    wire [4:0] ID_EX_RegisterRt = wire27;
    wire [4:0] ID_EX_RegisterRd;
    wire ID_EX_RegWrite = RegWriteWire1;

    wire [4:0] EX_MEM_RegisterRd = wire41;
    wire EX_MEM_RegWrite = RegWriteWire2;

    wire [4:0] MEM_WB_RegisterRd = wire45;
    wire MEM_WB_RegWrite = RegWriteWire3;

    wire [31:0] PCPlus8 = wire48 + 32'd4;

    // == Newly introduced signals for ID-stage branch decision ==
    // After IF_ID:
    // The Control block now is in ID and we also do branch comparison in ID.

    // HazardDetectionUnit now gets BranchTaken and JumpTaken from ID stage
    wire BranchTaken_ID;
    wire JumpTaken_ID;

    // Hazard Detection Unit: note that BranchTaken and JumpTaken come from ID stage now.
    HazardDetectionUnit HDU (
        .ID_EX_MemRead(MemReadWire1),
        .ID_EX_RegisterRt(wire27),
        .IF_ID_RegisterRs(IF_ID_RegisterRs),
        .IF_ID_RegisterRt(IF_ID_RegisterRt),
        .BranchTaken(BranchTaken_ID), // from ID
        .JumpTaken(JumpTaken_ID),     // from ID
        .PCWrite(HDU_PCWrite),
        .IF_ID_Write(HDU_IF_ID_Write),
        .Flush1(HDU_Flush1)           // Flush only IF_ID on control hazard
    );

    // PCSrcMux is now fed from ID stage decisions, but we still keep the module here:
    // We'll compute NextPC in ID stage and feed it to PC.
    // For now, just create a placeholder. We'll override wire1 soon.
    wire [31:0] NextPC_ID; // Computed in ID stage

    ProgramCounter PC(
        .Address(NextPC_ID),
        .PCResult(wire2),
        .Reset(Reset),
        .Clk(Clk),
        .PCWrite(HDU_PCWrite)
    );

    PCAdder PCAdd(
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
        .IF_ID_Write(HDU_IF_ID_Write),
        .inWire2(wire2),
        .inWire3(wire3),
        .inWire4(wire4),
        .outWire2(wire9),
        .outWire3(wire10),
        .outWire4(wire11),
        .Flush1(HDU_Flush1) 
    );

    Control Controller(
        .Instruction(wire11),
        .ControlHazard(1'b0), // No separate hazard line needed
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

    // Pass control signals directly to ID/EX:
    wire [4:0] ALUOpMuxed = ALUOpWire; 
    wire ToBranchMuxed    = ToBranchWire;
    wire RegDstMuxed      = RegDstWire;
    wire [1:0] ALUSrcAMuxed = ALUSrcAWire;
    wire [1:0] ALUSrcBMuxed = ALUSrcBWire;
    wire RegWriteMuxed    = RegWriteWire;
    wire MemWriteMuxed    = MemWriteWire;
    wire MemReadMuxed     = MemReadWire;
    wire [1:0] MemToRegMuxed = MemToRegWire;
    wire MemByteMuxed     = MemByteWire;
    wire MemHalfMuxed     = MemHalfWire;
    wire JorBranchMuxed   = JorBranchWire;
    wire JalSelMuxed      = JalSelWire;

    reg [31:0] zeroOperand = 32'b0;

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

    // J-type address computation (unchanged):
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
    );

    // == New: Compute branch target in ID stage ==
    wire [31:0] branchOffsetShifted;
    ShiftLeft2 Shift2_Stage(
        .toShift(wire18),
        .shiftedResult(branchOffsetShifted)
    );

    wire [31:0] branchTarget;
    Adder offsetAdder(
        .inA(wire10),              // PC+4 from IF/ID
        .inB(branchOffsetShifted),
        .AddResult(branchTarget)
    );

    // == Branch Comparator in ID stage ==
    BranchComparator branchComp(
        .A(wire14),
        .B(wire15),
        .ToBranch(ToBranchWire),
        .ALUOp(ALUOpWire),
        .BranchTaken(BranchTaken_ID)
    );

    // Jump decision in ID stage
    assign JumpTaken_ID = JorBranchWire & JSrcWire;

    // Next PC calculation in ID stage:
    wire PCSrc_ID = BranchTaken_ID;
    wire JumpSrc_ID = JumpTaken_ID;

    Mux3To1PCSrc PCSrcMux(
        .inA(wire3),
        .inB(branchTarget),
        .inC(JAddressWire),
        .out(NextPC_ID),
        .sel1(PCSrc_ID),
        .sel2(JumpSrc_ID)
    );

    // ID_EX pipeline register
    // Note: We no longer rely on EX stage for branch decision, but we still pass signals.
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
        .inWire18(wire18),
        .inWire10(wire10),
        .inWire27(wire11[20:16]),
        .inWire28(wire11[15:11]),
        .inWireRs(wire11[25:21]),
        .JSrc1(JSrcWire),
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
        .outWire10(wire46),
        .outWire16(wire21),
        .outWire14(wire22),
        .outWire9(wire23),
        .outWire15(wire24),
        .outWire17(wire25),
        .outWire18(wire26),
        .outWire27(wire27),
        .outWire28(wire28),
        .outWireRs(ID_EX_RegisterRs),
        .outJSrc1(JSrcWire1),
        .Flush(Flush_ID_EX)
    );

    // Execution Stage logic (no more branch decision here):
    // Forwarding
    Mux3To1 ForwardA_Mux(
        .sel(ForwardA),
        .in0(wire22),
        .in1(wire13),
        .in2(wire7),
        .out(ForwardedA)
    );
    
    Mux3To1 ForwardB_Mux(
        .sel(ForwardB),
        .in0(wire24),
        .in1(wire13),
        .in2(wire7),
        .out(ForwardedB)
    );
    
    Mux32Bit4To1 ALUSrcAMux(
        .inA(ForwardedA),
        .inB(wire21),
        .inC(wire23),
        .inD(zeroOperand),
        .sel(ALUSrcAWire1),
        .out(wire31)
    );
    
    Mux32Bit4To1 ALUSrcBMux(
        .inA(ForwardedB),
        .inB(wire26),
        .inC(wire21),
        .inD(zeroOperand),
        .sel(ALUSrcBWire1),
        .out(wire32)
    );

    Mux5Bit2To1 RegDstMux_Stage(
        .inA(wire27),
        .inB(wire28),
        .sel(RegDstWire1),
        .out(wire33)
    );

    // ALU only does arithmetic/logic now, not branches:
    ALU32Bit ALU_Stage(
        .ALUControl(ALUOpWire1),
        .A(wire31),
        .B(wire32),
        .ALUResult(wire34),
        .Zero(wire35) // Zero is computed but no longer used for branching
    );

    // EX_MEM pipeline register, zero and branch signals no longer control PC here
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
        .inWire46(wire46),
        .inWire30(32'b0), // no longer used branch target here
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
        .outWire46(wire47),
        .outWire30(wire6), // still has a slot for branch target, unused now
        .outWire35(wire38),
        .outWire34(wire7),
        .outWire24(wire40),
        .outWire33(wire41)
    );

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

    // No need for AND gate for PCSrc here because branching is decided in ID
    // and we've already selected NextPC_ID.

    MEM_WB MEM_WBRegFile(
        .Clk(Clk),
        .Reset(Reset),
        .inRegWrite(RegWriteWire2),
        .inJalSel(JalSelWire2),
        .inMemToReg(MemToRegWire2),
        .outRegWrite(RegWriteWire3),
        .outJalSel(JalSelWire3),
        .outMemToReg(MemToRegWire3),
        .inWire46(wire47),
        .inWire8(wire8),
        .inWire7(wire7),
        .inWire41(wire41),
        .outWire46(wire48),
        .outWire8(wire43),
        .outWire7(wire44),
        .outWire41(wire45)
    );

    Mux5Bit2To1 WriteRegMux (
        .inA(wire45),
        .inB(returnAddr),
        .sel(JalSelWire3),
        .out(wire49)
    );

    Mux32Bit4To1 MemToRegMux(
        .inA(wire43),       // Memory read data
        .inB(wire44),       // ALU result
        .inC(PCPlus8),      // PC+8 for JAL
        .inD(zeroOperand),
        .sel(MemToRegWire3),
        .out(wire13)
    );
    
    Mux5Bit2To1 JalSelMux(
        .inA(wire45),
        .inB(returnAddr),
        .sel(JalSelWire3),
        .out(wire12)
    );
    
    ForwardingUnit FU(
        .EX_MEM_RegWrite(RegWriteWire2),
        .EX_MEM_RegisterRd(wire41),
        .MEM_WB_RegWrite(RegWriteWire3),
        .MEM_WB_RegisterRd(wire45),
        .ID_EX_RegisterRs(ID_EX_RegisterRs),   // Corrected to use the new wire
        .ID_EX_RegisterRt(ID_EX_RegisterRt),   // Rt stays the same
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );
    

endmodule
