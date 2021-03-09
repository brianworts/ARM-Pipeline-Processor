`timescale 1ns / 1ps

module Mux(
    input clk, 
    input reset,
    
    input [63:0] inputA,
    input [63:0] inputB,
    input selector,
    output reg [63:0] outputData
    );
    
    always @(*)
    //Select data in Mux
    //Output
        //outputData
    begin
        if(reset)
        begin
            //#1 outputData = 0;
        end
        else
        begin
            if (selector)
            begin
                #1 outputData = inputB;
            end
            else
            begin
                #1 outputData = inputA;
            end
        end
    end
    
    
    /*
    always @(posedge clk)
    //Select data in Mux
    //Output
        //outputData
    begin
        if(reset)
        begin
            outputData <= 0;
        end
        else
        begin
            if (selector)
            begin
                outputData <= inputB;
            end
            else
            begin
                outputData <= inputA;
            end
        end
    end*/
    
    
endmodule
