`timescale 1ns / 1ps

module TopModule(Clk, Rst, en_out, out7);

    input Clk;
    input Rst;
    output [3:0] en_out;
    output [6:0] out7;
    
    (* mark_debug = "true" *) wire ClkOut;
    (* mark_debug = "true" *) wire [15:0] InstructionWire;
    
    ClkDiv Clock(
        .Clk(Clk), //clock input from board
        .Reset(Rst),
        .ClkOut(ClkOut)    //clock output to Clk
    );
    
    InstructionFetchUnit IFU (
        .Reset(Rst),    
        .Clk(ClkOut),      //clock input to IFU from ClkDiv
        .Instruction(InstructionWire)   //Instruction output
    );
    
    One4DigitDisplay display (
        .Clk(ClkOut),
        .NumberA(InstructionWire),
        .out7(out7),
        .en_out(en_out)
    );
    
endmodule
