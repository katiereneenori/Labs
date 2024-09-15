`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// Module - InstructionFetchUnit_tb.v
// Description - test functionality of IFU
//
// ECE369A - Computer Architecture
// Laboratory 1
////////////////////////////////////////////////////////////////////////////////


module InstructionFetchUnit_tb();

    reg Reset, Clk;
    
    wire [31:0] Instruction_tb;
    
    InstructionFetchUnit IFU_tb (
        .Reset(Reset),
        .Clk(Clk),
        .Instruction(Instruction_tb)
    );
    
    always begin
    
        #10 Clk = ~Clk;
    end
    
    initial begin
    
        Clk = 0;
        Reset = 0;
        
        #40 Reset = 1; //observe effect of immediate
        #40 Reset = 0;
        
        #100 Reset = 1; //wait some time and reset
        #100 Reset = 0;
        
        #500; //wait some more time
        
        $finish;
        
    end

endmodule
