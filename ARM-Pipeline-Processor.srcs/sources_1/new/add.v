`timescale 1ns / 1ps

module add(
    input clk,
    input reset,
    
    input inputA,
    input inputB,
    
    output outputData
    );
    
    
    assign outputData = inputA + inputB;
    
endmodule
