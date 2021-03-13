`timescale 1ns / 1ps

module Add(
    input clk,
    input reset,
    
    input [63:0] inputA,
    input [63:0] inputB,
    
    output reg [63:0] outputData
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
    
    /*
    always @(posedge clk)
    begin
        if (reset)
        begin
            outputData <= 0;
        end
        else
        begin
            outputData <= inputA + inputB;
        end
    end
    
    */
endmodule
