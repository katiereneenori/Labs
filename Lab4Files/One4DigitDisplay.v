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

module One4DigitDisplay(
    input  Clk,
    input  [15:0] NumberA, // 16-bit input number to display
    output [6:0] out7,     // Segment outputs for the 7-segment display
    output reg [3:0] en_out, // Enable outputs for each of the 4 digits
    output wire dp         // Decimal point (always off)
);

    // Intermediate variables to hold each digit of the 16-bit input number
    wire [3:0] firstdigitA;
    wire [3:0] seconddigitA;
    wire [3:0] thirddigitA;
    wire [3:0] forthdigitA;
    
    reg [3:0] in4; // Input to the SevenSegment module
    
    // Instantiate SevenSegment module for segment control
    SevenSegment m1(
        .numin(in4),
        .segout(out7)
    );

    // Constant to turn off the decimal point
    assign dp = 1;
         
    //-- Divider counter for ~93.5Hz refresh rate (with 100MHz main clock)
    reg [19:0] cnt = 20'd0; // 20-bit counter for digit refresh rate
    
    always @(posedge Clk) begin
        cnt <= cnt + 1;
    end
    
    //-- Structural design of digits
    //-- Separating bits of number to display in hex format
    assign firstdigitA = NumberA[3:0];
    assign seconddigitA = NumberA[7:4];
    assign thirddigitA = NumberA[11:8];
    assign forthdigitA = NumberA[15:12];
    
    //-- to display the number in the appropriate 7-segment digit
    always @(*) begin
        case(cnt[19:18])  // 100MHz/(2^20) = ~95.3 Hz refresh rate
            2'b00: begin 
                en_out <= 4'b1110; // Enable first digit
                in4 <= firstdigitA; // Display first digit
            end
            2'b01: begin 
                en_out <= 4'b1101; // Enable second digit
                in4 <= seconddigitA; // Display second digit
            end
            2'b10: begin 
                en_out <= 4'b1011; // Enable third digit
                in4 <= thirddigitA; // Display third digit
            end
            2'b11: begin 
                en_out <= 4'b0111; // Enable fourth digit
                in4 <= forthdigitA; // Display fourth digit
            end
            default: begin 
                en_out <= 4'b1111; // Disable all digits (default state)
                in4 <= 4'b1111; // Display nothing
            end 
        endcase
    end
    
endmodule

// SevenSegment module definition
module SevenSegment(
    input  [3:0] numin, // 4-bit binary input representing a single hex digit (0-15)
    output reg [6:0] segout // 7-bit output to control the segments a-g
);

    always @(numin) begin
        case (numin)
            4'b0000: segout <= 7'b1000000;    // 0 
            4'b0001: segout <= 7'b1111001;    // 1
            4'b0010: segout <= 7'b0100100;    // 2
            4'b0011: segout <= 7'b0110000;    // 3
            4'b0100: segout <= 7'b0011001;    // 4
            4'b0101: segout <= 7'b0010010;    // 5
            4'b0110: segout <= 7'b0000010;    // 6
            4'b0111: segout <= 7'b1111000;    // 7
            4'b1000: segout <= 7'b0000000;    // 8
            4'b1001: segout <= 7'b0010000;    // 9
            4'b1010: segout <= 7'b0001000;    // A
            4'b1011: segout <= 7'b0000011;    // B
            4'b1100: segout <= 7'b1000110;    // C
            4'b1101: segout <= 7'b0100001;    // D
            4'b1110: segout <= 7'b0000110;    // E
            4'b1111: segout <= 7'b0001110;    // F
            default: segout <= 7'b1111111;  // Blank (off state)
       endcase
    end
endmodule
