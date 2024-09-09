module TopModule_tb;
    reg Clk;
    reg Reset;
    wire [6:0] Seg;
    wire [3:0] An;
    wire dp;

    // Instantiate the TopModule
    TopModule uut (
        .Clk(Clk),
        .Reset(Reset),
        .Seg(Seg),
        .An(An),
        .dp(dp)
    );

    // Clock Generation
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk;  // 10ns period clock
    end

    // Reset Logic
    initial begin
        Reset = 1;   // Initially reset the system
        #20 Reset = 0;  // Release reset after 20ns
    end
endmodule
