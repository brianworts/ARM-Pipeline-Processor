`timescale 1ns / 1ps

module BranchAdd(
    input clk,
    input reset,
    
    input signed [63:0] inputA,
    input signed [18:0] inputB,
    
    output reg signed [63:0] outputData
    );
    
    always @(*)
    begin
        if (reset)
        begin
           // #1 outputData = 0;
        end
        else
        begin
            #1 outputData = inputA + inputB;
        end
    end
    
endmodule
