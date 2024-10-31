`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// The University of Arizona
// Electrical and Computer Engineering 
// Engineer: Ehsan Esmaili, Elnaz T. Yazdi
// 
// Create Date: 09/22/2016
// Last Revision: 8/21/2022
// Revision Author: Parker Dattilo
// Module Name: One4DigitDisplay
// Description: Displays up to 4 hexadecimal digits, so only a 16-bit binary number
//              may be accepted (removed NumberB, only using NumberA). Additionally,
//              changed the divider counter to 19 bits instead of 20 after removing NumberB
//              which results in a refresh rate of 190.7Hz which is within the suggested range
//              on the Basys3 reference manual.
//////////////////////////////////////////////////////////////////////////////////

module One4DigitDisplay(Clk, NumberA, out7, en_out);

    parameter NUM_WIDTH = 16;

    input  Clk;
    input  [NUM_WIDTH - 1:0] NumberA;
    // input  [NUM_WIDTH - 1:0] NumberB;
    output [6:0] out7; //seg a, b, ... g
    output reg [3:0] en_out;
//    output wire dp;
             
    reg  [3:0] in4;        
    
    // Use for Structural assignment method
    wire [3:0] firstdigitA;
    wire [3:0] seconddigitA;
    wire [3:0] thirddigitA;
    wire [3:0] forthdigitA;
    // wire [3:0] firstdigitB;
    // wire [3:0] seconddigitB;
    // wire [3:0] thirddigitB;
    // wire [3:0] forthdigitB;
    
    /* // Uncomment for Procedural assignment method
    wire [3:0] firstdigitA;
    wire [3:0] seconddigitA;
    wire [3:0] thirddigitA;
    wire [3:0] forthdigitA;
    wire [3:0] firstdigitB;
    wire [3:0] seconddigitB;
    wire [3:0] thirddigitB;
    wire [3:0] forthdigitB;*/
    
    //--------- --------- --------- --------- //
    //-- to use the module SevenSegment 
    SevenSegment m1(in4, out7);
    //--------- --------- --------- --------- //

 //   assign dp = 1;
         
    //-- divider counter for ~93.5Hz refresh rate (with 100MHz main clock)
    reg  [19:0] cnt = 19'd0;
    always @(posedge Clk) begin
        cnt <= cnt + 1;
    end
    
    //-- Structural design of digits
    //-- Separating bits of number to display in hex format
    assign firstdigitA = NumberA[3:0];
    assign seconddigitA = NumberA[7:4];
    assign thirddigitA = NumberA[11:8];
    assign forthdigitA = NumberA[15:12];
    
    // assign firstdigitB = NumberB[3:0];
    // assign seconddigitB = NumberB[7:4];
    // assign thirddigitB = NumberB[11:8];
    // assign forthdigitB = NumberB[15:12];
    
    // Procedural assignment alternative
    //-- to seperate each decimal digit for display
    /*always @(NumberA) begin
            if (NumberA < 65535)
                begin
                    firstdigitA <= NumberA%16;
                    seconddigitA <= (NumberA/16)%16;
                    thirddigitA <= (NumberA/256)%16;
                    forthdigitA <= NumberA/4096;
                end 
             else
             begin
                    firstdigitA <= 4'b1111;
                    seconddigitA <= 4'b1111;
                    thirddigitA <= 4'b1111;
                    forthdigitA <= 4'b1111;
             end
    end
    
    always @(NumberB) begin
            if (NumberB < 65535)
                begin
                    firstdigitB <= NumberB%16;
                    seconddigitB <= (NumberB/16)%16;
                    thirddigitB <= (NumberB/256)%16;
                    forthdigitB <= NumberB/4096;
                end 
             else
             begin
                    firstdigitB <= 4'b1111;
                    seconddigitB <= 4'b1111;
                    thirddigitB <= 4'b1111;
                    forthdigitB <= 4'b1111;
             end
    end */
    
    //-- to display the number in the appropriate 7-segment digit
    always @(cnt) begin
        case(cnt[19:18])  //100MHz/(2^20) = 95.3 Hz
            2'b00: begin en_out <= 4'b1110; in4 <= firstdigitA; end
            2'b01: begin en_out <= 4'b1101; in4 <= seconddigitA; end
            2'b10: begin en_out <= 4'b1011; in4 <= thirddigitA; end
            2'b11: begin en_out <= 4'b0111; in4 <= forthdigitA; end
            // 3'b100: begin en_out <= 8'b11101111; in4 <= firstdigitB; end
            // 3'b101: begin en_out <= 8'b11011111; in4 <= seconddigitB; end
            // 3'b110: begin en_out <= 8'b10111111; in4 <= thirddigitB; end
            // 3'b111: begin en_out <= 8'b01111111; in4 <= forthdigitB; end
            default: begin en_out <= 4'b1111; in4 <= 4'b1111; end 
        endcase
     end
     
     
    
endmodule
