`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Team Members: Katie Dionne & Tanner Shartel
// Overall percent effort of each team member: 50%/50%
// 
// ECE369A - Computer Architecture
// Laboratory 4
//Temporary placeholder for the register file pipeline
//for now, this just transfers the data from one side to the other
//in the hopes of testing out single instructions 
////////////////////////////////////////////////////////////////////////////////

module IF_ID(inWire2, inWire3, inWire4, outWire2, outWire3, outWire4, Clk, Reset, IF_ID_Write);

    input [31:0] inWire2, inWire3, inWire4;
    
    input Clk, Reset;
    
    input IF_ID_Write;
    
    output reg [31:0] outWire2, outWire3, outWire4;
    
    reg [31:0] itmdtRegs [2:0]; //3 registers to store intermediate pipeline values
    
  always @(posedge Clk or posedge Reset) begin
        if (Reset == 1) begin // reset all intermediate values to 0 if reset is high
        outWire2 <= 32'd0;
        outWire3 <= 32'd0;
        outWire4 <= 32'd0;
        end 
        
        else if (IF_ID_Write) begin
        outWire2 <= inWire2;
        outWire3 <= inWire3;
        outWire4 <= inWire4;
        
        end else begin
            // Hold the values (stall)
        outWire2 <= outWire2;
        outWire3 <= outWire3;
        outWire4 <= outWire4;
        
        end
    end
   
 /*   
    always @(negedge Clk) begin // make intermediate values available on falling edge of clock
        outWire2 <= inWire2;
        outWire3 <= inWire3;
        outWire4 <= inWire4;
    end
   

    
    always @(posedge Clk or posedge Reset) begin
    
    end
    always @(negedge Clk or posedge Reset) begin
        if (Reset) begin
            outWire2 <= 32'b0;
            outWire3 <= 32'b0;
            outWire4 <= 32'b0;
        end else begin
            outWire2 <= inWire2;
            outWire3 <= inWire3;
            outWire4 <= inWire4;
        end 
    end
    
    */
    
endmodule