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

module EX_MEM (
    input inToBranch, inRegWrite, inMemWrite, inMemRead, inMemByte, inMemHalf, inJalSel, inJorBranch,
    input [1:0] inMemToReg,
    input [31:0] inWire46, inWire30, inWire34, inWire24, inWire33,
    input Clk, Reset,
    input inWire35,
    output reg outToBranch, outRegWrite, outMemWrite, outMemRead, outMemByte, outMemHalf, outJalSel, outJorBranch,
    output reg [1:0] outMemToReg,
    output reg [31:0] outWire46, outWire30, outWire35, outWire34, outWire24, outWire33
);

   // reg OneBitRegs [7:0];        // 8 1-bit intermediate registers
   // reg [1:0] TwoBitRegs;        // 1 2-bit intermediate register
   // reg [31:0] ThirtyTwoBitRegs [5:0]; // 6 32-bit intermediate registers
    
    always @(posedge Clk or posedge Reset) begin
           if (Reset) begin
            // Reset outputs
            outToBranch   <= 1'b0;
            outRegWrite   <= 1'b0;
            outMemWrite   <= 1'b0;
            outMemRead    <= 1'b0;
            outMemByte    <= 1'b0;
            outMemHalf    <= 1'b0;
            outJalSel     <= 1'b0;
            outJorBranch  <= 1'b0;
            outMemToReg   <= 2'd0;
            outWire46     <= 32'd0;
            outWire30     <= 32'd0;
            outWire35     <= 32'd0;
            outWire34     <= 32'd0;
            outWire24     <= 32'd0;
            outWire33     <= 32'd0;
        end else begin
            // Register inputs
            outToBranch   <= inToBranch;
            outRegWrite   <= inRegWrite;
            outMemWrite   <= inMemWrite;
            outMemRead    <= inMemRead;
            outMemByte    <= inMemByte;
            outMemHalf    <= inMemHalf;
            outJalSel     <= inJalSel;
            outJorBranch  <= inJorBranch;
            outMemToReg   <= inMemToReg;
            outWire46     <= inWire46;
            outWire30     <= inWire30;
            outWire35     <= inWire35;
            outWire34     <= inWire34;
            outWire24     <= inWire24;
            outWire33     <= inWire33;
        end
     end
   
   /*
    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin // Set all intermediate registers to zero on reset
            OneBitRegs[0] <= 1'b0;
            OneBitRegs[1] <= 1'b0;
            OneBitRegs[2] <= 1'b0;
            OneBitRegs[3] <= 1'b0;
            OneBitRegs[4] <= 1'b0;
            OneBitRegs[5] <= 1'b0;
            OneBitRegs[6] <= 1'b0;
            OneBitRegs[7] <= 1'b0;
            TwoBitRegs <= 2'b00;
            ThirtyTwoBitRegs[0] <= 32'd0;
            ThirtyTwoBitRegs[1] <= 32'd0;
            ThirtyTwoBitRegs[2] <= 32'd0;
            ThirtyTwoBitRegs[3] <= 32'd0;
            ThirtyTwoBitRegs[4] <= 32'd0;
            ThirtyTwoBitRegs[5] <= 32'd0;
        end
        else begin
            OneBitRegs[0] <= inToBranch;
            OneBitRegs[1] <= inRegWrite;
            OneBitRegs[2] <= inMemWrite;
            OneBitRegs[3] <= inMemRead;
            OneBitRegs[4] <= inMemByte;
            OneBitRegs[5] <= inMemHalf;
            OneBitRegs[6] <= inJalSel;
            OneBitRegs[7] <= inJorBranch;
            TwoBitRegs <= inMemToReg;
            ThirtyTwoBitRegs[0] <= inWire46;
            ThirtyTwoBitRegs[1] <= inWire30;
            ThirtyTwoBitRegs[2] <= inWire35;
            ThirtyTwoBitRegs[3] <= inWire34;
            ThirtyTwoBitRegs[4] <= inWire24;
            ThirtyTwoBitRegs[5] <= inWire33;
        end
    end

    always @(negedge Clk) begin
        outToBranch <= OneBitRegs[0];
        outRegWrite <= OneBitRegs[1];
        outMemWrite <= OneBitRegs[2];
        outMemRead <= OneBitRegs[3];
        outMemByte <= OneBitRegs[4];
        outMemHalf <= OneBitRegs[5];
        outJalSel <= OneBitRegs[6];
        outJorBranch <= OneBitRegs[7];
        outMemToReg <= TwoBitRegs;
        outWire46 <= ThirtyTwoBitRegs[0];
        outWire30 <= ThirtyTwoBitRegs[1];
        outWire35 <= ThirtyTwoBitRegs[2];
        outWire34 <= ThirtyTwoBitRegs[3];
        outWire24 <= ThirtyTwoBitRegs[4];
        outWire33 <= ThirtyTwoBitRegs[5];
    end
    */

endmodule
