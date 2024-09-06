`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2024 09:39:15 PM
// Design Name: 
// Module Name: InstructionFetchUnit_tb
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
