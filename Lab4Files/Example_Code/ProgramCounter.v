module ProgramCounter(Clk, rst, in, out);
    input Clk, rst;
    input [31:0] in;
    output reg [31:0] out;
       
    always @(posedge Clk, posedge rst) begin
           if(rst)
                out <= 0;
           else
                out <= in;
    end
endmodule