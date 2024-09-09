`timescale 1ns / 1ps

module TopModule(
    input Clk,
    input Reset,
    output [6:0] Seg,
    output [3:0] An,
    output dp
);

    wire [31:0] Instruction;
    wire slowClk;
    wire [15:0] DisplayData;


    ClkDiv clkDivider(
        .Clk(Clk),
        .Rst(Reset),
        .ClkOut(slowClk)
    );


    InstructionFetchUnit IFU(
        .Clk(Clk),
        .Reset(Reset),
        .Instruction(Instruction)
    );


    assign DisplayData = Instruction[15:0];


    One4DigitDisplay display(
        .Clk(slowClk),
        .NumberA(DisplayData),
        .out7(Seg),
        .en_out(An),
        .dp(dp)
    );

endmodule
