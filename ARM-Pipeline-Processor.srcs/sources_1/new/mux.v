`timescale 1ns / 1ps

module mux(
    input clk, 
    input reset,
    
    input inputA,
    input inputB,
    input selector,
    output reg outputData
    );
    
    always @(posedge clk)
    //Select data in Mux
    //Output
        //outputData
    begin
        if(reset)
        begin
            outputData <= 32'hXXXXXXXX;
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
    end
    
    
endmodule
