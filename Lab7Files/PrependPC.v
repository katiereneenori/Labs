`timescale 1ns / 1ps



module PrependPC(
    input [31:0] LeftShiftedAddress,
    input [31:0] PC4Sig,
    input [31:0] RegAddress,
    input sel,
    //input [31:0] AddressToAdd,
    output reg [31:0] out
    );
    
    
    always @(*) begin
        if(sel == 0) begin
            out = {PC4Sig[31:28], LeftShiftedAddress[27:0]};
        end
        else if (sel == 1) begin
            out = RegAddress;
        end
    end
endmodule
