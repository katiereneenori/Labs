`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
//
// Module - PCAdder_tb.v
// Description - test functionality of PCAdder
//
// ECE369A - Computer Architecture
// Laboratory 1
////////////////////////////////////////////////////////////////////////////////

module PCAdder_tb();

    reg [31:0] PCResult;

    wire [31:0] PCAddResult;

    PCAdder u0(
        .PCResult(PCResult), 
        .PCAddResult(PCAddResult)
    );

	initial begin
	
    //input 0
    PCResult = 32'd0;
    #10;
    $display("PCResult = %d, PCAddResult = %d", PCResult, PCAddResult);
    
    //input 4
    PCResult = 32'd4;
    #10;
    $display("PCResult = %d, PCAddResult = %d", PCResult, PCAddResult);
	
    //input 8
    PCResult = 32'd8;
    #10;
    $display("PCResult = %d, PCAddResult = %d", PCResult, PCAddResult);
	
    //input 12
    PCResult = 32'd12;
    #10;
    $display("PCResult = %d, PCAddResult = %d", PCResult, PCAddResult);
    
    $stop;
    
	end

endmodule

